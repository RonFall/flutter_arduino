import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arduino/app/app_navigator.dart';
import 'package:flutter_arduino/app/presentation/app_colors.dart';
import 'package:flutter_arduino/app/presentation/app_text_style.dart';
import 'package:flutter_arduino/auth/domain/auth_scope_providers.dart';
import 'package:flutter_arduino/auth/presentation/screens/auth_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DevicesScreen extends ConsumerWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    ref.listen<AsyncValue<User?>>(authStateProvider, (prev, next) {
      final uid = next.value?.uid;

      // Если пользователь вышел - заменяем текущий экран на экран авторизации
      if (uid == null) {
        AppNavigator.replaceScreen(context, screen: const AuthScreen());
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.accentColor,
        title: user != null
            ? Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.cardColor,
                    child: Text('${user.email?[0]}'),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      '${user.email}',
                      maxLines: 1,
                      style: AppTextStyle.appBarStyle,
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
                color: AppColors.white,
              ),
            ),
          )
        ],
      ),
      body: Container(),
    );
  }
}
