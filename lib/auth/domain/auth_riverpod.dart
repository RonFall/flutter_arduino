import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_arduino/auth/data/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthStateNotifier extends StateNotifier<AsyncValue<User?>> {
  AuthStateNotifier({required AuthService service})
      : _service = service,
        super(const AsyncData(null)) {
    if (service.isAlreadyLoggedIn) state = AsyncData(service.user);
  }

  final AuthService _service;

  Future<void> logout() async {
    if (state.isLoading) return;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _service.logout();
      return null;
    });
  }

  Future<void> login({required String email, required String password}) async {
    if (state.isLoading) return;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await _service.login(
        email: email,
        password: password,
      );
      return response.user;
    });
  }
}
