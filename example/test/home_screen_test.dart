import './test_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

void main() {
  testWidgets('Click all the home screen things', (WidgetTester tester) async {
    await tester.runAsync(() async {
      final EFUILang enText = await EFUILang.delegate.load(const Locale('en'));

      final Widget testApp = await testOpenUI(prefs: <String, Object>{
        ...empathetechConfig,
        localeKey: <String>['en'],
      });

      await tester.pumpWidget(testApp);

      // Navigation //

      debugPrint('Navigating to Text settings');

      final Finder textSettingsButton = find.text(enText.tsPageTitle);
      await tester.tap(textSettingsButton);
      await tester.pumpAndSettle();

      debugPrint('Navigating to Layout settings');

      debugPrint('Navigating to Color settings');

      debugPrint('Navigating to Image settings');

      // Functionality //

      debugPrint('Toggling Dominant hand setting');

      debugPrint('Selecting each theme mode');

      debugPrint('Toggling Spanish language');

      debugPrint('Selecting reset all');
    });
  });
}
