/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// [debugPrint] alias; for permanent logging
/// Reserving [debugPrint] for temporary logging makes them easier to remove when the time comes
/// Optionally provide a [prefix] to make log filtering easier (include spaces!)
/// Also supports logging to a [String] 'buffer' (aka [ValueNotifier])
void ezLog(
  String message, {
  String prefix = '',
  int? wrapWidth,
  ValueNotifier<String>? buffer,
}) {
  debugPrint(prefix + message, wrapWidth: wrapWidth);
  if (buffer != null) buffer.value += ('$message\n');
}

/// Wait for a desired number of [seconds]
Future<void> ezPause(int seconds) =>
    Future<void>.delayed(Duration(seconds: seconds));

/// For integration testing
/// expect([finder], [matcher]) and ensure visibility
Future<void> ezFind(
  WidgetTester tester,
  Finder finder, {
  Matcher matcher = findsOneWidget,
}) async {
  expect(finder, matcher);
  await tester.ensureVisible(finder);
}

/// For integration testing
/// Find text and ensure visibility
Future<void> ezFindText(
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

/// For integration testing
/// Find widget and ensure visibility
Future<void> ezFindWidget(
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

/// For integration testing
/// Ensure visibility of, tap at, and settle a [finder] target
Future<void> ezTouch(
  WidgetTester tester,
  Finder finder, {
  bool warnIfMissed = false,
}) async {
  await tester.ensureVisible(finder);
  await tester.tapAt(tester.getCenter(finder, warnIfMissed: warnIfMissed));
  await tester.pumpAndSettle();
}

/// For integration testing
/// Ensure visibility of, tap at, and settle a [text] target
Future<void> ezTouchText(
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

/// For integration testing
/// Ensure visibility of, tap at, and settle a [widgetType] target
Future<void> ezTouchWidget(
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

/// For integration testing
/// Ensure visibility of, long press at, and settle a [finder] target
Future<void> ezHold(
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

/// For integration testing
/// Ensure visibility of, long press at, and settle a [text] target
Future<void> ezHoldText(
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

/// For integration testing
/// Take the [finder] and
/// Slide to the left, then
/// Slide to the right...
Future<void> ezChaCha(
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

/// For integration testing
/// Find and touch the button whose [Tooltip] is [back]
Future<void> ezTapBack(
  WidgetTester tester,
  String back, {
  bool warnIfMissed = false,
}) async {
  final Finder backButton = find.byTooltip(back);

  await tester.ensureVisible(backButton);
  await tester.tapAt(tester.getCenter(backButton, warnIfMissed: warnIfMissed));
  await tester.pumpAndSettle();
}

/// For integration testing
/// [WidgetTester.tapAt] the [offset] to dismiss a dialog/modal/etc
Future<void> ezDismiss(
  WidgetTester tester, {
  Offset offset = const Offset(1, 1),
}) async {
  await tester.tapAt(offset);
  await tester.pumpAndSettle();
}
