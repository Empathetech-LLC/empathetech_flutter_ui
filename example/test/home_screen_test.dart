import './test_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

void main() {
  testWidgets('Click all the home screen things', (WidgetTester tester) async {
    await tester.runAsync(() async {
      final Widget testApp = await testOpenUI(prefs: empathetechConfig);

      await tester.pumpWidget(testApp);
    });
  });
}
