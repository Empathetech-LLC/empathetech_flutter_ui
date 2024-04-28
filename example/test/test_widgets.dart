import 'package:example/screens/screens.dart';
import 'package:example/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

Widget testOpenUI({TargetPlatform initialPlatform = TargetPlatform.android}) {
  final GoRouter _router = GoRouter(
    initialLocation: homePath,
    routes: <RouteBase>[
      GoRoute(
        path: homePath,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: textSettingsPath,
            builder: (BuildContext context, GoRouterState state) {
              return const TextSettingsScreen();
            },
          ),
          GoRoute(
            path: layoutSettingsPath,
            builder: (BuildContext context, GoRouterState state) {
              return const LayoutSettingsScreen();
            },
          ),
          GoRoute(
            path: colorSettingsPath,
            builder: (BuildContext context, GoRouterState state) {
              return const ColorSettingsScreen();
            },
          ),
          GoRoute(
            path: imageSettingsPath,
            builder: (BuildContext context, GoRouterState state) {
              return const ImageSettingsScreen();
            },
          ),
        ],
      ),
    ],
  );

  return EzAppProvider(
    scaffoldMessengerKey: scaffoldMessengerKey,
    app: PlatformApp.router(
      debugShowCheckedModeBanner: false,

      // Language handlers
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>{
        LocaleNamesLocalizationsDelegate(),
        ...EFUILang.localizationsDelegates,
      },

      // Supported languages
      supportedLocales: EFUILang.supportedLocales,

      // Current language
      locale: EzConfig.getLocale(),

      title: 'Open UI Test',
      routerConfig: _router,
    ),
    initialPlatform: initialPlatform,
  );
}
