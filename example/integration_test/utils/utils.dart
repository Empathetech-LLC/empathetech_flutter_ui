/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

/// Wait for a desired number of [seconds]
Future<void> pause(int seconds) =>
    Future<void>.delayed(Duration(seconds: seconds));

/// Find text and ensure visibility
Future<void> validateText(
  WidgetTester tester,
  String text, {
  Matcher matcher = findsOneWidget,
}) async {
  final Finder textFinder = find.text(text);
  expect(textFinder, matcher);
  await tester.ensureVisible(textFinder);
}

/// Find widget and ensure visibility
Future<void> validateWidget(
  WidgetTester tester,
  Type widgetType, {
  Matcher matcher = findsOneWidget,
}) async {
  final Finder widgetFinder = find.byType(widgetType);
  expect(widgetFinder, matcher);
  await tester.ensureVisible(widgetFinder);
}

/// Find, touch, and settle a target
Future<void> touch(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.tapAt(tester.getCenter(finder));
  await tester.pumpAndSettle();
}

/// Find, touch, hold, and settle a target
Future<void> hold(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.longPressAt(tester.getCenter(finder));
  await tester.pumpAndSettle();
}

/// Find, touch, and settle a text target
Future<void> touchText(WidgetTester tester, String text) async {
  final Finder finder = find.text(text).last;
  await tester.ensureVisible(finder);
  await tester.tapAt(tester.getCenter(finder));
  await tester.pumpAndSettle();
}

/// Find, touch, hold, and settle a text target
Future<void> holdText(WidgetTester tester, String text) async {
  final Finder finder = find.text(text).last;
  await tester.ensureVisible(finder);
  await tester.longPressAt(tester.getCenter(finder));
  await tester.pumpAndSettle();
}

/// Take the [finder] and
/// Slide to the right, then
/// Slide to the left
Future<void> chaChaNow(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.timedDrag(
    finder,
    const Offset(100, 0),
    const Duration(milliseconds: 500),
  );
  await tester.pumpAndSettle();

  await tester.ensureVisible(finder);
  await tester.timedDrag(
    finder,
    const Offset(-100, 0),
    const Duration(milliseconds: 500),
  );
  await tester.pumpAndSettle();
}

/// Find and touch the button whose [Tooltip] is [l10n.gBack]
Future<void> goBack(WidgetTester tester, EFUILang l10n) async {
  final Finder backButton = find.byTooltip(l10n.gBack);

  await tester.ensureVisible(backButton);
  await tester.tap(backButton);
  await tester.pumpAndSettle();
}

/// Tap the top of the screen to dismiss a dialog
Future<void> dismissTap(WidgetTester tester) async {
  await tester.tapAt(const Offset(1, 1));
  await tester.pumpAndSettle();
}

/// Dismiss modal (aka [BottomSheet])
Future<void> dismissModal(WidgetTester tester) async {
  await tester.drag(find.byType(BottomSheet).last, const Offset(0, -100));
  await tester.pumpAndSettle();
}
