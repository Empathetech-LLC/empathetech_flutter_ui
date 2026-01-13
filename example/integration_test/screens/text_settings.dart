/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
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

      ezLog('Loading localizations');

      // Load the app //

      ezLog('Loading OpenUI');
      await tester.pumpWidget(const OpenUI());
      await tester.pumpAndSettle();

      // Test navigation //

      ezLog('\nTesting navigation');

      await ezTouch(
        tester,
        find.widgetWithText(EzElevatedIconButton, EzConfig.l10n.tsPageTitle),
      );

      // Verify text loaded //

      ezLog('\nValidating text');
      await ezFindText(
        tester,
        EzConfig.l10n.tsDisplayP1 +
            EzConfig.l10n.tsDisplayLink +
            EzConfig.l10n.tsDisplayP2,
      );
      await ezFindText(
        tester,
        EzConfig.l10n.tsHeadlineP1 +
            EzConfig.l10n.tsHeadlineLink +
            EzConfig.l10n.tsHeadlineP2,
      );
      await ezFindText(
        tester,
        EzConfig.l10n.tsTitleP1 + EzConfig.l10n.tsTitleLink,
      );
      await ezFindText(
        tester,
        EzConfig.l10n.tsBodyP1 +
            EzConfig.l10n.tsBodyLink +
            EzConfig.l10n.tsBodyP2,
      );
      await ezFindText(
        tester,
        EzConfig.l10n.tsLabelP1 +
            EzConfig.l10n.tsLabelLink +
            EzConfig.l10n.tsLabelP2,
      );

      //* Test functionality: Quick settings *//

      ezLog('\nTesting quick settings');
      final bool isCupertino = !kIsWeb && (Platform.isIOS || Platform.isMacOS);

      // Batch font updates //

      ezLog('Batch font updater');
      await ezTouch(tester, find.byType(DropdownMenu<String>));
      await ezTouchText(tester, roboto);

      // Batch size updates //

      ezLog('Batch font size: max');
      for (int i = 0; i < 15; i++) {
        await ezTouch(
          tester,
          find.byIcon(isCupertino ? CupertinoIcons.add : Icons.add),
        );
      }

      ezLog('Batch font size: min');
      for (int i = 0; i < 15; i++) {
        await ezTouch(
          tester,
          find.byIcon(isCupertino ? CupertinoIcons.minus : Icons.remove),
        );
      }

      // Reset //

      await testResetButton(tester, type: RBType.text);

      //* Test functionality: Advanced settings *//

      ezLog('\nTesting advanced settings');

      ezLog('\nNavigation');
      await ezTouchText(tester, EzConfig.l10n.gAdvanced);

      ezLog('\nDisplay');
      await ezTouch(tester, find.byType(DropdownMenu<String>).first);
      await ezTouch(
          tester, find.text(EzConfig.l10n.tsDisplay.toLowerCase()).first);
      await ezTouch(
        tester,
        find.widgetWithText(EzLink, EzConfig.l10n.tsDisplayLink),
      );
      await testAdvancedOptions(
        tester,
        fontSize: 63.0,
        isCupertino: isCupertino,
      );

      ezLog('\nHeadline');
      await ezTouch(tester, find.byType(DropdownMenu<String>).first);
      await ezTouch(
          tester, find.text(EzConfig.l10n.tsHeadline.toLowerCase()).first);
      await ezTouch(
        tester,
        find.widgetWithText(EzLink, EzConfig.l10n.tsHeadlineLink),
      );
      await testAdvancedOptions(
        tester,
        fontSize: 48.0,
        isCupertino: isCupertino,
      );

      ezLog('\nTitle');
      await ezTouch(tester, find.byType(DropdownMenu<String>).first);
      await ezTouch(
          tester, find.text(EzConfig.l10n.tsTitle.toLowerCase()).first);
      await ezTouch(
        tester,
        find.widgetWithText(EzLink, EzConfig.l10n.tsTitleLink),
      );
      await testAdvancedOptions(
        tester,
        fontSize: 33.0,
        isCupertino: isCupertino,
      );

      ezLog('\nBody');
      await ezTouch(tester, find.byType(DropdownMenu<String>).first);
      await ezTouch(
          tester, find.text(EzConfig.l10n.tsBody.toLowerCase()).first);
      await ezTouch(
        tester,
        find.widgetWithText(EzLink, EzConfig.l10n.tsBodyLink),
      );
      await testAdvancedOptions(
        tester,
        fontSize: 24.0,
        isCupertino: isCupertino,
      );

      ezLog('\nLabel');
      await ezTouch(tester, find.byType(DropdownMenu<String>).first);
      await ezTouch(
          tester, find.text(EzConfig.l10n.tsLabel.toLowerCase()).first);
      await ezTouch(
        tester,
        find.widgetWithText(EzLink, EzConfig.l10n.tsLabelLink),
      );
      await testAdvancedOptions(
        tester,
        fontSize: 21.0,
        isCupertino: isCupertino,
      );

      // Reset //

      await testResetButton(tester, type: RBType.text);

      // Reset for next test suite  //

      await ezTapBack(tester, EzConfig.l10n.gBack);
      ezLog('\nText settings test suite complete\n\n');
    });

Future<void> testAdvancedOptions(
  WidgetTester tester, {
  required bool isCupertino,
  required double fontSize,
}) async {
  ezLog('Font family');
  await ezTouch(tester, find.byType(DropdownMenu<String>).last);
  await ezTouchText(tester, roboto);

  ezLog('Font size');
  await ezTouch(
    tester,
    find.byIcon(isCupertino ? CupertinoIcons.minus : Icons.remove),
  );
  await tester.enterText(find.byType(TextFormField).at(0), '$fontSize');
  await ezTouch(
    tester,
    find.byIcon(isCupertino ? CupertinoIcons.add : Icons.add),
  );

  ezLog('Bold');
  await touchBold(tester);

  ezLog('Italics');
  await touchItalics(tester);

  ezLog('Underline');
  await touchUnderline(tester);

  ezLog('Letter spacing');
  await tester.enterText(find.byType(TextFormField).at(1), '1.0');

  ezLog('Word spacing');
  await tester.enterText(find.byType(TextFormField).at(2), '1.0');

  ezLog('Line height');
  await tester.enterText(find.byType(TextFormField).at(3), '1.0');
}

Future<void> touchBold(WidgetTester tester) async {
  try {
    await ezTouch(tester, find.byIcon(Icons.format_bold));
  } catch (_) {
    await ezTouch(tester, find.byIcon(Icons.format_bold_outlined));
    await ezTouch(tester, find.byIcon(Icons.format_bold));
    return;
  }
  await ezTouch(tester, find.byIcon(Icons.format_bold_outlined));
}

Future<void> touchItalics(WidgetTester tester) async {
  try {
    await ezTouch(tester, find.byIcon(Icons.format_italic));
  } catch (_) {
    await ezTouch(tester, find.byIcon(Icons.format_italic_outlined));
    await ezTouch(tester, find.byIcon(Icons.format_italic));
    return;
  }
  await ezTouch(tester, find.byIcon(Icons.format_italic_outlined));
}

Future<void> touchUnderline(WidgetTester tester) async {
  try {
    await ezTouch(tester, find.byIcon(Icons.format_underline));
  } catch (_) {
    await ezTouch(tester, find.byIcon(Icons.format_underline_outlined));
    await ezTouch(tester, find.byIcon(Icons.format_underline));
    return;
  }
  await ezTouch(tester, find.byIcon(Icons.format_underline_outlined));
}
