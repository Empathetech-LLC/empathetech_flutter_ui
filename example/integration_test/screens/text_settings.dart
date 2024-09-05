/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/export.dart';

import 'package:example/main.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
      final bool isCupertino = !kIsWeb && (Platform.isIOS || Platform.isMacOS);

      // Batch font updates //

      debugPrint('Batch font updater');
      await touch(tester, find.byType(DropdownMenu<String>));
      await touchAtText(tester, roboto);
      await dismissTap(tester);

      // Batch size updates //

      debugPrint('Batch font size: max');
      for (int i = 0; i < 15; i++) {
        await touchAt(
          tester,
          find.byIcon(isCupertino ? CupertinoIcons.add : Icons.add),
        );
      }

      debugPrint('Batch font size: min');
      for (int i = 0; i < 15; i++) {
        await touchAt(
          tester,
          find.byIcon(isCupertino ? CupertinoIcons.minus : Icons.remove),
        );
      }

      // Reset //

      await testResetButton(
        tester,
        type: RBType.text,
        l10n: l10n,
        isLefty: isLefty,
      );

      //// Test functionality: Advanced settings ////

      debugPrint('\nTesting advanced settings');

      debugPrint('\nNavigation');
      await touchAtText(tester, l10n.gAdvanced);

      debugPrint('\nDisplay');
      await touch(tester, find.byType(DropdownMenu<String>).first);
      await touchAtText(tester, l10n.tsDisplay.toLowerCase());
      await touch(
        tester,
        find.widgetWithText(EzLink, l10n.tsDisplay.toLowerCase()),
      );
      await testAdvancedOptions(tester);

      debugPrint('\nHeadline');
      await touch(tester, find.byType(DropdownMenu<String>).first);
      await touchAtText(tester, l10n.tsHeadline.toLowerCase());
      await touch(
        tester,
        find.widgetWithText(EzLink, l10n.tsHeadline.toLowerCase()),
      );
      await testAdvancedOptions(tester);

      debugPrint('\nTitle');
      await touch(tester, find.byType(DropdownMenu<String>).first);
      await touchAtText(tester, l10n.tsTitle.toLowerCase());
      await touch(
        tester,
        find.widgetWithText(EzLink, l10n.tsTitle.toLowerCase()),
      );
      await testAdvancedOptions(tester);

      debugPrint('\nBody');
      await touch(tester, find.byType(DropdownMenu<String>).first);
      await touchAtText(tester, l10n.tsBody.toLowerCase());
      await touch(
        tester,
        find.widgetWithText(EzLink, l10n.tsBody.toLowerCase()),
      );
      await testAdvancedOptions(tester);

      debugPrint('\nLabel');
      await touch(tester, find.byType(DropdownMenu<String>).first);
      await touchAtText(tester, l10n.tsLabel.toLowerCase());
      await touch(
        tester,
        find.widgetWithText(EzLink, l10n.tsLabel.toLowerCase()),
      );
      await testAdvancedOptions(tester);

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

Future<void> testAdvancedOptions(WidgetTester tester) async {
  debugPrint('Font family');
  await touch(tester, find.byType(DropdownMenu<String>).last);
  await touchAtText(tester, roboto);
  await dismissTap(tester);

  debugPrint('Font size');
  debugPrint('Bold');
  debugPrint('Italics');
  debugPrint('Underline');
  debugPrint('Letter spacing');
  debugPrint('Word spacing');
  debugPrint('Line height');
}
