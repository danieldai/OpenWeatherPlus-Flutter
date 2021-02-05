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

HourlyCondition _$HourlyConditionFromJson(Map<String, dynamic> json) {
  return HourlyCondition(
    cloud: int.parse(json['cloud'] as String),
    dew: int.parse(json['dew'] as String),
    hour: json['fxTime'] == null
        ? null
        : DateTime.parse(json['fxTime'] as String),
    humidity: int.parse(json['humidity'] as String),
    icon: json['icon'] as String,
    pop: int.parse(json['pop'] as String),
    precip: json['precip'] as String,
    pressure: int.parse(json['pressure'] as String),
    temp: int.parse(json['temp'] as String),
    text: json['text'] as String,
    wind360: int.parse(json['wind360'] as String),
    windDir: json['windDir'] as String,
    windScale: int.parse(json['windScale'] as String),
    windSpeed: double.parse(json['windSpeed'] as String),
  );
}

Map<String, dynamic> _$HourlyConditionToJson(HourlyCondition instance) =>
    <String, dynamic>{
      'cloud': numToString(instance.cloud),
      'dew': numToString(instance.dew),
      'fxTime': instance.hour?.toIso8601String(),
      'humidity': numToString(instance.humidity),
      'icon': instance.icon,
      'pop': numToString(instance.pop),
      'precip': instance.precip,
      'pressure': numToString(instance.pressure),
      'temp': numToString(instance.temp),
      'text': instance.text,
      'wind360': numToString(instance.wind360),
      'windDir': instance.windDir,
      'windScale': numToString(instance.windScale),
      'windSpeed': numToString(instance.windSpeed),
    };
