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
  /// 实况云量，百分比数值	23
  @JsonKey(name: 'cloud')
  String cloud;

  /// 实况露点温度	12
  @JsonKey(name: 'dew')
  String dew;

  /// 实况体感温度，默认单位：摄氏度	23
  @JsonKey(name: 'feelsLike')
  String feelsLike;

  /// 实况相对湿度，百分比数值	40
  @JsonKey(name: 'humidity')
  String humidity;

  /// 当前天气状况和图标的代码  100
  @JsonKey(name: 'icon')
  String icon;

  /// 实况观测时间	2013-12-30T01:45+08:00
  @JsonKey(name: 'obsTime')
  String obsTime;

  /// 实况降水量，默认单位：毫米	1.2
  @JsonKey(name: 'precip')
  String precip;

  /// 实况大气压强，默认单位：百帕	1020
  @JsonKey(name: 'pressure')
  String pressure;

  /// 实况温度，默认单位：摄氏度	21
  @JsonKey(name: 'temp')
  String temp;

  /// 实况天气状况的文字描述，包括阴晴雨雪等天气状态的描述	晴
  @JsonKey(name: 'text')
  String text;

  /// 实况能见度，默认单位：公里	10
  @JsonKey(name: 'vis')
  String vis;

  /// 实况风向360角度	305
  @JsonKey(name: 'wind360')
  String wind360;

  /// 实况风向	西北
  @JsonKey(name: 'windDir')
  String windDir;

  /// 实况风力等级	3
  @JsonKey(name: 'windScale')
  String windScale;

  /// 实况风速，公里/小时	15
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
  /// 逐小时预报云量，百分比数值	23
  @JsonKey(fromJson: int.parse, toJson: numToString)
  int cloud;

  /// 逐小时预报露点温度	12
  @JsonKey(fromJson: int.parse, toJson: numToString)
  int dew; // 露点温度

  /// 逐小时预报时间	2013-12-30T13:00+08:00
  @JsonKey(name: 'fxTime')
  DateTime fxTime;

  /// 逐小时预报相对湿度，百分比数值	40
  @JsonKey(name: 'humidity', fromJson: int.parse, toJson: numToString)
  int humidity;

  /// 逐小时预报天气状况图标代码，图标可通过天气状况和图标下载	101
  @JsonKey(name: 'icon')
  String icon;

  /// 逐小时预报降水概率，百分比数值，可能为空	5
  @JsonKey(fromJson: int.parse, toJson: numToString)
  int pop; // 降水概率

  /// 逐小时预报降水量，默认单位：毫米	1.2
  @JsonKey(name: 'precip')
  String precip;

  /// 逐小时预报大气压强，默认单位：百帕	1020
  @JsonKey(name: 'pressure', fromJson: int.parse, toJson: numToString)
  int pressure;

  /// 逐小时预报温度	2
  @JsonKey(name: 'temp', fromJson: int.parse, toJson: numToString)
  int temp;

  /// 逐小时预报天气状况文字描述，包括阴晴雨雪等天气状态的描述	多云
  @JsonKey(name: 'text')
  String text;

  /// 逐小时预报风向360角度	305
  @JsonKey(name: 'wind360', fromJson: int.parse, toJson: numToString)
  int wind360;

  /// 逐小时预报风向	西北
  @JsonKey(name: 'windDir')
  String windDir;

  /// 逐小时预报风力等级	3
  @JsonKey(name: 'windScale', fromJson: int.parse, toJson: numToString)
  int windScale;

  /// 逐小时预报风速，公里/小时	15
  @JsonKey(name: 'windSpeed', fromJson: double.parse, toJson: numToString)
  double windSpeed;



  HourlyCondition({
    this.cloud,
    this.dew,
    this.fxTime,
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
      ..fxTime = fxTime
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
    return 'HourlyCondition{fxTime: $fxTime, condition: $text: temp: $temp}';
  }

}


// https://dev.qweather.com/docs/api/weather/
@JsonSerializable()
class DailyCondition implements Cloneable<DailyCondition> {
  /// 预报当天云量，百分比数值 23
  @JsonKey(name: 'cloud', fromJson: int.parse, toJson: numToString)
  int cloud;

  /// 预报日期 2013-05-31
  @JsonKey(name: 'fxDate')
  DateTime fxDate;

  /// 预报当天相对湿度，百分比数值 40
  @JsonKey(name: 'humidity', fromJson: int.parse, toJson: numToString)
  int humidity;

  /// 预报白天天气状况的图标代码 100
  @JsonKey(name: 'iconDay')
  String iconDay;

  /// 预报夜间天气状况的图标代码 100
  @JsonKey(name: 'iconNight')
  String iconNight;

