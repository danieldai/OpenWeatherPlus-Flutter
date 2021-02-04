// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveCondition _$LiveConditionFromJson(Map<String, dynamic> json) {
  return LiveCondition(
    cloud: json['cloud'] as String,
    dew: json['dew'] as String,
    feelsLike: json['feelsLike'] as String,
    humidity: json['humidity'] as String,
    icon: json['icon'] as String,
    obsTime: json['obsTime'] as String,
    precip: json['precip'] as String,
    pressure: json['pressure'] as String,
    temp: json['temp'] as String,
    vis: json['vis'] as String,
    text: json['text'] as String,
    wind360: json['wind360'] as String,
    windDir: json['windDir'] as String,
    windScale: json['windScale'] as String,
    windSpeed: json['windSpeed'] as String,
  );
}

Map<String, dynamic> _$LiveConditionToJson(LiveCondition instance) =>
    <String, dynamic>{
      'cloud': instance.cloud,
      'dew': instance.dew,
      'feelsLike': instance.feelsLike,
      'humidity': instance.humidity,
      'icon': instance.icon,
      'obsTime': instance.obsTime,
      'precip': instance.precip,
      'pressure': instance.pressure,
      'temp': instance.temp,
      'text': instance.text,
      'vis': instance.vis,
      'wind360': instance.wind360,
      'windDir': instance.windDir,
      'windScale': instance.windScale,
      'windSpeed': instance.windSpeed,
    };
