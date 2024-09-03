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

const String name = 'home-screen';

void testSuite({
  required String title,
  Locale locale = english,
  bool isLefty = false,
}) =>
    testWidgets(title, (WidgetTester tester) async {
      // Load localization(s) //

      debugPrint('Loading localizations');
      final EFUILang l10n = await EFUILang.delegate.load(locale);

      final LocaleNames enNames =
          await const LocaleNamesLocalizationsDelegate().load(english);
      final LocaleNames esNames =
          await const LocaleNamesLocalizationsDelegate().load(spanish);
      final LocaleNames frNames =
          await const LocaleNamesLocalizationsDelegate().load(french);

      /// [english, spanish, french]
      final List<LocaleNames> l10nNames = <LocaleNames>[
        enNames,
        esNames,
        frNames,
      ];

      // Load the app //

      debugPrint('Loading OpenUI');
      await tester.pumpWidget(const OpenUI());
      await tester.pumpAndSettle();

      // Verify text loaded //

      debugPrint('\nValidating text');
      await validateText(tester: tester, text: appTitle);
      await validateText(tester: tester, text: l10n.gAttention);
      await validateWidget(tester: tester, widgetType: EzWarning);
      await validateText(tester: tester, text: l10n.ssDominantHand);
      await validateText(tester: tester, text: l10n.ssThemeMode);

      //// Test functionality ////

      // Options menu //

      debugPrint('\nTesting options menu (OM)');
      await touch(tester: tester, finder: find.byType(MenuAnchor).last);

      // ToDo: Test options functionality
      expect(find.text(l10n.gBYO).last, findsOneWidget);
      expect(find.text(l10n.gGiveFeedback).last, findsOneWidget);

      debugPrint('Dismissing OM');
      await dismissTap(tester);

      // Dominant hand  //

      debugPrint('\nTesting dominant hand setting (DHS)');
      await touch(tester: tester, finder: find.byType(DropdownMenu<bool>).last);

      if (isLefty) {
        debugPrint('Verifying DHS right hand layout');

        // Activate righty layout
        await tester.tapAt(tester.getCenter(find.text(l10n.gRight).last));
        await tester.pumpAndSettle();

        List<Widget> handButtonsChildren =
            (tester.widget(find.byType(Row).at(1)) as Row).children;

        // Verify righty layout
        expect(handButtonsChildren[0], isA<Flexible>());
        expect(handButtonsChildren[1], isA<EzSpacer>());
        expect(handButtonsChildren[2], isA<DropdownMenu<bool>>());

        debugPrint('Verifying DHS left hand layout');

        // Activate lefty layout
        await touch(
          tester: tester,
          finder: find.byType(DropdownMenu<bool>).last,
        );

        await tester.tapAt(tester.getCenter(find.text(l10n.gLeft).last));
        await tester.pumpAndSettle();

        // Verify lefty layout
        handButtonsChildren =
            (tester.widget(find.byType(Row).at(1)) as Row).children;

        expect(handButtonsChildren[0], isA<DropdownMenu<bool>>());
        expect(handButtonsChildren[1], isA<EzSpacer>());
        expect(handButtonsChildren[2], isA<Flexible>());
      } else {
        debugPrint('Verifying DHS left hand layout');

        // Activate lefty layout
        await tester.tapAt(tester.getCenter(find.text(l10n.gLeft).last));
        await tester.pumpAndSettle();

        List<Widget> handButtonsChildren =
            (tester.widget(find.byType(Row).at(1)) as Row).children;

        // Verify lefty layout
        expect(handButtonsChildren[0], isA<DropdownMenu<bool>>());
        expect(handButtonsChildren[1], isA<EzSpacer>());
        expect(handButtonsChildren[2], isA<Flexible>());

        debugPrint('Verifying DHS right hand layout');

        // Activate righty layout
        await touch(
          tester: tester,
          finder: find.byType(DropdownMenu<bool>).last,
        );

        await tester.tapAt(tester.getCenter(find.text(l10n.gRight).last));
        await tester.pumpAndSettle();

        // Verify righty layout
        handButtonsChildren =
            (tester.widget(find.byType(Row).at(1)) as Row).children;

        expect(handButtonsChildren[0], isA<Flexible>());
        expect(handButtonsChildren[1], isA<EzSpacer>());
        expect(handButtonsChildren[2], isA<DropdownMenu<bool>>());
      }

      // // Theme mode //

      // debugPrint('\nTesting theme mode setting (TMS)');
      // final Finder themeModeButton = find.byType(DropdownMenu<ThemeMode>);

      // debugPrint('Testing TMS exists');
      // expect(themeModeButton, findsOneWidget);
      // await touch(tester: tester, text: themeModeButton);

      // // Verify  layout
      // final Finder themeButtonsRowFinder = find.byType(Row).at(2);
      // final Row themeButtonsRow = tester.widget(themeButtonsRowFinder);
      // final List<Widget> themeButtonsChildren = themeButtonsRow.children;

      // if (isLefty) {
      //   expect(themeButtonsChildren[0], isA<DropdownMenu<ThemeMode>>());
      //   expect(themeButtonsChildren[1], isA<EzSpacer>());
      //   expect(themeButtonsChildren[2], isA<Flexible>());
      // } else {
      //   expect(themeButtonsChildren[0], isA<Flexible>());
      //   expect(themeButtonsChildren[1], isA<EzSpacer>());
      //   expect(themeButtonsChildren[2], isA<DropdownMenu<ThemeMode>>());
      // }

      // debugPrint('Testing TMS options appear');
      // final Finder systemButton = find.text(l10n.gSystem).last;
      // final Finder lightButton = find.text(l10n.gLight).last;
      // final Finder darkButton = find.text(l10n.gDark).last;

      // expect(systemButton, findsOneWidget);
      // expect(lightButton, findsOneWidget);
      // expect(darkButton, findsOneWidget);

      // debugPrint('Testing TMS menu is dismissible');
      // await dismissTap(tester);
      // await touch(tester: tester, text: themeModeButton);

      // debugPrint('Testing DHS functionality');

      // // Activate light theme
      // await tester.tap(lightButton);
      // await tester.pumpAndSettle();

      // // Activate dark theme
      // await touch(tester: tester, text: themeModeButton);
      // await tester.tap(darkButton);
      // await tester.pumpAndSettle();

      // // Activate system theme
      // await touch(tester: tester, text: themeModeButton);
      // await tester.tap(systemButton);
      // await tester.pumpAndSettle();

      // // Language //

      // debugPrint('\nTesting language setting button (LSB)');
      // final Finder languageButton = find.byType(EzLocaleSetting);

      // debugPrint('Testing LSB exists');
      // expect(languageButton, findsOneWidget);
      // await touch(tester: tester, text: languageButton);

      // debugPrint('Testing LSB options appear');
      // final Finder englishButton =
      //     find.text(l10nNames.first.nameOf('en')!).last;
      // final Finder spanishButton =
      //     find.text(l10nNames.first.nameOf('es')!).last;
      // final Finder frenchButton = find.text(l10nNames.first.nameOf('fr')!).last;
      // final Finder closeBUtton = find.text(l10n.gClose).last;

      // expect(englishButton, findsOneWidget);
      // expect(spanishButton, findsOneWidget);
      // expect(frenchButton, findsOneWidget);
      // expect(closeBUtton, findsOneWidget);

      // debugPrint('Testing LSB menu is dismissible');
      // await dismissTap(tester);
      // await touch(tester: tester, text: languageButton);

      // debugPrint('Testing LSB functionality');

      // // Activate Spanish localizations
      // await tester.tap(spanishButton);
      // await tester.pumpAndSettle();

      // await touch(tester: tester, text: languageButton);

      // // Activate French localizations
      // await tester.tap(frenchButton);
      // await tester.pumpAndSettle();

      // await touch(tester: tester, text: languageButton);

      // // Activate English localizations
      // await tester.tap(englishButton);
      // await tester.pumpAndSettle();

      // // Reset //

      // debugPrint('\nTesting reset button (RB)');
      // final Finder resetButton = find.byType(EzResetButton);

      // debugPrint('Testing RB exists');
      // expect(resetButton, findsOneWidget);

      // debugPrint('Testing RB activation');
      // await touch(tester: tester, text: resetButton);

      // debugPrint('Testing RB dialog options appear');
      // final Finder noButton = find.text(l10n.gNo).last;
      // final Finder yesButton = find.text(l10n.gYes).last;

      // expect(noButton, findsOneWidget);
      // expect(yesButton, findsOneWidget);

      // // Verify layout
      // final AlertDialog alertDialog = tester.widget(find.byType(AlertDialog));
      // final List<Widget> actions = alertDialog.actions!;
      // expect(actions.length, 2);

      // if (isLefty) {
      //   expect(actions[0], isA<TextButton>());
      //   expect((actions[0] as TextButton).child!.toString(), l10n.gYes);
      //   expect(actions[1], isA<TextButton>());
      //   expect((actions[1] as TextButton).child!.toString(), l10n.gNo);
      // } else {
      //   expect(actions[0], isA<TextButton>());
      //   expect((actions[0] as TextButton).child!.toString(), l10n.gNo);
      //   expect(actions[1], isA<TextButton>());
      //   expect((actions[1] as TextButton).child!.toString(), l10n.gYes);
      // }

      // debugPrint('Testing RB dialog dismiss options');
      // await dismissTap(tester);
      // await touch(tester: tester, text: resetButton);

      // await tester.tap(noButton);
      // await tester.pumpAndSettle();
      // await touch(tester: tester, text: resetButton);

      // debugPrint('Testing RB functionality');
      // await tester.tap(yesButton);
      // await tester.pumpAndSettle();

      // Reset for next test suite  //

      debugPrint('\nSettings home test suite complete\n');
    });
