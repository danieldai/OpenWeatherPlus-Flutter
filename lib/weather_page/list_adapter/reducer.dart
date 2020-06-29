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
import 'package:owp/weather_page/location/state.dart';

import '../state.dart';
import 'action.dart';

Reducer<WeatherState> buildReducer() {
  return asReducer(<Object, Reducer<WeatherState>>{
    LocationStateListAction.add: _add,
    LocationStateListAction.update: _update,
  });
}

WeatherState _add(WeatherState state, Action action) {
  final LocationState location = action.payload;
  final WeatherState newState = state.clone();
  newState.locationStates =
  List<LocationState>.from(state.locationStates);
  newState.locationStates.insert(1, location);
  return newState;
}

WeatherState _update(WeatherState state, Action action) {
  final List<LocationState> locations = action.payload ?? [];
  final WeatherState newState = state.clone();
  newState.locationStates = List<LocationState>.from(locations);
  return newState;
}