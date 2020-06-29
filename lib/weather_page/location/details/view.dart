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
import 'package:owp/common/icons.dart';

import 'state.dart';

Widget buildView(
    DetailsState state, Dispatch dispatch, ViewService viewService) {
  ScreenUtil screenUtil = ScreenUtil();
  return Container(
      width: screenUtil.setWidth(1080),
      height: screenUtil.setWidth(600),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: screenUtil.setWidth(50)),
                child: Text('今日详情',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: screenUtil.setSp(56)))),
            buildContent(state)
          ]));
}

Widget buildContent(DetailsState state) {
  var live = state.liveCondition;
  var daily = state?.dailyConditions?.first;

  ScreenUtil screenUtil = ScreenUtil();
  const ICON_HEIGHT = 80;

  var descStyle =
      TextStyle(fontSize: screenUtil.setSp(42), color: Colors.black38);
  var valueStyle = TextStyle(fontSize: screenUtil.setSp(42));
  return Container(
      height: screenUtil.setWidth(500),
      padding: EdgeInsets.only(
        left: screenUtil.setWidth(100),
        top: screenUtil.setWidth(50),
      ),
      child: Row(children: <Widget>[
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: <Widget>[
                WeatherIcon(
                    id: '${daily?.conditionIdDay ?? "100"}d',
                    height: screenUtil.setWidth(ICON_HEIGHT),
                    width: screenUtil.setWidth(ICON_HEIGHT)),
                SizedBox(width: screenUtil.setWidth(30)),
                Text('最高温度', style: descStyle),
                SizedBox(width: screenUtil.setWidth(15)),
                Text('${daily?.tempMax ?? "00"}°', style: valueStyle),
              ]),
              Row(children: <Widget>[
                WeatherIcon(
                    id: 'rainfall',
                    height: screenUtil.setWidth(ICON_HEIGHT),
                    width: screenUtil.setWidth(ICON_HEIGHT),
                    fit: BoxFit.fitHeight),
                SizedBox(width: screenUtil.setWidth(30)),
                Text('降水量', style: descStyle),
                SizedBox(width: screenUtil.setWidth(15)),
                Text('${live?.precipitation ?? "00"}mm', style: valueStyle),
              ]),
              Row(children: <Widget>[
                WeatherIcon(
                    id: 'pressure',
                    height: screenUtil.setWidth(ICON_HEIGHT),
                    width: screenUtil.setWidth(ICON_HEIGHT),
                    fit: BoxFit.fitWidth),
                SizedBox(width: screenUtil.setWidth(30)),
                Text('气压', style: descStyle),
                SizedBox(width: screenUtil.setWidth(15)),
                Text('${live?.pressure ?? "0"}HPA', style: valueStyle),
              ]),
              Row(children: <Widget>[
                WeatherIcon(
                    id: 'wind',
                    height: screenUtil.setWidth(ICON_HEIGHT),
                    width: screenUtil.setWidth(ICON_HEIGHT),
                    fit: BoxFit.fitWidth),
                SizedBox(width: screenUtil.setWidth(30)),
                Text('${live?.windDir ?? "未知" }', style: descStyle),
                SizedBox(width: screenUtil.setWidth(15)),
                Text('${live?.windLevel ?? "0"}级', style: valueStyle),
              ]),
            ]),
        SizedBox(width: screenUtil.setWidth(100)),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: <Widget>[
                WeatherIcon(
                    id: '${daily?.conditionIdNight ?? "100"}n',
                    height: screenUtil.setWidth(ICON_HEIGHT),
                    width: screenUtil.setWidth(ICON_HEIGHT)),
                SizedBox(width: screenUtil.setWidth(30)),
                Text('最低温度', style: descStyle),
                SizedBox(width: screenUtil.setWidth(15)),
                Text('${daily?.tempMin ?? "00"}°', style: valueStyle),
              ]),
              Row(children: <Widget>[
                WeatherIcon(
                    id: 'hum',
                    height: screenUtil.setWidth(ICON_HEIGHT),
                    width: screenUtil.setWidth(ICON_HEIGHT),
                    fit: BoxFit.fitHeight),
                SizedBox(width: screenUtil.setWidth(30)),
                Text('湿度', style: descStyle),
                SizedBox(width: screenUtil.setWidth(15)),
                Text('${live?.humidity ?? "0"}%', style: valueStyle),
              ]),
              Row(children: <Widget>[
                WeatherIcon(
                    id: 'visible',
                    height: screenUtil.setWidth(ICON_HEIGHT),
                    width: screenUtil.setWidth(ICON_HEIGHT),
                    fit: BoxFit.fitWidth),
                SizedBox(width: screenUtil.setWidth(30)),
                Text('能见度', style: descStyle),
                SizedBox(width: screenUtil.setWidth(15)),
                Text('${live?.vis ?? "0"}KM', style: valueStyle),
              ]),
              Row(children: <Widget>[
                Container(
                  height: screenUtil.setWidth(ICON_HEIGHT),
                )
              ]),
            ]),
      ]));
}

Widget buildContent_(DetailsState state) {
  var live = state.liveCondition;
  ScreenUtil screenUtil = ScreenUtil();

  return Container(
      padding: EdgeInsets.only(
        left: screenUtil.setWidth(100),
        top: screenUtil.setWidth(50),
      ),
      child: Column(children: <Widget>[
        Row(children: <Widget>[
          Row(children: <Widget>[
            WeatherIcon(
                id: '100d',
                height: screenUtil.setWidth(80),
                width: screenUtil.setWidth(80)),
            SizedBox(width: screenUtil.setWidth(50)),
            Text('最高温度'),
            Text('27°'),
          ]),
          SizedBox(width: screenUtil.setWidth(50)),
          Row(children: <Widget>[
            WeatherIcon(
                id: '100d',
                height: screenUtil.setWidth(80),
                width: screenUtil.setWidth(80)),
            Text('最低温度'),
            Text('21°'),
          ])
        ]),
        Row(children: <Widget>[
          Row(children: <Widget>[
            WeatherIcon(
                id: 'rainfall',
                height: screenUtil.setWidth(80),
                width: screenUtil.setWidth(80)),
            Text('降水量'),
            Text('${live.precipitation}mm'),
          ]),
          SizedBox(width: screenUtil.setWidth(50)),
          Row(children: <Widget>[
            WeatherIcon(
                id: 'hum',
                height: screenUtil.setWidth(80),
                width: screenUtil.setWidth(80)),
            Text('湿度'),
            Text('${live.humidity}%'),
          ])
        ]),
        Row(children: <Widget>[
          Row(children: <Widget>[
            WeatherIcon(
                id: 'pressure',
                height: screenUtil.setWidth(80),
                width: screenUtil.setWidth(80)),
            Text('气压'),
            Text('${live.pressure}HPA'),
          ]),
          SizedBox(width: screenUtil.setWidth(50)),
          Row(children: <Widget>[
            WeatherIcon(
                id: 'visible',
                height: screenUtil.setWidth(80),
                width: screenUtil.setWidth(100)),
            Text('能见度'),
            Text('${live.vis}KM'),
          ])
        ]),
        Row(children: <Widget>[
          Row(children: <Widget>[
            WeatherIcon(
                id: 'wind',
                height: screenUtil.setWidth(80),
                width: screenUtil.setWidth(80)),
            Text('${live.windDir}'),
            Text('${live.windLevel}级'),
          ]),
        ]),
      ]));
}
