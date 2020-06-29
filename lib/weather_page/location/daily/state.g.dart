// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyState _$DailyStateFromJson(Map<String, dynamic> json) {
  return DailyState(
    id: json['id'] as String,
    dailyConditions: (json['dailyConditions'] as List)
        ?.map((e) => e == null
            ? null
            : DailyCondition.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    dailyAqis: (json['dailyAqis'] as List)
        ?.map((e) =>
            e == null ? null : DailyAqi.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DailyStateToJson(DailyState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dailyConditions': instance.dailyConditions,
      'dailyAqis': instance.dailyAqis,
    };
