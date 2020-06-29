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
import 'package:owp/common/permissions.dart';
import 'package:owp/common/utils.dart';
import 'package:owp/platform/feedback.dart';
import 'package:owp/vendor/amap/model.dart';
import 'package:owp/vendor/api.dart';
import 'action.dart';
import 'daily/action.dart';
import 'hourly/action.dart';
import 'live/action.dart';
import 'state.dart';

//数据超过10分钟再重新获取天气数据
//const DATA_FETCH_INTERVAL = Duration(minutes: 10);
const DATA_FETCH_INTERVAL = Duration(seconds: 10);

var logger = Logger();

Effect<LocationState> buildEffect() {
  return combineEffects(<Object, Effect<LocationState>>{
    Lifecycle.initState: _init,
    // didUpdateWidget 表示上级widget更新了，导致子widget都重建
    // 上级widget的更新是由于上级widget的对应state发生的变化
    Lifecycle.didUpdateWidget: _update,
    Lifecycle.didChangeAppLifecycleState: _appLifecycleStateChange,
    LocationAction.doRefresh: _doRefresh,
  });
}


// 初始化时，获取一次数据。
void _init(Action action, Context<LocationState> ctx) async {

  var state = ctx.state;
  logger.d('init location component ${ctx.state.name}');

  if(state.activeCityId != state.id) {
    logger.d('activeCityId: ${state.activeCityId} this id: ${state.id} DO NOT update');
    return;
  } else {
    logger.d('activeCityId: ${state.activeCityId} this id: ${state.id} update');
  }

  var now = DateTime.now();
  var ts = ctx.state?.timestamp ?? now.subtract(Duration(days: 1));
  var age = now.difference(ts);


  if (age.compareTo(DATA_FETCH_INTERVAL) < 0) {
    logger.d('data age is $age, no need to fetch data');
    return;
  }

  try {
    await _getDataForLocation(ctx, ctx.state);
  } catch (e) {
    ctx.dispatch(LocationActionCreator.setUpdatingStatus(
        ctx.state.id, UpdatingStatus.failed));

    showLongAlert("访问网络发生错误", 16.0);

    rethrow;
  } finally {
    Future.delayed(const Duration(milliseconds: 1000), () {
      ctx.dispatch(LocationActionCreator.setUpdatingStatus(
          ctx.state.id, UpdatingStatus.idle));
    });
  }

}

// UpdatingStatus.updateNeeded时，更新一次数据
void _update(Action action, Context<LocationState> ctx) async {
  final state = ctx.state;

  if(state.updatingStatus != UpdatingStatus.updateNeeded) return;

  logger.d('Try update location ${state.name}');

  if(state.activeCityId != state.id) {
    logger.d('activeCityId: ${state.activeCityId} this id: ${state.id} DO NOT update');
    return;
  } else {
    logger.d('activeCityId: ${state.activeCityId} this id: ${state.id} update');
  }

  var now = DateTime.now();
  var ts = ctx.state?.timestamp ?? now.subtract(Duration(days: 1));
  var age = now.difference(ts);

  if (age.compareTo(DATA_FETCH_INTERVAL) < 0) {
    logger.d('data age is $age, no need to fetch data');
    return;
  }

  try {
    await _getDataForLocation(ctx, ctx.state);
  } catch (e) {
    ctx.dispatch(LocationActionCreator.setUpdatingStatus(
        ctx.state.id, UpdatingStatus.failed));

    showLongAlert("访问网络发生错误", 16.0);

    rethrow;
  }  finally {
    Future.delayed(const Duration(milliseconds: 1000), () {
      ctx.dispatch(LocationActionCreator.setUpdatingStatus(
          ctx.state.id, UpdatingStatus.idle));
    });
  }
}

void _appLifecycleStateChange(Action action, Context<LocationState> ctx) async {
  AppLifecycleState state = action.payload;

  if (state == AppLifecycleState.resumed) {
    // came back to Foreground
    ctx.dispatch(LocationActionCreator.doRefresh(ctx.state.id));
  }
}

