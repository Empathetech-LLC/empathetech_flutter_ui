/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// For integration tests
/// Wait for a desired number of [seconds]
Future<void> pause(int seconds) =>
    Future<void>.delayed(Duration(seconds: seconds));

/// For integration tests
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

/// For integration tests
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

/// For integration tests
/// Find, touch, and settle a target
Future<void> touch(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.tapAt(tester.getCenter(finder));
  await tester.pumpAndSettle();
}

/// For integration tests
/// Find, touch, hold, and settle a target
Future<void> hold(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.longPressAt(tester.getCenter(finder));
  await tester.pumpAndSettle();
}

/// For integration tests
/// Find, touch, and settle a text target
Future<void> touchText(WidgetTester tester, String text) async {
  final Finder finder = find.text(text).last;
  await tester.ensureVisible(finder);
  await tester.tapAt(tester.getCenter(finder));
  await tester.pumpAndSettle();
}

/// For integration tests
/// Find, touch, hold, and settle a text target
Future<void> holdText(WidgetTester tester, String text) async {
  final Finder finder = find.text(text).last;
  await tester.ensureVisible(finder);
  await tester.longPressAt(tester.getCenter(finder));
  await tester.pumpAndSettle();
}

/// For integration tests
/// Take the [finder] and
/// Slide to the left, then
/// Slide to the right...
Future<void> chaChaNow(
  WidgetTester tester,
  Finder finder, {
  Offset leftOffset = const Offset(-100, 0),
  Offset rightOffset = const Offset(100, 0),
}) async {
  await tester.ensureVisible(finder);
  await tester.timedDrag(
    finder,
    leftOffset,
    const Duration(milliseconds: 500),
  );
  await tester.pumpAndSettle();

  await tester.ensureVisible(finder);
  await tester.timedDrag(
    finder,
    rightOffset,
    const Duration(milliseconds: 500),
  );
  await tester.pumpAndSettle();
}

/// For integration tests
/// Find and touch the button whose [Tooltip] is [back]
Future<void> goBack(WidgetTester tester, String back) async {
  final Finder backButton = find.byTooltip(back);

  await tester.ensureVisible(backButton);
  await tester.tap(backButton);
  await tester.pumpAndSettle();
}

/// For integration tests
/// Tap at [offset] to dismiss a dialog/modal/etc
Future<void> dismissTap(
  WidgetTester tester, {
  Offset offset = const Offset(1, 1),
}) async {
  await tester.tapAt(offset);
  await tester.pumpAndSettle();
}
