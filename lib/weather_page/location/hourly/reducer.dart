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

Reducer<HourlyState> buildReducer() {
  return asReducer(<Object, Reducer<HourlyState>>{
    HourlyAction.update: _update,
    HourlyAction.scroll: _scroll,
  });
}

HourlyState _update(HourlyState state, Action action) {
  final HourlyState now = action.payload;
  if (state.id == now?.id) {
    HourlyState newState = state.clone();
    newState.hourlyConditions = now.hourlyConditions;
    return newState;
  }
  return state;
}

HourlyState _scroll(HourlyState state, Action action) {
  final HourlyState now = action.payload;
  if (state.id == now?.id) {
    HourlyState newState = state.clone();
    newState.scrollPosition = now.scrollPosition;
    return newState;
  }
  return state;
}
