/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'open_ui_test.dart' as core;
import 'utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

const String name = 'Home screen';

void main() async {
  await core.runTestSuites(
    testSuites: <Function>[testSuite],
    screenNames: <String>[name],
  );
}

void testSuite({
  required String title,
  required Locale locale,
  required EFUILang l10n,
  required LocaleNames localeNames,
  Function? setup,
}) =>
    testWidgets(title, (WidgetTester tester) async {
      //// Run the tests ////

      await setup?.call();

      // Load the app //

      final Widget testApp = testOpenUI(title: title, locale: locale);

      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      //// Test functionality ////

      // Dominant hand  //

      final Finder dominantHandButton = find.byType(DropdownMenu<bool>);

      expect(dominantHandButton, findsOneWidget);
      await touch(tester, dominantHandButton);

      final Finder rightButton = find.text(l10n.gRight).last;
      final Finder leftButton = find.text(l10n.gLeft).last;

      expect(rightButton, findsOneWidget);
      expect(leftButton, findsOneWidget);

      await tester.tap(leftButton);
      await tester.pumpAndSettle();

      final Finder handButtonsRowFinder = find.byType(Row).at(1);
      Row handButtonsRow = tester.widget(handButtonsRowFinder);
      List<Widget> children = handButtonsRow.children;

      expect(children[0], isA<DropdownMenu<bool>>());
      expect(children[1], isA<EzSpacer>());
      expect(children[2], isA<Flexible>());

      await touch(tester, dominantHandButton);

      await tester.tap(rightButton);
      await tester.pumpAndSettle();

      handButtonsRow = tester.widget(handButtonsRowFinder);
      children = handButtonsRow.children;

      expect(children[0], isA<Flexible>());
      expect(children[1], isA<EzSpacer>());
      expect(children[2], isA<DropdownMenu<bool>>());

      // Theme mode //

      final Finder themeModeButton = find.byType(DropdownMenu<ThemeMode>);

      expect(themeModeButton, findsOneWidget);
      await touch(tester, themeModeButton);

      final Finder systemButton = find.text(l10n.gSystem).last;
      final Finder darkButton = find.text(l10n.gDark).last;
      final Finder lightButton = find.text(l10n.gLight).last;

      expect(systemButton, findsOneWidget);
      expect(darkButton, findsOneWidget);
      expect(lightButton, findsOneWidget);

      await tester.tap(systemButton);
      await tester.pumpAndSettle();

      await touch(tester, themeModeButton);
      await tester.tap(darkButton);
      await tester.pumpAndSettle();

      await touch(tester, themeModeButton);
      await tester.tap(lightButton);
      await tester.pumpAndSettle();

      // Language //

      final Finder languageButton = find.byType(EzLocaleSetting);

      expect(languageButton, findsOneWidget);
      await touch(tester, languageButton);

      final Finder englishButton = find.text(localeNames.nameOf('en')!).last;
      final Finder spanishButton = find.text(localeNames.nameOf('es')!).last;

      expect(englishButton, findsOneWidget);
      expect(spanishButton, findsOneWidget);

      await tester.tap(spanishButton);
      await tester.pumpAndSettle();

      await touch(tester, languageButton);

      await tester.tap(englishButton);
      await tester.pumpAndSettle();

      // Reset //

      final Finder resetButton = find.byType(EzResetButton);

      expect(resetButton, findsOneWidget);
      await touch(tester, resetButton);

      final Finder noButton = find.text(l10n.gNo).last;
      final Finder yesButton = find.text(l10n.gYes).last;

      expect(noButton, findsOneWidget);
      expect(yesButton, findsOneWidget);

      await tester.tap(yesButton);
      await tester.pumpAndSettle();
    });
