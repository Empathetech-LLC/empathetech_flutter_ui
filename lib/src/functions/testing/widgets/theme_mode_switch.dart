/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

/// For integration testing
/// Test [EzThemeModeSwitch]
Future<void> testTMSwitch(
  WidgetTester tester, {
  required EFUILang l10n,
  required bool isLefty,
}) async {
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
}
