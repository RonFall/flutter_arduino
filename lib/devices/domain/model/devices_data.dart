import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class DevicesData with EquatableMixin {
  const DevicesData({
    required this.humidity,
    required this.temperature,
  });

  final int? humidity;
  final int? temperature;

  @override
  List<Object?> get props => [humidity, temperature];
}
