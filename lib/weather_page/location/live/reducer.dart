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

Reducer<LiveState> buildReducer() {
  return asReducer(<Object, Reducer<LiveState>>{
    LiveAction.updateCondition: _updateCondition,
    LiveAction.updateAqi: _updateAqi,
  });
}

LiveState _updateCondition(LiveState state, Action action) {
  final LiveState now = action.payload;
  if (state.id == now?.id) {
    LiveState newState = state.clone();
    newState.liveCondition = now.liveCondition;
    return newState;
  }
  return state;
}

LiveState _updateAqi(LiveState state, Action action) {
  final LiveState now = action.payload;
  if (state.id == now?.id) {
    LiveState newState = state.clone();
    newState.liveAqi = now.liveAqi;
    return newState;
  }
  return state;
}