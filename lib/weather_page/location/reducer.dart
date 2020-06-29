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

import 'action.dart';
import 'state.dart';

Reducer<LocationState> buildReducer() {
  return asReducer(
    <Object, Reducer<LocationState>>{
      LocationAction.updateLocationName: _updateLocationName,
      LocationAction.updateTimestamp: _updateTimestamp,
      LocationAction.setUpdatingStatus: _setUpdatingStatus,
      LocationAction.updateCity: _updateCity,
      LocationAction.updateGpsLocation: _updateGpsLocation,
    },
  );
}

LocationState _updateLocationName(LocationState state, Action action) {
  LocationState location = action.payload ?? null;
  if (location?.id == state.id) {
    return state.clone()
      ..name = location.name;
  }
  return state;
}

LocationState _updateTimestamp(LocationState state, Action action) {
  LocationState location = action.payload ?? null;
  if (location?.id == state.id) {
    var n = DateTime.now();
    return state.clone()
      ..timestamp = n;
  }
  return state;
}

LocationState _setUpdatingStatus(LocationState state, Action action) {
  LocationState location = action.payload ?? null;
  if (location?.id == state.id) {
    return state.clone()
      ..updatingStatus = location.updatingStatus;
  }
  return state;
}

LocationState _updateCity(LocationState state, Action action) {
  LocationState location = action.payload ?? null;
  if (location?.id == state.id) {
    return state.clone()
      ..city = location.city;
  }
  return state;
}

LocationState _updateGpsLocation(LocationState state, Action action) {
  LocationState location = action.payload ?? null;
  if (location?.id == state.id) {
    return state.clone()
      ..gpsLocation = location.gpsLocation;
  }
  return state;
}
