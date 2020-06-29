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
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:owp/weather_page/action.dart';
import 'package:owp/weather_page/location/state.dart';

import 'state.dart';


Widget buildView(
    HeaderState state, Dispatch dispatch, ViewService viewService) {
  //default value : width : 1080px , height:1920px , allowFontScaling:false
  var screenUtil = ScreenUtil();

  LocationState location;

  try {
    location = state.locationStates?.elementAt(state.activeIndex);
  } catch (e) {
    ; // do nothing, left location null;
  }

  var title = <Widget>[];


  //GPS位置在位置名右侧显示定位图标
  if (location?.gps ?? false) {
    title.add(Icon(
      Icons.location_on,
      size: screenUtil.setWidth(40),
      color: Colors.white,
    ));
  }

  // 城市名
  title.add(
    Text(
      location?.name ?? '尚未关注任何城市',
      style: TextStyle(
          fontSize: screenUtil.setSp(52),
          fontWeight: FontWeight.w300,
          color: Colors.white),
    )
  );


  //最右侧的位置添加按钮
  var locationAddButton = InkWell(
    child: Container(
      padding: EdgeInsets.only(
          top: screenUtil.setWidth(0),
          left: screenUtil.setWidth(20),
          right: screenUtil.setWidth(20)),
      alignment: Alignment.topCenter,
      child: Icon(Icons.add,
          color: Colors.white, size: screenUtil.setWidth(90)),
    ),
      onTap: () => dispatch(
          WeatherActionCreator.onEditLocationListAction(state.locationStates))
  );

  title.add(locationAddButton);

  var rows = <Widget>[
    SizedBox(height: screenUtil.setWidth(5)),
    Row( crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: title)
  ];

  // 位置名称下留10个像素空格
  rows.add(SizedBox(height: screenUtil.setWidth(6)));

  //有多个位置时，显示位置名索引圆点
  if (state.locationStates.length > 1) {
    var dots = Container(
        height: screenUtil.setWidth(28),
        width: screenUtil.setWidth(1080-25-25-65),
        child: Stack(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: screenUtil.setWidth(15)),
                child: CustomPaint(
                    painter: BackgroundPainter(
                        step: 10,
                        count: state.locationStates.length,
                        screenUtil: screenUtil))),
            Container(
                padding: EdgeInsets.only(left: screenUtil.setWidth(15)),
                child: CustomPaint(
                    painter: IndexPainter(
                        step: 10,
                        index: state.activeIndex,
                        screenUtil: screenUtil))),
          ],
        ));

    rows.add(dots);
  } else {
    rows.add(
        Container(
            height: screenUtil.setWidth(28),
            width: screenUtil.setWidth(1080-25-25-65))
    );
  }

  return Container(
    // color: Colors.green,
//      height: screenUtil.setWidth(140),
      padding: EdgeInsets.only(left: screenUtil.setWidth(50)),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            Column(
              children: rows,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
            ),
          ]));
}

class BackgroundPainter extends CustomPainter {
  int count;
  double step;
  ScreenUtil screenUtil;

  BackgroundPainter({this.count, this.step, this.screenUtil});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (var i = 0; i < count; i++) {
      canvas.drawCircle(Offset(i * step, screenUtil.setWidth(16)),
          screenUtil.setWidth(6), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class IndexPainter extends CustomPainter {
  int index;
  double step;
  ScreenUtil screenUtil;

  IndexPainter({this.index, this.step, this.screenUtil});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(index * step, screenUtil.setWidth(16)),
        screenUtil.setWidth(6), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
