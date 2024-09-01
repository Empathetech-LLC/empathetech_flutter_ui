/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

const String name = 'text-settings-screen';

void testSuite({
  required String title,
  required Locale locale,
  required EFUILang l10n,
  required List<LocaleNames> localeNames,
  bool isLefty = false,
}) =>
    testWidgets(title, (WidgetTester tester) async {
      // Load the app //

      final Widget testApp = testOpenUI(title: title, locale: locale);

      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      // Navigate to text settings //

      final Finder textSettingsButton = find.widgetWithText(
        ElevatedButton,
        l10n.tsPageTitle,
      );

      expect(textSettingsButton, findsOneWidget);
      await touch(tester: tester, finder: textSettingsButton);

      await goBack(tester: tester, l10n: l10n); // Remove me!

      // Test functionality //
    });