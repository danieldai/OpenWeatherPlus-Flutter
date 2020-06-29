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
import 'action.dart';

import 'state.dart';

Widget buildView(
    LocationState state, Dispatch dispatch, ViewService viewService) {
  var screenUtil = ScreenUtil();

  Future<Null> refresh() async {
    dispatch(LocationActionCreator.doRefresh(state.id));
    return null;
  }

  var buildContent = (BoxConstraints constraints) => Column(
        children: <Widget>[
          SizedBox(
              height: ScreenUtil.statusBarHeight +
                  AppBar().preferredSize.height +
                  screenUtil.setWidth(500)),
          Container(
//          color: Colors.blue,
              height: screenUtil.setWidth(900),
              child: viewService.buildComponent('live')),

          Container(height: screenUtil.setWidth(30)),
          viewService.buildComponent('hourly'),
          Container(height: screenUtil.setWidth(30)),
          viewService.buildComponent('daily'),
          Container(height: screenUtil.setWidth(30)),
          viewService.buildComponent('details'),
          Container(height: screenUtil.setWidth(30)),
          viewService.buildComponent('air'),
          Container(
              width: screenUtil.setWidth(1080),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('Powered By heweather.com',
                        style: TextStyle(color: Colors.black54)),
                    SizedBox(
                      width: screenUtil.setWidth(10),
                    )
                  ])),
          Container(height: screenUtil.setWidth(10)),

        ],
      );

  return Container(child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
    return RefreshIndicator(
        color: Colors.white,
        backgroundColor: Colors.transparent,
        onRefresh: refresh,
        child: SingleChildScrollView(
            child: Stack(children: <Widget>[
          Container(
            height: screenUtil.setWidth(1800),
            width: screenUtil.setWidth(1080),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/bg/back_${state.backgroundCode ?? '100d'}.png'),
                    fit: BoxFit.cover)),
          ),
          Positioned(
              top: screenUtil.setWidth(1600),
              left: 0,
              child: Container(
                height: screenUtil.setWidth(3000),
                width: screenUtil.setWidth(1080),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/bg/back.png'),
                        fit: BoxFit.fitWidth)),
              )),
          buildContent(constraints)
        ])));
  }));
}
