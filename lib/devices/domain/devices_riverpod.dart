import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_arduino/devices/domain/model/devices_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DevicesStateNotifier extends StateNotifier<AsyncValue<DevicesData?>> {
  DevicesStateNotifier({required DatabaseReference database})
      : _database = database,
        super(const AsyncData(null));

  final DatabaseReference _database;

  Future<void> getDevicesData() async {
    if (state.isLoading) return;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      // Метод once в данном случае опрашивает БД лишь раз, чтобы получить
      // данные
      final response = await _database.once();
      // А затем просто достаем из пути, который мы указывали при написании
      // кода для ESP32
      final data = response.snapshot.child('devices').value as Map?;

      // Заполнение данных происходит прямо в логике, так как реализация простая
      return DevicesData(
        humidity: data?['humidity'],
        temperature: data?['temperature'],
      );
    });
  }
}
