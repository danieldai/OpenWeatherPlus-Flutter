// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HourlyState _$HourlyStateFromJson(Map<String, dynamic> json) {
  return HourlyState(
    id: json['id'] as String,
    hourlyConditions: (json['hourlyConditions'] as List)
        ?.map((e) => e == null
            ? null
            : HourlyCondition.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HourlyStateToJson(HourlyState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hourlyConditions': instance.hourlyConditions,
    };
