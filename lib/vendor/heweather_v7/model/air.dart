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
  @JsonKey(name: 'aqi', fromJson: double.parse, toJson: numToString)
  double value;

  @JsonKey(name: 'category')
  String category;

  @JsonKey(name: 'level')
  String level;

  @JsonKey(fromJson: double.parse, toJson: numToString)
  double co;

  @JsonKey(fromJson: double.parse, toJson: numToString)
  double no2;

  @JsonKey(fromJson: double.parse, toJson: numToString)
  double o3;

  @JsonKey(fromJson: double.parse, toJson: numToString)
  double pm10;

  @JsonKey(fromJson: double.parse, toJson: numToString)
  double pm2p5;

  @JsonKey(name: 'primary')
  String primary;

  @JsonKey(name: 'pubTime')
  DateTime pubTime;

  @JsonKey(fromJson: double.parse, toJson: numToString)
  double so2;

  LiveAqi({
    this.value,
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
      ..value = value
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
    return 'LiveAqi{value: $value: pm25: $pm2p5 pubtime: $pubTime}';
  }
}
