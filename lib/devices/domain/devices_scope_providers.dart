import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_arduino/devices/domain/devices_riverpod.dart';
import 'package:flutter_arduino/devices/domain/models/devices_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final devicesStateProvider = StateNotifierProvider.autoDispose<
    DevicesStateNotifier, AsyncValue<DevicesData?>>((_) {
  return DevicesStateNotifier(database: FirebaseDatabase.instance.ref())
    // При входе на экран, где используется этот провайдер сразу же начнется
    // запрос в сеть посредством вызова getDevicesData
    ..getDevicesData();
});
