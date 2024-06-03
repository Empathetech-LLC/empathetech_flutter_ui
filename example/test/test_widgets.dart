import 'package:example/main.dart';
import 'package:example/utils/export.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

Future<Widget> testOpenUI({
  required Map<String, Object> prefs,
  TargetPlatform platform = TargetPlatform.android,
}) async {
  SharedPreferences.setMockInitialValues(prefs);
  final SharedPreferences preferences = await SharedPreferences.getInstance();

  EzConfig.init(
    preferences: preferences,
    assetPaths: <String>{},
    defaults: prefs,
  );

  return EzAppProvider(
    initialPlatform: platform,
    app: PlatformApp.router(
      // Production ready!
      debugShowCheckedModeBanner: false,

      // Language handlers
      localizationsDelegates: <LocalizationsDelegate<dynamic>>{
        const LocaleNamesLocalizationsDelegate(),
        ...EFUILang.localizationsDelegates,
        OpenUIFeedbackLocalizationsDelegate(),
      },

      // Supported languages
      supportedLocales: EFUILang.supportedLocales,

      // Current language
      locale: EzConfig.getLocale(),

      title: appTitle,
      routerConfig: router,
    ),
  );
}
