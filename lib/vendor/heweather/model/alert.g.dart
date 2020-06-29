// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Alert _$AlertFromJson(Map<String, dynamic> json) {
  return Alert(
    cityId: json['cid'] as String,
    content: json['txt'] as String,
    level: json['level'] as String,
    title: json['title'] as String,
    type: json['type'] as String,
    status: json['stat'] as String,
  );
}

Map<String, dynamic> _$AlertToJson(Alert instance) => <String, dynamic>{
      'cid': instance.cityId,
      'level': instance.level,
      'stat': instance.status,
      'title': instance.title,
      'type': instance.type,
      'txt': instance.content,
    };

Alerts _$AlertsFromJson(Map<String, dynamic> json) {
  return Alerts(
    items: (json['alarm'] as List)
        ?.map(
            (e) => e == null ? null : Alert.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AlertsToJson(Alerts instance) => <String, dynamic>{
      'alarm': instance.items,
    };
