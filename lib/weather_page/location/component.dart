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
import 'package:owp/weather_page/location/details/component.dart';

import 'air/component.dart';
import 'daily/component.dart';
import 'effect.dart';
import 'hourly/component.dart';
import 'live/component.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class LocationComponent extends Component<LocationState> with WidgetsBindingObserverMixin<LocationState> {
  LocationComponent()
      : super(
    effect: buildEffect(),
    reducer: buildReducer(),
    view: buildView,
    dependencies: Dependencies<LocationState>(
        adapter: null,
        slots: <String, Dependent<LocationState>>{
          'live': LiveConnector() + LiveComponent(),
          'hourly': HourlyConnector() + HourlyComponent(),
          'daily': DailyConnector() + DailyComponent(),
          'details': DetailsConnector() + DetailsComponent(),
          'air': AirConnector() + AirComponent(),
        }),);

}
