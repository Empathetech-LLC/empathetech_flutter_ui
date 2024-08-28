/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:example/main.dart';
import 'package:example/utils/export.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

Widget testOpenUI({
  required String title,
  required Locale locale,
}) =>
    EzAppProvider(
      key: ValueKey<String>(title),
      app: PlatformApp.router(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        localizationsDelegates: <LocalizationsDelegate<dynamic>>{
          const LocaleNamesLocalizationsDelegate(),
          ...EFUILang.localizationsDelegates,
          EmpathetechFeedbackLocalizationsDelegate(),
        },
        supportedLocales: EFUILang.supportedLocales,
        locale: locale,
        routerConfig: router,
      ),
    );

/// Find text and ensure visibility
Future<void> validateText({
  required WidgetTester tester,
  Matcher matcher = findsOneWidget,
  required String finder,
}) async {
  final Finder textFinder = find.text(finder);
  expect(textFinder, matcher);
  await tester.ensureVisible(textFinder);
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
