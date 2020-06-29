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
import 'package:owp/common/basic.dart';
import 'package:owp/vendor/amap/model.dart';
import 'package:owp/vendor/model.dart';

import 'state.dart';


enum LocationAction {
  setUpdatingStatus,
  updateGpsLocation,
  updateLocationName,
  updateTimestamp,
  updateCity,
  doRefresh,
  updateBackgroundCode,
}

class LocationActionCreator {
  static Action setUpdatingStatus(String id, UpdatingStatus status) {
    return Action(LocationAction.setUpdatingStatus,
        payload: LocationState(id: id)..updatingStatus = status);
  }

  static Action updateGpsLocation(String id, GpsLocation gpsLocation) {
    return Action(LocationAction.updateGpsLocation,
        payload: LocationState(id: id)..gpsLocation = gpsLocation);
  }

  static Action updateLocationName(LocationState location) {
    return PersistAction(LocationAction.updateLocationName, payload: location);
  }

  static Action updateTimestamp(String id) {
    return PersistAction(LocationAction.updateTimestamp,
        payload: LocationState(id: id));
  }

  static Action updateCity(String id, HeCity city) {
    return Action(LocationAction.updateCity,
        payload: LocationState(id: id)..city = city);
  }

  static Action doRefresh(String id) {
    return Action(LocationAction.doRefresh,
        payload: LocationState(id: id));
  }

  static Action updateBackgroundCode(String conditionCode) {
    return Action(LocationAction.updateBackgroundCode, payload: conditionCode);
  }
}