//手动下拉触发的数据更新
void _doRefresh(Action action, Context<LocationState> ctx) async {
  if (ctx.state.updatingStatus == UpdatingStatus.updating) {
    return;
  }

  LocationState location = action.payload ?? null;
  if (location?.id == ctx.state.id) {
    logger.d('refresh location component ${ctx.state.name}');

    var now = DateTime.now();
    var ts = ctx.state?.timestamp ?? now.subtract(Duration(days: 1));
    var age = now.difference(ts);

    if (age.compareTo(DATA_FETCH_INTERVAL) < 0) {
      logger.d('data age is $age, no need to fetch data');
      return;
    }

    try {
      await _getDataForLocation(ctx, ctx.state);
    } catch (e) {
      ctx.dispatch(LocationActionCreator.setUpdatingStatus(
          ctx.state.id, UpdatingStatus.failed));

      showLongAlert("访问网络发生错误", 16.0);

      rethrow;
    } finally {
      Future.delayed(const Duration(milliseconds: 1000), () {
        ctx.dispatch(LocationActionCreator.setUpdatingStatus(
            ctx.state.id, UpdatingStatus.idle));
      });
    }
  }
}




Future<Null> _getDataForLocation(
    Context<LocationState> ctx, LocationState locationState) async {

  if (ctx.state.updatingStatus == UpdatingStatus.updating) {
    logger.d('updatingStatus of ${locationState.name} is ${ctx.state.updatingStatus}, DO NOT getData');
    return;
  }

  logger.d('updatingStatus of ${locationState.name} is ${ctx.state.updatingStatus}, DO getData');

  ctx.dispatch(LocationActionCreator.setUpdatingStatus(
      ctx.state.id, UpdatingStatus.updating));

//  await getPhonePermission(ctx.context);
//  await getStoragePermission(ctx.context);

  if (locationState.gps) {
    await getLocationPermission(ctx.context);

    AMapLocation loc;
    try {
      logger.d('begin get gps location');

      //针对GPS位置启动高德定位客户端
      await AMapLocationClient.startup(AMapLocationOption(
          onceLocation: true,
          desiredAccuracy: CLLocationAccuracy.kCLLocationAccuracyHundredMeters));
      loc = await AMapLocationClient.getLocation(true);
      AMapLocationClient.shutdown();

    } catch (e) {
      logger.d('error', e);
    }
    logger.d('Got gps localtion: $loc');

    if (!loc.success) {
      //定位失败时显示错误信息对话框 success=false
      ctx.dispatch(LocationActionCreator.setUpdatingStatus(
          ctx.state.id, UpdatingStatus.failed));

      showLongAlert("获取地理位置失败", 16.0);

      return;
    }

    //记录GPS位置信息
    ctx.dispatch(LocationActionCreator.updateGpsLocation(
        locationState.id, GpsLocation.fromAmapLocation(loc)));

    //TODO 检查name合法性再更新
    ctx.dispatch(LocationActionCreator.updateLocationName(
        locationState.clone()..name = '${loc.district} ${loc.street ?? ""}'));

    logger.d('Request weather data');

    // 只有gps位置才有分钟级降雨预报

    await _getDataByGps(ctx, locationState, loc.latitude, loc.longitude);

  } else {
    await _getDataByCityId(ctx, locationState);
  }

  logger.d('Finished request weather data');

  //todo 检查是否已经没有余额了
  // status : "no balance"

  //todo 检查API 返回状态
  // 提取保存城市信息
  //HeCity city = HeCity.fromJson(json.decode(responses[0].data)[VERSION][0]['basic']);
  //ctx.dispatch(LocationActionCreator.updateCity(cityId, city));

  //var inChina = city.country == '中国';


  //更新数据时间戳
  ctx.dispatch(LocationActionCreator.updateTimestamp(locationState.id));

  //更新状态标识
  ctx.dispatch(LocationActionCreator.setUpdatingStatus(
      locationState.id, UpdatingStatus.completed));


  Future.delayed(const Duration(milliseconds: 1000), () {
    ctx.dispatch(LocationActionCreator.setUpdatingStatus(
        locationState.id, UpdatingStatus.idle));
  });

  // 如果上面的 dispatch 没有生效，用此来保证状态设计
  Future.delayed(const Duration(milliseconds: 5000), () {
    ctx.dispatch(LocationActionCreator.setUpdatingStatus(
        locationState.id, UpdatingStatus.idle));
  });
}

