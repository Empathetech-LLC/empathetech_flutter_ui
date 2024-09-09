/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

/// For integration testing
/// Test [EzLocaleSetting]
Future<void> testLocaleSetting(
  WidgetTester tester, {
  required EFUILang l10n,
  required LocaleNames l10nNames,
  required bool isLefty,
}) async {
  debugPrint('\nTesting language setting button');
  // ToDo: Test button text updates with selected locale

  // Activate Spanish localizations
  debugPrint('Spanish');
  await touch(tester, find.byType(EzLocaleSetting));
  await touchText(tester, l10nNames.nameOf('es')!);
  await tester.pumpAndSettle();

  // Activate French localizations
  debugPrint('French');
  await touch(tester, find.byType(EzLocaleSetting));
  await touchText(tester, l10nNames.nameOf('fr')!);
  await tester.pumpAndSettle();

  // Activate English localizations
  debugPrint('English');
  await touch(tester, find.byType(EzLocaleSetting));
  await touchText(tester, l10nNames.nameOf('en')!);
  await tester.pumpAndSettle();

  // Activate English localizations
  debugPrint('Close');
  await touch(tester, find.byType(EzLocaleSetting));
  await touchText(tester, l10n.gClose);
  await tester.pumpAndSettle();
}
