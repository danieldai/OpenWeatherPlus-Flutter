// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grid.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrecipitationForecast _$PrecipitationForecastFromJson(
    Map<String, dynamic> json) {
  return PrecipitationForecast(
    desc: json['txt'] as String,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  );
}

Map<String, dynamic> _$PrecipitationForecastToJson(
        PrecipitationForecast instance) =>
    <String, dynamic>{
      'txt': instance.desc,
      'date': instance.date?.toIso8601String(),
    };

PrecipitationValue _$PrecipitationValueFromJson(Map<String, dynamic> json) {
  return PrecipitationValue(
    value: double.parse(json['pcpn'] as String),
    time: json['time'] == null ? null : DateTime.parse(json['time'] as String),
  );
}

Map<String, dynamic> _$PrecipitationValueToJson(PrecipitationValue instance) =>
    <String, dynamic>{
      'pcpn': numToString(instance.value),
      'time': instance.time?.toIso8601String(),
    };

PrecipitationType _$PrecipitationTypeFromJson(Map<String, dynamic> json) {
  return PrecipitationType(
    type: json['pcpn_type'] as String,
  );
}

Map<String, dynamic> _$PrecipitationTypeToJson(PrecipitationType instance) =>
    <String, dynamic>{
      'pcpn_type': instance.type,
    };

MinuteForecast _$MinuteForecastFromJson(Map<String, dynamic> json) {
  return MinuteForecast(
    forecast: json['grid_minute_forecast'] == null
        ? null
        : PrecipitationForecast.fromJson(
            json['grid_minute_forecast'] as Map<String, dynamic>),
    values: (json['pcpn_5m'] as List)
        ?.map((e) => e == null
            ? null
            : PrecipitationValue.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    type: json['pcpn_type'] == null
        ? null
        : PrecipitationType.fromJson(json['pcpn_type'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MinuteForecastToJson(MinuteForecast instance) =>
    <String, dynamic>{
      'grid_minute_forecast': instance.forecast,
      'pcpn_5m': instance.values,
      'pcpn_type': instance.type,
    };
