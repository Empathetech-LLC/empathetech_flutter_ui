/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// For integration testing
/// Test [EzThemeModeSwitch]
Future<void> testTMSwitch(WidgetTester tester) async {
  ezLog('\nTesting theme mode setting');

  // Verify  layout
  if (EzConfig.isLefty) {
    assert(
      tester.getCenter(find.byType(DropdownMenu<ThemeMode>)).dx <
          tester.getCenter(find.text(EzConfig.l10n.ssThemeMode)).dx,
      'DH layout mismatch',
    );
  } else {
    assert(
      tester.getCenter(find.byType(DropdownMenu<ThemeMode>)).dx >
          tester.getCenter(find.text(EzConfig.l10n.ssThemeMode)).dx,
      'DH layout mismatch',
    );
  }

  // Activate light theme
  ezLog('Light');
  await ezTouch(tester, find.byType(DropdownMenu<ThemeMode>));
  await ezTouchText(tester, EzConfig.l10n.gLight);

  // Activate system theme
  ezLog('System');
  await ezTouch(tester, find.byType(DropdownMenu<ThemeMode>));
  await ezTouchText(tester, EzConfig.l10n.gSystem);

  // Activate dark theme
  ezLog('Dark');
  await ezTouch(tester, find.byType(DropdownMenu<ThemeMode>));
  await ezTouchText(tester, EzConfig.l10n.gDark);
}
