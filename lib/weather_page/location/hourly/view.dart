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

import 'dart:math';
import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:owp/common/icons.dart';
import 'package:owp/common/monotonex.dart';
import 'package:owp/custom/scrollbar.dart';
import 'package:owp/vendor/model.dart';

import 'action.dart';
import 'state.dart';

const double CHART_WIDTH = 2200; // 2200 px
const double CHART_HEIGHT = 330; // 412.5 px
/*
header height: 45
body: height: 200
left side bar width: 30
 */

const double HEADER_HEIGHT = 123.75; // 123.75 px
//温度曲线图总高度 96, (包括曲线，曲线填充，天气图标和温度游标)
const double CURVE_CHART_HEIGHT = 264; // 264 px
const CURVE_LINE_RANGE = 135.5; // 温度曲线点，Y轴取值范围 135.5px
const CURVE_LINE_BASE = 57.75; // 温度曲线点，偏移基数 57.75 px
// 曲线最低点：96-21=75, 最高点 96-21-50 = 25

const CHART_RIGHT_MARGIN = 100.0; //86.25px

String _formatTime(DateTime time) {
  return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
}

Widget buildView(
  HourlyState state,
  Dispatch dispatch,
  ViewService viewService,
) {
  var header = buildHeader(state.sunRise, state.sunSet);
  var body = buildBody(state, dispatch, viewService);
  var sideBar = buildSideBar(state);
  return Container(
      child: Column(children: <Widget>[
    header,
    Row(children: <Widget>[sideBar, body])
  ]));
}

Widget buildHeader(DateTime sunRise, DateTime sunSet) {
  if (sunRise == null || sunSet == null) return Container();

  var screenUtil = ScreenUtil();

  return Container(
      height: screenUtil.setWidth(120),
      padding: EdgeInsets.only(
          left: screenUtil.setWidth(50)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('预报',
                style: TextStyle(
                    color: Colors.black87, fontSize: screenUtil.setSp(56))),
          ]));
}

Widget buildSideBar(HourlyState state) {
  if (state.hourlyConditions == null) {
    return Container();
  }

  var high = state.hourlyConditions.map((h) => h.temp).reduce(max);
  var low = state.hourlyConditions.map((h) => h.temp).reduce(min);

  var screenUtil = ScreenUtil();

  return Container(
      height: screenUtil.setWidth(CHART_HEIGHT),
      width: screenUtil.setWidth(82.5),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        SizedBox(height: screenUtil.setWidth(41.25)),
        Text('$high°',
            style: TextStyle(
                color: Colors.black87, fontSize: screenUtil.setSp(38.5))),
        Container(height: screenUtil.setWidth(96.25)),
        Text('$low°',
            style: TextStyle(
                color: Colors.black87, fontSize: screenUtil.setSp(38.5))),
        Container(height: screenUtil.setWidth(60.5)),
      ]));
}

