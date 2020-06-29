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

part 'alert.g.dart';


/// 预警种类：台风、暴雨、暴雪、寒潮、大风、沙尘暴、高温、干旱、雷电、冰雹、霜冻、大雾、
/// 霾、道路结冰、寒冷、灰霾、雷雨大风、森林火险、降温、道路冰雪、干热风、低温、冰冻、
/// 空气重污染、海上大雾、雷暴大风、持续低温、浓浮尘、龙卷风、低温冻害、海上大风、
/// 低温雨雪冰冻、强对流、臭氧、大雪、强降雨、强降温、雪灾、森林（草原）火险、雷暴、
/// 严寒、沙尘、海上雷雨大风、海上雷电、海上台风。
///
/// 预警级别：白色（仅限广东省内）、蓝色、黄色、橙色、红色
///
/// 更新时间：每15分钟更新一次。

//天气预警
@JsonSerializable()
class Alert implements Cloneable<Alert> {
  @JsonKey(name: 'cid')
  String cityId;

  String level;

  @JsonKey(name: 'stat')
  String status;

  String title;

  String type;

  @JsonKey(name: 'txt')
  String content;

  Alert({
    this.cityId,
    this.content,
    this.level,
    this.title,
    this.type,
    this.status,
  });

  factory Alert.fromJson(Map<String, dynamic> parsedJson) => _$AlertFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$AlertToJson(this);

  @override
  Alert clone() {
    return Alert()
      ..cityId = cityId
      ..content = content
      ..level = level
      ..title = title
      ..type = type
      ..status = status;
  }
}

@JsonSerializable()
class Alerts implements Cloneable<Alerts> {

  @JsonKey(name: 'alarm')
  List<Alert> items;

  Alerts({this.items});

  factory Alerts.fromJson(Map<String, dynamic> parsedJson) => _$AlertsFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$AlertsToJson(this);

  @override
  Alerts clone() {
    return Alerts()
      ..items = items;
  }
}
