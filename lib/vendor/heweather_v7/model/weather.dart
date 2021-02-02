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

  @override
  LiveCondition clone() {
    return LiveCondition();
  }
}