Widget buildBody(
  HourlyState state,
  Dispatch dispatch,
  ViewService viewService,
) {
  if ((state?.hourlyConditions?.length ?? 0) == 0) {
    return Container();
  }

  var screenUtil = ScreenUtil();

  double width = screenUtil.setWidth(CHART_WIDTH);
  double height = screenUtil.setWidth(CHART_HEIGHT);

  double screenWidth = MediaQuery.of(viewService.context).size.width;

  var now = DateTime.now();
  var sunRise = state?.sunRise ?? DateTime(now.year, now.month, now.day, 6);
  var sunSet = state?.sunSet ?? DateTime(now.year, now.month, now.day, 18);

  var layers = <Widget>[
    Container(
        height: height,
        width: width,
        child: CustomPaint(
          foregroundPainter: LinePainter(
              states: state.hourlyConditions,
              width: width - screenUtil.setWidth(CHART_RIGHT_MARGIN),
              height: screenUtil.setWidth(CURVE_CHART_HEIGHT)),
        )),
    Container(
        height: height,
        width: width,
        child: CustomPaint(
          foregroundPainter: HourPainter(
              states: state.hourlyConditions,
              width: width - screenUtil.setWidth(CHART_RIGHT_MARGIN),
              height: height),
        ))
  ];

  List<HourlyIconRange> iconRanges =
      getIconRanges(sunRise, sunSet, state.hourlyConditions);

  for (var iconRange in iconRanges) {
    layers.add(Container(
        height: height,
        width: width,
        child: CustomPaint(
          foregroundPainter: AreaPainter(
              scrollPosition: state.scrollPosition,
              screenWidth: screenWidth,
              states: state.hourlyConditions,
              width: width - screenUtil.setWidth(CHART_RIGHT_MARGIN),
              start: iconRange.start,
              end: iconRange.end,
              icon: iconRange.icon,
              height: screenUtil.setWidth(CURVE_CHART_HEIGHT)),
        )));
  }
  // end to draw icon ranges

  // start to draw weather icons
  double step = (width - screenUtil.setWidth(CHART_RIGHT_MARGIN)) /
      (state.hourlyConditions.length - 1);
  var iconWidgets = <Widget>[];

  for (var iconRange in iconRanges) {
    iconWidgets.add(Container(
        width: step * (iconRange.end + 1 - iconRange.start),
        child: Center(
            child: WeatherIcon(
                id: iconRange.icon, width: screenUtil.setWidth(60)))));
  }

  layers.add(Container(
      height: height,
      margin: EdgeInsets.only(
          bottom: screenUtil.setWidth(0), top: screenUtil.setWidth(135)),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.end, children: iconWidgets)));

  layers.add(Container(
      height: height,
      width: width,
      child: CustomPaint(
        foregroundPainter: IndicatorPainter(
            scrollPosition: state.scrollPosition,
            states: state.hourlyConditions,
            screenWidth: screenWidth,
            width: width - screenUtil.setWidth(CHART_RIGHT_MARGIN),
            height: screenUtil.setWidth(CURVE_CHART_HEIGHT)),
      )));

  return Container(
      height: height,
      width: screenWidth - screenUtil.setWidth(82.5),
      child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            dispatch(HourlyActionCreator.onScrollAction(
                state.id, scrollNotification.metrics.pixels));
            return true; //Return true to cancel the notification bubbling.
          },
          child: MyScrollbar(
              child: ListView(scrollDirection: Axis.horizontal, children: [
            Container(width: screenUtil.setWidth(33)),
            Stack(children: layers)
          ]))));
}

List<Point> _getPoints(
    List<HourlyCondition> states, double width, double height) {
  List<Point> points = [];

  var screenUtil = ScreenUtil();

  var temps = states.map((i) => i.temp).toList();

  if (temps.length > 0) {
    var low = temps.reduce(min);

    for (var i = 0; i < temps.length; i++) {
      temps[i] -= low;
    }
    var range = temps.reduce(max);

    double step = width / (temps.length - 1);

    for (var i = 0; i < temps.length; i++) {
      points.add(Point(
          step * i,
          height -
              (temps[i] / range * screenUtil.setWidth(CURVE_LINE_RANGE) +
                  screenUtil.setWidth(CURVE_LINE_BASE))));
    }
  }
  return points;
}

class LinePainter extends CustomPainter {
  List<HourlyCondition> states;
  List<Point> points;
  double height;
  double width;

  LinePainter({this.states, this.height, this.width});

  @override
  void paint(Canvas canvas, Size size) {
    points = _getPoints(states, width, height);

    if (points.length == 0) {
      return;
    }

    _drawSmoothLine(canvas);
  }

