import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arduino/auth/domain/auth_scope_providers.dart';
import 'package:flutter_arduino/devices/presentation/screens/devices_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Получаем значение TextEditingController, которое используем для
    // текстового поля. ref.watch будет перестраивать виджет каждый раз, когда
    // его значение меняется, например, при вызове у этого
    // TextEditingController метода dispose
    final loginController = ref.watch(loginAuthProvider);
    final passController = ref.watch(passAuthProvider);
    _listenAuthState(context, ref);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2252AB),
        title: const Text(
          'Аутентификация',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.device_hub_rounded, size: 128),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: loginController,
                decoration: const InputDecoration(hintText: 'Email'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: passController,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Пароль'),
                onEditingComplete: () {
                  _completeInput(
                    context,
                    ref,
                    email: loginController.text.trim(),
                    pass: passController.text.trim(),
                  );
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
            const SizedBox(height: 24),
            Consumer(
              builder: (context, ref, child) {
                final isLoading = ref.watch(authStateProvider).isLoading;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    height: 48,
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () {
                        _completeInput(
                          context,
                          ref,
                          email: loginController.text.trim(),
                          pass: passController.text.trim(),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xFF2252AB),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Войти',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Метод завершения ввода логина и пароля
  void _completeInput(
    BuildContext context,
    WidgetRef ref, {
    required String email,
    required String pass,
  }) {
    // Если у пользователя открыта клавиатура - скрываем ее
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 1;
    if (isKeyboardVisible) FocusScope.of(context).unfocus();

    // Вызываем функцию для входа
    ref.read(authStateProvider.notifier).login(email: email, password: pass);
  }

  /// Отслеживает состояние авторизованности пользователя
  void _listenAuthState(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<User?>>(authStateProvider, (previous, next) async {
      // Получаем значение флага для SnackBar
      final hasSnackBarAppeared = ref.watch(hasSnackBarAppearedProvider);

      // В случае ошибки показываем информационное сообщение
      if (next.hasError && !hasSnackBarAppeared) {
        final snackBar = ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Ошибка: ${_mapFirebaseError(next.error)}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            duration: const Duration(seconds: 3),
            onVisible: () {
              // Меняем значение при показе на true, что позволит ограничить
              // показ во время вывода этого сообщения
              ref.read(hasSnackBarAppearedProvider.notifier).state = true;
            },
          ),
        );
        await snackBar.closed;
        // Меняем обратно на false после завершения показа
        ref.read(hasSnackBarAppearedProvider.notifier).state = false;
      }

      // В случае успешной авторизации переходим на экран устройств
      if (next.hasValue && context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const DevicesScreen()),
        );
      }
    });
  }

  /// Сравнивает ошибку, которая приходит с Firebase и возвращает строку с
  /// сообщением.
  ///
  /// [error] - ошибка из ответа по [FirebaseAuthException]
  String _mapFirebaseError(Object? error) {
    if (error is FirebaseAuthException) {
      if (error.code == 'unknown') {
        return 'поля с логином и/или паролем пустые!';
      }
      if (error.code == 'invalid-email') {
        return 'введен неверный формат Email!';
      }
      if (error.code == 'user-not-found') {
        return 'пользователь с такими данными не найден!';
      }
      if (error.code == 'too-many-requests') {
        return 'слишком много запросов!';
      }
      if (error.code == 'wrong-password') {
        return 'введен неверный Email и/или пароль!';
      }
    }
    return 'неизвестное состояние. Попробуйте еще раз.';
  }
}
