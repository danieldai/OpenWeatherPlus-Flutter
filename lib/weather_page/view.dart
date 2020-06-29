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

import 'action.dart';
import 'state.dart';

Widget buildView(WeatherState state, Dispatch dispatch, ViewService viewService) {
  MediaQueryData mediaQuery = MediaQuery.of(viewService.context);

  //default value : width : 1080px , height:1920px , allowFontScaling:false
  ScreenUtil.init(viewService.context);

  final ListAdapter adapter = viewService.buildAdapter();

  return Stack(children: <Widget>[
    Scaffold(
      extendBodyBehindAppBar:true,
      appBar: AppBar(
        bottomOpacity: 0.0,
        toolbarOpacity: 1,
        elevation: 0,
        title: viewService.buildComponent('header'),
        titleSpacing: 0,
        backgroundColor: Colors.black38.withAlpha(50),
      ),
      body: PageView.builder(
          controller: state.controller,
          onPageChanged: (index) {
            if (index != state.activeIndex) {
              dispatch(WeatherActionCreator.onWeatherPageChangedAction(index));
            }
          },
          itemBuilder: adapter.itemBuilder,
          itemCount: adapter.itemCount),
      backgroundColor: Colors.transparent,
    )
  ]);
}
