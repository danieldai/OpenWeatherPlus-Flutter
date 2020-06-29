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

import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;
import 'package:dio/dio.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:package_info/package_info.dart';
import 'package:owp/common/utils.dart';

import 'model/model.dart';

const String VERSION = 'HeWeather6';

const HEWEATHER_TRY = 3;

class HeWeather {

  static Dio _dio;

  static Future<Dio> getDio() async {
    if (_dio == null) {
      PackageInfo packageInfo;
      try {
        packageInfo = await PackageInfo.fromPlatform();
      } catch (e, stacktrace) {
        uploadException(e, stacktrace);
      }

      _dio = Dio(BaseOptions(
          baseUrl: 'https://search.heweather.net',
          connectTimeout: 5000, //5s
          receiveTimeout: 5000, //5s
          responseType: ResponseType.plain, //确保所有API返回字符串，统一手工做json解析
          headers: {
            'X-App-Version': packageInfo?.version ?? 'NA',
            'X-App-Build': packageInfo?.buildNumber ?? 'NA',
          },
      ));
//      _dio.interceptors.add(LogInterceptor(responseBody: true));
      //_dio.httpClientAdapter = MockAdapter();
    }
    return _dio;
  }

  static Future<List<HeCity>> getHotCities({number = 30}) async {
    var url = '/top';
    var key = '96fc47f64d28432f8972e8226ab4ca3f';

    var params = {
      'group': 'cn',
      'number': number,
      'key': key
    };

    var dio = await getDio();

    // 加入请求失败重试
    // 统计网络请求结果统计到友盟
    Response response;
    var i = 0;
    while(true) {
      try {
        response = await dio.get(url, queryParameters: params);
        break;
      } catch(e, stacktrace) {
        i++;
        FlutterBugly.uploadException(
            message: e.toString() + '(AUTO RETRY)',
            detail: stacktrace.toString());
        if (i == HEWEATHER_TRY) {
          rethrow;
        }
      }
    }

    List<dynamic> cities = json.decode(response.data)[VERSION][0]['basic']
        .map((i) => HeCity.fromJson(i))
        .toList();
    return List<HeCity>.from(cities);
  }

  static Future<List<HeCity>> searchCities(String query) async {

    var url = '/find';
    var key = '96fc47f64d28432f8972e8226ab4ca3f';

    var params = {
      'location': query,
      'group': 'cn',
      'number': 50,
      'key': key,
    };

    params['sign'] = _getSignature(params, key);

    var dio = await getDio();

    // 加入请求失败重试
    // T统计网络请求结果统计到友盟
    Response response;
    var i = 0;
    while(true) {
      try {
        response = await dio.get(url, queryParameters: params);
        break;
      } catch(e, stacktrace) {
        i++;
        FlutterBugly.uploadException(
            message: e.toString() + '(AUTO RETRY)',
            detail: stacktrace.toString());
        if (i == HEWEATHER_TRY) {
          rethrow;
        }
      }
    }

    List<dynamic> cities = json.decode(response.data)[VERSION][0]['basic']
        .map((i) => HeCity.fromJson(i))
        .toList();
    return List<HeCity>.from(cities);
  }

  static Future<LiveCondition> getLiveConditionByCityId(String cityId) async {
    Response response = await getBasicDataByCityId(cityId, 'now');

    LiveCondition condition = LiveCondition.fromJson(json.decode(response.data)[VERSION][0]['now']);
    return condition;
  }

  static Future<LiveCondition> getLiveConditionByGps(double lat, double lon) async {
    Response response = await getBasicDataByGps(lat, lon, 'now');

    LiveCondition condition =
    LiveCondition.fromJson(json.decode(response.data)[VERSION][0]['now']);
    return condition;
  }

  static Future<LiveAqi> getLiveAqiByCityId(String cityId) async {
    Response response = await getAirDataByCityId(cityId, 'now');

    LiveAqi condition = LiveAqi.fromJson(json.decode(response.data)[VERSION][0]['air_now_city']);
    return condition;
  }

  static Future<LiveAqi> getLiveAqiByGps(double lat, double lon) async {
    Response response = await getAirDataByGps(lat, lon, 'now');

    //TODO 国外没有 aqi 数据
    LiveAqi condition = LiveAqi.fromJson(json.decode(response.data)[VERSION][0]['air_now_city']);
    return condition;
  }

  static Future<List<HeIndexItem>> getIndexByCityId(String cityId) async {
    Response response = await getBasicDataByCityId(cityId, 'lifestyle');

    List<dynamic> states = json.decode(response.data)[VERSION][0]['lifestyle']
        .map((i) => HeIndexItem.fromJson(i))
        .toList();
    return List<HeIndexItem>.from(states);
  }

  static Future<List<HeIndexItem>> getIndexByGps(double lat, double lon) async {
    Response response = await getBasicDataByGps(lat, lon, 'lifestyle');

    List<dynamic> states = json.decode(response.data)[VERSION][0]['lifestyle']
        .map((i) => HeIndexItem.fromJson(i))
        .toList();
    return List<HeIndexItem>.from(states);
  }

  static Future<List<HourlyCondition>> getHourlyDataByCityId(String cityId) async {
    Response response = await getBasicDataByCityId(cityId, 'hourly');

    List<dynamic> states = json.decode(response.data)[VERSION][0]['hourly']
        .map((i) => HourlyCondition.fromJson(i))
        .toList();

    return List<HourlyCondition>.from(states);
  }

