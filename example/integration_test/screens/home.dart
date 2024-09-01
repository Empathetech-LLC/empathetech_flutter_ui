/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/export.dart';

import 'package:flutter/material.dart';
import 'package:example/utils/consts.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

const String name = 'home-screen';

Future<bool> testSuite({
  required String title,
  required Locale locale,
  required EFUILang l10n,
  required List<LocaleNames> localeNames,
  bool isLefty = false,
}) async {
  testWidgets(title, (WidgetTester tester) async {
    // Load the app //

    final Widget testApp = testOpenUI(title: title, locale: locale);

    await tester.pumpWidget(testApp);
    await tester.pumpAndSettle();

    //// Verify text loaded ////

    validateText(tester: tester, finder: appTitle);
    validateText(tester: tester, finder: l10n.gAttention);
    try {
      validateText(tester: tester, finder: l10n.ssSettingsGuide);
    } catch (e) {
      validateText(tester: tester, finder: l10n.ssSettingsGuideWeb);
    }
    validateText(tester: tester, finder: l10n.ssDominantHand);
    validateText(tester: tester, finder: l10n.ssThemeMode);

    //// Test functionality ////

    // Dominant hand  //

    final Finder dominantHandButton = find.byType(DropdownMenu<bool>);

    // Verify the button exists
    expect(dominantHandButton, findsOneWidget);
    await touch(tester: tester, finder: dominantHandButton);

    // Verify the options appear
    final Finder rightButton = find.text(l10n.gRight).last;
    final Finder leftButton = find.text(l10n.gLeft).last;

    expect(rightButton, findsOneWidget);
    expect(leftButton, findsOneWidget);

    // Verify the menu is dismissible
    await dismissTap(tester);
    await touch(tester: tester, finder: dominantHandButton);

    final Finder handButtonsRowFinder = find.byType(Row).at(1);
    Row handButtonsRow = tester.widget(handButtonsRowFinder);
    List<Widget> handButtonsChildren = handButtonsRow.children;

    if (isLefty) {
      // Activate righty layout
      await tester.tap(rightButton);
      await tester.pumpAndSettle();

      // Verify righty layout
      expect(handButtonsChildren[0], isA<Flexible>());
      expect(handButtonsChildren[1], isA<EzSpacer>());
      expect(handButtonsChildren[2], isA<DropdownMenu<bool>>());

      // Activate lefty layout
      await touch(tester: tester, finder: dominantHandButton);

      await tester.tap(leftButton);
      await tester.pumpAndSettle();

      // Verify lefty layout
      handButtonsRow = tester.widget(handButtonsRowFinder);
      handButtonsChildren = handButtonsRow.children;

      expect(handButtonsChildren[0], isA<DropdownMenu<bool>>());
      expect(handButtonsChildren[1], isA<EzSpacer>());
      expect(handButtonsChildren[2], isA<Flexible>());
    } else {
      // Activate lefty layout
      await tester.tap(leftButton);
      await tester.pumpAndSettle();

      // Verify lefty layout
      expect(handButtonsChildren[0], isA<DropdownMenu<bool>>());
      expect(handButtonsChildren[1], isA<EzSpacer>());
      expect(handButtonsChildren[2], isA<Flexible>());

      // Activate righty layout
      await touch(tester: tester, finder: dominantHandButton);

      await tester.tap(rightButton);
      await tester.pumpAndSettle();

      // Verify righty layout
      handButtonsRow = tester.widget(handButtonsRowFinder);
      handButtonsChildren = handButtonsRow.children;

      expect(handButtonsChildren[0], isA<Flexible>());
      expect(handButtonsChildren[1], isA<EzSpacer>());
      expect(handButtonsChildren[2], isA<DropdownMenu<bool>>());
    }

    // Theme mode //

    final Finder themeModeButton = find.byType(DropdownMenu<ThemeMode>);

    // Verify the button exists
    expect(themeModeButton, findsOneWidget);
    await touch(tester: tester, finder: themeModeButton);

    // Verify  layout
    final Finder themeButtonsRowFinder = find.byType(Row).at(2);
    final Row themeButtonsRow = tester.widget(themeButtonsRowFinder);
    final List<Widget> themeButtonsChildren = themeButtonsRow.children;

    if (isLefty) {
      expect(themeButtonsChildren[0], isA<DropdownMenu<ThemeMode>>());
      expect(themeButtonsChildren[1], isA<EzSpacer>());
      expect(themeButtonsChildren[2], isA<Flexible>());
    } else {
      expect(themeButtonsChildren[0], isA<Flexible>());
      expect(themeButtonsChildren[1], isA<EzSpacer>());
      expect(themeButtonsChildren[2], isA<DropdownMenu<ThemeMode>>());
    }

    // Verify the options appear
    final Finder systemButton = find.text(l10n.gSystem).last;
    final Finder lightButton = find.text(l10n.gLight).last;
    final Finder darkButton = find.text(l10n.gDark).last;

    expect(systemButton, findsOneWidget);
    expect(lightButton, findsOneWidget);
    expect(darkButton, findsOneWidget);

    // Verify the menu is dismissible
    await dismissTap(tester);
    await touch(tester: tester, finder: themeModeButton);

    // Activate light theme
    await tester.tap(lightButton);
    await tester.pumpAndSettle();

    // Activate dark theme
    await touch(tester: tester, finder: themeModeButton);
    await tester.tap(darkButton);
    await tester.pumpAndSettle();

    // Activate system theme
    await touch(tester: tester, finder: themeModeButton);
    await tester.tap(systemButton);
    await tester.pumpAndSettle();

    // Language //

    final Finder languageButton = find.byType(EzLocaleSetting);

    // Verify the button exists
    expect(languageButton, findsOneWidget);
    await touch(tester: tester, finder: languageButton);

    // Verify the options appear
    final Finder englishButton =
        find.text(localeNames.first.nameOf('en')!).last;
    final Finder spanishButton =
        find.text(localeNames.first.nameOf('es')!).last;
    final Finder frenchButton = find.text(localeNames.first.nameOf('fr')!).last;
    final Finder closeBUtton = find.text(l10n.gClose).last;

    expect(englishButton, findsOneWidget);
    expect(spanishButton, findsOneWidget);
    expect(frenchButton, findsOneWidget);
    expect(closeBUtton, findsOneWidget);

    // Verify the menu is dismissible
    await dismissTap(tester);
    await touch(tester: tester, finder: languageButton);

    // Activate Spanish localizations
    await tester.tap(spanishButton);
    await tester.pumpAndSettle();

    await touch(tester: tester, finder: languageButton);

    // Activate French localizations
    await tester.tap(frenchButton);
    await tester.pumpAndSettle();

    await touch(tester: tester, finder: languageButton);

    // Activate English localizations
    await tester.tap(englishButton);
    await tester.pumpAndSettle();

    // Reset //

    final Finder resetButton = find.byType(EzResetButton);

    // Verify the button exists
    expect(resetButton, findsOneWidget);
    await touch(tester: tester, finder: resetButton);

    // Verify the options appear
    final Finder noButton = find.text(l10n.gNo).last;
    final Finder yesButton = find.text(l10n.gYes).last;

    expect(noButton, findsOneWidget);
    expect(yesButton, findsOneWidget);

    // Verify layout
    final AlertDialog alertDialog = tester.widget(find.byType(AlertDialog));
    final List<Widget> actions = alertDialog.actions!;
    expect(actions.length, 2);

    if (isLefty) {
      expect(actions[0], isA<TextButton>());
      expect((actions[0] as TextButton).child!.toString(), l10n.gYes);
      expect(actions[1], isA<TextButton>());
      expect((actions[1] as TextButton).child!.toString(), l10n.gNo);
    } else {
      expect(actions[0], isA<TextButton>());
      expect((actions[0] as TextButton).child!.toString(), l10n.gNo);
      expect(actions[1], isA<TextButton>());
      expect((actions[1] as TextButton).child!.toString(), l10n.gYes);
    }

    // Verify dismiss options
    await dismissTap(tester);
    await touch(tester: tester, finder: resetButton);

    await tester.tap(noButton);
    await tester.pumpAndSettle();
    await touch(tester: tester, finder: resetButton);

    // Activate reset button
    await tester.tap(yesButton);
    await tester.pumpAndSettle();

    // Options menu //

    final Finder optionsMenu = find.byType(MenuAnchor);

    // Verify the button exists
    expect(optionsMenu, findsOneWidget);
    await touch(tester: tester, finder: optionsMenu);

    // Verify the options appear
    final Finder byoButton = find.text(l10n.gBYO).last;
    final Finder feedbackButton = find.text(l10n.gGiveFeedback).last;

    expect(byoButton, findsOneWidget);
    expect(feedbackButton, findsOneWidget);

    // Verify the menu is dismissible
    await dismissTap(tester);
    await touch(tester: tester, finder: optionsMenu);
  });

  return true;
}
