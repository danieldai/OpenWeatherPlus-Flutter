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

import '../../utils.dart';

part 'air.g.dart';


/*
 * 空气质量实况
 * https://api.heweather.net/s6/air/now
 */
@JsonSerializable()
class LiveAqi implements Cloneable<LiveAqi> {
  //此数据的更新时间
  DateTime timestamp;

  @JsonKey(name: 'aqi', fromJson: double.parse, toJson: numToString)
  double value;

  @JsonKey(name: 'qlty')
  String quality;

  @JsonKey(name: 'main')
  String mainSource;

  @JsonKey(fromJson: double.parse, toJson: numToString)
  double co;

  @JsonKey(fromJson: double.parse, toJson: numToString)
  double no2;

  @JsonKey(fromJson: double.parse, toJson: numToString)
  double o3;

  @JsonKey(fromJson: double.parse, toJson: numToString)
  double pm10;

  @JsonKey(fromJson: double.parse, toJson: numToString)
  double pm25;

  @JsonKey(fromJson: double.parse, toJson: numToString)
  double so2;

  @JsonKey(name: 'pub_time')
  DateTime pubtime;


  LiveAqi({
    this.quality,
    this.value,
    this.mainSource,
    this.co,
    this.no2,
    this.o3,
    this.pm10,
    this.pm25,
    this.so2,
    this.pubtime,
  });

  factory LiveAqi.fromJson(Map<String, dynamic> parsedJson) => _$LiveAqiFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$LiveAqiToJson(this);

  @override
  LiveAqi clone() {
    return LiveAqi()
      ..quality = quality
      ..mainSource = mainSource
      ..co = co
      ..no2 = no2
      ..o3 = o3
      ..pm10 = pm10
      ..pm25 = pm25
      ..pubtime = pubtime
      ..so2 = so2
      ..value = value;
  }

  @override
  String toString() {
    return 'LiveAqi{value: $value: pm25: $pm25 pubtime: $pubtime}';
  }
}


@JsonSerializable()
class DailyAqi implements Cloneable<DailyAqi> {
  DateTime date;

  @JsonKey(name: 'aqi', fromJson: int.parse, toJson: numToString)
  int value;

  @JsonKey(name: 'qlty')
  String quality;

  @JsonKey(name: 'main')
  String mainSource;

  DailyAqi({this.date, this.value, this.quality, this. mainSource});

  factory DailyAqi.fromJson(Map<String, dynamic> parsedJson) => _$DailyAqiFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$DailyAqiToJson(this);


  @override
  DailyAqi clone() {
    return DailyAqi()
      ..date = date
      ..quality = quality
      ..mainSource = mainSource
      ..value = value;
  }

  @override
  String toString() {
    return 'DailyAqi{date: $date, value: $value}';
  }
}