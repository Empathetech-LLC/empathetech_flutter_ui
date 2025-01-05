/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// [debugPrint] rename
/// 100% so I can search for [debugPrint] in my code to find the temporary ones
void ezLog(String message, {int? wrapWidth, ValueNotifier<String>? buffer}) {
  debugPrint(message, wrapWidth: wrapWidth);
  if (buffer != null) buffer.value += ('$message\n');
}

/// For integration tests
/// Wait for a desired number of [seconds]
Future<void> pause(int seconds) =>
    Future<void>.delayed(Duration(seconds: seconds));

/// For integration tests
/// expect([finder], [matcher]) and ensure visibility
Future<void> validate(
  WidgetTester tester,
  Finder finder, {
  Matcher matcher = findsOneWidget,
}) async {
  expect(finder, matcher);
  await tester.ensureVisible(finder);
}

/// For integration tests
/// Find text and ensure visibility
Future<void> validateText(
  WidgetTester tester,
  String text, {
  bool findRichText = false,
  bool skipOffstage = false,
  Matcher matcher = findsOneWidget,
}) async {
  final Finder textFinder = find.text(
    text,
    findRichText: findRichText,
    skipOffstage: skipOffstage,
  );

  expect(textFinder, matcher);
  await tester.ensureVisible(textFinder);
}

/// For integration tests
/// Find widget and ensure visibility
Future<void> validateWidget(
  WidgetTester tester,
  Type widgetType, {
  Matcher matcher = findsOneWidget,
  bool skipOffstage = false,
}) async {
  final Finder widgetFinder = find.byType(
    widgetType,
    skipOffstage: skipOffstage,
  );

  expect(widgetFinder, matcher);
  await tester.ensureVisible(widgetFinder);
}

/// For integration tests
/// Find, touch, and settle a target
Future<void> touch(
  WidgetTester tester,
  Finder finder, {
  bool warnIfMissed = false,
}) async {
  await tester.ensureVisible(finder);
  await tester.tapAt(tester.getCenter(finder, warnIfMissed: warnIfMissed));
  await tester.pumpAndSettle();
}

/// For integration tests
/// Find, touch, and settle a text target
Future<void> touchText(
  WidgetTester tester,
  String text, {
  bool findRichText = false,
  bool skipOffstage = false,
  bool warnIfMissed = false,
}) async {
  final Finder finder = find
      .text(text, findRichText: findRichText, skipOffstage: skipOffstage)
      .last;

  await tester.ensureVisible(finder);
  await tester.tapAt(tester.getCenter(finder, warnIfMissed: warnIfMissed));
  await tester.pumpAndSettle();
}

/// For integration tests
/// Find, touch, and settle a widget target
Future<void> touchWidget(
  WidgetTester tester,
  Type widgetType, {
  bool skipOffstage = false,
  bool warnIfMissed = false,
}) async {
  final Finder finder =
      find.byType(widgetType, skipOffstage: skipOffstage).last;

  await tester.ensureVisible(finder);
  await tester.tapAt(tester.getCenter(finder, warnIfMissed: warnIfMissed));
  await tester.pumpAndSettle();
}

/// For integration tests
/// Find, touch, hold, and settle a target
Future<void> hold(
  WidgetTester tester,
  Finder finder, {
  bool warnIfMissed = false,
}) async {
  await tester.ensureVisible(finder);
  await tester.longPressAt(tester.getCenter(
    finder,
    warnIfMissed: warnIfMissed,
  ));
  await tester.pumpAndSettle();
}

/// For integration tests
/// Find, touch, hold, and settle a text target
Future<void> holdText(
  WidgetTester tester,
  String text, {
  bool warnIfMissed = false,
}) async {
  final Finder finder = find.text(text).last;
  await tester.ensureVisible(finder);
  await tester.longPressAt(tester.getCenter(
    finder,
    warnIfMissed: warnIfMissed,
  ));
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
Future<void> goBack(
  WidgetTester tester,
  String back, {
  bool warnIfMissed = false,
}) async {
  final Finder backButton = find.byTooltip(back);

  await tester.ensureVisible(backButton);
  await tester.tapAt(tester.getCenter(backButton, warnIfMissed: warnIfMissed));
  await tester.pumpAndSettle();
}

/// For integration tests
/// [WidgetTester.tapAt] the [offset] to dismiss a dialog/modal/etc
Future<void> dismissTap(
  WidgetTester tester, {
  Offset offset = const Offset(1, 1),
}) async {
  await tester.tapAt(offset);
  await tester.pumpAndSettle();
}
