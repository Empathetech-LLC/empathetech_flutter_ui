/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'screens/home.dart' as home;
import 'utils/export.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

const String parentTest = 'default-config';

void main() async {
  // Gather testing data //

  final EFUILang enText = await EFUILang.delegate.load(english);

  final LocaleNames enNames =
      await const LocaleNamesLocalizationsDelegate().load(english);
  final LocaleNames esNames =
      await const LocaleNamesLocalizationsDelegate().load(spanish);
  final LocaleNames frNames =
      await const LocaleNamesLocalizationsDelegate().load(french);

  /// [english, spanish, french]
  final List<LocaleNames> l10nNames = <LocaleNames>[enNames, esNames, frNames];

  /// Setup mock [SharedPreferences]
  void setMock() {
    SharedPreferences.setMockInitialValues(empathetechConfig);
  }

  // Run test suites //

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group(home.name, () {
    setUpAll(setMock);
    home.testSuite(
      title: '${home.name}-$parentTest',
      locale: english,
      l10n: enText,
      localeNames: l10nNames,
    );
  });
}
