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
  if (isLefty) {
    assert(
      tester.getCenter(find.byType(DropdownMenu<ThemeMode>)).dx <
          tester.getCenter(find.text(l10n.ssThemeMode)).dx,
      'DH layout mismatch',
    );
  } else {
    assert(
      tester.getCenter(find.byType(DropdownMenu<ThemeMode>)).dx >
          tester.getCenter(find.text(l10n.ssThemeMode)).dx,
      'DH layout mismatch',
    );
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
