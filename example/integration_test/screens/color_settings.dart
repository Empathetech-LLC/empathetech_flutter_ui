/* open_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/image_links.dart';

import 'package:example/main.dart';

import 'dart:io';
import 'package:flutter/material.dart';
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

      await ezTouch(
        tester,
        find.widgetWithText(EzElevatedIconButton, l10n.csPageTitle),
      );

      //* Test functionality: Quick settings *//

      ezLog('\nTesting quick settings');

      ezLog('\nValidating text');
      await ezFindText(
        tester,
        l10n.gEditingTheme(l10n.gDark.toLowerCase()),
      );

      ezLog('\nMonochrome');
      await ezTouchText(tester, l10n.csMonoChrome);

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
      await ezTouchText(tester, l10n.gAdvanced);

      ezLog('Validating text');
      await ezFindText(
        tester,
        l10n.gEditingTheme(l10n.gDark.toLowerCase()),
      );

      await testCS(
        tester,
        text: csPrimary,
        l10n: l10n,
        defaultColor: true,
        textColor: false,
        isLefty: isLefty,
      );
      await testCS(
        tester,
        text: csOnSurface,
        l10n: l10n,
        defaultColor: true,
        textColor: true,
        isLefty: isLefty,
      );

      ezLog('Testing add color modal');
      await ezTouchText(tester, l10n.csAddColor);

      ezLog('How this works');
      await ezFindText(tester, l10n.gHowThisWorks);

      ezLog('Add on primary');
      await ezTouchText(tester, csOnPrimary);
      await ezDismiss(tester);
      await testCS(
        tester,
        text: csOnPrimary,
        l10n: l10n,
        defaultColor: false,
        textColor: true,
        isLefty: isLefty,
      );

      ezLog('Add surface tint');
      await ezTouchText(tester, l10n.csAddColor);
      await tester.ensureVisible(find.text(csSurfaceTint).last);
      await tester.fling(
        find.descendant(
          of: find.byType(BottomSheet),
          matching: find.byType(EzScrollView).last,
        ),
        const Offset(0, -500),
        2000,
      );
      await tester.pumpAndSettle();
      await ezTouchText(tester, csSurfaceTint);
      await ezDismiss(tester);

      await testCS(
        tester,
        text: csSurfaceTint,
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

      await ezTapBack(tester, l10n.gBack);
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
  await ezTouchText(tester, text);

  if (textColor) {
    ezLog('Text options');
    await ezFindText(tester, l10n.csRecommended);

    ezLog('Close');
    await ezTouchText(tester, l10n.gClose);

    ezLog('Yes');
    await ezTouchText(tester, text);
    await ezTouchText(tester, l10n.gYes);

    ezLog('Custom\n');
    await ezTouchText(tester, text);
    await ezTouchText(tester, l10n.csUseCustom);
  }

  ezLog('Layout');
  final bool isCupertino = !kIsWeb && (Platform.isIOS || Platform.isMacOS);

  if (isCupertino) {
    final List<EzCupertinoAction> actions =
        (tester.widget(find.byType(EzAlertDialog).last) as EzAlertDialog)
            .cupertinoActions! as List<EzCupertinoAction>;

    expect(actions.length, 2);
    if (isLefty) {
      expect(actions[0].text, l10n.gApply);
      expect(actions[1].text, l10n.gCancel);
    } else {
      expect(actions[0].text, l10n.gCancel);
      expect(actions[1].text, l10n.gApply);
    }
  } else {
    final List<EzTextButton> actions =
        (tester.widget(find.byType(EzAlertDialog).last) as EzAlertDialog)
            .materialActions! as List<EzTextButton>;

    expect(actions.length, 2);
    if (isLefty) {
      expect(actions[0].text, l10n.gApply);
      expect(actions[1].text, l10n.gCancel);
    } else {
      expect(actions[0].text, l10n.gCancel);
      expect(actions[1].text, l10n.gApply);
    }
  }

  ezLog('Cancel');
  await ezTouchText(tester, l10n.gCancel);

  ezLog('Apply');
  await ezTouchText(tester, text);
  if (textColor) await ezTouchText(tester, l10n.csUseCustom);
  await ezChaCha(tester, find.byType(Slider));
  await ezTouchText(tester, l10n.gApply);

  ezLog('\nTesting $text reset\n');
  await ezHoldText(tester, text);

  ezLog('Text/layout');

  if (!defaultColor) {
    await ezFindText(tester, l10n.gOptions);
    await ezTouchText(tester, l10n.gReset);
  }

  await ezFindText(tester, l10n.gReset);

  if (isCupertino) {
    final List<EzCupertinoAction> actions =
        (tester.widget(find.byType(EzAlertDialog).last) as EzAlertDialog)
            .cupertinoActions! as List<EzCupertinoAction>;

    expect(actions.length, 2);
    if (isLefty) {
      expect(actions[0].text, Text(l10n.gYes));
      expect(actions[1].text, Text(l10n.gNo));
    } else {
      expect(actions[0].text, Text(l10n.gNo));
      expect(actions[1].text, Text(l10n.gYes));
    }
  } else {
    final List<EzTextButton> actions =
        (tester.widget(find.byType(EzAlertDialog).last) as EzAlertDialog)
            .materialActions! as List<EzTextButton>;

    expect(actions.length, 2);
    if (isLefty) {
      expect(actions[0].text, Text(l10n.gYes));
      expect(actions[1].text, Text(l10n.gNo));
    } else {
      expect(actions[0].text, Text(l10n.gNo));
      expect(actions[1].text, Text(l10n.gYes));
    }
  }

  ezLog('No');
  await ezTouchText(tester, l10n.gNo);

  ezLog('Yes');
  await ezHoldText(tester, text);
  if (!defaultColor) await ezTouchText(tester, l10n.gReset);
  await ezTouchText(tester, l10n.gYes);

  if (!defaultColor) {
    ezLog('Remove');

    await ezHoldText(tester, text);
    await ezTouchText(tester, l10n.gClose);
    await ezHoldText(tester, text);
    await ezTouchText(tester, l10n.gRemove);
    expect(find.text(text), findsNothing);
  }
}
