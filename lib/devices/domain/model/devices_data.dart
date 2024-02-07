import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class DevicesData with EquatableMixin {
  const DevicesData({
    required this.humidity,
    required this.temperature,
  });

  /// Влажность
  final int? humidity;

  /// Температура
  final int? temperature;

  @override
  List<Object?> get props => [humidity, temperature];
}
