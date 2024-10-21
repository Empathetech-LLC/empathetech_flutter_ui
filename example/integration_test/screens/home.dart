/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:example/main.dart';
import 'package:example/utils/consts.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

void testSuite({
  Locale locale = english,
  bool isLefty = false,
}) =>
    testWidgets('home-screen', (WidgetTester tester) async {
      // Load localization(s) //

      ezLog('Loading localizations');
      final EFUILang l10n = await EFUILang.delegate.load(locale);
      final LocaleNames l10nNames =
          await const LocaleNamesLocalizationsDelegate().load(locale);

      // Load the app //

      ezLog('Loading OpenUI');
      await tester.pumpWidget(const OpenUI());
      await tester.pumpAndSettle();

      // Verify text loaded //

      ezLog('\nValidating text');
      await validateText(tester, appTitle);
      await validateWidget(tester, EzWarning);
      await validateText(tester, l10n.ssDominantHand);
      await validateText(tester, l10n.ssThemeMode);

      //* Test functionality *//

      // Options menu //

      ezLog('\nTesting options menu');
      await touch(tester, find.byType(MenuAnchor).last);

      expect(find.text(l10n.gBYO).last, findsOneWidget);
      expect(find.text(l10n.gGiveFeedback).last, findsOneWidget);

      ezLog('Dismissing');
      await dismissTap(tester);

      await testDHSetting(tester, l10n: l10n, isLefty: isLefty);
      await testTMSwitch(tester, l10n: l10n, isLefty: isLefty);
      await testLocaleSetting(
        tester,
        l10n: l10n,
        l10nNames: l10nNames,
        isLefty: isLefty,
      );

      // Reset button //

      await testResetButton(
        tester,
        type: RBType.all,
        l10n: l10n,
        isLefty: isLefty,
      );

      // Reset for next test suite  //

      ezLog('\nSettings home test suite complete\n\n');
    });
