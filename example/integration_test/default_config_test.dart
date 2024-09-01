/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'screens/home.dart' as home;
import 'screens/text_settings.dart' as text;
import 'screens/layout_settings.dart' as layout;
import 'screens/color_settings.dart' as color;
import 'screens/image_settings.dart' as image;
import 'utils/export.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

const String parentTest = 'default-config';

void main() {
  // Setup the test environment //

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  late final EFUILang enText;
  late final List<LocaleNames> l10nNames;

  final Completer<bool> completer = Completer<bool>();

  setUpAll(() async {
    enText = await EFUILang.delegate.load(english);

    final LocaleNames enNames =
        await const LocaleNamesLocalizationsDelegate().load(english);
    final LocaleNames esNames =
        await const LocaleNamesLocalizationsDelegate().load(spanish);
    final LocaleNames frNames =
        await const LocaleNamesLocalizationsDelegate().load(french);

    l10nNames = <LocaleNames>[enNames, esNames, frNames];

    // Set mock values //

    SharedPreferences.setMockInitialValues(empathetechConfig);
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    EzConfig.init(
      preferences: preferences,
      assetPaths: <String>{},
      defaults: empathetechConfig,
    );

    completer.complete(true);

    return completer.future;
  });

  // Run test suites //

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

  // Layout settings

  // Color settings

  // Image settings
}
