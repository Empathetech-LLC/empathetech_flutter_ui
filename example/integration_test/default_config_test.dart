/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'screens/home.dart' as home;
import 'utils/export.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

const String parentTest = 'default-config';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  /// Setup mock [SharedPreferences]
  void setMock() {
    SharedPreferences.setMockInitialValues(empathetechConfig);
  }

  group(home.name, () {
    setUpAll(setMock);
    home.testSuite(title: '${home.name}-$parentTest', locale: english);
  });
}
