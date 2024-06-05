import 'package:example/main.dart';
import 'package:example/utils/export.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

Future<void> goBack(WidgetTester tester) async {
  final Finder backButton = find.byIcon(Icons.arrow_back);
  expect(backButton, findsOneWidget);
  await tester.ensureVisible(backButton);
  await tester.tap(backButton);
  await tester.pumpAndSettle();
}

/// Find, touch, and settle a touch-point
Future<void> touch(WidgetTester tester, Finder toFind) async {
  await tester.ensureVisible(toFind);
  await tester.tap(toFind);
  await tester.pumpAndSettle();
}

Widget testOpenUI({
  required String title,
  required Locale locale,
  TargetPlatform platform = TargetPlatform.android,
}) =>
    EzAppProvider(
      key: ValueKey<String>(title),
      initialPlatform: platform,
      app: PlatformApp.router(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        localizationsDelegates: <LocalizationsDelegate<dynamic>>{
          const LocaleNamesLocalizationsDelegate(),
          ...EFUILang.localizationsDelegates,
          OpenUIFeedbackLocalizationsDelegate(),
        },
        supportedLocales: EFUILang.supportedLocales,
        locale: locale,
        routerConfig: router,
      ),
    );
