/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'screens/settings-home.dart' as home;
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
    displayFontSizeKey: minDisplay,
    displayFontHeightKey: minFontHeight,
    displayLetterSpacingKey: minFontLetterSpacing,
    displayWordSpacingKey: minFontWordSpacing,

    // Headline
    headlineFontSizeKey: minHeadline,
    headlineFontHeightKey: minFontHeight,
    headlineLetterSpacingKey: minFontLetterSpacing,
    headlineWordSpacingKey: minFontWordSpacing,

    // Title
    titleFontSizeKey: minTitle,
    titleFontHeightKey: minFontHeight,
    titleLetterSpacingKey: minFontLetterSpacing,
    titleWordSpacingKey: minFontWordSpacing,

    // Body
    bodyFontSizeKey: minBody,
    bodyFontHeightKey: minFontHeight,
    bodyLetterSpacingKey: minFontLetterSpacing,
    bodyWordSpacingKey: minFontWordSpacing,

    // Label
    labelFontSizeKey: minLabel,
    labelFontHeightKey: minFontHeight,
    labelLetterSpacingKey: minFontLetterSpacing,
    labelWordSpacingKey: minFontWordSpacing,

    // Layout settings //

    marginKey: minMargin,
    paddingKey: minPadding,
    spacingKey: minSpacing,
  };

  SharedPreferences.setMockInitialValues(testConfig);
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  EzConfig.init(
    assetPaths: <String>{},
    preferences: prefs,
    defaults: testConfig,
  );

  group(
    'minimum-config',
    () {
      home.testSuite();
      text.testSuite();
      layout.testSuite();
      color.testSuite();
      image.testSuite();
    },
  );
}
