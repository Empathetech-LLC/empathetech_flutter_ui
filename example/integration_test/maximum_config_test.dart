/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'screens/settings/home.dart' as home;
import 'screens/settings/color.dart' as color;
import 'screens/settings/design.dart' as design;
import 'screens/settings/layout.dart' as layout;
import 'screens/settings/text.dart' as text;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  EzConfig.init(
    assetPaths: <String>{},
    defaults: empathMaxConfig,
    localeFallback: americanEnglish,
    l10nFallback: await EFUILang.delegate.load(americanEnglish),
    preferences: await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(
          allowList: allEZConfigKeys.keys.toSet()),
    ),
  );

  group(
    'maximum-config',
    () {
      home.testSuite();
      color.testSuite();
      design.testSuite();
      layout.testSuite();
      text.testSuite();
    },
  );
}
