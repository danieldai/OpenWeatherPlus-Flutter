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

part 'basic.g.dart';


@JsonSerializable()
class HeCity implements Cloneable<HeCity> {
  @JsonKey(name: 'cid')
  String id;

  @JsonKey(name: 'location')
  String name;

  //市级
  @JsonKey(name: 'parent_city')
  String parentCity;

  //省级
  @JsonKey(name: 'admin_area')
  String adminArea;

  @JsonKey(name: 'cnty')
  String country;

  @JsonKey(name: 'lat', fromJson: double.parse, toJson: numToString)
  double latitude;

  @JsonKey(name: 'lon', fromJson: double.parse, toJson: numToString)
  double longitude;

  String tz;

  String type;

  HeCity({
    this.id,
    this.name,
    this.parentCity,
    this.adminArea,
    this.country,
    this.latitude,
    this.longitude,
    this.tz,
    this.type
  });

  factory HeCity.fromJson(Map<String, dynamic> parsedJson) => _$HeCityFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$HeCityToJson(this);

  @override
  HeCity clone() {
    return HeCity()
      ..id = id
      ..name = name
      ..parentCity = parentCity
      ..adminArea = adminArea
      ..country = country
      ..latitude = latitude
      ..longitude = longitude
      ..tz = tz
      ..type = type;
  }

  @override
  String toString() {
    return 'City{id: $id, location: $country $adminArea $parentCity $name}';
  }

}