Future<Null> _getDataByGps(Context<LocationState> ctx, LocationState locationState, double lat, double lon) async {

  //实况天气
  //注意： 前面的数据请求失败，不能影响后面的操作
  try {
    var liveCondition = await HeWeather.getLiveConditionByGps(lat, lon);
    ctx.dispatch(
        LiveActionCreator.updateCondition(locationState.id, liveCondition));
  } on NoSuchMethodError catch(e) {
    logger.d(e.toString());
  } catch(e, stacktrace){
    logger.d('Failed to get liveCondition for ${locationState.id} ${locationState.name}', e);
    uploadException(e, stacktrace);
  }

  //实况空气
  try {
    var liveAqi = await HeWeather.getLiveAqiByGps(lat, lon);
    ctx.dispatch(LiveActionCreator.updateAqi(locationState.id, liveAqi));
  } on NoSuchMethodError catch(e) {
    logger.d(e.toString());
  } catch(e, stacktrace){
    logger.d('Failed to get liveAqi for ${locationState.id} ${locationState.name}', e);
    uploadException(e, stacktrace);
  }

  //每天天气
  try {
    var daily = await HeWeather.getDailyConditionByGps(lat, lon);
    ctx.dispatch(DailyActionCreator.updateCondition(locationState.id, daily));
  } on NoSuchMethodError catch(e) {
    logger.d(e.toString());
  } catch(e, stacktrace){
    logger.d('Failed to get dailyCondition for ${locationState.id} ${locationState.name}', e);
    uploadException(e, stacktrace);
  }


  //小时详情
  try {
    var hourly = await HeWeather.getHourlyDataByGps(lat, lon);
    ctx.dispatch(HourlyActionCreator.onUpdateAction(locationState.id, hourly));
  } on NoSuchMethodError catch(e) {
    logger.d(e.toString());
  } catch(e, stacktrace){
    logger.d('Failed to get hourlyCondition for ${locationState.id} ${locationState.name}', e);
    uploadException(e, stacktrace);
  }

}

Future<Null> _getDataByCityId(Context<LocationState> ctx, LocationState locationState) async {

  //实况天气
  try {
    var liveCondition = await HeWeather.getLiveConditionByCityId(
        locationState.id);
    ctx.dispatch(
        LiveActionCreator.updateCondition(locationState.id, liveCondition));
  } on NoSuchMethodError catch(e) {
    logger.d(e.toString());
  } catch(e, stacktrace){
    logger.d('Failed to get liveCondition for ${locationState.id} ${locationState.name}', e);
    uploadException(e, stacktrace);
  }

  //实况空气
  try {
    var liveAqi = await HeWeather.getLiveAqiByCityId(locationState.id);
    ctx.dispatch(LiveActionCreator.updateAqi(locationState.id, liveAqi));
  } on NoSuchMethodError catch(e) {
    logger.d(e.toString());
  } catch(e, stacktrace){
    logger.d('Failed to get liveAqi for ${locationState.id} ${locationState.name}', e);
    uploadException(e, stacktrace);
  }

  //每天天气
  try {
    var daily = await HeWeather.getDailyConditionByCityId(
        locationState.id);
    ctx.dispatch(DailyActionCreator.updateCondition(locationState.id, daily));
  } on NoSuchMethodError catch(e) {
    logger.d(e.toString());
  } catch(e, stacktrace){
    logger.d('Failed to get dailyCondition for ${locationState.id} ${locationState.name}', e);
    uploadException(e, stacktrace);
  }

  //小时详情
  try {
    var hourly = await HeWeather.getHourlyDataByCityId(locationState.id);
    ctx.dispatch(HourlyActionCreator.onUpdateAction(locationState.id, hourly));
  } on NoSuchMethodError catch(e) {
    logger.d(e.toString());
  } catch(e, stacktrace){
    logger.d('Failed to get hourlyCondition for ${locationState.id} ${locationState.name}', e);
    uploadException(e, stacktrace);
  }

}