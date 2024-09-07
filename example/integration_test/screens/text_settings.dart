/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

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
      await touchText(tester, roboto);

      // Batch size updates //

      debugPrint('Batch font size: max');
      for (int i = 0; i < 15; i++) {
        await touch(
          tester,
          find.byIcon(isCupertino ? CupertinoIcons.add : Icons.add),
        );
      }

      debugPrint('Batch font size: min');
      for (int i = 0; i < 15; i++) {
        await touch(
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
      await touchText(tester, l10n.gAdvanced);

      debugPrint('\nDisplay');
      await touch(tester, find.byType(DropdownMenu<String>).first);
      await touch(tester, find.text(l10n.tsDisplay.toLowerCase()).first);
      await touch(
        tester,
        find.widgetWithText(EzLink, l10n.tsDisplayLink),
      );
      await testAdvancedOptions(
        tester,
        fontSize: 63.0,
        isCupertino: isCupertino,
      );

      debugPrint('\nHeadline');
      await touch(tester, find.byType(DropdownMenu<String>).first);
      await touch(tester, find.text(l10n.tsHeadline.toLowerCase()).first);
      await touch(
        tester,
        find.widgetWithText(EzLink, l10n.tsHeadlineLink),
      );
      await testAdvancedOptions(
        tester,
        fontSize: 48.0,
        isCupertino: isCupertino,
      );

      debugPrint('\nTitle');
      await touch(tester, find.byType(DropdownMenu<String>).first);
      await touch(tester, find.text(l10n.tsTitle.toLowerCase()).first);
      await touch(
        tester,
        find.widgetWithText(EzLink, l10n.tsTitleLink),
      );
      await testAdvancedOptions(
        tester,
        fontSize: 33.0,
        isCupertino: isCupertino,
      );

      debugPrint('\nBody');
      await touch(tester, find.byType(DropdownMenu<String>).first);
      await touch(tester, find.text(l10n.tsBody.toLowerCase()).first);
      await touch(
        tester,
        find.widgetWithText(EzLink, l10n.tsBodyLink),
      );
      await testAdvancedOptions(
        tester,
        fontSize: 24.0,
        isCupertino: isCupertino,
      );

      debugPrint('\nLabel');
      await touch(tester, find.byType(DropdownMenu<String>).first);
      await touch(tester, find.text(l10n.tsLabel.toLowerCase()).first);
      await touch(
        tester,
        find.widgetWithText(EzLink, l10n.tsLabelLink),
      );
      await testAdvancedOptions(
        tester,
        fontSize: 21.0,
        isCupertino: isCupertino,
      );

      // Reset //

      await testResetButton(
        tester,
        type: RBType.text,
        l10n: l10n,
        isLefty: isLefty,
      );

      // Reset for next test suite  //

      await goBack(tester, l10n);
      debugPrint('\nText settings test suite complete\n\n');
    });

Future<void> testAdvancedOptions(
  WidgetTester tester, {
  required bool isCupertino,
  required double fontSize,
}) async {
  debugPrint('Font family');
  await touch(tester, find.byType(DropdownMenu<String>).last);
  await touchText(tester, roboto);

  debugPrint('Font size');
  await touch(
    tester,
    find.byIcon(isCupertino ? CupertinoIcons.minus : Icons.remove),
  );
  await tester.enterText(find.byType(TextFormField).at(0), '$fontSize');
  await touch(
    tester,
    find.byIcon(isCupertino ? CupertinoIcons.add : Icons.add),
  );

  debugPrint('Bold');
  await touchBold(tester);

  debugPrint('Italics');
  await touchItalics(tester);

  debugPrint('Underline');
  await touchUnderline(tester);

  debugPrint('Letter spacing');
  await tester.enterText(find.byType(TextFormField).at(1), '1.0');

  debugPrint('Word spacing');
  await tester.enterText(find.byType(TextFormField).at(2), '1.0');

  debugPrint('Line height');
  await tester.enterText(find.byType(TextFormField).at(3), '1.0');
}

Future<void> touchBold(WidgetTester tester) async {
  try {
    await touch(tester, find.byIcon(Icons.format_bold));
  } catch (_) {
    await touch(tester, find.byIcon(Icons.format_bold_outlined));
    await touch(tester, find.byIcon(Icons.format_bold));
    return;
  }
  await touch(tester, find.byIcon(Icons.format_bold_outlined));
}

Future<void> touchItalics(WidgetTester tester) async {
  try {
    await touch(tester, find.byIcon(Icons.format_italic));
  } catch (_) {
    await touch(tester, find.byIcon(Icons.format_italic_outlined));
    await touch(tester, find.byIcon(Icons.format_italic));
    return;
  }
  await touch(tester, find.byIcon(Icons.format_italic_outlined));
}

Future<void> touchUnderline(WidgetTester tester) async {
  try {
    await touch(tester, find.byIcon(Icons.format_underline));
  } catch (_) {
    await touch(tester, find.byIcon(Icons.format_underline_outlined));
    await touch(tester, find.byIcon(Icons.format_underline));
    return;
  }
  await touch(tester, find.byIcon(Icons.format_underline_outlined));
}