  static Future<List<HourlyCondition>> getHourlyDataByGps(double lat, double lon) async {
    Response response = await getBasicDataByGps(lat, lon, 'hourly');

    List<dynamic> states = json.decode(response.data)[VERSION][0]['hourly']
        .map((i) => HourlyCondition.fromJson(i))
        .toList();
    return List<HourlyCondition>.from(states);
  }

  static Future<List<DailyCondition>> getDailyConditionByCityId(String cityId) async {
    Response response = await getBasicDataByCityId(cityId, 'forecast');

    List<dynamic> states = json.decode(response.data)[VERSION][0]['daily_forecast']
        .map((i) => DailyCondition.fromJson(i))
        .toList();
    return List<DailyCondition>.from(states);
  }

  static Future<List<DailyCondition>> getDailyConditionByGps(double lat, double lon) async {
    Response response = await getBasicDataByGps(lat, lon, 'forecast');

    List<dynamic> states = json.decode(response.data)[VERSION][0]['daily_forecast']
        .map((i) => DailyCondition.fromJson(i))
        .toList();
    return List<DailyCondition>.from(states);
  }

  static Future<List<DailyAqi>> getDailyAqiByCityId(String cityId) async {
    Response response = await getAirDataByCityId(cityId, 'forecast');

    List<dynamic> states = json.decode(response.data)[VERSION][0]['air_forecast']
        .map((i) => DailyAqi.fromJson(i))
        .toList();

    return List<DailyAqi>.from(states);
  }

  static Future<List<DailyAqi>> getDailyAqiByGps(double lat, double lon) async {
    Response response = await getAirDataByGps(lat, lon, 'forecast');

    List<dynamic> states = json.decode(response.data)[VERSION][0]['air_forecast']
        .map((i) => DailyAqi.fromJson(i))
        .toList();

    return List<DailyAqi>.from(states);
  }

  static Future<Response> getAlertByGps(double lat, double lon) async {
    var url = 'https://free-api.heweather.net/s6/alarm';

    return getData(url, '$lon,$lat');

  }

  static Future<Response> getAlertByCityId(String cityId) async {
    var url = 'https://free-api.heweather.net/s6/alarm';

    return getData(url, cityId);
  }

  static Future<Response> getGridMinuteByGps(double lat, double lon) async {
    return getGridDataByGps(lat, lon, 'grid-minute');
  }

  /*
  weather-type 值	描述	授权
  now	实况天气	商业/免费
  forecast	3-10天预报	商业/免费
  hourly	逐小时预报	商业/免费
  lifestyle	生活指数	商业/免费
  */
  static Future<Response> getBasicDataByCityId(String cityId, [String type]) {
    var url = 'https://free-api.heweather.net/s6/weather';
    if (type != null) {
      url += '/$type';
    }
    return getData(url, cityId);
  }

  /*
  air-type 值	描述	授权
  now	空气质量实况	商业/免费
  forecast	未来3-7天空气质量预报	商业
  hourly	未来24小时逐小时空气质量预报	商业
   */
  static Future<Response> getAirDataByCityId(String cityId, [String type]) {
    var url = 'https://free-api.heweather.net/s6/air';
    if (type != null) {
      url += '/$type';
    }
    return getData(url, cityId);
  }


  /*
  weather-type 值	描述	授权
  now	实况天气	商业/免费
  forecast	3-10天预报	商业/免费
  hourly	逐小时预报	商业/免费
  lifestyle	生活指数	商业/免费
  */
  static Future<Response> getBasicDataByGps(double lat, double lon, [String type]) {
    var url = 'https://free-api.heweather.net/s6/weather';
    if (type != null) {
      url += '/$type';
    }
    return getData(url, '$lon,$lat');
  }

  /*
  air-type 值	描述	授权
  now	空气质量实况	商业/免费
  forecast	未来3-7天空气质量预报	商业
  hourly	未来24小时逐小时空气质量预报	商业
   */
  static Future<Response> getAirDataByGps(double lat, double lon, [String type]) {
    var url = 'https://free-api.heweather.net/s6/air';
    if (type != null) {
      url += '/$type';
    }
    return getData(url, '$lon,$lat');
  }

  /*

  grid-type 值	描述	授权
  grid-now	格点实况天气	商业
  grid-forecast	格点3-7天预报	商业/免费
  grid-hourly	格点逐小时预报	商业
  grid-minute 分钟级降雨 商业版
   */
  static Future<Response> getGridDataByGps(double lat, double lon, [String type]) {
    var url = 'https://api.heweather.net/s6/weather';
    if (type != null) {
      url += '/$type';
    }
    return getData(url, '$lon,$lat');
  }

  static Future<Response> getData(String url, String location) async {
    var key = '96fc47f64d28432f8972e8226ab4ca3f';

    var dio = await getDio();

    var params = {
      'username': 'HE2006301521521507',
      'lang': 'zh',
      'location': location,
      't': DateTime
          .now()
          .millisecondsSinceEpoch ~/ 1000,
      'sign': ''
    };

    params['sign'] = _getSignature(params, key);

    return dio.get(url, queryParameters: params);
  }
}


String _getSignature(Map<String, dynamic> params, String secret) {
  var data = '';
  var sortedKeys = params.keys.toList()..sort();

  for(var k in sortedKeys) {
    if (k != 'sign' && k != 'key' && params[k].toString() != '') {
      data += k + '=' + params[k].toString() + '&';
    }
  }
  data = data.substring(0, data.length-1);
  data += secret;

  var content = Utf8Encoder().convert(data);
  var md5 = crypto.md5;
  var digest = md5.convert(content);
  return base64.encode(digest.bytes);
}
