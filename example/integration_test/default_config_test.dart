/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'screens/home.dart' as home;
import 'screens/text_settings.dart' as text;
import 'screens/layout_settings.dart' as layout;
import 'screens/color_settings.dart' as color;
import 'screens/image_settings.dart' as image;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

void main() async {
  // Setup the test environment //

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const Locale english = Locale('en');
  const Locale spanish = Locale('es');
  const Locale french = Locale('fr');

  final EFUILang enText = await EFUILang.delegate.load(english);

  final LocaleNames enNames =
      await const LocaleNamesLocalizationsDelegate().load(english);
  final LocaleNames esNames =
      await const LocaleNamesLocalizationsDelegate().load(spanish);
  final LocaleNames frNames =
      await const LocaleNamesLocalizationsDelegate().load(french);
  final List<LocaleNames> l10nNames = <LocaleNames>[enNames, esNames, frNames];

  // Set mock values //

  SharedPreferences.setMockInitialValues(empathetechConfig);
  final SharedPreferences preferences = await SharedPreferences.getInstance();

  EzConfig.init(
    preferences: preferences,
    assetPaths: <String>{},
    defaults: empathetechConfig,
  );

  // Run the test suites //

  const String parentTest = 'default-config';

  // Settings home
  group(
    home.name,
    () => home.testSuite(
      title: '${home.name}-$parentTest',
      locale: english,
      l10n: enText,
      localeNames: l10nNames,
    ),
  );

  // Text settings
  group(
    text.name,
    () => text.testSuite(
      title: '${text.name}-$parentTest',
      locale: english,
      l10n: enText,
      localeNames: l10nNames,
    ),
  );

  // Layout settings
  group(
    layout.name,
    () => layout.testSuite(
      title: '${layout.name}-$parentTest',
      locale: english,
      l10n: enText,
      localeNames: l10nNames,
    ),
  );

  // Color settings
  group(
    color.name,
    () => color.testSuite(
      title: '${color.name}-$parentTest',
      locale: english,
      l10n: enText,
      localeNames: l10nNames,
    ),
  );

  // Image settings
  group(
    image.name,
    () => image.testSuite(
      title: '${image.name}-$parentTest',
      locale: english,
      l10n: enText,
      localeNames: l10nNames,
    ),
  );
}
