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
import 'package:owp/vendor/model.dart';


class WeatherIcon extends StatelessWidget {
  final String id;
  final double width;
  final double height;
  final BoxFit fit;

  WeatherIcon({this.id, this.width, this.height, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        child: Image.asset('assets/icon/icon_$id.png', fit: fit));
  }
}


class HourlyIconRange {
  int start;
  int end;
  String icon;

  HourlyIconRange({this.start, this.end, this.icon});
}

List<HourlyIconRange> getIconRanges(
    DateTime sunRise, DateTime sunSet, List<HourlyCondition> hourlyConditions,
    {int iconDayOverride, int iconNightOverride}) {
  // start to draw icon ranges
  var nightStart = sunSet.minute == 0 ? sunSet.hour : sunSet.hour + 1;
  var dayStart = sunRise.minute == 0 ? sunRise.hour : sunRise.hour + 1;

  var icons = <String>[];

  // do not use the latest hour
  var conditions = hourlyConditions.sublist(0, hourlyConditions.length - 1);

  for (var condition in conditions) {
    if (condition.hour.hour < nightStart && condition.hour.hour >= dayStart) {
      icons.add('${iconDayOverride ?? condition.conditionCode}d');
    } else {
      icons.add('${iconNightOverride ?? condition.conditionCode}n');
    }
  }

  List<HourlyIconRange> iconRanges = [];

  var last = 0;
  var i = 1;
  for (; i < icons.length; i++) {
    if (icons[i] != icons[last]) {
      iconRanges
          .add(HourlyIconRange(start: last, end: i - 1, icon: icons[last]));
      last = i;
    }
  }

  if (iconRanges.length == 0) {
    iconRanges.add(
        HourlyIconRange(start: 0, end: icons.length - 1, icon: icons.first));
  }

  if (iconRanges.last.end != icons.length - 1) {
    iconRanges.add(
        HourlyIconRange(start: last, end: icons.length - 1, icon: icons[last]));
  }

  return iconRanges;
}
