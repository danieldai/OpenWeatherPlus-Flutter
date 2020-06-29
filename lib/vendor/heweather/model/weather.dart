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
 * https://api.heweather.net/s6/weather/now
 */
@JsonSerializable()
class LiveCondition implements Cloneable<LiveCondition> {

  //此数据的更新时间
  DateTime timestamp;

  //实况名称
  @JsonKey(name: 'cond_txt')
  String conditionText;

  //实况代码 根据实况代码显示 天气图标和天气背景
  @JsonKey(name: 'cond_code', fromJson: int.parse, toJson: numToString)
  int conditionCode;

  //温度
  @JsonKey(name: 'tmp', fromJson: int.parse, toJson: numToString)
  int temp;

  //体感温度
  @JsonKey(name: 'fl', fromJson: int.parse, toJson: numToString)
  int feel;

  //大气压
  @JsonKey(name: 'pres', fromJson: int.parse, toJson: numToString)
  int pressure;

  //空气相对湿度
  @JsonKey(name: 'hum', fromJson: int.parse, toJson: numToString)
  int humidity;

  //能见度
  @JsonKey(fromJson: int.parse, toJson: numToString)
  int vis;

  //风向，角度
  @JsonKey(name: 'wind_deg', fromJson: int.parse, toJson: numToString)
  int windDegree;

  //风向，文字
  @JsonKey(name: 'wind_dir')
  String windDir;

  //风力
  @JsonKey(name: 'wind_sc')
  String windLevel;

  //风速
  @JsonKey(name: 'wind_spd', fromJson: double.parse, toJson: numToString)
  double windSpeed;

  //和风特有属性
  @JsonKey(fromJson: int.parse, toJson: numToString)
  int cloud;

  @JsonKey(name: 'pcpn', fromJson: double.parse, toJson: numToString)
  double precipitation;

  LiveCondition({
    this.timestamp,
    this.cloud,
    this.conditionCode,
    this.conditionText,
    this.feel,
    this.humidity,
    this.precipitation,
    this.pressure,
    this.temp,
    this.vis,
    this.windDegree,
    this.windDir,
    this.windSpeed,
    this.windLevel,
  });

  factory LiveCondition.fromJson(Map<String, dynamic> parsedJson) => _$LiveConditionFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$LiveConditionToJson(this);

  @override
  LiveCondition clone() {
    return LiveCondition()
      ..timestamp = timestamp
      ..cloud = cloud
      ..conditionCode = conditionCode
      ..conditionText = conditionText
      ..feel = feel
      ..humidity = humidity
      ..precipitation = precipitation
      ..pressure = pressure
      ..temp = temp
      ..vis = vis
      ..windDegree = windDegree
      ..windDir = windDir
      ..windSpeed = windSpeed
      ..windLevel = windLevel;
  }

  @override
  String toString() {
    return 'LiveCondition{condition: $conditionText: temp: $temp}';
  }
}


//生活指数
@JsonSerializable()
class HeIndexItem implements Cloneable<HeIndexItem> {
  static const TYPES = {
    'comf': '舒适度指数',
    'cw': '洗车指数',
    'drsg': '穿衣指数',
    'flu': '感冒指数',
    'sport': '运动指数',
    'trav': '旅游指数',
    'uv': '紫外线指数',
    'air': '空气污染扩散条件指数',
    'ac': '空调开启指数',
    'ag': '过敏指数',
    'gl': '太阳镜指数',
    'mu': '化妆指数',
    'airc': '晾晒指数',
    'ptfc': '交通指数',
    'fsh': '钓鱼指数',
    'spi': '防晒指数',
  };

  @JsonKey(name: 'type')
  String type;

  @JsonKey(ignore: true)
  String name;

  @JsonKey(name: 'brf')
  String status;

  @JsonKey(name: 'txt')
  String desc;

  HeIndexItem({
    this.type,
    this.status,
    this.desc,
  }){
    name = TYPES[type];
  }