  void _drawSmoothLine(Canvas canvas) {
    Paint smoothPaint = Paint()
      ..color = Colors.black38
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final smoothPath = Path()
      ..moveTo(points.first.x.toDouble(), points.first.y.toDouble());
    MonotoneX.addCurve(smoothPath, points);

    canvas.drawPath(smoothPath, smoothPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

double _getIndicatorPosition(scrollPosition, width, screenWidth) {
  var screenUtil = ScreenUtil();

  var x = scrollPosition *
      1.2 /
      width *
      (width + screenWidth - screenUtil.setWidth(110));
  if (x > width - 0.01) {
    x = width - 0.01;
  }
  return x;
}

class IndicatorPainter extends CustomPainter {
  double scrollPosition;
  List<HourlyCondition> states;
  List<Point> points;
  double height;
  double width;
  double screenWidth;

  IndicatorPainter(
      {this.scrollPosition,
      this.states,
      this.height,
      this.width,
      this.screenWidth});

  @override
  void paint(Canvas canvas, Size size) {
    points = _getPoints(states, width, height);

    if (points.length == 0) {
      return;
    }
    _drawIndicator(canvas);
  }

  void _drawIndicator(Canvas canvas) {
    var screenUtil = ScreenUtil();

    Paint pointPaint = Paint()..color = Colors.black12.withAlpha(50);

    double x = _getIndicatorPosition(scrollPosition, width, screenWidth);

    var i = 1;
    for (; i < points.length; i++) {
      if (x <= points[i].x) break;
    }

    var middle = (points[i - 1].x + points[i].x) / 2;

    var text = '';
    if (x < middle) {
      text = '${states[i - 1].temp}℃';
    } else {
      text = '${states[i].temp}℃';
    }

    double y = (x - points[i - 1].x) /
            (points[i].x - points[i - 1].x) *
            (points[i].y - points[i - 1].y) +
        points[i - 1].y;

    var rrect = RRect.fromRectAndCorners(
        Rect.fromLTRB(x, y, x + screenUtil.setWidth(CHART_RIGHT_MARGIN),
            y - screenUtil.setWidth(68.75)),
        topLeft: Radius.circular(screenUtil.setWidth(41.25)),
        topRight: Radius.circular(screenUtil.setWidth(41.25)),
        bottomRight: Radius.circular(screenUtil.setWidth(41.25)));

    canvas.drawRRect(rrect, pointPaint);

    TextSpan span = TextSpan(
        style:
            TextStyle(color: Colors.black87, fontSize: screenUtil.setWidth(36)),
        text: text);
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas,
        Offset(x + screenUtil.setWidth(10), y - screenUtil.setWidth(55)));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class AreaPainter extends CustomPainter {
  double scrollPosition;
  double screenWidth;
  List<HourlyCondition> states;
  List<Point> points;
  double height;
  double width;
  String icon;
  int start;
  int end;
  double left = 0;
  double right = 0;

  Color color = Colors.black.withOpacity(0.1);

  AreaPainter(
      {this.scrollPosition,
      this.states,
      this.height,
      this.width,
      this.icon,
      this.start,
      this.end,
      this.screenWidth});

  @override
  void paint(Canvas canvas, Size size) {
    points = [];
    var screenUtil = ScreenUtil();

    double indicatorPosition =
        _getIndicatorPosition(scrollPosition, width, screenWidth);
    var temps = states.map((i) => i.temp).toList();

    if (temps.length > 0) {
      var low = temps.reduce(min);

      for (var i = 0; i < temps.length; i++) {
        temps[i] -= low;
      }

      var range = temps.reduce(max);

      double step = width / (temps.length - 1);
      left = step * start;
      right = step * (end + 1);

//      if (left <= indicatorPosition && indicatorPosition < right) {
//        color = Colors.white.withOpacity(0.8);
//      }

      left += 1;
      right -= 1;

      for (var i = 0; i < temps.length; i++) {
        points.add(Point(
            step * i,
            height -
                temps[i] / range * screenUtil.setWidth(CURVE_LINE_RANGE) -
                screenUtil.setWidth(CURVE_LINE_BASE)));
      }
    }

    if (points.length == 0) {
      return;
    }

    _drawSmoothPartFill(canvas);
  }

  void _drawSmoothPartFill(Canvas canvas) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final path = Path()
      ..moveTo(points.first.x.toDouble(), points.first.y.toDouble());
    MonotoneX.addCurve(path, points);

    path.lineTo(points.last.x, height);
    path.lineTo(points.first.x, height);
    path.lineTo(points.first.x, points.first.y);

    canvas.clipRect(Rect.fromLTRB(left, 0, right, height));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class HourPainter extends CustomPainter {
  List<HourlyCondition> states;
  List<Point> points;
  double height;
  double width;

  HourPainter({this.states, this.height, this.width});

  @override
  void paint(Canvas canvas, Size size) {
    if (states.length == 0) {
      return;
    }
    double step = width / (states.length - 1);

    for (var i = 0; i < states.length - 1; i++) {
      var text = states[i].hour.hour == 0 ? '明天' : '${states[i].hour.hour}:00';
      _drawHour(canvas, i * step, text);
    }
  }

  void _drawHour(Canvas canvas, double x, String text) {
    var screenUtil = ScreenUtil();
    TextSpan span = TextSpan(
        style: TextStyle(color: Colors.black87, fontSize: screenUtil.setSp(33)),
        text: text);
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(x, screenUtil.setWidth(280)));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
