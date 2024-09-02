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
Future<void> validateText({
  required WidgetTester tester,
  Matcher matcher = findsOneWidget,
  required String text,
}) async {
  final Finder textFinder = find.text(text);
  expect(textFinder, matcher);
  await tester.ensureVisible(textFinder);
}

/// Find widget and ensure visibility
Future<void> validateWidget({
  required WidgetTester tester,
  required Type widgetType,
  Matcher matcher = findsOneWidget,
}) async {
  final Finder widgetFinder = find.byType(widgetType);
  expect(widgetFinder, matcher);
  await tester.ensureVisible(widgetFinder);
}

/// Find, touch, and settle a touch-point
Future<void> touch({
  required WidgetTester tester,
  required Finder finder,
}) async {
  await tester.ensureVisible(finder);
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

/// Find and touch the button whose [Tooltip] is [l10n.gBack]
Future<void> goBack({
  required WidgetTester tester,
  required EFUILang l10n,
}) async {
  final Finder backButton = find.byTooltip(l10n.gBack);
  expect(backButton, findsOneWidget);

  await tester.ensureVisible(backButton);
  await tester.tap(backButton);
  await tester.pumpAndSettle();
}

/// Tap the top of the screen to dismiss a dialog
Future<void> dismissTap(WidgetTester tester) async {
  final Size size = tester.view.physicalSize;
  await tester.tapAt(Offset(size.width / 3, 1));
  await tester.pumpAndSettle();
}
