// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveCondition _$LiveConditionFromJson(Map<String, dynamic> json) {
  return LiveCondition(
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
    cloud: int.parse(json['cloud'] as String),
    conditionCode: int.parse(json['cond_code'] as String),
    conditionText: json['cond_txt'] as String,
    feel: int.parse(json['fl'] as String),
    humidity: int.parse(json['hum'] as String),
    precipitation: double.parse(json['pcpn'] as String),
    pressure: int.parse(json['pres'] as String),
    temp: int.parse(json['tmp'] as String),
    vis: int.parse(json['vis'] as String),
    windDegree: int.parse(json['wind_deg'] as String),
    windDir: json['wind_dir'] as String,
    windSpeed: double.parse(json['wind_spd'] as String),
    windLevel: json['wind_sc'] as String,
  );
}

Map<String, dynamic> _$LiveConditionToJson(LiveCondition instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp?.toIso8601String(),
      'cond_txt': instance.conditionText,
      'cond_code': numToString(instance.conditionCode),
      'tmp': numToString(instance.temp),
      'fl': numToString(instance.feel),
      'pres': numToString(instance.pressure),
      'hum': numToString(instance.humidity),
      'vis': numToString(instance.vis),
      'wind_deg': numToString(instance.windDegree),
      'wind_dir': instance.windDir,
      'wind_sc': instance.windLevel,
      'wind_spd': numToString(instance.windSpeed),
      'cloud': numToString(instance.cloud),
      'pcpn': numToString(instance.precipitation),
    };

HeIndexItem _$HeIndexItemFromJson(Map<String, dynamic> json) {
  return HeIndexItem(
    type: json['type'] as String,
    status: json['brf'] as String,
    desc: json['txt'] as String,
  );
}

Map<String, dynamic> _$HeIndexItemToJson(HeIndexItem instance) =>
    <String, dynamic>{
      'type': instance.type,
      'brf': instance.status,
      'txt': instance.desc,
    };

HeLifeIndex _$HeLifeIndexFromJson(Map<String, dynamic> json) {
  return HeLifeIndex(
    items: (json['items'] as List)
        ?.map((e) =>
            e == null ? null : HeIndexItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HeLifeIndexToJson(HeLifeIndex instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

HourlyCondition _$HourlyConditionFromJson(Map<String, dynamic> json) {
  return HourlyCondition(
    conditionText: json['cond_txt'] as String,
    cloud: int.parse(json['cloud'] as String),
    conditionCode: int.parse(json['cond_code'] as String),
    humidity: int.parse(json['hum'] as String),
    dew: int.parse(json['dew'] as String),
    pop: int.parse(json['pop'] as String),
    pressure: int.parse(json['pres'] as String),
    hour: json['time'] == null ? null : DateTime.parse(json['time'] as String),
    temp: int.parse(json['tmp'] as String),
    windDegree: int.parse(json['wind_deg'] as String),
    windDir: json['wind_dir'] as String,
    windSpeed: double.parse(json['wind_spd'] as String),
  );
}

Map<String, dynamic> _$HourlyConditionToJson(HourlyCondition instance) =>
    <String, dynamic>{
      'time': instance.hour?.toIso8601String(),
      'tmp': numToString(instance.temp),
      'cond_txt': instance.conditionText,
      'cond_code': numToString(instance.conditionCode),
      'hum': numToString(instance.humidity),
      'pres': numToString(instance.pressure),
      'wind_deg': numToString(instance.windDegree),
      'wind_dir': instance.windDir,
      'wind_spd': numToString(instance.windSpeed),
      'cloud': numToString(instance.cloud),
      'pop': numToString(instance.pop),
      'dew': numToString(instance.dew),
    };

DailyCondition _$DailyConditionFromJson(Map<String, dynamic> json) {
  return DailyCondition(
    conditionDay: json['cond_txt_d'] as String,
    conditionIdDay: int.parse(json['cond_code_d'] as String),
    conditionIdNight: int.parse(json['cond_code_n'] as String),
    conditionNight: json['cond_txt_n'] as String,
    predictDate:
        json['date'] == null ? null : DateTime.parse(json['date'] as String),
    precipitation: double.parse(json['pcpn'] as String),
    humidity: int.parse(json['hum'] as String),
    pop: int.parse(json['pop'] as String),
    pressure: int.parse(json['pres'] as String),
    sunrise: json['sr'] as String,
    sunset: json['ss'] as String,
    tempMax: int.parse(json['tmp_max'] as String),
    tempMin: int.parse(json['tmp_min'] as String),
    uvi: int.parse(json['uv_index'] as String),
    vis: int.parse(json['vis'] as String),
    windDegree: int.parse(json['wind_deg'] as String),
    windDir: json['wind_dir'] as String,
    windLevel: json['wind_sc'] as String,
    windSpeed: double.parse(json['wind_spd'] as String),
  );
}

Map<String, dynamic> _$DailyConditionToJson(DailyCondition instance) =>
    <String, dynamic>{
      'cond_txt_d': instance.conditionDay,
      'cond_txt_n': instance.conditionNight,
      'cond_code_d': numToString(instance.conditionIdDay),
      'cond_code_n': numToString(instance.conditionIdNight),
      'date': instance.predictDate?.toIso8601String(),
      'pcpn': numToString(instance.precipitation),
      'hum': numToString(instance.humidity),
      'pop': numToString(instance.pop),
      'pres': numToString(instance.pressure),
      'sr': instance.sunrise,
      'ss': instance.sunset,
      'tmp_max': numToString(instance.tempMax),
      'tmp_min': numToString(instance.tempMin),
      'uv_index': numToString(instance.uvi),
      'vis': numToString(instance.vis),
      'wind_deg': numToString(instance.windDegree),
      'wind_dir': instance.windDir,
      'wind_sc': instance.windLevel,
      'wind_spd': numToString(instance.windSpeed),
    };
