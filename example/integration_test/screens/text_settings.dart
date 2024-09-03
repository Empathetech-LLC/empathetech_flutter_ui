/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/export.dart';

import 'package:example/main.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

const String name = 'text-settings-screen';

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

      final Finder tsButton = find.widgetWithText(
        ElevatedButton,
        l10n.tsPageTitle,
      );

      expect(tsButton, findsOneWidget);
      await touch(tester: tester, finder: tsButton);
      await goBack(tester: tester, l10n: l10n); // And test going back
      await touch(tester: tester, finder: tsButton);

      // Verify text loaded //

      debugPrint('\nValidating text');
      debugPrint(
          "This will probably be different because it's rich text or whatever");

      //// Test functionality ////

      debugPrint('\n\n');
    });
