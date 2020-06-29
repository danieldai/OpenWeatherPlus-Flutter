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
import 'package:flutter_screenutil/screenutil.dart';
import 'package:owp/common/air.dart';
import 'package:owp/vendor/model.dart';

import 'state.dart';

Widget buildView(AirState state, Dispatch dispatch, ViewService viewService) {
  ScreenUtil screenUtil = ScreenUtil();
  return Container(
      width: screenUtil.setWidth(1080),
      height: screenUtil.setWidth(500),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[buildTitle(state), buildContent(state)]));
}

Widget buildTitle(AirState state) {
  LiveAqi liveAqi = state.liveAqi;
  ScreenUtil screenUtil = ScreenUtil();

  return Container(
      padding: EdgeInsets.only(left: screenUtil.setWidth(50)),
      child: Row(children: <Widget>[
        Text('空气质量',
            style: TextStyle(
                color: Colors.black87, fontSize: screenUtil.setSp(42))),
        SizedBox(width: screenUtil.setWidth(30)),
        Container(
            padding: EdgeInsets.symmetric(
                horizontal: screenUtil.setWidth(16),
                vertical: screenUtil.setWidth(6)),
            decoration: BoxDecoration(
              color: aqiToColor(liveAqi?.value),
              borderRadius: BorderRadius.all(
                Radius.circular(screenUtil.setWidth(16)),
              ),
            ),
            child: Row(children: <Widget>[
              Text('${liveAqi?.value?.toStringAsFixed(0) ?? "0"}',
                  style: TextStyle(color: Colors.white)),
              SizedBox(width: screenUtil.setWidth(10)),
              Text(aqiToText(liveAqi?.value),
                  style: TextStyle(color: Colors.white)),
            ]))
      ]));
}

Widget buildContent(AirState state) {
  LiveAqi liveAqi = state.liveAqi;
  ScreenUtil screenUtil = ScreenUtil();

  var titleStyle =
      TextStyle(fontSize: screenUtil.setSp(42), color: Colors.black38);
  var subStyle = TextStyle(
      fontSize: screenUtil.setSp(20),
      fontWeight: FontWeight.bold,
      color: Colors.black38);
  var valueStyle = TextStyle(fontSize: screenUtil.setSp(42));

  return Container(
      height: screenUtil.setWidth(200),
      padding: EdgeInsets.only(
        left: screenUtil.setWidth(100),
        top: screenUtil.setWidth(50),
        right: screenUtil.setWidth(100),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(children: <Widget>[
                    Text('PM2.5', style: titleStyle),
                    SizedBox(width: screenUtil.setWidth(20)),
                    Text('${liveAqi?.pm25 ?? 00}', style: valueStyle),
                  ]),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text('NO', style: titleStyle),
                        Text('2', style: subStyle),
                        SizedBox(width: screenUtil.setWidth(20)),
                        Text('${liveAqi?.no2 ?? 00}', style: valueStyle),
                      ])
                ]),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(children: <Widget>[
                    Text('PM10', style: titleStyle),
                    SizedBox(width: screenUtil.setWidth(20)),
                    Text('${liveAqi?.pm10 ?? 00}', style: valueStyle),
                  ]),
                  Row(children: <Widget>[
                    Text('CO', style: titleStyle),
                    SizedBox(width: screenUtil.setWidth(20)),
                    Text('${liveAqi?.co ?? 00}', style: valueStyle),
                  ])
                ]),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text('SO', style: titleStyle),
                        Text('2', style: subStyle),
                        SizedBox(width: screenUtil.setWidth(20)),
                        Text('${liveAqi?.so2 ?? 00}', style: valueStyle),
                      ]),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('O', style: titleStyle),
                        Text('3', style: subStyle),
                        SizedBox(width: screenUtil.setWidth(20)),
                        Text('${liveAqi?.o3 ?? 00}', style: valueStyle),
                      ])
                ]),
          ]));
}
