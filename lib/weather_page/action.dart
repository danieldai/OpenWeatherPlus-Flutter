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

import 'location/state.dart';


enum WeatherAction {
  onWeatherPageChanged,
  setActiveIndex,
  onEditLocationList,
}

class WeatherActionCreator {
  static Action onWeatherPageChangedAction(int index) {
    return Action(WeatherAction.onWeatherPageChanged, payload: index);
  }

  static Action setActiveIndexAction(int index) {
    return Action(WeatherAction.setActiveIndex, payload: index);
  }

  static Action onEditLocationListAction(List<LocationState> states) {
    return Action(WeatherAction.onEditLocationList, payload: states);
  }
}
