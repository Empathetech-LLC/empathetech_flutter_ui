/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/image_links.dart';

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
    testWidgets('color-settings-screen', (WidgetTester tester) async {
      // Load localization(s) //

      ezLog('Loading localizations');
      final EFUILang l10n = await EFUILang.delegate.load(locale);

      // Load the app //

      ezLog('Loading OpenUI');
      await tester.pumpWidget(const OpenUI());
      await tester.pumpAndSettle();

      // Test navigation //

      ezLog('\nTesting navigation');

      await touch(
        tester,
        find.widgetWithText(ElevatedButton, l10n.csPageTitle),
      );

      //* Test functionality: Quick settings *//

      ezLog('\nTesting quick settings');

      ezLog('\nValidating text');
      await validateText(
        tester,
        l10n.gEditingTheme(l10n.gDark.toLowerCase()),
      );

      ezLog('\nMonochrome');
      await touchText(tester, l10n.csMonoChrome);

      ezLog('\nColorScheme from image');
      await testImageSetting(
        tester,
        finder: find.byType(EzImageSetting),
        type: '${l10n.gDark.toLowerCase()} ${l10n.csColorScheme}',
        updateCS: false,
        l10n: l10n,
        networkImageURLs: imageURLs,
        isLefty: isLefty,
      );

      await testResetButton(
        tester,
        type: RBType.color,
        l10n: l10n,
        isLefty: isLefty,
      );

      //* Test functionality: Advanced settings *//

      ezLog('\nTesting advanced settings');

      ezLog('Navigation');
      await touchText(tester, l10n.gAdvanced);

      ezLog('Validating text');
      await validateText(
        tester,
        l10n.gEditingTheme(l10n.gDark.toLowerCase()),
      );

      await testCS(
        tester,
        text: l10n.csPrimary,
        l10n: l10n,
        defaultColor: true,
        textColor: false,
        isLefty: isLefty,
      );
      await testCS(
        tester,
        text: l10n.csOnSurface,
        l10n: l10n,
        defaultColor: true,
        textColor: true,
        isLefty: isLefty,
      );

      ezLog('Testing add color modal');
      await touchText(tester, l10n.csAddColor);

      ezLog('How this works');
      await validateText(tester, l10n.gHowThisWorks);

      ezLog('Add on primary');
      await touchText(tester, l10n.csOnPrimary);
      await dismissTap(tester);
      await testCS(
        tester,
        text: l10n.csOnPrimary,
        l10n: l10n,
        defaultColor: false,
        textColor: true,
        isLefty: isLefty,
      );

      ezLog('Add surface tint');
      await touchText(tester, l10n.csAddColor);
      await tester.ensureVisible(find.text(l10n.csSurfaceTint).last);
      await tester.fling(
        find.descendant(
          of: find.byType(BottomSheet),
          matching: find.byType(EzScrollView).last,
        ),
        const Offset(0, -500),
        2000,
      );
      await tester.pumpAndSettle();
      await touchText(tester, l10n.csSurfaceTint);
      await dismissTap(tester);

      await testCS(
        tester,
        text: l10n.csSurfaceTint,
        l10n: l10n,
        defaultColor: false,
        textColor: false,
        isLefty: isLefty,
      );

      await testResetButton(
        tester,
        type: RBType.color,
        l10n: l10n,
        isLefty: isLefty,
      );

      // Reset for next test suite  //

      await goBack(tester, l10n.gBack);
      ezLog('\nColor settings test suite complete\n\n');
    });

Future<void> testCS(
  WidgetTester tester, {
  required String text,
  required EFUILang l10n,
  required bool defaultColor,
  required bool textColor,
  required bool isLefty,
}) async {
  ezLog('\nTesting $text update\n');
  await touchText(tester, text);

  if (textColor) {
    ezLog('Text options');
    await validateText(tester, l10n.csRecommended);

    ezLog('Close');
    await touchText(tester, l10n.gClose);

    ezLog('Yes');
    await touchText(tester, text);
    await touchText(tester, l10n.gYes);

    ezLog('Custom\n');
    await touchText(tester, text);
    await touchText(tester, l10n.csUseCustom);
  }

  ezLog('Layout');
  final bool isCupertino = !kIsWeb && (Platform.isIOS || Platform.isMacOS);

  if (isCupertino) {
    final List<CupertinoDialogAction> actions =
        (tester.widget(find.byType(EzAlertDialog).last) as EzAlertDialog)
            .cupertinoActions!;

    expect(actions.length, 2);
    if (isLefty) {
      expect(actions[0].child.toString(), Text(l10n.gApply).toString());
      expect(actions[1].child.toString(), Text(l10n.gCancel).toString());
    } else {
      expect(actions[0].child.toString(), Text(l10n.gCancel).toString());
      expect(actions[1].child.toString(), Text(l10n.gApply).toString());
    }
  } else {
    final List<TextButton> actions =
        (tester.widget(find.byType(EzAlertDialog).last) as EzAlertDialog)
            .materialActions! as List<TextButton>;

    expect(actions.length, 2);
    if (isLefty) {
      expect(actions[0].child.toString(), Text(l10n.gApply).toString());
      expect(actions[1].child.toString(), Text(l10n.gCancel).toString());
    } else {
      expect(actions[0].child.toString(), Text(l10n.gCancel).toString());
      expect(actions[1].child.toString(), Text(l10n.gApply).toString());
    }
  }

  ezLog('Cancel');
  await touchText(tester, l10n.gCancel);

  ezLog('Apply');
  await touchText(tester, text);
  if (textColor) await touchText(tester, l10n.csUseCustom);
  await chaChaNow(tester, find.byType(Slider));
  await touchText(tester, l10n.gApply);

  ezLog('\nTesting $text reset\n');
  await holdText(tester, text);

  ezLog('Text/layout');

  if (!defaultColor) {
    await validateText(tester, l10n.gOptions);
    await touchText(tester, l10n.gReset);
  }

  await validateText(tester, l10n.gReset);

  if (isCupertino) {
    final List<CupertinoDialogAction> actions =
        (tester.widget(find.byType(EzAlertDialog).last) as EzAlertDialog)
            .cupertinoActions!;

    expect(actions.length, 2);
    if (isLefty) {
      expect(actions[0].child.toString(), Text(l10n.gYes).toString());
      expect(actions[1].child.toString(), Text(l10n.gNo).toString());
    } else {
      expect(actions[0].child.toString(), Text(l10n.gNo).toString());
      expect(actions[1].child.toString(), Text(l10n.gYes).toString());
    }
  } else {
    final List<TextButton> actions =
        (tester.widget(find.byType(EzAlertDialog).last) as EzAlertDialog)
            .materialActions! as List<TextButton>;

    expect(actions.length, 2);
    if (isLefty) {
      expect(actions[0].child.toString(), Text(l10n.gYes).toString());
      expect(actions[1].child.toString(), Text(l10n.gNo).toString());
    } else {
      expect(actions[0].child.toString(), Text(l10n.gNo).toString());
      expect(actions[1].child.toString(), Text(l10n.gYes).toString());
    }
  }

  ezLog('No');
  await touchText(tester, l10n.gNo);

  ezLog('Yes');
  await holdText(tester, text);
  if (!defaultColor) await touchText(tester, l10n.gReset);
  await touchText(tester, l10n.gYes);

  if (!defaultColor) {
    ezLog('Remove');

    await holdText(tester, text);
    await touchText(tester, l10n.gClose);
    await holdText(tester, text);
    await touchText(tester, l10n.csRemove);
    expect(find.text(text), findsNothing);
  }
}
