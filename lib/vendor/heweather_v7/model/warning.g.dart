// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warning.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Warning _$WarningFromJson(Map<String, dynamic> json) {
  return Warning(
    id: json['id'] as String,
    sender: json['sender'] as String,
    pubTime: json['pubTime'] == null
        ? null
        : DateTime.parse(json['pubTime'] as String),
    title: json['title'] as String,
    startTime: json['startTime'] == null
        ? null
        : DateTime.parse(json['startTime'] as String),
    endTime: json['endTime'] == null
        ? null
        : DateTime.parse(json['endTime'] as String),
    status: json['status'] as String,
    level: json['level'] as String,
    type: json['type'] as String,
    typeName: json['typeName'] as String,
    text: json['text'] as String,
    related: json['related'] as String,
  );
}

Map<String, dynamic> _$WarningToJson(Warning instance) => <String, dynamic>{
      'id': instance.id,
      'sender': instance.sender,
      'pubTime': instance.pubTime?.toIso8601String(),
      'title': instance.title,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'status': instance.status,
      'level': instance.level,
      'type': instance.type,
      'typeName': instance.typeName,
      'text': instance.text,
      'related': instance.related,
    };
