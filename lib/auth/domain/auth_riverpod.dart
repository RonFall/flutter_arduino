import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_arduino/auth/data/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthStateNotifier extends StateNotifier<AsyncValue<User?>> {
  AuthStateNotifier({required AuthService service})
      : _service = service,
        // В super объявляется изначальное состояние (initial). Так как данных
        // нет, ставим null
        super(const AsyncData(null)) {
    // Если пользователь уже был авторизован, просто меняем состояние на
    // успешное
    if (service.isAlreadyLoggedIn) state = AsyncData(service.user);
  }

  final AuthService _service;

  Future<void> logout() async {
    if (state.isLoading) return;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _service.logout();
      // После выхода делаем User равным null, так как от id внутри этой модели
      // определяется состояние авторизованности в приложении
      return null;
    });
  }

  Future<void> login({required String email, required String password}) async {
    if (state.isLoading) return;

    state = const AsyncLoading();
    // AsyncValue.guard используется для удобства. По факту получается
    // state = AsyncData(response.user) в случае успеха, либо
    // state = AsyncError(error, stackTrace) в случае ошибки
    state = await AsyncValue.guard(() async {
      final response = await _service.login(
        email: email,
        password: password,
      );
      return response.user;
    });
  }
}
