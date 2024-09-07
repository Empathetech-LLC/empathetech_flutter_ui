/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/export.dart';

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

      debugPrint('Loading localizations');
      final EFUILang l10n = await EFUILang.delegate.load(locale);
      final LocaleNames l10nNames =
          await const LocaleNamesLocalizationsDelegate().load(locale);

      // Load the app //

      debugPrint('Loading OpenUI');
      await tester.pumpWidget(const OpenUI());
      await tester.pumpAndSettle();

      // Verify text loaded //

      debugPrint('\nValidating text');
      await validateText(tester, appTitle);
      await validateWidget(tester, EzWarning);
      await validateText(tester, l10n.ssDominantHand);
      await validateText(tester, l10n.ssThemeMode);

      //// Test functionality ////

      // Options menu //

      debugPrint('\nTesting options menu');
      await touch(tester, find.byType(MenuAnchor).last);

      // ToDo: Test options functionality
      expect(find.text(l10n.gBYO).last, findsOneWidget);
      expect(find.text(l10n.gGiveFeedback).last, findsOneWidget);

      debugPrint('Dismissing');
      await dismissTap(tester);

      // Dominant hand  //

      debugPrint('\nTesting dominant hand setting');
      await touch(tester, find.byType(DropdownMenu<bool>).last);

      if (isLefty) {
        debugPrint('Right hand layout');

        // Activate righty layout
        await touchText(tester, l10n.gRight);

        List<Widget> handButtonsChildren =
            (tester.widget(find.byType(Row).at(1)) as Row).children;

        expect(handButtonsChildren.length, 3);

        // Verify righty layout
        expect(handButtonsChildren[0], isA<Text>());
        expect(handButtonsChildren[1], isA<EzSpacer>());
        expect(handButtonsChildren[2], isA<DropdownMenu<bool>>());

        debugPrint('Left hand layout');

        // Activate lefty layout
        await touch(tester, find.byType(DropdownMenu<bool>).last);
        await touchText(tester, l10n.gLeft);

        // Verify lefty layout
        handButtonsChildren =
            (tester.widget(find.byType(Row).at(1)) as Row).children;

        expect(handButtonsChildren[0], isA<DropdownMenu<bool>>());
        expect(handButtonsChildren[1], isA<EzSpacer>());
        expect(handButtonsChildren[2], isA<Text>());
      } else {
        debugPrint('Left hand layout');

        // Activate lefty layout
        await touchText(tester, l10n.gLeft);

        List<Widget> handButtonsChildren =
            (tester.widget(find.byType(Row).at(1)) as Row).children;

        expect(handButtonsChildren.length, 3);

        // Verify lefty layout
        expect(handButtonsChildren[0], isA<DropdownMenu<bool>>());
        expect(handButtonsChildren[1], isA<EzSpacer>());
        expect(handButtonsChildren[2], isA<Text>());

        debugPrint('Right hand layout');

        // Activate righty layout
        await touch(tester, find.byType(DropdownMenu<bool>).last);
        await touchText(tester, l10n.gRight);

        // Verify righty layout
        handButtonsChildren =
            (tester.widget(find.byType(Row).at(1)) as Row).children;

        expect(handButtonsChildren[0], isA<Text>());
        expect(handButtonsChildren[1], isA<EzSpacer>());
        expect(handButtonsChildren[2], isA<DropdownMenu<bool>>());
      }

      // Theme mode //

      debugPrint('\nTesting theme mode setting');

      // Verify  layout
      final List<Widget> themeButtonsChildren =
          (tester.widget(find.byType(EzRow).at(2)) as EzRow).children;

      expect(themeButtonsChildren.length, 3);
      if (isLefty) {
        expect(themeButtonsChildren[0], isA<DropdownMenu<ThemeMode>>());
        expect(themeButtonsChildren[1], isA<EzSpacer>());
        expect(themeButtonsChildren[2], isA<Text>());
      } else {
        expect(themeButtonsChildren[0], isA<Text>());
        expect(themeButtonsChildren[1], isA<EzSpacer>());
        expect(themeButtonsChildren[2], isA<DropdownMenu<ThemeMode>>());
      }

      // Activate light theme
      debugPrint('Light');
      await touch(tester, find.byType(DropdownMenu<ThemeMode>));
      await touchText(tester, l10n.gLight);

      // Activate system theme
      debugPrint('System');
      await touch(tester, find.byType(DropdownMenu<ThemeMode>));
      await touchText(tester, l10n.gSystem);

      // Activate dark theme
      debugPrint('Dark');
      await touch(tester, find.byType(DropdownMenu<ThemeMode>));
      await touchText(tester, l10n.gDark);

      // Language //

      debugPrint('\nTesting language setting button');
      // ToDo: Test button text updates with selected locale

      // Activate Spanish localizations
      debugPrint('Spanish');
      await touch(tester, find.byType(EzLocaleSetting));
      await touchText(tester, l10nNames.nameOf('es')!);
      await tester.pumpAndSettle();

      // Activate French localizations
      debugPrint('French');
      await touch(tester, find.byType(EzLocaleSetting));
      await touchText(tester, l10nNames.nameOf('fr')!);
      await tester.pumpAndSettle();

      // Activate English localizations
      debugPrint('English');
      await touch(tester, find.byType(EzLocaleSetting));
      await touchText(tester, l10nNames.nameOf('en')!);
      await tester.pumpAndSettle();

      // Activate English localizations
      debugPrint('Close');
      await touch(tester, find.byType(EzLocaleSetting));
      await touchText(tester, l10n.gClose);
      await tester.pumpAndSettle();

      // Reset button //

      await testResetButton(
        tester,
        type: RBType.all,
        l10n: l10n,
        isLefty: isLefty,
      );

      // Reset for next test suite  //

      debugPrint('\nSettings home test suite complete\n\n');
    });
