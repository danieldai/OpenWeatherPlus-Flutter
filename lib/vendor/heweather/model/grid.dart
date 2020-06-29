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

part 'grid.g.dart';

@JsonSerializable()
class PrecipitationForecast implements Cloneable<PrecipitationForecast> {
  @JsonKey(name: 'txt')
  String desc;

  DateTime date;

  PrecipitationForecast({
    this.desc,
    this.date,
  });

  @override
  PrecipitationForecast clone() {
    return PrecipitationForecast()
      ..desc = desc
      ..date = date;
  }

  factory PrecipitationForecast.fromJson(Map<String, dynamic> parsedJson) => _$PrecipitationForecastFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$PrecipitationForecastToJson(this);

  @override
  String toString() {
    return 'PrecipitationForecast{value: $desc: time: $date}';
  }
}


@JsonSerializable()
class PrecipitationValue implements Cloneable<PrecipitationValue> {
  @JsonKey(name: 'pcpn', fromJson: double.parse, toJson: numToString)
  double value;

  DateTime time;

  PrecipitationValue({
    this.value,
    this.time,
  });

  @override
  PrecipitationValue clone() {
    return PrecipitationValue()
        ..value = value
        ..time = time;
  }

  factory PrecipitationValue.fromJson(Map<String, dynamic> parsedJson) => _$PrecipitationValueFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$PrecipitationValueToJson(this);

  @override
  String toString() {
    return 'PrecipitationValue{value: $value: time: $time}';
  }
}

@JsonSerializable()
class PrecipitationType implements Cloneable<PrecipitationType> {

  /// rain雨，snow雪
  @JsonKey(name: 'pcpn_type')
  String type;

  PrecipitationType({this.type});

  @override
  PrecipitationType clone() {
    return PrecipitationType()
      ..type = type;
  }

  factory PrecipitationType.fromJson(Map<String, dynamic> parsedJson) => _$PrecipitationTypeFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$PrecipitationTypeToJson(this);

  @override
  String toString() {
    return 'PrecipitationType{type: $type}';
  }

}

@JsonSerializable()
class MinuteForecast implements Cloneable<MinuteForecast> {

  @JsonKey(name: 'grid_minute_forecast')
  PrecipitationForecast forecast;

  @JsonKey(name: 'pcpn_5m')
  List<PrecipitationValue> values;

  @JsonKey(name: 'pcpn_type')
  PrecipitationType type;

  MinuteForecast({this.forecast, this.values, this.type});

  @override
  MinuteForecast clone() {
    return MinuteForecast()
      ..forecast = forecast
      ..values = values
      ..type = type;
  }

  factory MinuteForecast.fromJson(Map<String, dynamic> parsedJson) => _$MinuteForecastFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$MinuteForecastToJson(this);

  @override
  String toString() {
    return 'GridMinuteForecast{forecast: $forecast}';
  }

}