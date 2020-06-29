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
import 'package:meta/meta.dart';
import 'package:owp/vendor/model.dart';

part 'state.g.dart';

@JsonSerializable()
class HourlyState implements Cloneable<HourlyState> {
  String id;

  @JsonKey(ignore: true)
  double scrollPosition = 0.0;

  @JsonKey(ignore: true)
  DateTime sunRise;

  @JsonKey(ignore: true)
  DateTime sunSet;

  List<HourlyCondition> hourlyConditions;

  HourlyState(
      {@required this.id,
      this.hourlyConditions,
      this.scrollPosition = 0.0,
      this.sunRise,
      this.sunSet});

  factory HourlyState.fromJson(Map<String, dynamic> parsedJson) =>
      _$HourlyStateFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$HourlyStateToJson(this);

  @override
  HourlyState clone() {
    return HourlyState(id: id)
      ..hourlyConditions = hourlyConditions
      ..scrollPosition = scrollPosition
      ..sunRise = sunRise
      ..sunSet = sunSet;
  }
}
