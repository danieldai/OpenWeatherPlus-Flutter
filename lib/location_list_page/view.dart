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
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:owp/weather_page/location/state.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:owp/common/permissions.dart';
import 'package:owp/constants.dart';
import 'package:owp/location_list_page/action.dart';
import 'package:owp/platform/feedback.dart';
import 'package:owp/vendor/amap/model.dart';
import 'package:owp/vendor/api.dart';
import 'package:owp/vendor/model.dart';

import 'state.dart';

var logger = Logger();

Widget buildView(
    LocationListState state, Dispatch dispatch, ViewService viewService) {
  var screenUtil = ScreenUtil();
  return WillPopScope(
      onWillPop: () {
        Navigator.pop<LocationListState>(viewService.context, state);
        // 返回false，告知onWillPop手动返回上级路由
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            title:
                Text('城市管理', style: TextStyle(fontSize: screenUtil.setSp(53))),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () async {
                    // 限制用户只能关注7个城市，包含自动定位位置
                    if (state.locationStates.length >= 7) {

                      showLongAlert("抱歉，最多只能关注7个城市", screenUtil.setSp(44));

                    } else {
                      HeCity result = await showSearch(
                        context: viewService.context,
                        delegate: LocationSearchDelegate(
                            locations: state.locationStates,
                            hotCities: HeWeather.getHotCities(number: 29)),
                      );

                      //用户可能没有选择任何城市
                      if(result == null) return;

                      if (result.id == GPS_LOCATION_ID) {
                        // 获取到GPS位置时，说明已经获取到定位权限
                        // 如果是GPS位置，先定位，然后返回
                        AMapLocation loc;
                        try {
                          logger.d('begin get gps location');

                          //针对GPS位置启动高德定位客户端
                          await AMapLocationClient.startup(
                              AMapLocationOption(
                                  onceLocation: true,
                                  desiredAccuracy: CLLocationAccuracy
                                      .kCLLocationAccuracyHundredMeters));
                          loc = await AMapLocationClient.getLocation(true);
                          AMapLocationClient.shutdown();
                        } catch (e) {
                          logger.d('error', e);
                        }
                        logger.d('Got gps localtion: $loc');

                        if (!loc.success) {
                          //定位失败时显示错误信息对话框 success=false

                          showLongAlert("定位失败，未添加自动定位位置", 16.0, gravity: ToastGravity.CENTER);

                        } else {
                          var newLocation = LocationState.simple(
                              id: GPS_LOCATION_ID,
                              name: '${loc.district} ${loc.street ?? ""}',
                              gps: true)
                            ..gpsLocation = GpsLocation.fromAmapLocation(loc);

                          Navigator.of(viewService.context)
                              .pop<LocationListState>(state.clone()
                                ..locationStates.add(newLocation));
                        }
                      } else {
                        // 用户添加了新位置后，把新位置和已有位置合并后返回给上级Page
                        var newLocation = LocationState.simple(
                            id: result.id, name: result.name)
                          ..city = result;

                        Navigator.of(viewService.context)
                            .pop<LocationListState>(
                                state.clone()..locationStates.add(newLocation));
                      }
                    }
                  }),
            ],
          ),
          body: Container(
              padding: EdgeInsets.only(top: screenUtil.setWidth(27.5)),
              child: ListView(
                  children:
                      state.locationStates.map((LocationState locationState) {
                return Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 0.5, color: Colors.grey[300]))),
                    child: ListTile(
                      leading: locationState.gps
                          ? Icon(Icons.home)
                          : Icon(Icons.business),
                      title: Text(locationState.name,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: screenUtil.setSp(44))),
                      //GPS位置不能删除
                      trailing: locationState.gps
                          ? IconButton(
                              icon: Icon(
                                Icons.location_on,
                                color: Colors.grey,
                              ),
                              onPressed: () {})
                          : IconButton(
                              icon: Icon(Icons.cancel, color: Colors.red),
                              onPressed: () {
                                dispatch(LocationListActionCreator
                                    .deleteLocationAction(locationState));
                              }),
                    ));
              }).toList()))));
}

class LocationSearchDelegate extends SearchDelegate<HeCity> {
  final List<LocationState> locations;
  final Future<List<HeCity>> hotCities;
  final List<HeCity> searchCities;

