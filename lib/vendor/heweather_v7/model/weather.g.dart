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

DailyCondition _$DailyConditionFromJson(Map<String, dynamic> json) {
  return DailyCondition(
    cloud: int.parse(json['cloud'] as String),
    fxDate: json['fxDate'] == null
        ? null
        : DateTime.parse(json['fxDate'] as String),
    humidity: int.parse(json['humidity'] as String),
    iconDay: json['iconDay'] as String,
    iconNight: json['iconNight'] as String,
    moonPhase: json['moonPhase'] as String,
    moonrise: json['moonrise'] as String,
    moonset: json['moonset'] as String,
    precipitation: double.parse(json['precip'] as String),
    pressure: int.parse(json['pres'] as String),
    sunrise: json['sunrise'] as String,
    sunset: json['sunset'] as String,
    tempMax: int.parse(json['tempMax'] as String),
    tempMin: int.parse(json['tempMin'] as String),
    textDay: json['textDay'] as String,
    textNight: json['textNight'] as String,
    uvIndex: int.parse(json['uvIndex'] as String),
    vis: int.parse(json['vis'] as String),
    wind360Day: int.parse(json['wind360Day'] as String),
    wind360Night: int.parse(json['wind360Night'] as String),
    windDirDay: json['windDirDay'] as String,
    windDirNight: json['windDirNight'] as String,
    windScaleDay: json['windScaleDay'] as String,
    windScaleNight: json['windScaleNight'] as String,
    windSpeedDay: double.parse(json['windSpeedDay'] as String),
    windSpeedNight: double.parse(json['windSpeedNight'] as String),
  );
}

Map<String, dynamic> _$DailyConditionToJson(DailyCondition instance) =>
    <String, dynamic>{
      'cloud': numToString(instance.cloud),
      'fxDate': instance.fxDate?.toIso8601String(),
      'humidity': numToString(instance.humidity),
      'iconDay': instance.iconDay,
      'iconNight': instance.iconNight,
      'moonPhase': instance.moonPhase,
      'moonrise': instance.moonrise,
      'moonset': instance.moonset,
      'precip': numToString(instance.precipitation),
      'pres': numToString(instance.pressure),
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
      'tempMax': numToString(instance.tempMax),
      'tempMin': numToString(instance.tempMin),
      'textDay': instance.textDay,
      'textNight': instance.textNight,
      'uvIndex': numToString(instance.uvIndex),
      'vis': numToString(instance.vis),
      'wind360Day': numToString(instance.wind360Day),
      'wind360Night': numToString(instance.wind360Night),
      'windDirDay': instance.windDirDay,
      'windDirNight': instance.windDirNight,
      'windScaleDay': instance.windScaleDay,
      'windScaleNight': instance.windScaleNight,
      'windSpeedDay': numToString(instance.windSpeedDay),
      'windSpeedNight': numToString(instance.windSpeedNight),
    };
