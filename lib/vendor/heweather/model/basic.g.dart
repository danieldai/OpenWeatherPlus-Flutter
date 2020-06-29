// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeCity _$HeCityFromJson(Map<String, dynamic> json) {
  return HeCity(
    id: json['cid'] as String,
    name: json['location'] as String,
    parentCity: json['parent_city'] as String,
    adminArea: json['admin_area'] as String,
    country: json['cnty'] as String,
    latitude: double.parse(json['lat'] as String),
    longitude: double.parse(json['lon'] as String),
    tz: json['tz'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$HeCityToJson(HeCity instance) => <String, dynamic>{
      'cid': instance.id,
      'location': instance.name,
      'parent_city': instance.parentCity,
      'admin_area': instance.adminArea,
      'cnty': instance.country,
      'lat': numToString(instance.latitude),
      'lon': numToString(instance.longitude),
      'tz': instance.tz,
      'type': instance.type,
    };
