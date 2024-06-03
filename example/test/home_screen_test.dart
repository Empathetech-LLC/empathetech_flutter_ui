import 'test_widgets.dart';

import 'package:example/screens/export.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

void main() {
  testWidgets('Click all the home screen things', (WidgetTester tester) async {
    await tester.runAsync(() async {
      // Load the app //

      final EFUILang enText = await EFUILang.delegate.load(const Locale('en'));

      final Widget testApp = await testOpenUI(prefs: <String, Object>{
        ...empathetechConfig,
        localeKey: <String>['en'],
      });

      debugPrint('Loading Open UI');

      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      expect(find.byType(PlatformApp), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);

      // Navigation //

      debugPrint('Navigating to Text settings');

      final Finder textSettingsButton = find.widgetWithText(
        ElevatedButton,
        enText.tsPageTitle,
      );
      expect(textSettingsButton, findsOneWidget);

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
