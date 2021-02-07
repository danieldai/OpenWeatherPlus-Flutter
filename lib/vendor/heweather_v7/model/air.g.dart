// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'air.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveAqi _$LiveAqiFromJson(Map<String, dynamic> json) {
  return LiveAqi(
    aqi: double.parse(json['aqi'] as String),
    category: json['category'] as String,
    level: json['level'] as String,
    co: double.parse(json['co'] as String),
    no2: double.parse(json['no2'] as String),
    o3: double.parse(json['o3'] as String),
    pm10: double.parse(json['pm10'] as String),
    pm2p5: double.parse(json['pm2p5'] as String),
    primary: json['primary'] as String,
    pubTime: json['pubTime'] == null
        ? null
        : DateTime.parse(json['pubTime'] as String),
    so2: double.parse(json['so2'] as String),
  );
}

Map<String, dynamic> _$LiveAqiToJson(LiveAqi instance) => <String, dynamic>{
      'aqi': numToString(instance.aqi),
      'category': instance.category,
      'level': instance.level,
      'co': numToString(instance.co),
      'no2': numToString(instance.no2),
      'o3': numToString(instance.o3),
      'pm10': numToString(instance.pm10),
      'pm2p5': numToString(instance.pm2p5),
      'primary': instance.primary,
      'pubTime': instance.pubTime?.toIso8601String(),
      'so2': numToString(instance.so2),
    };

DailyAqi _$DailyAqiFromJson(Map<String, dynamic> json) {
  return DailyAqi(
    date: json['fxDate'] == null
        ? null
        : DateTime.parse(json['fxDate'] as String),
    value: int.parse(json['aqi'] as String),
    category: json['category'] as String,
    level: json['level'] as String,
    primary: json['primary'] as String,
  );
}

Map<String, dynamic> _$DailyAqiToJson(DailyAqi instance) => <String, dynamic>{
      'fxDate': instance.date?.toIso8601String(),
      'aqi': numToString(instance.value),
      'category': instance.category,
      'level': instance.level,
      'primary': instance.primary,
    };
