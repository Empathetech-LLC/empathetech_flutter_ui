import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> goBack(WidgetTester tester) async {
  final Finder backButton = find.byIcon(Icons.arrow_back);
  expect(backButton, findsOneWidget);
  await tester.tap(backButton);
  await tester.pumpAndSettle();
}

/// Find, touch, and settle a touch-point
Future<void> touch(WidgetTester tester, Finder toFind) async {
  await tester.ensureVisible(toFind);
  await tester.tap(toFind);
  await tester.pumpAndSettle();
}
