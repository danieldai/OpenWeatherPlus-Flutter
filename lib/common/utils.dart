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

import 'package:flutter_bugly/flutter_bugly.dart';

DateTime fromDateTime(DateTime src,
    {int year,
    int month,
    int day,
    int hour,
    int minute,
    int second,
    int millisecond}) {
  return DateTime(
      year == null ? src.year : year,
      month == null ? src.month : month,
      day == null ? src.day : day,
      hour == null ? src.hour : hour,
      minute == null ? src.minute : minute,
      second == null ? src.second : second,
      millisecond == null ? src.millisecond : millisecond);
}

DateTime currentHour() {
  var now = DateTime.now();
  return fromDateTime(now, minute: 0, second: 0, millisecond: 0);
}

Future<double> whenNotZero(Stream<double> source) async {
  await for (double value in source) {
    if (value > 0) {
      return value;
    }
  }
  // stream exited without a true value, maybe return an exception.
}

// 描述在canvas上的绘画区域
class PaintBox {
  /// 绘画内容的左边界
  double left;

  /// 绘画内容的上边界
  double top;

  /// 绘画内容的高度
  double height;

  /// 绘画内容的宽度
  double width;

  PaintBox({this.left, this.top, this.height, this.width});

  PaintBox.fromLTHW(this.left, this.top, this.height, this.width);

  @override
  String toString() {
    return 'PaintBox{left: $left, top: $top, height: $height, width: $width}';
  }
}

void uploadException(Exception e, StackTrace stacktrace) {
  FlutterBugly.uploadException(
      message: e.toString(),
      detail: stacktrace.toString());
}

T getElementAt<T>(List<T> list, int index) {
  try {
    return list?.elementAt(index);
  } on RangeError catch(e) {
    return null;
  }
}