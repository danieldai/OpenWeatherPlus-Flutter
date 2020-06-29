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
class DailyState implements Cloneable<DailyState> {
  String id;
  List<DailyCondition> dailyConditions;
  List<DailyAqi> dailyAqis;

  @JsonKey(ignore: true)
  double scrollPosition = 0.0;

  DailyState({@required this.id, this.dailyConditions, this.dailyAqis});

  factory DailyState.fromJson(Map<String, dynamic> parsedJson) => _$DailyStateFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$DailyStateToJson(this);

  @override
  DailyState clone() {
    return DailyState(id:id)
      ..dailyConditions = dailyConditions
      ..dailyAqis = dailyAqis
      ..scrollPosition = scrollPosition;
  }
}
