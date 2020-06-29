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
import 'package:owp/vendor/model.dart';
import 'package:owp/weather_page/location/state.dart';

import 'action.dart';
import 'state.dart';

Reducer<LocationListState> buildReducer() {
  return asReducer(
    <Object, Reducer<LocationListState>>{
      LocationListAction.deleteLocation: _deleteLocation,
      LocationListAction.receivedHotCities: _receivedHotCities,
      LocationListAction.receivedSearchCities: _receivedSearchCities,
    },
  );
}

LocationListState _deleteLocation(LocationListState state, Action action) {
  LocationState locationState = action.payload;
  final LocationListState newState = state.clone();
  newState.locationStates = List.from(
      newState.locationStates.where((l) => l.id != locationState?.id));
  return newState;
}


LocationListState _receivedHotCities(LocationListState state, Action action) {
  List<HeCity> cities = action.payload ?? List<HeCity>();
  final LocationListState newState = state.clone();
  newState.hotCities = cities;
  return newState;
}

LocationListState _receivedSearchCities(LocationListState state, Action action) {
  List<HeCity> cities = action.payload ?? List<HeCity>();
  final LocationListState newState = state.clone();
  newState.searchCities = cities;
  return newState;
}