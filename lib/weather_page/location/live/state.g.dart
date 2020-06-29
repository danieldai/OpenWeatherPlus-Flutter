// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveState _$LiveStateFromJson(Map<String, dynamic> json) {
  return LiveState(
    id: json['id'] as String,
    liveCondition: json['liveCondition'] == null
        ? null
        : LiveCondition.fromJson(json['liveCondition'] as Map<String, dynamic>),
    liveAqi: json['liveAqi'] == null
        ? null
        : LiveAqi.fromJson(json['liveAqi'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LiveStateToJson(LiveState instance) => <String, dynamic>{
      'id': instance.id,
      'liveCondition': instance.liveCondition,
      'liveAqi': instance.liveAqi,
    };
