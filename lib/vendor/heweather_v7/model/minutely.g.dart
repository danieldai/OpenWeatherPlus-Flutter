// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'minutely.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Minutely _$MinutelyFromJson(Map<String, dynamic> json) {
  return Minutely(
    fxTime: json['fxTime'] == null
        ? null
        : DateTime.parse(json['fxTime'] as String),
    precip: double.parse(json['precip'] as String),
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$MinutelyToJson(Minutely instance) => <String, dynamic>{
      'fxTime': instance.fxTime?.toIso8601String(),
      'precip': numToString(instance.precip),
      'type': instance.type,
    };
