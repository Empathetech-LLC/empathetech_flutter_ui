/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'color_settings_screen.dart' as color;
import 'home_screen.dart' as home;
import 'image_settings_screen.dart' as image;
import 'layout_settings_screen.dart' as layout;
import 'text_settings_screen.dart' as text;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

void main() async {
  final List<Function> testSuites = <Function>[
    home.testSuite,
    text.testSuite,
    layout.testSuite,
    color.testSuite,
    image.testSuite,
  ];

  final List<String> screenNames = <String>[
    home.name,
    text.name,
    layout.name,
    color.name,
    image.name,
  ];

  await runTestSuites(testSuites: testSuites, screenNames: screenNames);
}

Future<void> runTestSuites({
  required List<Function> testSuites,
  required List<String> screenNames,
}) async {
  //// Setup the test environment ////

  // Load contextual data //

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const Locale english = Locale('en');
  const Locale spanish = Locale('es');
  const Locale french = Locale('fr');
  const List<Locale> locales = <Locale>[english, spanish, french];

  final EFUILang enText = await EFUILang.delegate.load(english);
  final EFUILang esText = await EFUILang.delegate.load(spanish);
  final EFUILang frText = await EFUILang.delegate.load(french);
  final List<EFUILang> l10ns = <EFUILang>[enText, esText, frText];

  final LocaleNames enNames =
      await const LocaleNamesLocalizationsDelegate().load(english);
  final LocaleNames esNames =
      await const LocaleNamesLocalizationsDelegate().load(spanish);
  final LocaleNames frNames =
      await const LocaleNamesLocalizationsDelegate().load(french);
  final List<LocaleNames> l10nNames = <LocaleNames>[enNames, esNames, frNames];

  // Set mock values //

  final Map<String, Object> mockValues = <String, Object>{
    ...empathetechConfig,
    isLeftyKey: false,
    isDarkThemeKey: true,
    localeKey: <String>[english.languageCode],
  };

  SharedPreferences.setMockInitialValues(mockValues);
  final SharedPreferences preferences = await SharedPreferences.getInstance();

  EzConfig.init(
    preferences: preferences,
    assetPaths: <String>{},
    defaults: mockValues,
  );

  //// Run the tests ////

  for (int i = 0; i < testSuites.length; i++) {
    final Function testSuite = testSuites[i];
    final String screenName = screenNames[i];

    // Test user configs //

    // Default config
    await testSuite(
      title: '$screenName layout test: Default config',
      locale: english,
      l10n: enText,
      localeNames: enNames,
    );

    // Minimum config
    await testSuite(
      title: '$screenName layout test: Minimum config',
      locale: english,
      l10n: enText,
      localeNames: enNames,
      setup: () async {
        // Text settings //

        // Display
        await preferences.setDouble(displayFontSizeKey, minFontSize);
        await preferences.setDouble(displayFontHeightKey, minFontHeight);
        await preferences.setDouble(
            displayLetterSpacingKey, minFontLetterSpacing);
        await preferences.setDouble(displayWordSpacingKey, minFontWordSpacing);

        // Headline
        await preferences.setDouble(headlineFontSizeKey, minFontSize);
        await preferences.setDouble(headlineFontHeightKey, minFontHeight);
        await preferences.setDouble(
            headlineLetterSpacingKey, minFontLetterSpacing);
        await preferences.setDouble(headlineWordSpacingKey, minFontWordSpacing);

        // Title
        await preferences.setDouble(titleFontSizeKey, minFontSize);
        await preferences.setDouble(titleFontHeightKey, minFontHeight);
        await preferences.setDouble(
            titleLetterSpacingKey, minFontLetterSpacing);
        await preferences.setDouble(titleWordSpacingKey, minFontWordSpacing);

        // Body
        await preferences.setDouble(bodyFontSizeKey, minFontSize);
        await preferences.setDouble(bodyFontHeightKey, minFontHeight);
        await preferences.setDouble(bodyLetterSpacingKey, minFontLetterSpacing);
        await preferences.setDouble(bodyWordSpacingKey, minFontWordSpacing);

        // Label
        await preferences.setDouble(labelFontSizeKey, minFontSize);
        await preferences.setDouble(labelFontHeightKey, minFontHeight);
        await preferences.setDouble(
            labelLetterSpacingKey, minFontLetterSpacing);
        await preferences.setDouble(labelWordSpacingKey, minFontWordSpacing);

        // Layout settings //

        await preferences.setDouble(marginKey, minMargin);
        await preferences.setDouble(paddingKey, minPadding);
        await preferences.setDouble(spacingKey, minSpacing);
      },
    );

    // Maximum config
    await testSuite(
      title: '$screenName layout test: Maximum config',
      locale: english,
      l10n: enText,
      localeNames: enNames,
      setup: () async {
        // Text settings //

        // Display
        await preferences.setDouble(displayFontSizeKey, maxFontSize);
        await preferences.setDouble(displayFontHeightKey, maxFontHeight);
        await preferences.setDouble(
            displayLetterSpacingKey, maxFontLetterSpacing);
        await preferences.setDouble(displayWordSpacingKey, maxFontWordSpacing);

        // Headline
        await preferences.setDouble(headlineFontSizeKey, maxFontSize);
        await preferences.setDouble(headlineFontHeightKey, maxFontHeight);
        await preferences.setDouble(
            headlineLetterSpacingKey, maxFontLetterSpacing);
        await preferences.setDouble(headlineWordSpacingKey, maxFontWordSpacing);

        // Title
        await preferences.setDouble(titleFontSizeKey, maxFontSize);
        await preferences.setDouble(titleFontHeightKey, maxFontHeight);
        await preferences.setDouble(
            titleLetterSpacingKey, maxFontLetterSpacing);
        await preferences.setDouble(titleWordSpacingKey, maxFontWordSpacing);

        // Body
        await preferences.setDouble(bodyFontSizeKey, maxFontSize);
        await preferences.setDouble(bodyFontHeightKey, maxFontHeight);
        await preferences.setDouble(bodyLetterSpacingKey, maxFontLetterSpacing);
        await preferences.setDouble(bodyWordSpacingKey, maxFontWordSpacing);

        // Label
        await preferences.setDouble(labelFontSizeKey, maxFontSize);
        await preferences.setDouble(labelFontHeightKey, maxFontHeight);
        await preferences.setDouble(
            labelLetterSpacingKey, maxFontLetterSpacing);
        await preferences.setDouble(labelWordSpacingKey, maxFontWordSpacing);

        // Layout settings //

        await preferences.setDouble(marginKey, maxMargin);
        await preferences.setDouble(paddingKey, maxPadding);
        await preferences.setDouble(spacingKey, maxSpacing);
      },
    );

    // Test Lefty //

    await testSuite(
      title: '$screenName lefty test',
      locale: english,
      l10n: enText,
      localeNames: enNames,
      setup: () async {
        await preferences.setBool(isLeftyKey, true);
      },
    );

    // Test light theme //

    await testSuite(
      title: '$screenName light mode test',
      locale: english,
      l10n: enText,
      localeNames: enNames,
      setup: () async {
        await preferences.setBool(isDarkThemeKey, false);
      },
    );

    // Test languages //

    for (int i = 1; i < locales.length; i++) {
      await testSuite(
        title: '$screenName language test: ${locales[i].languageCode}',
        locale: locales[i],
        l10n: l10ns[i],
        localeNames: l10nNames[i],
        setup: () async {
          await preferences.setStringList(
            localeKey,
            <String>[locales[i].languageCode],
          );
        },
      );
    }
  }
}
