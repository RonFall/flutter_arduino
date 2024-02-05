import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_arduino/devices/data/models/devices_data.dart';
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
      final response = await _database.once();
      final data = response.snapshot.child('devices/antonov').value as Map;

      // Заполнение данных происходит прямо в логике, так как реализация проще
      return DevicesData(
        humidity: data['humidity'],
        temperature: data['temperature'],
      );
    });
  }
}
