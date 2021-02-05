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
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../utils.dart';
part 'weather.g.dart';

/*
 * 天气实况数据
 * https://dev.qweather.com/docs/api/weather/
 * https://api.qweather.com/v7/weather/now
 */
@JsonSerializable()
class LiveCondition implements Cloneable<LiveCondition> {

  @JsonKey(name: 'cloud')
  String cloud;

  @JsonKey(name: 'dew')
  String dew;

  @JsonKey(name: 'feelsLike')
  String feelsLike;

  @JsonKey(name: 'humidity')
  String humidity;

  @JsonKey(name: 'icon')
  String icon;

  @JsonKey(name: 'obsTime')
  String obsTime;

  @JsonKey(name: 'precip')
  String precip;

  @JsonKey(name: 'pressure')
  String pressure;

  @JsonKey(name: 'temp')
  String temp;

  @JsonKey(name: 'text')
  String text;

  @JsonKey(name: 'vis')
  String vis;

  @JsonKey(name: 'wind360')
  String wind360;

  @JsonKey(name: 'windDir')
  String windDir;

  @JsonKey(name: 'windScale')
  String windScale;

  @JsonKey(name: 'windSpeed')
  String windSpeed;

  LiveCondition({
    this.cloud,
    this.dew,
    this.feelsLike,
    this.humidity,
    this.icon,
    this.obsTime,
    this.precip,
    this.pressure,
    this.temp,
    this.vis,
    this.text,
    this.wind360,
    this.windDir,
    this.windScale,
    this.windSpeed,
  });

  factory LiveCondition.fromJson(Map<String, dynamic> parsedJson) => _$LiveConditionFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$LiveConditionToJson(this);

  @override
  LiveCondition clone() {
    return LiveCondition()
        ..cloud = cloud
        ..dew = dew
        ..feelsLike = feelsLike
        ..humidity = humidity
        ..icon = icon
        ..obsTime = obsTime
        ..precip = precip
        ..pressure = pressure
        ..temp = temp
        ..vis = vis
        ..text = text
        ..wind360 = wind360
        ..windDir = windDir
        ..windScale = windScale
        ..windSpeed = windSpeed;
  }

  @override
  String toString() {
    return 'LiveCondition{condition: $text: temp: $temp}';
  }
}

@JsonSerializable()
class HourlyCondition implements Cloneable<HourlyCondition> {
  @JsonKey(fromJson: int.parse, toJson: numToString)
  int cloud;

  @JsonKey(fromJson: int.parse, toJson: numToString)
  int dew; // 露点温度

  @JsonKey(name: 'fxTime')
  DateTime hour;

  @JsonKey(name: 'humidity', fromJson: int.parse, toJson: numToString)
  int humidity;

  @JsonKey(name: 'icon')
  String icon;

  @JsonKey(fromJson: int.parse, toJson: numToString)
  int pop; // 降水概率

  @JsonKey(name: 'precip')
  String precip;

  @JsonKey(name: 'pressure', fromJson: int.parse, toJson: numToString)
  int pressure;

  @JsonKey(name: 'temp', fromJson: int.parse, toJson: numToString)
  int temp;

  @JsonKey(name: 'text')
  String text;

  @JsonKey(name: 'wind360', fromJson: int.parse, toJson: numToString)
  int wind360;

  @JsonKey(name: 'windDir')
  String windDir;

  @JsonKey(name: 'windScale', fromJson: int.parse, toJson: numToString)
  int windScale;

  @JsonKey(name: 'windSpeed', fromJson: double.parse, toJson: numToString)
  double windSpeed;



  HourlyCondition({
    this.cloud,
    this.dew,
    this.hour,
    this.humidity,
    this.icon,
    this.pop,
    this.precip,
    this.pressure,
    this.temp,
    this.text,
    this.wind360,
    this.windDir,
    this.windScale,
    this.windSpeed,
  });

  factory HourlyCondition.fromJson(Map<String, dynamic> parsedJson) => _$HourlyConditionFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$HourlyConditionToJson(this);

  @override
  HourlyCondition clone() {
    return HourlyCondition()
      ..cloud = cloud
      ..dew = dew
      ..hour = hour
      ..humidity = humidity
      ..icon = icon
      ..pop = pop
      ..precip = precip
      ..pressure = pressure
      ..temp = temp
      ..text = text
      ..wind360 = wind360
      ..windDir = windDir
      ..windScale = windScale
      ..windSpeed = windSpeed;
  }

  @override
  String toString() {
    return 'HourlyCondition{hour: $hour, condition: $text: temp: $temp}';
  }

}