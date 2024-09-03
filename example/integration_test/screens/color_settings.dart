/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/export.dart';

import 'package:example/main.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

const String name = 'color-settings-screen';

void testSuite({
  required String title,
  Locale locale = english,
  bool isLefty = false,
}) =>
    testWidgets(title, (WidgetTester tester) async {
      // Load localization(s) //

      debugPrint('Loading localizations');
      final EFUILang l10n = await EFUILang.delegate.load(locale);

      // Load the app //

      debugPrint('Loading OpenUI');
      await tester.pumpWidget(const OpenUI());
      await tester.pumpAndSettle();

      // Test navigation //

      debugPrint('\nTesting navigation');

      final Finder csButton = find.widgetWithText(
        ElevatedButton,
        l10n.csPageTitle,
      );

      expect(csButton, findsOneWidget);
      await touch(tester: tester, finder: csButton);

      // Verify text loaded //

      debugPrint('\nValidating text');
      await validateText(
        tester: tester,
        text: l10n.gEditingTheme(l10n.gDark.toLowerCase()),
      );

      //// Test functionality ////

      // Reset for next test suite  //

      await goBack(tester: tester, l10n: l10n);
      debugPrint('\nColor settings test suite complete\n');
    });
