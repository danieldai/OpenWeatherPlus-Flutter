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

import 'package:flutter/material.dart';

String aqiToText(num value) {
  var text = '优';
  if (value == null) {
    text = '优';
  } else if (value >= 51 && value <= 100) {
    text = '良';
  } else if (value >= 101 && value <= 150) {
    text = '轻度';
  } else if (value >= 151 && value <= 200) {
    text = '中度';
  } else if (value >= 201 && value <= 300) {
    text = '重度';
  } else if (value > 300) {
    text = '严重';
  }
  return text;
}

const _COLORS = [
  Color(0xFF8fc31f),
  Color(0xFFFFBB18),
  Color(0xFFC57901),
  Color(0xFFEA111A),
  Color(0xFF5f52a5),
  Color(0xFF600202)
];

/// 0－50、51－100、101－150、151－200、201－300和大于300六档。
Color aqiToColor(num value) {
  var color = _COLORS[0];
  if (value == null) {
    color = _COLORS[0];
  } else if (value >= 51 && value <= 100) {
    color = _COLORS[1];
  } else if (value >= 101 && value <= 150) {
    color = _COLORS[2];
  } else if (value >= 151 && value <= 200) {
    color = _COLORS[3];
  } else if (value >= 201 && value <= 300) {
    color = _COLORS[4];
  } else if (value > 300) {
    color = _COLORS[5];
  }
  return color;
}
