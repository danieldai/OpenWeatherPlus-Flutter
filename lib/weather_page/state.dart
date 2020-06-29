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
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:owp/constants.dart';

import 'header/state.dart';
import 'location/state.dart';

part 'state.g.dart';

@JsonSerializable()
class WeatherState extends MutableSource implements Cloneable<WeatherState> {
  List<LocationState> locationStates;

  @JsonKey(ignore: true)
  int activeIndex;

  @JsonKey(ignore: true)
  String activeCityId;

  @JsonKey(ignore: true)
  PageController controller;

  WeatherState({this.locationStates, this.activeIndex = 0}) {
    controller = PageController(initialPage: activeIndex, keepPage: true);
    activeCityId = locationStates?.elementAt(activeIndex)?.id;
  }

  factory WeatherState.empty() {
    return WeatherState()
      ..locationStates = []
      ..activeIndex = 0;
  }

  factory WeatherState.onlyGpsLocation() {
    List<LocationState> locationStates = [
      LocationState.simple(
          id: GPS_LOCATION_ID,
          gps: true,
          name: '定位中...'),
    ];

    return WeatherState()
      ..locationStates = locationStates
      ..activeIndex = 0
      ..activeCityId = locationStates[0].id;
  }

  factory WeatherState.onlyIdLocation() {
    List<LocationState> locationStates = [
      LocationState.simple(
          id: 'CN101010100',
          gps: false,
          name: '北京市'),
      LocationState.simple(
          id: 'CN101020100',
          gps: false,
          name: '上海市'),
    ];

    return WeatherState()
      ..locationStates = locationStates
      ..activeIndex = 0
      ..activeCityId = locationStates[0].id;
  }

  //Used to setup test locations
  factory WeatherState.testLocations() {
    List<LocationState> locationStates = [
      LocationState.simple(
          id: GPS_LOCATION_ID,
          gps: true,
          name: '定位中...'),
      LocationState.simple(
          id: 'CN101020100',
          gps: false,
          name: '上海市'),
    ];

    return WeatherState()
      ..locationStates = locationStates
      ..activeIndex = 0
      ..activeCityId = locationStates[0].id;
  }

//  factory WeatherState.fromJson(Map<String, dynamic> parsedJson)=> _$WeatherStateFromJson(parsedJson);
//
//  Map<String, dynamic> toJson() => _$WeatherStateToJson(this);

  @override
  WeatherState clone() {
    return WeatherState()
      ..locationStates = locationStates
      ..controller = controller
      ..activeIndex = activeIndex
      ..activeCityId = activeCityId;
  }

  @override
  Object getItemData(int index) {
    return locationStates[index]..activeCityId=activeCityId;
  }

  @override
  String getItemType(int index) {
    return 'locationWeather';
  }

  @override
  int get itemCount => locationStates?.length ?? 0;

  @override
  void setItemData(int index, Object data) {
    locationStates[index] = data;
  }
}

WeatherState initState(Map<String, dynamic> params) {
  return WeatherState.onlyIdLocation(); // TODO
}

class HeaderConnector extends ConnOp<WeatherState, HeaderState>
    with ReselectMixin<WeatherState, HeaderState>{

  @override
  void set(WeatherState state, HeaderState subState) {
    // do nothing
  }

  @override
  List<dynamic> factors(WeatherState state) {
    return <int>[state.activeIndex];
  }

  @override
  HeaderState computed(WeatherState state) {
    var s = HeaderState()
      ..locationStates = state.locationStates
      ..activeIndex = state.activeIndex;

    return s;
  }
}
