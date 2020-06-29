// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'air.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveAqi _$LiveAqiFromJson(Map<String, dynamic> json) {
  return LiveAqi(
    quality: json['qlty'] as String,
    value: double.parse(json['aqi'] as String),
    mainSource: json['main'] as String,
    co: double.parse(json['co'] as String),
    no2: double.parse(json['no2'] as String),
    o3: double.parse(json['o3'] as String),
    pm10: double.parse(json['pm10'] as String),
    pm25: double.parse(json['pm25'] as String),
    so2: double.parse(json['so2'] as String),
    pubtime: json['pub_time'] == null
        ? null
        : DateTime.parse(json['pub_time'] as String),
  )..timestamp = json['timestamp'] == null
      ? null
      : DateTime.parse(json['timestamp'] as String);
}

Map<String, dynamic> _$LiveAqiToJson(LiveAqi instance) => <String, dynamic>{
      'timestamp': instance.timestamp?.toIso8601String(),
      'aqi': numToString(instance.value),
      'qlty': instance.quality,
      'main': instance.mainSource,
      'co': numToString(instance.co),
      'no2': numToString(instance.no2),
      'o3': numToString(instance.o3),
      'pm10': numToString(instance.pm10),
      'pm25': numToString(instance.pm25),
      'so2': numToString(instance.so2),
      'pub_time': instance.pubtime?.toIso8601String(),
    };

DailyAqi _$DailyAqiFromJson(Map<String, dynamic> json) {
  return DailyAqi(
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    value: int.parse(json['aqi'] as String),
    quality: json['qlty'] as String,
    mainSource: json['main'] as String,
  );
}

Map<String, dynamic> _$DailyAqiToJson(DailyAqi instance) => <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'aqi': numToString(instance.value),
      'qlty': instance.quality,
      'main': instance.mainSource,
    };
