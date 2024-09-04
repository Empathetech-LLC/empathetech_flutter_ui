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
    testWidgets('color-settings-screen', (WidgetTester tester) async {
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
        find.widgetWithText(ElevatedButton, l10n.csPageTitle),
      );

      //// Test functionality: Quick settings ////

      debugPrint('\nTesting quick settings');

      debugPrint('Validating text');
      await validateText(
        tester,
        l10n.gEditingTheme(l10n.gDark.toLowerCase()),
      );

      await testImageSetting(
        tester,
        finder: find.byType(EzImageSetting),
        type: '${l10n.gDark.toLowerCase()} ${l10n.csColorScheme}',
        updateCS: false,
        l10n: l10n,
        isLefty: isLefty,
      );

      await testResetButton(
        tester,
        type: RBType.color,
        l10n: l10n,
        isLefty: isLefty,
      );

      //// Test functionality: Advanced settings ////

      debugPrint('\nTesting advanced settings');

      debugPrint('Navigation');
      await touchAtText(tester, l10n.gAdvanced);

      debugPrint('Validating text');
      await validateText(
        tester,
        l10n.gEditingTheme(l10n.gDark.toLowerCase()),
      );

      await testResetButton(
        tester,
        type: RBType.color,
        l10n: l10n,
        isLefty: isLefty,
      );

      // Reset for next test suite  //

      await goBack(tester, l10n);
      debugPrint('\nColor settings test suite complete\n');
    });
