import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_arduino/devices/data/models/devices_data.dart';
import 'package:flutter_arduino/devices/domain/devices_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final devicesStateProvider =
    StateNotifierProvider<DevicesStateNotifier, AsyncValue<DevicesData?>>((_) {
  return DevicesStateNotifier(database: FirebaseDatabase.instance.ref())
    ..getDevicesData();
});
