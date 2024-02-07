import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arduino/auth/data/services/auth_service.dart';
import 'package:flutter_arduino/auth/domain/auth_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginAuthProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  // onDispose срабатывает в местах, где использовался
  // ref.watch(loginAuthProvider). После выхода из экрана этот текстовый
  // контроллер закрывается
  ref.onDispose(() => controller.dispose());
  return controller;
});

final passAuthProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

/// Провайдер для определения показа информационного сообщения. По факту булево,
/// которое нужно, чтобы ограничить показ SnackBar в UI
final hasSnackBarAppearedProvider = StateProvider<bool>((ref) => false);

final userProvider = Provider<User?>(
  (ref) => ref.watch(authStateProvider).value,
);

/// Провайдер текущего состояния авторизованности
final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, AsyncValue<User?>>(
  (_) => AuthStateNotifier(service: AuthService()),
);
