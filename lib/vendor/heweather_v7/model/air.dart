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

@JsonSerializable()
class LiveAqi implements Cloneable<LiveAqi> {
  @JsonKey(name: 'aqi', fromJson: double.parse, toJson: numToString)
  double value;

  LiveAqi({
    this.value,
  });

  @override
  LiveAqi clone() {
    return LiveAqi()
      ..value = value;
  }
}