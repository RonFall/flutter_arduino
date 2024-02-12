import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_arduino/devices/domain/models/devices_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DevicesStateNotifier extends StateNotifier<AsyncValue<DevicesData?>> {
  DevicesStateNotifier({required DatabaseReference database})
      : _database = database,
        super(const AsyncData(null));

  final DatabaseReference _database;

  late StreamSubscription<DatabaseEvent> _subscription;

  Future<void> getDevicesData() async {
    state = const AsyncLoading();
    // Обновление данных происходит в реальном времени
    _subscription = _database.onValue.listen((event) {
      final data = event.snapshot.child('devices').value as Map?;
      if (data == null) return;

      state = AsyncData(DevicesData.fromJson(data));
    }, onError: (e, s) => state = AsyncError(e, s));
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
