// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GpsLocation _$GpsLocationFromJson(Map<String, dynamic> json) {
  return GpsLocation(
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
    country: json['country'] as String,
    province: json['province'] as String,
    city: json['city'] as String,
    district: json['district'] as String,
    street: json['street'] as String,
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
    formattedAddress: json['formattedAddress'] as String,
  );
}

Map<String, dynamic> _$GpsLocationToJson(GpsLocation instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp?.toIso8601String(),
      'country': instance.country,
      'province': instance.province,
      'city': instance.city,
      'district': instance.district,
      'street': instance.street,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'formattedAddress': instance.formattedAddress,
    };