  factory HeIndexItem.fromJson(Map<String, dynamic> parsedJson) => _$HeIndexItemFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$HeIndexItemToJson(this);

  @override
  HeIndexItem clone() {
    return HeIndexItem()
      ..type = type
      ..name = name
      ..status = status
      ..desc = desc;
  }

  @override
  String toString() {
    return 'IndexItem{name: $name type: $type: status: $status}';
  }
}

@JsonSerializable()
class HeLifeIndex implements Cloneable<HeLifeIndex> {
  List<HeIndexItem> items;

  HeLifeIndex({this.items});

  factory HeLifeIndex.fromJson(Map<String, dynamic> parsedJson)  => _$HeLifeIndexFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$HeLifeIndexToJson(this);

  @override
  HeLifeIndex clone() {
    return HeLifeIndex()
      ..items = items;
  }
}


@JsonSerializable()
class HourlyCondition implements Cloneable<HourlyCondition> {
  @JsonKey(name: 'time')
  DateTime hour;

  @JsonKey(name: 'tmp', fromJson: int.parse, toJson: numToString)
  int temp;

  @JsonKey(name: 'cond_txt')
  String conditionText;

  @JsonKey(name: 'cond_code', fromJson: int.parse, toJson: numToString)
  int conditionCode;

  @JsonKey(name: 'hum', fromJson: int.parse, toJson: numToString)
  int humidity;

  @JsonKey(name: 'pres', fromJson: int.parse, toJson: numToString)
  int pressure;

  @JsonKey(name: 'wind_deg', fromJson: int.parse, toJson: numToString)
  int windDegree;

  @JsonKey(name: 'wind_dir')
  String windDir;

  @JsonKey(ignore: true)
  int windLevel;

  @JsonKey(name: 'wind_spd', fromJson: double.parse, toJson: numToString)
  double windSpeed;

  @JsonKey(fromJson: int.parse, toJson: numToString)
  int cloud;

  @JsonKey(fromJson: int.parse, toJson: numToString)
  int pop; // 降水概率


  @JsonKey(fromJson: int.parse, toJson: numToString)
  int dew; // 露点温度

  HourlyCondition({
    this.conditionText,
    this.cloud,
    this.conditionCode,
    this.humidity,
    this.dew,
    this.pop,
    this.pressure,
    this.hour,
    this.temp,
    this.windDegree,
    this.windDir,
    this.windSpeed,
  }){
    this.windLevel = _windSpeedToLevel(windSpeed);
  }

  factory HourlyCondition.fromJson(Map<String, dynamic> parsedJson) => _$HourlyConditionFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$HourlyConditionToJson(this);

  @override
  HourlyCondition clone() {
    return HourlyCondition()
      ..conditionText = conditionText
      ..cloud = cloud
      ..conditionCode = conditionCode
      ..humidity = humidity
      ..dew = dew
      ..pop = pop
      ..pressure = pressure
      ..hour = hour
      ..temp = temp
      ..windDegree = windDegree
      ..windDir = windDir
      ..windSpeed = windSpeed
      ..windLevel = windLevel;
  }

  @override
  String toString() {
    return 'HourlyCondition{hour: $hour, condition: $conditionText: temp: $temp}';
  }

  _windSpeedToLevel(double speed) {
    if (speed <= 1) {
      return 0;
    } else if (speed <= 6) {
      return 1;
    } else if (speed <= 12) {
      return 2;
    } else if (speed <= 20) {
      return 3;
    } else if (speed <= 29) {
      return 4;
    } else if (speed <= 39) {
      return 5;
    } else if (speed <= 50) {
      return 6;
    } else if (speed <= 62) {
      return 7;
    } else if (speed <= 75) {
      return 8;
    } else if (speed <= 89) {
      return 9;
    } else if (speed <= 103) {
      return 10;
    } else if (speed <= 118) {
      return 11;
    } else if (speed <= 134) {
      return 12;
    } else if (speed <= 150) {
      return 13;
    } else if (speed <= 167) {
      return 14;
    } else if (speed <= 184) {
      return 15;
    } else if (speed <= 202) {
      return 16;
    } else if (speed <= 221) {
      return 17;
    } else {
      return 18;
    }
  }
}

