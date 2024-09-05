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

// ToDo: Verify expected color values

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

      debugPrint('\nValidating text');
      await validateText(
        tester,
        l10n.gEditingTheme(l10n.gDark.toLowerCase()),
      );

      debugPrint('\nMonochrome');
      await touchAtText(tester, l10n.csMonoChrome);

      debugPrint('\nColorScheme from image');
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

      debugPrint('Testing add color modal');
      await touchAtText(tester, l10n.csAddColor);

      debugPrint('How this works');
      await validateText(tester, l10n.gHowThisWorks);
      // ToDo: Verify link

      debugPrint('Add on primary');
      await touchAtText(tester, l10n.csOnPrimary);
      await dismissTap(tester);
      await testCS(
        tester,
        text: l10n.csOnPrimary,
        l10n: l10n,
        defaultColor: false,
        textColor: true,
        isLefty: isLefty,
      );

      debugPrint('Add surface tint');
      await touchAtText(tester, l10n.csAddColor);
      await tester.ensureVisible(find.text(l10n.csSurfaceTint).last);
      await tester.fling(
        find.descendant(
          of: find.byType(BottomSheet),
          matching: find.byType(EzScrollView),
        ),
        const Offset(0, -500),
        2000,
      );
      await tester.pumpAndSettle();
      await touchAtText(tester, l10n.csSurfaceTint);
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

      await goBack(tester, l10n);
      debugPrint('\nColor settings test suite complete\n\n');
    });

Future<void> testCS(
  WidgetTester tester, {
  required String text,
  required EFUILang l10n,
  required bool defaultColor,
  required bool textColor,
  required bool isLefty,
}) async {
  debugPrint('\nTesting $text update\n');
  await touchAtText(tester, text);

  if (textColor) {
    debugPrint('Text options');
    await validateText(tester, l10n.csRecommended);

    debugPrint('Close');
    await touchAtText(tester, l10n.gClose);

    debugPrint('Yes');
    await touchAtText(tester, text);
    await touchAtText(tester, l10n.gYes);

    debugPrint('Custom\n');
    await touchAtText(tester, text);
    await touchAtText(tester, l10n.csUseCustom);
  }

  debugPrint('Layout');
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

  debugPrint('Cancel');
  await touchAtText(tester, l10n.gCancel);

  debugPrint('Apply');
  await touchAtText(tester, text);
  if (textColor) await touchAtText(tester, l10n.csUseCustom);
  await chaChaNow(tester, find.byType(Slider));
  await touchAtText(tester, l10n.gApply);

  /* Tests to unlock when the follow issue is resolved
  https://github.com/flutter/flutter/issues/98804

  debugPrint('\nTesting $text reset\n');
  await holdAtText(tester, text);

  debugPrint('Text/layout');

  if (!defaultColor) {
    await validateText(tester, l10n.gOptions);
    await touchAtText(tester, l10n.gReset);
  }

  await validateText(tester, l10n.csResetTo);

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

  debugPrint('No');
  await touchAtText(tester, l10n.gNo);

  debugPrint('Yes');
  await holdAtText(tester, text);
  if (!defaultColor) await touchAtText(tester, l10n.gReset);
  await touchAtText(tester, l10n.gYes);

  if (!defaultColor) {
    debugPrint('Remove');

    await holdAtText(tester, text);
    await touchAtText(tester, l10n.gClose);
    await holdAtText(tester, text);
    await touchAtText(tester, l10n.csRemove);
    expect(find.text(text), findsNothing);
  }
  */
}
