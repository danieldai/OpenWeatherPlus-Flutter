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

part 'minutely.g.dart';

/// 分钟级降水
///
/// 和风天气分钟级降水API接口提供中国地区未来2小时内每5分钟降水数据、降水类型以及未来2小时的降水概况信息。
/// 可实现精确到1公里格点的全国分钟级降雨/降雪预报，为每一分钟的降雨进行预测
///
/// https://dev.qweather.com/docs/api/minutely/
@JsonSerializable()
class Minutely implements Cloneable<Minutely> {
  /// 预报时间	2013-12-30T01:45+08:00
  @JsonKey(name: 'fxTime')
  DateTime fxTime;

  /// 降水量	10
  @JsonKey(name: 'precip', fromJson: double.parse, toJson: numToString)
  double precip;

  /// 实时空气质量指数等级	2
  @JsonKey(name: 'type')
  String type;

  Minutely({
    this.fxTime,
    this.precip,
    this.type,
  });

  factory Minutely.fromJson(Map<String, dynamic> parsedJson) =>
      _$MinutelyFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$MinutelyToJson(this);

  @override
  Minutely clone() {
    return Minutely()
        ..fxTime = fxTime
        ..precip = precip
        ..type = type;
  }

  @override
  String toString() {
    return 'Minutely{fxTime: $fxTime: precip: $precip type: $type}';
  }
}