  /// 月相名称	满月
  @JsonKey(name: 'moonPhase')
  String moonPhase;

  /// 月升时间	16:09
  @JsonKey(name: 'moonrise')
  String moonrise;

  /// 月落时间	04:21
  @JsonKey(name: 'moonset')
  String moonset;

  /// 预报当天降水量，默认单位：毫米 1.2
  @JsonKey(name: 'precip', fromJson: double.parse, toJson: numToString)
  double precipitation;

  /// 预报当天大气压强，默认单位：百帕 1020
  @JsonKey(name: 'pres', fromJson: int.parse, toJson: numToString)
  int pressure;

  /// 日出时间 07:34
  @JsonKey(name: 'sunrise')
  String sunrise;

  /// 日落时间	17:21
  @JsonKey(name: 'sunset')
  String sunset;

  // 预报当天最高温度	4
  @JsonKey(name: 'tempMax', fromJson: int.parse, toJson: numToString)
  int tempMax;

  /// 预报当天最低温度	-5
  @JsonKey(name: 'tempMin', fromJson: int.parse, toJson: numToString)
  int tempMin;

  /// 预报白天天气状况文字描述 晴
  @JsonKey(name: 'textDay')
  String textDay;

  /// 预报晚间天气状况文字描述 晴
  @JsonKey(name: 'textNight')
  String textNight;

  /// 预报当天紫外线强度指数 3
  @JsonKey(name: 'uvIndex', fromJson: int.parse, toJson: numToString)
  int uvIndex;

  /// 预报当天能见度，默认单位：公里 	10
  @JsonKey(name: 'vis', fromJson: int.parse, toJson: numToString)
  int vis;

  /// 预报白天风向360角度  305
  @JsonKey(name: 'wind360Day', fromJson: int.parse, toJson: numToString)
  int wind360Day;

  /// 预报夜间风向360角度 305
  @JsonKey(name: 'wind360Night', fromJson: int.parse, toJson: numToString)
  int wind360Night;

  /// 预报白天风向  西北
  @JsonKey(name: 'windDirDay')
  String windDirDay;

  /// 预报夜间当天风向 西北
  @JsonKey(name: 'windDirNight')
  String windDirNight;

  /// 预报白天风力等级 3-4
  @JsonKey(name: 'windScaleDay')
  String windScaleDay;

  /// 预报夜间风力等级 3-4
  @JsonKey(name: 'windScaleNight')
  String windScaleNight;

  /// 预报白天风速，公里/小时 15
  @JsonKey(name: 'windSpeedDay', fromJson: double.parse, toJson: numToString)
  double windSpeedDay;

  /// 预报夜间风速，公里/小时 15
  @JsonKey(name: 'windSpeedNight', fromJson: double.parse, toJson: numToString)
  double windSpeedNight;


  DailyCondition({
    this.cloud,
    this.fxDate,
    this.humidity,
    this.iconDay,
    this.iconNight,
    this.moonPhase,
    this.moonrise,
    this.moonset,
    this.precipitation,
    this.pressure,
    this.sunrise,
    this.sunset,
    this.tempMax,
    this.tempMin,
    this.textDay,
    this.textNight,
    this.uvIndex,
    this.vis,
    this.wind360Day,
    this.wind360Night,
    this.windDirDay,
    this.windDirNight,
    this.windScaleDay,
    this.windScaleNight,
    this.windSpeedDay,
    this.windSpeedNight,
  });

  // factory DailyCondition.fromJson(Map<String, dynamic> parsedJson) => _$DailyConditionFromJson(parsedJson);

  // Map<String, dynamic> toJson() => _$DailyConditionToJson(this);

  @override
  DailyCondition clone() {
    return DailyCondition()
      ..cloud = cloud
      ..fxDate = fxDate
      ..humidity = humidity
      ..iconDay = iconDay
      ..iconNight = iconNight
      ..moonPhase = moonPhase
      ..moonrise = moonrise
      ..moonset = moonset
      ..precipitation = precipitation
      ..pressure = pressure
      ..sunrise = sunrise
      ..sunset = sunset
      ..tempMax = tempMax
      ..tempMin = tempMin
      ..textDay = textDay
      ..textNight = textNight
      ..uvIndex = uvIndex
      ..vis = vis
      ..wind360Day = wind360Day
      ..wind360Night = wind360Night
    ..windDirDay = windDirDay
    ..windDirNight = windDirNight
    ..windScaleDay = windScaleDay
    ..windScaleNight = windScaleNight
    ..windSpeedDay = windSpeedDay
    ..windSpeedNight = windSpeedNight;
  }

  @override
  String toString() {
    return 'DailyCondition{ date: $fxDate, textDay: $textDay}';
  }
}