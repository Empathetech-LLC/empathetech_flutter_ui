/* open_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'screens/settings_home.dart' as home;
import 'screens/color_settings.dart' as color;
import 'screens/design_settings.dart' as design;
import 'screens/layout_settings.dart' as layout;
import 'screens/text_settings.dart' as text;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  final Map<String, Object> testConfig = <String, Object>{
    ...mobileEmpathConfig,
    appLocaleKey: <String>['es'],
  };

  SharedPreferences.setMockInitialValues(testConfig);
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  EzConfig.init(
    preferences: prefs,
    defaults: testConfig,
    fallbackLang: await EFUILang.delegate.load(americanEnglish),
    assetPaths: <String>{},
  );

  group(
    'es-locale',
    () {
      home.testSuite(locale: spanish);
      color.testSuite(locale: spanish);
      design.testSuite(locale: spanish);
      layout.testSuite(locale: spanish);
      text.testSuite(locale: spanish);
    },
  );
}
