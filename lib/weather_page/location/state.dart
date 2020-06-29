// Copyright 2020 Daniel Dai (danieldai.com, mianjiajia.com)
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:fish_redux/fish_redux.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:owp/common/utils.dart';
import 'package:owp/vendor/amap/model.dart';
import 'package:owp/vendor/model.dart';
import 'package:owp/weather_page/location/details/state.dart';

import 'air/state.dart';
import 'daily/state.dart';
import 'hourly/state.dart';
import 'live/state.dart';

part 'state.g.dart';

enum UpdatingStatus {
  idle, updating, completed, failed, updateNeeded,
}

const String kDefaultBackgroundCode = '100d';

@JsonSerializable()
class LocationState implements Cloneable<LocationState> {
  String id;

  @JsonKey(ignore: true)
  String activeCityId;

  bool gps; // whether it's a gps location

  String name;

  //上次数据获取时间
  DateTime timestamp;

  @JsonKey(ignore: true)
  UpdatingStatus updatingStatus = UpdatingStatus.idle;

  HeCity city;
  GpsLocation gpsLocation;

  String get backgroundCode {
    var liveCondition = liveState?.liveCondition;
    int conditionId = liveCondition?.conditionCode ?? 100;
    var suffix = _dayOrNightNow(liveCondition);
    return '$conditionId$suffix';
  }

  LiveState liveState;
  HourlyState hourlyState;
  DailyState dailyState;

  LocationState({
    this.id,
    this.gps,
    this.timestamp,
    this.city,
    this.gpsLocation,
    this.name,
    this.liveState,
    this.hourlyState,
    this.dailyState,
  });

  LocationState.simple({this.id, this.name, this.gps=false}) {
    liveState = LiveState.empty(id);
    hourlyState = HourlyState(id:id);
    dailyState = DailyState(id:id);
  }

  factory LocationState.fromJson(Map<String, dynamic> parsedJson) => _$LocationStateFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$LocationStateToJson(this);

  @override
  LocationState clone() {
    return LocationState()
      ..id = id
      ..gps = gps
      ..timestamp = timestamp
      ..city = city
      ..gpsLocation = gpsLocation
      ..name = name
      ..liveState = liveState
      ..hourlyState = hourlyState
      ..dailyState = dailyState;
  }


}

//天气实况
class LiveConnector extends ConnOp<LocationState, LiveState> {
  @override
  LiveState get(LocationState state) {
    return state.liveState.clone();
  }

  @override
  void set(LocationState state, LiveState subState) {
    state.liveState = subState;
  }
}

//天气实况详情
class DetailsConnector extends ConnOp<LocationState, DetailsState> {
  @override
  DetailsState get(LocationState state) {
    return DetailsState()
      ..liveCondition = state?.liveState?.liveCondition
      ..dailyConditions = state?.dailyState?.dailyConditions;
  }

}

//小时天气
class HourlyConnector extends ConnOp<LocationState, HourlyState> {
  @override
  HourlyState get(LocationState state) {
    return state.hourlyState
      ..sunRise = state?.dailyState?.dailyConditions?.elementAt(0)?.sunRise
      ..sunSet = state?.dailyState?.dailyConditions?.elementAt(0)?.sunSet;
  }

  @override
  void set(LocationState state, HourlyState subState) {
    state.hourlyState = subState;
  }
}

//多天天气
class DailyConnector extends ConnOp<LocationState, DailyState> {
  @override
  DailyState get(LocationState state) {
    return state.dailyState;
  }

  @override
  void set(LocationState state, DailyState subState) {
    state.dailyState = subState;
  }
}

class AirConnector extends ConnOp<LocationState, AirState> {
  @override
  AirState get(LocationState state) {
    return AirState()..liveAqi = state?.liveState?.liveAqi;
  }

}

/// return 'd' on day and 'n' on night
String _dayOrNightNow(LiveCondition liveCondition) {
  var now = DateTime.now();
  DateTime sunRise = DateTime(now.year, now.month, now.day, 6); // TODO use real sun rise, sun set from heweather
  DateTime sunSet = DateTime(now.year, now.month, now.day, 18);

  sunRise = fromDateTime(sunRise, year: now.year, month: now.month, day: now.day);
  sunSet = fromDateTime(sunSet, year: now.year, month: now.month, day: now.day);

  var suffix = 'd';
  if (now.isBefore(sunRise) || now.isAfter(sunSet)) {
    suffix = 'n';
  }

  return suffix;
}