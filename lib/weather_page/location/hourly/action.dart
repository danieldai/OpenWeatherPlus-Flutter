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

enum HourlyAction { update, scroll }

class HourlyActionCreator {
  static Action onUpdateAction(
      String id, List<HourlyCondition> hourlyConditions) {
    return PersistAction(HourlyAction.update,
        payload: HourlyState(id: id)..hourlyConditions = hourlyConditions);
  }

  static Action onScrollAction(String id, double scrollPosition) {
    return Action(HourlyAction.scroll,
        payload: HourlyState(id: id)..scrollPosition = scrollPosition);
  }
}
