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

import 'package:amap_location/amap_location.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:logger/logger.dart';
import 'package:owp/location_list_page/state.dart';
import 'package:owp/location_list_page/view.dart';
import 'package:owp/platform/feedback.dart';
import 'package:owp/vendor/amap/model.dart';
import 'package:owp/vendor/api.dart';
import 'package:owp/vendor/model.dart';
import 'package:owp/weather_page/location/state.dart';

import '../constants.dart';
import 'state.dart';

var logger = Logger();

Effect<LocationListState> buildEffect() {
  return combineEffects(<Object, Effect<LocationListState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
  });
}

dynamic _init(Action action, Context<LocationListState> ctx) async {
  if (ctx.state.locationStates.length > 0) {
    return;
  }

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    HeCity result = await showSearch(
      context: ctx.context,
      delegate: LocationSearchDelegate(
          locations: ctx.state.locationStates,
          hotCities: HeWeather.getHotCities()),
    );

    //用户可能没有选择任何城市
    if(result == null) return;

    if(result.id == GPS_LOCATION_ID) {
      // 获取到GPS位置时，说明已经获取到定位权限
      // 如果是GPS位置，先定位，然后返回
      AMapLocation loc;
      try {
        logger.d('begin get gps location');

        //针对GPS位置启动高德定位客户端
        await AMapLocationClient.startup(AMapLocationOption(
            onceLocation: true,
            desiredAccuracy:
            CLLocationAccuracy.kCLLocationAccuracyHundredMeters));
        loc = await AMapLocationClient.getLocation(true);
        AMapLocationClient.shutdown();
      } catch (e) {
        logger.d('error', e);
      }
      logger.d('Got gps localtion: $loc');

      if (!loc.success) {
        //定位失败时显示错误信息对话框 success=false

        showLongAlert("定位失败，未添加自动定位位置", 16.0);

      } else {
        var newLocation = LocationState.simple(
            id: GPS_LOCATION_ID,
            name: '${loc.district} ${loc.street ?? ""}',
            gps: true)
          ..gpsLocation = GpsLocation.fromAmapLocation(loc);

        Navigator.of(ctx.context).pop<
            LocationListState>(
            ctx.state.clone()
              ..locationStates.add(newLocation));
      }
    } else {
      // 用户添加了新位置后，把新位置和已有位置合并后返回给上级Page
      var newLocation =
      LocationState.simple(id: result.id, name: result.name)
        ..city = result;

      Navigator.of(ctx.context).pop<
          LocationListState>(
          ctx.state.clone()
            ..locationStates.add(newLocation));
    }
  });
}

void _dispose(Action action, Context<LocationListState> ctx) async {
}