/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/export.dart';

import 'package:example/main.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

void testSuite({
  Locale locale = english,
  bool isLefty = false,
}) =>
    testWidgets('layout-settings-screen', (WidgetTester tester) async {
      // Load localization(s) //

      debugPrint('Loading localizations');
      final EFUILang l10n = await EFUILang.delegate.load(locale);

      // Load the app //

      debugPrint('Loading OpenUI');
      await tester.pumpWidget(const OpenUI());
      await tester.pumpAndSettle();

      // Test navigation //

      debugPrint('\nTesting navigation');

      await touch(
        tester,
        find.widgetWithText(ElevatedButton, l10n.lsPageTitle),
      );

      // Verify text loaded //

      debugPrint('\nValidating text');
      await validateText(tester, l10n.gHowThisWorks);

      //// Test functionality ////

      // Margin //
      debugPrint('\nTesting margin');
      await touch(tester, find.byType(EzLayoutSetting).at(0));
      await dismissTap(tester);

      // Padding //
      debugPrint('\nTesting padding');
      await touch(tester, find.byType(EzLayoutSetting).at(1));
      await dismissTap(tester);

      // Spacing //
      debugPrint('\nTesting spacing');
      await touch(tester, find.byType(EzLayoutSetting).at(2));
      await dismissTap(tester);

      // Reset for next test suite  //

      await goBack(tester, l10n);
      debugPrint('\nLayout settings test suite complete\n');
    });
