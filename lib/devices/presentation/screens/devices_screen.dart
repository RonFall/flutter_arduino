import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_arduino/auth/domain/auth_scope_providers.dart';
import 'package:flutter_arduino/auth/presentation/screens/auth_screen.dart';
import 'package:flutter_arduino/devices/domain/devices_scope_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DevicesScreen extends ConsumerWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    // authStateProvider провайдер вызовется по нажатию кнопки выхода. В теле
    // этого слушателя стоит проверка
    ref.listen<AsyncValue<User?>>(authStateProvider, (prev, next) {
      final uid = next.value?.uid;

      // Если пользователь вышел - заменяем текущий экран на экран авторизации
      if (uid == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const AuthScreen()),
        );
      }
    });

    final deviceData = ref.watch(devicesStateProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2252AB),
        title: user != null
            ? Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFFBAD2D3),
                    child: Text('${user.email?[0]}'),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      '${user.email}',
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            : null,
        actions: [
          IconButton(
            onPressed: ref.read(authStateProvider.notifier).logout,
            icon: const Tooltip(
              message: 'Выход',
              child: Icon(
                Icons.exit_to_app_rounded,
                size: 28,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      // Метод when в асинхронных операциях в Riverpod позволяет удобно
      // распределять события загрузки, ошибки и успеха на нужные виджеты,
      // которые описаны здесь
      body: deviceData.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: Color(0xFF2252AB)),
        ),
        error: (error, stackTrace) {
          return Center(
            child: _DevicesErrorView(
              onPressed: () {
                // Перезапрашиваем данные в случае ошибки
                ref.read(devicesStateProvider.notifier).getDevicesData();
              },
            ),
          );
        },
        data: (data) {
          if (data == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Не удалось получить данные',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(devicesStateProvider.notifier).getDevicesData();
                    },
                    child: const Text('Обновить'),
                  ),
                ],
              ),
            );
          }

          final temperature = data.temperature;
          final humidity = data.humidity;
          final readingDateTime = data.readingDateTime;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (readingDateTime != null)
                  Text(
                    'Время последнего показания: '
                    '${DateFormat('HH:mm:ss dd.MM.yyyy').format(readingDateTime)}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                Text(
                  temperature != null
                      ? 'Температура: $temperature ℃'
                      : 'Нет данных по температуре',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  humidity != null
                      ? 'Влажность: $humidity %'
                      : 'Нет данных по влажности',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Виджет, который отобразится при возникшей ошибке получения данных
class _DevicesErrorView extends StatelessWidget {
  const _DevicesErrorView({this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Не удалось загрузить данные\nс сервера. Проверьте свое'
            '\nсоединение, либо обратитесь к\nадминистратору.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 48,
          width: MediaQuery.sizeOf(context).width / 1.5,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                const Color(0xFF2252AB),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              textStyle: MaterialStateProperty.all(
                const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onPressed: onPressed,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    'Попробовать еще раз',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.restart_alt_rounded,
                  size: 22,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
