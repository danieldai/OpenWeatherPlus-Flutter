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
import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class GpsLocation implements Cloneable<GpsLocation> {
  DateTime timestamp;

  String country;

  String province;

  String city;

  String district;

  String street;

  double latitude;

  double longitude;

  String formattedAddress;

  GpsLocation(
      {this.timestamp,
      this.country,
      this.province,
      this.city,
      this.district,
      this.street,
      this.latitude,
      this.longitude,
      this.formattedAddress});

  factory GpsLocation.fromAmapLocation(AMapLocation aMapLocation) {
    return GpsLocation(
      timestamp: DateTime.fromMillisecondsSinceEpoch((aMapLocation.timestamp*1000).floor()),
      country: aMapLocation.country,
      province: aMapLocation.province,
      city: aMapLocation.province,
      district: aMapLocation.district,
      street: aMapLocation.street,
      latitude: aMapLocation.latitude,
      longitude: aMapLocation.longitude,
      formattedAddress: aMapLocation.formattedAddress,
    );
  }

  factory GpsLocation.fromJson(Map<String, dynamic> parsedJson) => _$GpsLocationFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$GpsLocationToJson(this);

  @override
  GpsLocation clone() {
    return GpsLocation()
      ..timestamp = timestamp
      ..country = country
      ..province = province
      ..city = city
      ..district = district
      ..street = street
      ..latitude = latitude
      ..longitude = longitude
      ..formattedAddress = formattedAddress;
  }

  @override
  String toString() {
    return 'GpsLocation{address: $formattedAddress, latitude: $latitude, longitude: $longitude }';
  }
}