  LocationSearchDelegate({this.locations, this.hotCities, this.searchCities});

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            close(context, null);
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    if (query.length < 2) {
      return _buildHotCities(context);
    } else {
      return _buildFilteredCities(context);
    }
  }

  FutureBuilder<List<HeCity>> _buildHotCities(BuildContext context) {
    return FutureBuilder<List<HeCity>>(
        future: hotCities,
        builder: (context, AsyncSnapshot<List<HeCity>> async) {
          Widget ret;
          //在这里根据快照的状态，返回相应的widget
          if (async.connectionState == ConnectionState.active ||
              async.connectionState == ConnectionState.waiting) {
            ret = Center(
              child: CircularProgressIndicator(),
            );
          }
          if (async.connectionState == ConnectionState.done) {
            if (async.hasError) {
              return ret = Center(
                child: Text("ERROR"),
              );
            } else if (async.hasData) {
              List<HeCity> hotCities = async.data;
              ret = buildHotCityListView(context, hotCities);
            }
          }
          return ret;
        });
  }

  /// 在热门城市的第一个位置显示一个特殊按钮，显示当前定位位置
  /// 如果未定位则显示定位提示信息，用户点击时请求定位权限
  Widget buildHotCityListView(BuildContext context, List<HeCity> hotCities) {
    var screenUtil = ScreenUtil();

    // 把GPS位置放在第1个
    if (hotCities[0].id != GPS_LOCATION_ID) {
      hotCities.insert(0, HeCity(id: GPS_LOCATION_ID, name: '定位'));
    }

    Set<String> ids = locations.map((l) => l.id).toSet();

    var _buildCityCard = (city) {
      var fontSize = screenUtil.setSp(44);

      return Card(
          //color: Colors.red,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          elevation: 3.0,
          child: InkWell(
              onTap: () async {
                if (ids.contains(city.id)) {

                  showShortAlert("抱歉，不能重复添加城市", screenUtil.setSp(44));

                } else if (city.id == GPS_LOCATION_ID) {
                  // 请求定位，如果定位成功，把定位位置添加到城市列表
                  // 请求定位权限
                  var permissionStatus =
                      await getLocationPermission(context, ensure: false);

                  // 获取到定位权限后，把定位位置作为第一个城市添加到城市列表中
                  if (permissionStatus == PermissionStatus.granted) {
                    close(context, city);
                  } else {
                    //定位失败时显示错误信息对话框 success=false

                    showShortAlert("没有权限定位设备，请检查APP权限配置", screenUtil.setSp(44), gravity: ToastGravity.CENTER);

                  }
                } else {
                  close(context, city);
                }
              },
              child: Container(
                  height: screenUtil.setWidth(82.5),
                  alignment: Alignment.center,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        if (city.id == GPS_LOCATION_ID)
                          Icon(Icons.location_on,
                              color: ids.contains(city.id)
                                  ? Colors.cyan
                                  : Colors.black54),
                        Text("${city.name}",
                            style: TextStyle(
                                fontSize: fontSize,
                                color: ids.contains(city.id)
                                    ? Colors.cyan
                                    : Colors.black54))
                      ]))));
    };

    return Container(
        padding: EdgeInsets.only(
            left: screenUtil.setWidth(55),
            right: screenUtil.setWidth(55),
            top: screenUtil.setWidth(55)),
        child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 20,
            childAspectRatio: 2.5,
            children: hotCities.map(_buildCityCard).toList()));
  }

  FutureBuilder<List<HeCity>> _buildFilteredCities(BuildContext context) {
    return FutureBuilder<List<HeCity>>(
      builder: (context, AsyncSnapshot<List<HeCity>> async) {
        Widget ret;
        //在这里根据快照的状态，返回相应的widget
        if (async.connectionState == ConnectionState.active ||
            async.connectionState == ConnectionState.waiting) {
          ret = Center(
            child: CircularProgressIndicator(),
          );
        }
        if (async.connectionState == ConnectionState.done) {
          if (async.hasError) {
            return ret = Center(
              child: Text("ERROR"),
            );
          } else if (async.hasData) {
            List<HeCity> list = async.data;
            ret = buildSearchCityListView(context, list);
          }
        }
        return ret;
      },
      future: HeWeather.searchCities(query),
    );
  }

  Widget buildSearchCityListView(
      BuildContext context, List<HeCity> filteredCities) {
    var screenUtil = ScreenUtil();
    Set<String> ids = locations.map((l) => l.id).toSet();

    return ListView.builder(
      itemCount: filteredCities.length,
      itemBuilder: (context, index) {
        var city = filteredCities[index];
        return ListTile(
            onTap: () {
              if (ids.contains(city.id)) {

                showShortAlert("抱歉，不能重复添加城市", screenUtil.setSp(44));

              } else {
                close(context, city);
              }
            },
            title: Container(
                padding: EdgeInsets.only(bottom: screenUtil.setWidth(44)),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 0.5, color: Colors.grey[300]))),
                child: Text(
                    "${city.country}-${city.adminArea}-${city.parentCity}-${city.name}",
                    style: TextStyle(
                        fontSize: screenUtil.setSp(44),
                        color: ids.contains(city.id)
                            ? Colors.cyan
                            : Colors.black87))));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length < 2) {
      return _buildHotCities(context);
    } else {
      return _buildFilteredCities(context);
    }
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    var screenUtil = ScreenUtil();
    return super.appBarTheme(context).copyWith(
        textTheme: TextTheme(title: TextStyle(fontSize: screenUtil.setSp(44))));
  }
}
