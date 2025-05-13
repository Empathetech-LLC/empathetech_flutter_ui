/* open_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'screens/settings_home.dart' as home;
import 'screens/text_settings.dart' as text;
import 'screens/layout_settings.dart' as layout;
import 'screens/color_settings.dart' as color;
import 'screens/image_settings.dart' as image;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences.setMockInitialValues(mobileEmpathConfig);
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  EzConfig.init(
    preferences: prefs,
    defaults: mobileEmpathConfig,
    fallbackLang: await EFUILang.delegate.load(english),
    assetPaths: <String>{},
  );

  group(
    'default-config',
    () {
      home.testSuite();
      text.testSuite();
      layout.testSuite();
      color.testSuite();
      image.testSuite();
    },
  );
}
