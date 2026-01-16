/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../utils/image_links.dart';

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

      ezLog('Loading localizations');

      // Load the app //

      ezLog('Loading OpenUI');
      await tester.pumpWidget(const OpenUI());
      await tester.pumpAndSettle();

      // Test navigation //

      ezLog('\nTesting navigation');

      await ezTouch(
        tester,
        find.widgetWithText(EzElevatedIconButton, EzConfig.l10n.csPageTitle),
      );

      //* Test functionality: Quick settings *//

      ezLog('\nTesting quick settings');

      ezLog('\nValidating text');
      await ezFindText(
        tester,
        EzConfig.l10n.gEditingTheme(EzConfig.l10n.gDark.toLowerCase()),
      );

      ezLog('\nMonochrome');
      await ezTouchText(tester, EzConfig.l10n.csMonoChrome);

      ezLog('\nColorScheme from image');
      await testImageSetting(
        tester,
        finder: find.byType(EzImageSetting),
        type:
            '${EzConfig.l10n.gDark.toLowerCase()} ${EzConfig.l10n.csColorScheme}',
        updateCS: false,
        networkImageURLs: imageURLs,
      );

      await testResetButton(tester, type: RBType.color);

      //* Test functionality: Advanced settings *//

      ezLog('\nTesting advanced settings');

      ezLog('Navigation');
      await ezTouchText(tester, EzConfig.l10n.gAdvanced);

      ezLog('Validating text');
      await ezFindText(
        tester,
        EzConfig.l10n.gEditingTheme(EzConfig.l10n.gDark.toLowerCase()),
      );

      await testCS(
        tester,
        text: csPrimary,
        defaultColor: true,
        textColor: false,
      );
      await testCS(
        tester,
        text: csOnSurface,
        defaultColor: true,
        textColor: true,
      );

      ezLog('Testing add color modal');
      await ezTouchText(tester, EzConfig.l10n.csAddColor);

      ezLog('How this works');
      await ezFindText(tester, EzConfig.l10n.gHowThisWorks);

      ezLog('Add on primary');
      await ezTouchText(tester, csOnPrimary);
      await ezDismiss(tester);
      await testCS(
        tester,
        text: csOnPrimary,
        defaultColor: false,
        textColor: true,
      );

      ezLog('Add surface tint');
      await ezTouchText(tester, EzConfig.l10n.csAddColor);
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
        defaultColor: false,
        textColor: false,
      );

      await testResetButton(
        tester,
        type: RBType.color,
      );

      // Reset for next test suite  //

      await ezTapBack(tester, EzConfig.l10n.gBack);
      ezLog('\nColor settings test suite complete\n\n');
    });

Future<void> testCS(
  WidgetTester tester, {
  required String text,
  required bool defaultColor,
  required bool textColor,
}) async {
  ezLog('\nTesting $text update\n');
  await ezTouchText(tester, text);

  if (textColor) {
    ezLog('Text options');
    await ezFindText(tester, EzConfig.l10n.csRecommended);

    ezLog('Close');
    await ezTouchText(tester, EzConfig.l10n.gClose);

    ezLog('Yes');
    await ezTouchText(tester, text);
    await ezTouchText(tester, EzConfig.l10n.gYes);

    ezLog('Custom\n');
    await ezTouchText(tester, text);
    await ezTouchText(tester, EzConfig.l10n.csUseCustom);
  }

  ezLog('Layout');

  List<EzTextButton> actions =
      (tester.widget(find.byType(EzAlertDialog).last) as EzAlertDialog).actions!
          as List<EzTextButton>;

  expect(actions.length, 2);
  if (EzConfig.isLefty) {
    expect(actions[0].text, EzConfig.l10n.gApply);
    expect(actions[1].text, EzConfig.l10n.gCancel);
  } else {
    expect(actions[0].text, EzConfig.l10n.gCancel);
    expect(actions[1].text, EzConfig.l10n.gApply);
  }

  ezLog('Cancel');
  await ezTouchText(tester, EzConfig.l10n.gCancel);

  ezLog('Apply');
  await ezTouchText(tester, text);
  if (textColor) await ezTouchText(tester, EzConfig.l10n.csUseCustom);
  await ezChaCha(tester, find.byType(Slider));
  await ezTouchText(tester, EzConfig.l10n.gApply);

  ezLog('\nTesting $text reset\n');
  await ezHoldText(tester, text);

  ezLog('Text/layout');

  if (!defaultColor) {
    await ezFindText(tester, EzConfig.l10n.gOptions);
    await ezTouchText(tester, EzConfig.l10n.gReset);
  }

  await ezFindText(tester, EzConfig.l10n.gReset);

  actions = (tester.widget(find.byType(EzAlertDialog).last) as EzAlertDialog)
      .actions! as List<EzTextButton>;

  expect(actions.length, 2);
  if (EzConfig.isLefty) {
    expect(actions[0].text, Text(EzConfig.l10n.gYes));
    expect(actions[1].text, Text(EzConfig.l10n.gNo));
  } else {
    expect(actions[0].text, Text(EzConfig.l10n.gNo));
    expect(actions[1].text, Text(EzConfig.l10n.gYes));
  }

  ezLog('No');
  await ezTouchText(tester, EzConfig.l10n.gNo);

  ezLog('Yes');
  await ezHoldText(tester, text);
  if (!defaultColor) await ezTouchText(tester, EzConfig.l10n.gReset);
  await ezTouchText(tester, EzConfig.l10n.gYes);

  if (!defaultColor) {
    ezLog('Remove');

    await ezHoldText(tester, text);
    await ezTouchText(tester, EzConfig.l10n.gClose);
    await ezHoldText(tester, text);
    await ezTouchText(tester, EzConfig.l10n.gRemove);
    expect(find.text(text), findsNothing);
  }
}
