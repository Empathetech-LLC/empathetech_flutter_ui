/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// For integration testing
/// Test [EzDominantHandSwitch]
Future<void> testDHSetting(WidgetTester tester) async {
  ezLog('\nTesting dominant hand setting');
  await ezTouch(tester, find.byType(DropdownMenu<bool>).last);

  if (EzConfig.isLefty) {
    ezLog('Right hand layout');

    // Activate righty layout
    await ezTouchText(tester, EzConfig.l10n.gRight);

    List<Widget> handButtonsChildren =
        (tester.widget(find.byType(Row).at(1)) as Row).children;

    expect(handButtonsChildren.length, 3);

    // Verify righty layout
    expect(handButtonsChildren[0], isA<EzTextBackground>());
    expect(handButtonsChildren[1], isA<EzSpacer>());
    expect(handButtonsChildren[2], isA<DropdownMenu<bool>>());

    ezLog('Left hand layout');

    // Activate lefty layout
    await ezTouch(tester, find.byType(DropdownMenu<bool>).last);
    await ezTouchText(tester, EzConfig.l10n.gLeft);

    // Verify lefty layout
    handButtonsChildren =
        (tester.widget(find.byType(Row).at(1)) as Row).children;

    expect(handButtonsChildren[0], isA<DropdownMenu<bool>>());
    expect(handButtonsChildren[1], isA<EzSpacer>());
    expect(handButtonsChildren[2], isA<EzTextBackground>());
  } else {
    ezLog('Left hand layout');

    // Activate lefty layout
    await ezTouchText(tester, EzConfig.l10n.gLeft);

    List<Widget> handButtonsChildren =
        (tester.widget(find.byType(Row).at(1)) as Row).children;

    expect(handButtonsChildren.length, 3);

    // Verify lefty layout
    expect(handButtonsChildren[0], isA<DropdownMenu<bool>>());
    expect(handButtonsChildren[1], isA<EzSpacer>());
    expect(handButtonsChildren[2], isA<EzTextBackground>());

    ezLog('Right hand layout');

    // Activate righty layout
    await ezTouch(tester, find.byType(DropdownMenu<bool>).last);
    await ezTouchText(tester, EzConfig.l10n.gRight);

    // Verify righty layout
    handButtonsChildren =
        (tester.widget(find.byType(Row).at(1)) as Row).children;

    expect(handButtonsChildren[0], isA<EzTextBackground>());
    expect(handButtonsChildren[1], isA<EzSpacer>());
    expect(handButtonsChildren[2], isA<DropdownMenu<bool>>());
  }
}
