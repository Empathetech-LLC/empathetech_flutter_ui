/* empathetech_flutter_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

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
  ezLog('\nTesting language setting button');

  // Activate Spanish localizations
  ezLog('Spanish');
  await touch(tester, find.byType(EzLocaleSetting));
  await touchText(tester, l10nNames.nameOf('es')!);
  await tester.pumpAndSettle();

  // Activate French localizations
  ezLog('French');
  await touch(tester, find.byType(EzLocaleSetting));
  await touchText(tester, l10nNames.nameOf('fr')!);
  await tester.pumpAndSettle();

  // Activate English localizations
  ezLog('English');
  await touch(tester, find.byType(EzLocaleSetting));
  await touchText(tester, l10nNames.nameOf('en')!);
  await tester.pumpAndSettle();

  // Activate English localizations
  ezLog('Close');
  await touch(tester, find.byType(EzLocaleSetting));
  await touchText(tester, l10n.gClose);
  await tester.pumpAndSettle();
}
