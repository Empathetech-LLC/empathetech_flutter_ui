import 'open_ui_test.dart' as core;
import 'utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

const String name = 'Color settings screen';

void main() async {
  await core.runTestSuites(
    testSuites: <Function>[testSuite],
    screenNames: <String>[name],
  );
}

void testSuite({
  required String title,
  required Locale locale,
  required EFUILang l10n,
  required LocaleNames localeNames,
  Function? setup,
}) =>
    testWidgets(title, (WidgetTester tester) async {
      //// Run the tests ////

      setup?.call();

      // Load the app //

      final Widget testApp = testOpenUI(title: title, locale: locale);

      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      //// Test navigation ////

      final Finder colorSettingsButton = find.widgetWithText(
        ElevatedButton,
        l10n.csPageTitle,
      );

      expect(colorSettingsButton, findsOneWidget);
      await touch(tester, colorSettingsButton);
      await goBack(tester: tester, l10n: l10n);

      //// Test functionality ////
    });
