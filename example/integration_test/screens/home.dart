/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/export.dart';

import 'package:example/main.dart';
import 'package:example/utils/consts.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
      await validateText(tester, l10n.gAttention);
      await validateWidget(tester, EzWarning);
      await validateText(tester, l10n.ssDominantHand);
      await validateText(tester, l10n.ssThemeMode);

      //// Test functionality ////

      // Options menu //

      debugPrint('\nTesting options menu (OM)');
      await touch(tester, find.byType(MenuAnchor).last);

      // ToDo: Test options functionality
      expect(find.text(l10n.gBYO).last, findsOneWidget);
      expect(find.text(l10n.gGiveFeedback).last, findsOneWidget);

      debugPrint('Dismissing OM');
      await dismissTap(tester);

      // Dominant hand  //

      debugPrint('\nTesting dominant hand setting (DHS)');
      await touch(tester, find.byType(DropdownMenu<bool>).last);

      if (isLefty) {
        debugPrint('Right hand layout');

        // Activate righty layout
        await touchAtText(tester, l10n.gRight);

        List<Widget> handButtonsChildren =
            (tester.widget(find.byType(Row).at(1)) as Row).children;

        expect(handButtonsChildren.length, 3);

        // Verify righty layout
        expect(handButtonsChildren[0], isA<Flexible>());
        expect(handButtonsChildren[1], isA<EzSpacer>());
        expect(handButtonsChildren[2], isA<DropdownMenu<bool>>());

        debugPrint('Left hand layout');

        // Activate lefty layout
        await touch(tester, find.byType(DropdownMenu<bool>).last);
        await touchAtText(tester, l10n.gLeft);

        // Verify lefty layout
        handButtonsChildren =
            (tester.widget(find.byType(Row).at(1)) as Row).children;

        expect(handButtonsChildren[0], isA<DropdownMenu<bool>>());
        expect(handButtonsChildren[1], isA<EzSpacer>());
        expect(handButtonsChildren[2], isA<Flexible>());
      } else {
        debugPrint('Left hand layout');

        // Activate lefty layout
        await touchAtText(tester, l10n.gLeft);

        List<Widget> handButtonsChildren =
            (tester.widget(find.byType(Row).at(1)) as Row).children;

        expect(handButtonsChildren.length, 3);

        // Verify lefty layout
        expect(handButtonsChildren[0], isA<DropdownMenu<bool>>());
        expect(handButtonsChildren[1], isA<EzSpacer>());
        expect(handButtonsChildren[2], isA<Flexible>());

        debugPrint('Right hand layout');

        // Activate righty layout
        await touch(tester, find.byType(DropdownMenu<bool>).last);
        await touchAtText(tester, l10n.gRight);

        // Verify righty layout
        handButtonsChildren =
            (tester.widget(find.byType(Row).at(1)) as Row).children;

        expect(handButtonsChildren[0], isA<Flexible>());
        expect(handButtonsChildren[1], isA<EzSpacer>());
        expect(handButtonsChildren[2], isA<DropdownMenu<bool>>());
      }

      // Theme mode //

      debugPrint('\nTesting theme mode setting (TMS)');

      // Verify  layout
      final List<Widget> themeButtonsChildren =
          (tester.widget(find.byType(EzRow).at(2)) as EzRow).children;

      expect(themeButtonsChildren.length, 3);
      if (isLefty) {
        expect(themeButtonsChildren[0], isA<DropdownMenu<ThemeMode>>());
        expect(themeButtonsChildren[1], isA<EzSpacer>());
        expect(themeButtonsChildren[2], isA<Flexible>());
      } else {
        expect(themeButtonsChildren[0], isA<Flexible>());
        expect(themeButtonsChildren[1], isA<EzSpacer>());
        expect(themeButtonsChildren[2], isA<DropdownMenu<ThemeMode>>());
      }

      // Activate light theme
      debugPrint('Light');
      await touch(tester, find.byType(DropdownMenu<ThemeMode>));
      await touchAtText(tester, l10n.gLight);

      // Activate system theme
      debugPrint('System');
      await touch(tester, find.byType(DropdownMenu<ThemeMode>));
      await touchAtText(tester, l10n.gSystem);

      // Activate dark theme
      debugPrint('Dark');
      await touch(tester, find.byType(DropdownMenu<ThemeMode>));
      await touchAtText(tester, l10n.gDark);

      // Language //

      debugPrint('\nTesting language setting button (LSB)');

      // Activate Spanish localizations
      debugPrint('Spanish');
      await touch(tester, find.byType(EzLocaleSetting));
      await tester.tap(find.text(l10nNames.nameOf('es')!).last); // tap at text
      await tester.pumpAndSettle();

      // Activate French localizations
      debugPrint('French');
      await touch(tester, find.byType(EzLocaleSetting));
      await tester.tap(find.text(l10nNames.nameOf('fr')!).last);
      await tester.pumpAndSettle();

      // Activate English localizations
      debugPrint('English');
      await touch(tester, find.byType(EzLocaleSetting));
      await tester.tap(find.text(l10nNames.nameOf('en')!).last);
      await tester.pumpAndSettle();

      // Activate English localizations
      debugPrint('Close');
      await touch(tester, find.byType(EzLocaleSetting));
      await tester.tap(find.text(l10n.gClose).last);
      await tester.pumpAndSettle();

      // Reset //

      debugPrint('\nTesting reset button (RB)');
      await touch(tester, find.byType(EzResetButton));

      // Verify layout
      final bool isCupertino = !kIsWeb && (Platform.isIOS || Platform.isMacOS);

      late final List<TextButton>? materialActions;
      late final List<CupertinoDialogAction>? cupertinoActions;

      if (isCupertino) {
        cupertinoActions =
            (tester.widget(find.byType(EzAlertDialog)) as EzAlertDialog)
                .cupertinoActions!;
      } else {
        materialActions =
            (tester.widget(find.byType(EzAlertDialog)) as EzAlertDialog)
                .materialActions! as List<TextButton>;
      }

      if (isCupertino) {
        final List<CupertinoDialogAction> actions = cupertinoActions!;

        expect(actions.length, 2);
        if (isLefty) {
          expect(actions[0].child.toString(), Text(l10n.gYes).toString());
          expect(actions[1].child.toString(), Text(l10n.gNo).toString());
        } else {
          expect(actions[0].child.toString(), Text(l10n.gNo).toString());
          expect(actions[1].child.toString(), Text(l10n.gYes).toString());
        }
      } else {
        final List<TextButton> actions = materialActions!;

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
      await touch(tester, find.byType(EzResetButton));
      await touchAtText(tester, l10n.gYes);

      // Reset for next test suite  //

      debugPrint('\nSettings home test suite complete\n');
    });
