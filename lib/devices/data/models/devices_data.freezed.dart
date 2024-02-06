// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'devices_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DevicesData {
  /// Влажность
  int? get humidity => throw _privateConstructorUsedError;

  /// Температура
  int? get temperature => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DevicesDataCopyWith<DevicesData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DevicesDataCopyWith<$Res> {
  factory $DevicesDataCopyWith(
          DevicesData value, $Res Function(DevicesData) then) =
      _$DevicesDataCopyWithImpl<$Res, DevicesData>;
  @useResult
  $Res call({int? humidity, int? temperature});
}

/// @nodoc
class _$DevicesDataCopyWithImpl<$Res, $Val extends DevicesData>
    implements $DevicesDataCopyWith<$Res> {
  _$DevicesDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? humidity = freezed,
    Object? temperature = freezed,
  }) {
    return _then(_value.copyWith(
      humidity: freezed == humidity
          ? _value.humidity
          : humidity // ignore: cast_nullable_to_non_nullable
              as int?,
      temperature: freezed == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DevicesDataImplCopyWith<$Res>
    implements $DevicesDataCopyWith<$Res> {
  factory _$$DevicesDataImplCopyWith(
          _$DevicesDataImpl value, $Res Function(_$DevicesDataImpl) then) =
      __$$DevicesDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? humidity, int? temperature});
}

/// @nodoc
class __$$DevicesDataImplCopyWithImpl<$Res>
    extends _$DevicesDataCopyWithImpl<$Res, _$DevicesDataImpl>
    implements _$$DevicesDataImplCopyWith<$Res> {
  __$$DevicesDataImplCopyWithImpl(
      _$DevicesDataImpl _value, $Res Function(_$DevicesDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? humidity = freezed,
    Object? temperature = freezed,
  }) {
    return _then(_$DevicesDataImpl(
      humidity: freezed == humidity
          ? _value.humidity
          : humidity // ignore: cast_nullable_to_non_nullable
              as int?,
      temperature: freezed == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$DevicesDataImpl implements _DevicesData {
  const _$DevicesDataImpl({this.humidity, this.temperature});

  /// Влажность
  @override
  final int? humidity;

  /// Температура
  @override
  final int? temperature;

  @override
  String toString() {
    return 'DevicesData(humidity: $humidity, temperature: $temperature)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DevicesDataImpl &&
            (identical(other.humidity, humidity) ||
                other.humidity == humidity) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature));
  }

  @override
  int get hashCode => Object.hash(runtimeType, humidity, temperature);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DevicesDataImplCopyWith<_$DevicesDataImpl> get copyWith =>
      __$$DevicesDataImplCopyWithImpl<_$DevicesDataImpl>(this, _$identity);
}

abstract class _DevicesData implements DevicesData {
  const factory _DevicesData({final int? humidity, final int? temperature}) =
      _$DevicesDataImpl;

  @override

  /// Влажность
  int? get humidity;
  @override

  /// Температура
  int? get temperature;
  @override
  @JsonKey(ignore: true)
  _$$DevicesDataImplCopyWith<_$DevicesDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
