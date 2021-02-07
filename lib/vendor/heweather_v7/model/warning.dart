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

part 'warning.g.dart';

/// https://dev.qweather.com/docs/api/warning/
@JsonSerializable()
class Warning implements Cloneable<Warning> {
  /// 本条预警的唯一标识，可判断本条预警是否已经存在，id有效期不超过72小时
  /// 202010110345679813
  @JsonKey(name: 'id')
  String id;

  /// 预警发布单位，可能为空	深圳市气象台
  @JsonKey(name: 'sender')
  String sender;

  /// 预警发布时间	2017-10-25T12:03+08:00
  @JsonKey(name: 'pubTime')
  DateTime pubTime;

  /// 预警信息标题	广东省深圳市气象台发布雷电黄色预警
  String title;

  /// 预警开始时间，可能为空。	2017-10-25T13:12
  @JsonKey(name: 'startTime')
  DateTime startTime;

  /// 预警结束时间，可能为空。	2017-10-26T13:12
  @JsonKey(name: 'endTime')
  DateTime endTime;

  /// 预警状态，可能为空
  /// active 预警中或首次预警
  /// update 预警信息更新
  /// cancel 取消预警
  String status;

  /// 预警等级	黄色
  String level;

  /// 预警类型	11B17
  String type;

  /// 预警等级名称	大雾
  String typeName;

  /// 预警详细文字描述
  /// 深圳市气象局于10月04日12时59分发布雷电黄色预警信号，请注意防御。
  @JsonKey(name: 'text')
  String text;

  /// 与本条预警相关联的预警ID，当预警状态为cancel或update时返回。可能为空
  /// 202010110345679813
  String related;

  Warning({
    this.id,
    this.sender,
    this.pubTime,
    this.title,
    this.startTime,
    this.endTime,
    this.status,
    this.level,
    this.type,
    this.typeName,
    this.text,
    this.related,
  });

  factory Warning.fromJson(Map<String, dynamic> parsedJson) => _$WarningFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$WarningToJson(this);

  @override
  Warning clone() {
    return Warning()
      ..id = id
      ..sender = sender
      ..pubTime = pubTime
      ..title = title
      ..startTime = startTime
      ..endTime = endTime
      ..status = status
      ..level = level
      ..type = type
      ..typeName = typeName
      ..text = text
      ..related = related;
  }
}
