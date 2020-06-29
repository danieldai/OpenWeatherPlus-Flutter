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

import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


Future<Null> getPhonePermission(BuildContext context) async {
  // get phone permission is not valid on iOS
  if (Platform.isIOS) {
    return;
  }

  // 检查是否有手机设备权限，用于获取IMEI等信息
  PermissionStatus permission =
  await PermissionHandler().checkPermissionStatus(PermissionGroup.phone);
  if (!(permission == PermissionStatus.granted)) {
    await PermissionHandler().requestPermissions([PermissionGroup.phone]);
  }

  permission =
  await PermissionHandler().checkPermissionStatus(PermissionGroup.phone);
  // 在此循环中确保获取手机设备权限，否则不继续
  while (!(permission == PermissionStatus.granted)) {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Row(children: [
            Icon(
              Icons.device_unknown,
              color: Colors.redAccent,
            ),
            Text("没有手机设备权限")
          ]),
          content: Text("我们需要获取您的手机设备权限，否则您可能无法正常使用亲壳天气"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("拒绝"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text("允许"),
              onPressed: () async {
                await PermissionHandler()
                    .requestPermissions([PermissionGroup.phone]);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    permission =
    await PermissionHandler().checkPermissionStatus(PermissionGroup.phone);

    if (!(permission == PermissionStatus.granted)) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Row(children: [
              Icon(
                Icons.error,
                color: Colors.redAccent,
              ),
              Text("获取权限失败")
            ]),
            content: Text("获取您的手机设备权限失败，您可能无法正常使用亲壳天气；是否要打开应用设置并允许权限"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              FlatButton(
                child: Text("取消"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                child: Text("确定"),
                onPressed: () async {
                  await PermissionHandler().openAppSettings();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}

Future<Null> getStoragePermission(BuildContext context) async {
  // 获取存储权限
  PermissionStatus permission =
  await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
  if (!(permission == PermissionStatus.granted)) {
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }

  permission =
  await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);

  // 在循环中确保获取存储权限
  while (!(permission == PermissionStatus.granted)) {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Row(children: [
            Icon(
              Icons.insert_drive_file,
              color: Colors.redAccent,
            ),
            Text("没有存储空间权限")
          ]),
          content: Text("我们需要获取您的存储空间权限，否则您可能无法正常使用亲壳天气"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("拒绝"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text("允许"),
              onPressed: () async {
                if (permission == PermissionStatus.denied) {
                  await PermissionHandler()
                      .requestPermissions([PermissionGroup.storage]);
                } else {
                  await PermissionHandler().openAppSettings();
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);

    if (!(permission == PermissionStatus.granted)) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Row(children: [
              Icon(
                Icons.error,
                color: Colors.redAccent,
              ),
              Text("获取权限失败")
            ]),
            content: Text("获取您的存储空间权限失败，您可能无法正常使用亲壳天气；是否要打开应用设置并允许权限"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              FlatButton(
                child: Text("取消"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                child: Text("确定"),
                onPressed: () async {
                  await PermissionHandler().openAppSettings();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}

Future<Null> openLocationSetting() async {
  final AndroidIntent intent = AndroidIntent(
    action: 'android.settings.LOCATION_SOURCE_SETTINGS',
  );
  await intent.launch();
}

Future<PermissionStatus> getLocationPermission(BuildContext context, {ensure = true}) async {
  // 先确保手机的定位服务已经开启，// TODO 这里使用Android特定实现，移植到ios时需要注意
  ServiceStatus serviceStatus =
  await PermissionHandler().checkServiceStatus(PermissionGroup.location);

  while (serviceStatus != ServiceStatus.enabled && ensure) {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Row(children: [
            Icon(
              Icons.location_off,
              color: Colors.redAccent,
            ),
            Text("定位服务未开启")
          ]),
          content: Text("我们需要获取您的位置信息，否则可能无法正常使用亲壳天气，请打开手机的定位服务"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("拒绝"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              textColor: Colors.white,
              child: Text("确定"),
              onPressed: () async {
                await openLocationSetting();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    serviceStatus =
    await PermissionHandler().checkServiceStatus(PermissionGroup.location);
  }

  // 确保获取手机的定位服务权限
  PermissionStatus permission = await PermissionHandler()
      .checkPermissionStatus(PermissionGroup.locationWhenInUse);
  if (!(permission == PermissionStatus.granted)) {
    await PermissionHandler()
        .requestPermissions([PermissionGroup.locationWhenInUse]);
  }

  permission = await PermissionHandler()
      .checkPermissionStatus(PermissionGroup.locationWhenInUse);

  if(!ensure) {
    return permission;
  }

  while (!(permission == PermissionStatus.granted)) {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Row(children: [
            Icon(
              Icons.location_off,
              color: Colors.redAccent,
            ),
            Text("没有位置信息权限")
          ]),
          content: Text("我们需要获取您的位置信息，否则可能无法正常使用亲壳天气"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("拒绝"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              textColor: Colors.white,
              child: Text("允许"),
              onPressed: () async {
                if (permission == PermissionStatus.denied) {
                  await PermissionHandler()
                      .requestPermissions([PermissionGroup.locationWhenInUse]);
                } else {
                  await PermissionHandler().openAppSettings();
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.locationWhenInUse);

    if (permission == PermissionStatus.granted) {
      return permission;
    } else {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Row(children: [
              Icon(
                Icons.error,
                color: Colors.redAccent,
              ),
              Text("获取权限失败")
            ]),
            content: Text("获取您的位置信息权限失败，您可能无法正常使用亲壳天气；是否要打开应用设置并允许权限"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              FlatButton(
                child: Text("取消"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              RaisedButton(
                textColor: Colors.white,
                child: Text("确定"),
                onPressed: () async {
                  await PermissionHandler().openAppSettings();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  return null;
}