@JsonSerializable()
class DailyCondition implements Cloneable<DailyCondition> {
  @JsonKey(name: 'cond_txt_d')
  String conditionDay;

  @JsonKey(name: 'cond_txt_n')
  String conditionNight;

  @JsonKey(name: 'cond_code_d', fromJson: int.parse, toJson: numToString)
  int conditionIdDay;

  @JsonKey(name: 'cond_code_n', fromJson: int.parse, toJson: numToString)
  int conditionIdNight;

  @JsonKey(name: 'date')
  DateTime predictDate;

  @JsonKey(name: 'pcpn', fromJson: double.parse, toJson: numToString)
  double precipitation;

  @JsonKey(name: 'hum', fromJson: int.parse, toJson: numToString)
  int humidity;

  @JsonKey(fromJson: int.parse, toJson: numToString)
  int pop; // 降水概率

  @JsonKey(name: 'pres', fromJson: int.parse, toJson: numToString)
  int pressure;

  @JsonKey(name: 'sr')
  String sunrise; // 示例 6:00

  @JsonKey(name: 'ss')
  String sunset; // 示例 18:00

  @JsonKey(ignore: true)
  DateTime get sunRise => DateTime.parse("${DateFormat('yyyy-MM-dd').format(predictDate)} $sunrise:00");

  @JsonKey(ignore: true)
  DateTime get sunSet => DateTime.parse("${DateFormat('yyyy-MM-dd').format(predictDate)} $sunset:00");

  @JsonKey(name: 'tmp_max', fromJson: int.parse, toJson: numToString)
  int tempMax;

  @JsonKey(name: 'tmp_min', fromJson: int.parse, toJson: numToString)
  int tempMin;

  @JsonKey(name: 'uv_index', fromJson: int.parse, toJson: numToString)
  int uvi;

  @JsonKey(name: 'vis', fromJson: int.parse, toJson: numToString)
  int vis;

  @JsonKey(name: 'wind_deg', fromJson: int.parse, toJson: numToString)
  int windDegree;

  @JsonKey(name: 'wind_dir')
  String windDir;

  @JsonKey(name: 'wind_sc')
  String windLevel;

  @JsonKey(name: 'wind_spd', fromJson: double.parse, toJson: numToString)
  double windSpeed;

  DailyCondition({
    this.conditionDay,
    this.conditionIdDay,
    this.conditionIdNight,
    this.conditionNight,
    this.predictDate,
    this.precipitation,
    this.humidity,
    this.pop,
    this.pressure,
    this.sunrise,
    this.sunset,
    this.tempMax,
    this.tempMin,
    this.uvi,
    this.vis,
    this.windDegree,
    this.windDir,
    this.windLevel,
    this.windSpeed,
  });

  factory DailyCondition.fromJson(Map<String, dynamic> parsedJson) => _$DailyConditionFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$DailyConditionToJson(this);

  @override
  DailyCondition clone() {
    return DailyCondition()
      ..conditionDay = conditionDay
      ..conditionIdDay = conditionIdDay
      ..conditionIdNight = conditionIdNight
      ..conditionNight = conditionNight
      ..predictDate = predictDate
      ..precipitation = precipitation
      ..humidity = humidity
      ..pop = pop
      ..pressure = pressure
      ..sunrise = sunrise
      ..sunset = sunset
      ..tempMax = tempMax
      ..tempMin = tempMin
      ..uvi = uvi
      ..vis = vis
      ..windDegree = windDegree
      ..windDir = windDir
      ..windLevel = windLevel
      ..windSpeed = windSpeed;
  }

  @override
  String toString() {
    return 'DailyCondition{ date: $predictDate, conditionDay: $conditionDay}';
  }
}

