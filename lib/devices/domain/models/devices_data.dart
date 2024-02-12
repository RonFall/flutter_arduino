import 'package:flutter/foundation.dart';

@immutable
class DevicesData {
  const DevicesData({
    required this.humidity,
    required this.temperature,
    required this.readingDateTime,
  });

  /// Влажность
  final int? humidity;

  /// Температура
  final int? temperature;

  /// Время считывания
  final DateTime? readingDateTime;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DevicesData &&
          runtimeType == other.runtimeType &&
          humidity == other.humidity &&
          temperature == other.temperature &&
          readingDateTime == other.readingDateTime;

  @override
  int get hashCode =>
      humidity.hashCode ^ temperature.hashCode ^ readingDateTime.hashCode;

  static DevicesData fromJson(Map json) {
    // Так как отсчет времени происходит с начала эпохи (01.01.1970) в секундах,
    // здесь происходит преобразование этого времени в понятный вид
    final timestamp = json['timestamp'];
    final readingDateTime = timestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(timestamp * 1000)
        : null;

    return DevicesData(
      temperature: json['temperature'],
      humidity: json['humidity'],
      readingDateTime: readingDateTime,
    );
  }
}
