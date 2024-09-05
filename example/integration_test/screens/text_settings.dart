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
    testWidgets('text-settings-screen', (WidgetTester tester) async {
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
        find.widgetWithText(ElevatedButton, l10n.tsPageTitle),
      );

      // Verify text loaded //

      debugPrint('\nValidating text');
      await validateText(
        tester,
        l10n.tsDisplayP1 + l10n.tsDisplayLink + l10n.tsDisplayP2,
      );
      await validateText(
        tester,
        l10n.tsHeadlineP1 + l10n.tsHeadlineLink + l10n.tsHeadlineP2,
      );
      await validateText(
        tester,
        l10n.tsTitleP1 + l10n.tsTitleLink,
      );
      await validateText(
        tester,
        l10n.tsBodyP1 + l10n.tsBodyLink + l10n.tsBodyP2,
      );
      await validateText(
        tester,
        l10n.tsLabelP1 + l10n.tsLabelLink + l10n.tsLabelP2,
      );

      //// Test functionality: Quick settings ////

      debugPrint('\nTesting quick settings');

      // Batch font updates //

      debugPrint('Batch font updater');
      await touch(tester, find.byType(DropdownMenu<String>));
      // ToDo: Verify expected font family names
      await dismissTap(tester);

      // Batch size updates //

      debugPrint('Batch font size: max');

      debugPrint('Batch font size: min');

      // Reset //

      await testResetButton(
        tester,
        type: RBType.text,
        l10n: l10n,
        isLefty: isLefty,
      );

      //// Test functionality: Advanced settings ////

      debugPrint('\nTesting advanced settings');

      debugPrint('Navigation');
      await touchAtText(tester, l10n.gAdvanced);

      debugPrint('Font families');
      debugPrint('Dropdown && max');
      debugPrint('Link && min');

      debugPrint('Text sizes');
      debugPrint('Dropdown && max');
      debugPrint('Link && min');

      debugPrint('Bolding');
      debugPrint('Dropdown && max');
      debugPrint('Link && min');

      debugPrint('Italicizing');
      debugPrint('Dropdown && max');
      debugPrint('Link && min');

      debugPrint('Underlining');
      debugPrint('Dropdown && max');
      debugPrint('Link && min');

      debugPrint('Spacing letters');
      debugPrint('Dropdown && max');
      debugPrint('Link && min');

      debugPrint('Spacing words');
      debugPrint('Dropdown && max');
      debugPrint('Link && min');

      debugPrint('Spacing lines');
      debugPrint('Dropdown && max');
      debugPrint('Link && min');

      // Reset //

      await testResetButton(
        tester,
        type: RBType.text,
        l10n: l10n,
        isLefty: isLefty,
      );

      // Reset for next test suite  //

      await goBack(tester, l10n);
      debugPrint('\nText settings test suite complete\n');
    });
