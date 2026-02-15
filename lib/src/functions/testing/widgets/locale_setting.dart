/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

/// For integration testing
/// Test [EzLocaleSetting]
Future<void> testLocaleSetting(
  WidgetTester tester, {
  required LocaleNames l10nNames,
}) async {
  ezLog('\nTesting language setting button');

  // Activate Spanish localizations
  ezLog('Spanish');
  await ezTouch(tester, find.byType(EzLocaleSetting));
  await ezTouchText(tester, l10nNames.nameOf('es')!);
  await tester.pumpAndSettle();

  // Activate French localizations
  ezLog('French');
  await ezTouch(tester, find.byType(EzLocaleSetting));
  await ezTouchText(tester, l10nNames.nameOf('fr')!);
  await tester.pumpAndSettle();

  // Activate English localizations
  ezLog('English');
  await ezTouch(tester, find.byType(EzLocaleSetting));
  await ezTouchText(tester, l10nNames.nameOf('en')!);
  await tester.pumpAndSettle();

  // Activate English localizations
  ezLog('Close');
  await ezTouch(tester, find.byType(EzLocaleSetting));
  await ezTouchText(tester, EzConfig.l10n.gClose);
  await tester.pumpAndSettle();
}
