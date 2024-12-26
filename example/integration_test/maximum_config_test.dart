/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
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

  final Map<String, Object> testConfig = <String, Object>{
    ...empathetechConfig,
    isDarkThemeKey: true,

    // Text settings //

    // Display
    displayFontSizeKey: maxDisplay,
    displayFontHeightKey: maxFontHeight,
    displayLetterSpacingKey: maxFontLetterSpacing,
    displayWordSpacingKey: maxFontWordSpacing,

    // Headline
    headlineFontSizeKey: maxHeadline,
    headlineFontHeightKey: maxFontHeight,
    headlineLetterSpacingKey: maxFontLetterSpacing,
    headlineWordSpacingKey: maxFontWordSpacing,

    // Title
    titleFontSizeKey: maxTitle,
    titleFontHeightKey: maxFontHeight,
    titleLetterSpacingKey: maxFontLetterSpacing,
    titleWordSpacingKey: maxFontWordSpacing,

    // Body
    bodyFontSizeKey: maxBody,
    bodyFontHeightKey: maxFontHeight,
    bodyLetterSpacingKey: maxFontLetterSpacing,
    bodyWordSpacingKey: maxFontWordSpacing,

    // Label
    labelFontSizeKey: maxLabel,
    labelFontHeightKey: maxFontHeight,
    labelLetterSpacingKey: maxFontLetterSpacing,
    labelWordSpacingKey: maxFontWordSpacing,

    // Layout settings //

    marginKey: maxMargin,
    paddingKey: maxPadding,
    spacingKey: maxSpacing,
  };

  SharedPreferences.setMockInitialValues(testConfig);
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  EzConfig.init(
    assetPaths: <String>{},
    preferences: prefs,
    defaults: testConfig,
  );

  group(
    'maximum-config',
    () {
      home.testSuite();
      text.testSuite();
      layout.testSuite();
      color.testSuite();
      image.testSuite();
    },
  );
}
