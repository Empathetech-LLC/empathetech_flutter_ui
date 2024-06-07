import 'open_ui_test.dart';
import 'utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

const String name = 'Layout settings screen';

void main() async {
  await runTestSuites(
    testSuites: <Function>[testSuite],
    screenNames: <String>[name],
  );
}

void testSuite({
  required String title,
  required Locale locale,
  required EFUILang l10n,
  required LocaleNames localeNames,
  TargetPlatform platform = TargetPlatform.android,
  Size screenSize = const Size(430, 932), // Large phone (iPhone 14 Pro Max)
  Function? setup,
}) =>
    testWidgets(title, (WidgetTester tester) async {
      //// Run the tests ////

      // Setup the test environment //

      await tester.binding.setSurfaceSize(screenSize);

      setup?.call();

      // Load the app //

      final Widget testApp = testOpenUI(
        title: title,
        locale: locale,
        platform: platform,
      );

      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      //// Test navigation ////

      final Finder layoutSettingsButton = find.widgetWithText(
        ElevatedButton,
        l10n.lsPageTitle,
      );

      expect(layoutSettingsButton, findsOneWidget);
      await touch(tester, layoutSettingsButton);

      //// Test functionality ////
    });
