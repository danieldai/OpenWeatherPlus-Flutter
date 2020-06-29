// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationState _$LocationStateFromJson(Map<String, dynamic> json) {
  return LocationState(
    id: json['id'] as String,
    gps: json['gps'] as bool,
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
    city: json['city'] == null
        ? null
        : HeCity.fromJson(json['city'] as Map<String, dynamic>),
    gpsLocation: json['gpsLocation'] == null
        ? null
        : GpsLocation.fromJson(json['gpsLocation'] as Map<String, dynamic>),
    name: json['name'] as String,
    liveState: json['liveState'] == null
        ? null
        : LiveState.fromJson(json['liveState'] as Map<String, dynamic>),
    hourlyState: json['hourlyState'] == null
        ? null
        : HourlyState.fromJson(json['hourlyState'] as Map<String, dynamic>),
    dailyState: json['dailyState'] == null
        ? null
        : DailyState.fromJson(json['dailyState'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LocationStateToJson(LocationState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gps': instance.gps,
      'name': instance.name,
      'timestamp': instance.timestamp?.toIso8601String(),
      'city': instance.city,
      'gpsLocation': instance.gpsLocation,
      'liveState': instance.liveState,
      'hourlyState': instance.hourlyState,
      'dailyState': instance.dailyState,
    };
