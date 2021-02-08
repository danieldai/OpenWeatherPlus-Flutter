// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeLocation _$HeLocationFromJson(Map<String, dynamic> json) {
  return HeLocation(
    id: json['id'] as String,
    name: json['name'] as String,
    lat: double.parse(json['lat'] as String),
    lon: double.parse(json['lon'] as String),
    adm2: json['adm2'] as String,
    adm1: json['adm1'] as String,
    country: json['country'] as String,
    tz: json['tz'] as String,
    utcOffset: json['utcOffset'] as String,
    isDst: json['isDst'] as String,
    type: json['type'] as String,
    rank: json['rank'] as int,
    fxLink: json['fxLink'] as String,
  );
}

Map<String, dynamic> _$HeLocationToJson(HeLocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lat': numToString(instance.lat),
      'lon': numToString(instance.lon),
      'adm2': instance.adm2,
      'adm1': instance.adm1,
      'country': instance.country,
      'tz': instance.tz,
      'utcOffset': instance.utcOffset,
      'isDst': instance.isDst,
      'type': instance.type,
      'rank': instance.rank,
      'fxLink': instance.fxLink,
    };
