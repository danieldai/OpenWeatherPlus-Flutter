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

import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:owp/common/icons.dart';
import 'package:owp/vendor/model.dart';

import 'state.dart';

Widget buildView(
  DailyState state,
  Dispatch dispatch,
  ViewService viewService,
) {
  // 没有数据时显示空内容
  if ((state?.dailyConditions?.length ?? 0) == 0) {
    return Container();
  }

  var screenUtil = ScreenUtil();

  // 此宽度对应 1920x1080 设计尺寸的宽度，在其它屏幕转换为对应屏幕宽度
  double width = screenUtil.setWidth(1080);
  double height = screenUtil.setWidth(850);

  double totalWidth = width / 6 * 15;
  double columnWidth = width / 6;

  double headerHeight = screenUtil.setWidth(120);

  return Column(children: [

    // 内容
    Container(
        height: height,
        color: Colors.black12,
        child: Column(
  children: state.dailyConditions.map((condition) {
    return DailyConditionRow(
      condition: condition,
      width: columnWidth,
    );}).toList(growable: false)
  ))]);
}

class FriendlyWeekday extends StatelessWidget {
  final DateTime date;
  final Color color;
  final fontSize;
  static const WEEKDAYS = {
    1: '周一',
    2: '周二',
    3: '周三',
    4: '周四',
    5: '周五',
    6: '周六',
    7: '周日',
  };

  FriendlyWeekday({this.date, this.color, this.fontSize});

  @override
  Widget build(BuildContext context) {
    var d = date.add(Duration(seconds: 1));
    var now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day);
    var text = '';
    if (d.isAfter(today) && d.isBefore(today.add(Duration(days: 1)))) {
      text = '今天';
    } else {
      text = WEEKDAYS[d.weekday];
    }
    return Text(
      "$text",
      strutStyle: StrutStyle(
        forceStrutHeight: true,
        fontSize: fontSize,
      ),
      style: TextStyle(color: color, fontSize: fontSize),
    );
  }
}


class DailyConditionRow extends StatelessWidget {
  final DailyCondition condition;
  final double width;

  DailyConditionRow({this.condition, this.width});

  @override
  Widget build(BuildContext context) {
    var screenUtil = ScreenUtil();
    return Container(
      height: screenUtil.setWidth(120),
        child: Row(children: <Widget>[
      SizedBox(width: screenUtil.setWidth(50)),
      FriendlyWeekday(date: condition.predictDate, color: Colors.black54,fontSize: screenUtil.setSp(56)),
      SizedBox(width: screenUtil.setWidth(320)),
      WeatherIcon(id: '${condition.conditionIdDay}d', height: screenUtil.setWidth(80), width: screenUtil.setWidth(80)),
      SizedBox(width: screenUtil.setWidth(30)),
      WeatherIcon(id: '${condition.conditionIdNight}n', height: screenUtil.setWidth(80), width: screenUtil.setWidth(80)),
      SizedBox(width: screenUtil.setWidth(160)),
      Text('${condition.tempMax}°', style: TextStyle(fontSize: screenUtil.setSp(56))),
      SizedBox(width: screenUtil.setWidth(30)),
      Text('${condition.tempMin}°', style: TextStyle(fontSize: screenUtil.setSp(56), color: Colors.black45)),
    ]));
  }
}



