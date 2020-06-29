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
import 'package:owp/vendor/model.dart';

import 'state.dart';

enum DailyAction { updateCondition, updateAqi, scroll }

class DailyActionCreator {
  static Action updateCondition(String id, List<DailyCondition> conditions) {
    return PersistAction(DailyAction.updateCondition,
        payload: DailyState(id: id)..dailyConditions = conditions);
  }

  static Action updateAqi(String id, List<DailyAqi> aqis) {
    return PersistAction(DailyAction.updateAqi,
        payload: DailyState(id: id)..dailyAqis = aqis);
  }

  static Action onScrollAction(String id, double scrollPosition) {
    return Action(DailyAction.scroll,
        payload: DailyState(id: id)..scrollPosition = scrollPosition);
  }
}
