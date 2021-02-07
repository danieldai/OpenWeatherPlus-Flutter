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

part 'air.g.dart';

/// https://dev.qweather.com/docs/api/air/
@JsonSerializable()
class LiveAqi implements Cloneable<LiveAqi> {
  /// 实时空气质量指数	74
  @JsonKey(name: 'aqi', fromJson: double.parse, toJson: numToString)
  double aqi;

  /// 实时空气质量指数级别	良
  @JsonKey(name: 'category')
  String category;

  /// 实时空气质量指数等级	2
  @JsonKey(name: 'level')
  String level;

  /// 实时 一氧化碳	33
  @JsonKey(fromJson: double.parse, toJson: numToString)
  double co;

  /// 实时 二氧化氮	40
  @JsonKey(fromJson: double.parse, toJson: numToString)
  double no2;

  /// 实时 臭氧	20
  @JsonKey(fromJson: double.parse, toJson: numToString)
  double o3;

  /// 实时 pm10	78
  @JsonKey(fromJson: double.parse, toJson: numToString)
  double pm10;

  /// 实时 pm2.5	66
  @JsonKey(fromJson: double.parse, toJson: numToString)
  double pm2p5;

  /// 实时空气质量的主要污染物，空气质量为优时，返回值为NA	pm2.5
  @JsonKey(name: 'primary')
  String primary;

  /// 实时空气质量数据发布时间	2013-12-30T01:45+08:00
  @JsonKey(name: 'pubTime')
  DateTime pubTime;

  /// 实时 二氧化硫	30
  @JsonKey(fromJson: double.parse, toJson: numToString)
  double so2;

  LiveAqi({
    this.aqi,
    this.category,
    this.level,
    this.co,
    this.no2,
    this.o3,
    this.pm10,
    this.pm2p5,
    this.primary,
    this.pubTime,
    this.so2,
  });

  factory LiveAqi.fromJson(Map<String, dynamic> parsedJson) =>
      _$LiveAqiFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$LiveAqiToJson(this);

  @override
  LiveAqi clone() {
    return LiveAqi()
      ..aqi = aqi
      ..category = category
      ..level = level
      ..co = co
      ..no2 = no2
      ..o3 = o3
      ..pm10 = pm10
      ..pm2p5 = pm2p5
      ..primary = primary
      ..pubTime = pubTime
      ..so2 = so2;
  }

  @override
  String toString() {
    return 'LiveAqi{aqi: $aqi: pm25: $pm2p5 pubTime: $pubTime}';
  }
}

@JsonSerializable()
class DailyAqi implements Cloneable<DailyAqi> {
  @JsonKey(name: 'fxDate')
  DateTime date;

  @JsonKey(name: 'aqi', fromJson: int.parse, toJson: numToString)
  int value;

  @JsonKey(name: 'category')
  String category;

  @JsonKey(name: 'level')
  String level;

  @JsonKey(name: 'primary')
  String primary;

  DailyAqi({this.date, this.value, this.category, this. level, this.primary});

  factory DailyAqi.fromJson(Map<String, dynamic> parsedJson) => _$DailyAqiFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$DailyAqiToJson(this);

  @override
  DailyAqi clone() {
    return DailyAqi()
      ..date = date
      ..value = value
        ..category = category
        ..level = level
        ..primary = primary;
  }

  @override
  String toString() {
    return 'DailyAqi{date: $date, value: $value}';
  }
}

