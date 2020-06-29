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

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:owp/location_list_page/page.dart';
import 'package:owp/location_list_page/state.dart';
import 'action.dart';
import 'list_adapter/action.dart';
import 'state.dart';

Effect<WeatherState> buildEffect() {
  return combineEffects(<Object, Effect<WeatherState>>{
    WeatherAction.onWeatherPageChanged: _onWeatherPageChanged,
    WeatherAction.onEditLocationList: _onEditLocationList,
  });
}

void _onWeatherPageChanged(Action action, Context<WeatherState> ctx) {
  int index = action.payload ?? 0;
  ctx.dispatch(WeatherActionCreator.setActiveIndexAction(index));
}

/// 响应编辑城市列表，打开城市列表页面，并把当前的城市数据传递过去。
/// 从城市列表页面返回时，会返回新的城市数据，对比新老数据进行现有列表进行增删操作
void _onEditLocationList(Action action, Context<WeatherState> ctx) {
  Navigator.of(ctx.context)
      .push<LocationListState>(MaterialPageRoute<LocationListState>(
      settings: RouteSettings(name: 'page.location.list'),
      builder: (BuildContext buildCtx) => LocationListPage()
          .buildPage(List.from(ctx.state.locationStates))))
      .then((LocationListState list) {
    if (list != null) {
      var oldIds = ctx.state.locationStates.map((l) => l.id).toSet();
      var newIds = list.locationStates.map((l) => l.id).toSet();

      if (oldIds != newIds) {
        // 在已有城市中挑选出哪些需要保留
        var locations = ctx.state.locationStates
            .where((l) => newIds.contains(l.id))
            .toList();

        // 假设前提: 一次只添加一个城市
        for (var newLocation in list.locationStates) {
          if (!oldIds.contains(newLocation.id)) {
            // 发现了一个新城市
            if (locations.length > 0) {
              // 如果存在旧城市需要保留，则添加新城市到第二个位置
              locations.add(newLocation);
              ctx.dispatch(LocationStateListActionCreator.update(locations));
              // 注意：由于 PageViewController的限制，当新增加页面时，即使调到的最新页面，在pagechange 回调函数中依然 最新index-1
              // 所以先调用 jumpToPage , 再更新 active Index
              ctx.state.controller.jumpToPage(locations.length - 1);
              ctx.dispatch(WeatherActionCreator.setActiveIndexAction(
                  locations.length - 1));
              return;
            } else {
              // 如果不存在旧城市需要保留，则添加新城市到第一个位置
              locations.add(newLocation);
              ctx.dispatch(LocationStateListActionCreator.update(locations));
              ctx.state.controller.jumpToPage(0);
              ctx.dispatch(WeatherActionCreator.setActiveIndexAction(0));
              return;
            }
          }
        }

        // if reach here, it means no locations added
        var i = min(ctx.state.activeIndex, locations.length - 1);
        ctx.dispatch(LocationStateListActionCreator.update(locations));
        ctx.dispatch(WeatherActionCreator.setActiveIndexAction(i));
        ctx.state.controller.jumpToPage(i);
      }
    }
  });
}