import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arduino/app/presentation/app_colors.dart';
import 'package:flutter_arduino/app/presentation/app_text_style.dart';
import 'package:flutter_arduino/app/presentation/components/app_textfield.dart';
import 'package:flutter_arduino/app/presentation/components/components_utils.dart';
import 'package:flutter_arduino/auth/domain/auth_scope_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginController = ref.watch(loginAuthProvider);
    final passController = ref.watch(passAuthProvider);
    _listenAuthState(context, ref);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.accentColor,
        title: const Text('Авторизация', style: AppTextStyle.appBarStyle),
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
              child: AppTextField(
                controller: loginController,
                hintText: 'Email',
                fieldAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                next: true,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AppTextField(
                controller: passController,
                hintText: 'Пароль',
                onComplete: () {
                  _completeInput(
                    context,
                    ref,
                    email: loginController.text.trim(),
                    pass: passController.text.trim(),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Consumer(
              builder: (context, ref, child) {
                final isLoading = ref.watch(authStateProvider).isLoading;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AppButton(
                    height: 48,
                    width: double.maxFinite,
                    text: isLoading ? null : 'Войти',
                    textStyle: AppTextStyle.buttonTextStyle,
                    buttonColor: AppColors.accentColor,
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.white,
                            ),
                          )
                        : null,
                    onPressed: () {
                      _completeInput(
                        context,
                        ref,
                        email: loginController.text.trim(),
                        pass: passController.text.trim(),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _completeInput(
    BuildContext context,
    WidgetRef ref, {
    required String email,
    required String pass,
  }) {
    if (isKeyboardVisible(context)) FocusScope.of(context).unfocus();
    ref.read(authStateProvider.notifier).login(email: email, password: pass);
  }

  void _listenAuthState(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<User?>>(authStateProvider, (previous, next) async {
      final hasSnackBarAppeared = ref.watch(hasSnackBarAppearedProvider);

      if (next.hasError) {
        if (!hasSnackBarAppeared) {
          final snackBar = ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Ошибка: ${_mapFirebaseError(next.error)}',
                style: AppTextStyle.snackBarTextStyle,
              ),
              duration: const Duration(seconds: 3),
              onVisible: () {
                ref.read(hasSnackBarAppearedProvider.notifier).state = true;
              },
            ),
          );
          await snackBar.closed;
          ref.read(hasSnackBarAppearedProvider.notifier).state = false;
        }
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
