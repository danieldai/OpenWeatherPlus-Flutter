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

part 'basic.g.dart';

/// 城市信息搜索
///
/// https://dev.qweather.com/docs/api/geo/
@JsonSerializable()
class HeLocation implements Cloneable<HeLocation> {
  /// 地区/城市ID	101280604
  @JsonKey(name: 'id')
  String id;

  /// 地区/城市名称	南山区
  @JsonKey(name: 'name')
  String name;

  /// 地区/城市纬度	22.53122
  @JsonKey(name: 'lat', fromJson: double.parse, toJson: numToString)
  double lat;

  /// 地区/城市经度	113.92942
  @JsonKey(name: 'lon', fromJson: double.parse, toJson: numToString)
  double lon;

  /// 该地区/城市的上级行政区划名称	深圳市
  @JsonKey(name: 'adm2')
  String adm2;

  /// 该地区/城市所属一级行政区域	广东省
  @JsonKey(name: 'adm1')
  String adm1;

  /// 该地区/城市所属国家名称	中国
  @JsonKey(name: 'country')
  String country;

  /// 该地区/城市所在时区	Asia/Shanghai
  String tz;

  /// 该地区/城市目前与UTC时间偏移的小时数	+08:00
  /// 参见 https://dev.qweather.com/docs/start/glossary#utc-offset
  String utcOffset;

  /// 该地区/城市是否当前处于夏令时
  /// 1 表示当前处于夏令时
  /// 0 表示当前不是夏令时
  String isDst;

  /// 该地区/城市的属性
  String type;

  /// 地区评分	10
  /// 参见 https://dev.qweather.com/docs/start/glossary#rank
  int rank;

  /// 该地区的天气预报网页链接，便于嵌入你的网站或应用	http://hfx.link/34T5
  String fxLink;

  HeLocation({
    this.id,
    this.name,
    this.lat,
    this.lon,
    this.adm2,
    this.adm1,
    this.country,
    this.tz,
    this.utcOffset,
    this.isDst,
    this.type,
    this.rank,
    this.fxLink,
  });

  // factory HeCity.fromJson(Map<String, dynamic> parsedJson) => _$HeLocationFromJson(parsedJson);

  // Map<String, dynamic> toJson() => _$HeLocationToJson(this);

  @override
  HeLocation clone() {
    return HeLocation()
      ..id = id
      ..name = name
      ..lat = lat
      ..lon = lon
      ..adm2 = adm2
      ..adm1 = adm1
      ..country = country
      ..tz = tz
      ..utcOffset = utcOffset
      ..isDst = isDst
      ..type = type
      ..rank = rank
      ..fxLink = fxLink;
  }

  @override
  String toString() {
    return 'HeLocation{id: $id, location: $country $adm1 $adm2 $name}';
  }

}