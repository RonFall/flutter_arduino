import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arduino/auth/data/services/auth_service.dart';
import 'package:flutter_arduino/auth/domain/auth_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginAuthProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final passAuthProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final hasSnackBarAppearedProvider = StateProvider<bool>((ref) => false);

final userProvider = Provider<User?>(
  (ref) => ref.watch(authStateProvider).value,
);

final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, AsyncValue<User?>>(
  (_) => AuthStateNotifier(service: AuthService()),
);
