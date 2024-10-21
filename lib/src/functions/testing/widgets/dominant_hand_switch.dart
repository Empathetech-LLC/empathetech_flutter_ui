/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

/// For integration testing
/// Test [EzDominantHandSwitch]
Future<void> testDHSetting(
  WidgetTester tester, {
  required EFUILang l10n,
  required bool isLefty,
}) async {
  ezLog('\nTesting dominant hand setting');
  await touch(tester, find.byType(DropdownMenu<bool>).last);

  if (isLefty) {
    ezLog('Right hand layout');

    // Activate righty layout
    await touchText(tester, l10n.gRight);

    List<Widget> handButtonsChildren =
        (tester.widget(find.byType(Row).at(1)) as Row).children;

    expect(handButtonsChildren.length, 3);

    // Verify righty layout
    expect(handButtonsChildren[0], isA<Text>());
    expect(handButtonsChildren[1], isA<EzSpacer>());
    expect(handButtonsChildren[2], isA<DropdownMenu<bool>>());

    ezLog('Left hand layout');

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
    ezLog('Left hand layout');

    // Activate lefty layout
    await touchText(tester, l10n.gLeft);

    List<Widget> handButtonsChildren =
        (tester.widget(find.byType(Row).at(1)) as Row).children;

    expect(handButtonsChildren.length, 3);

    // Verify lefty layout
    expect(handButtonsChildren[0], isA<DropdownMenu<bool>>());
    expect(handButtonsChildren[1], isA<EzSpacer>());
    expect(handButtonsChildren[2], isA<Text>());

    ezLog('Right hand layout');

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
}
