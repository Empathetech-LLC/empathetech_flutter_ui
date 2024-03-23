import 'screens/screens.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

void main() async {
  // Most apps need this
  // https://stackoverflow.com/questions/63873338/
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize EzConfig //

  // Get a SharedPreferences instance to... share
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Make it so
  EzConfig.init(
    // Paths to any locally stored images the app uses
    assetPaths: <String>{},

    preferences: prefs,

    // Your brand colors, custom styling, etc
    defaults: empathetechConfig,
  );

  // Set device orientation(s)
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Run the app!
  runApp(const EFUIExample());
}

/// Initialize a path based router for web-enabled apps
/// Or any other app that requires deep linking
/// https://docs.flutter.dev/ui/navigation/deep-linking
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
          path: imageSettingsPath,
          builder: (BuildContext context, GoRouterState state) {
            return const ImageSettingsScreen();
          },
        ),
        GoRoute(
          path: colorSettingsPath,
          builder: (BuildContext context, GoRouterState state) {
            return const ColorSettingsScreen();
          },
        ),
        GoRoute(
          path: layoutSettingsPath,
          builder: (BuildContext context, GoRouterState state) {
            return const LayoutSettingsScreen();
          },
        ),
      ],
    ),
  ],
);

class EFUIExample extends StatelessWidget {
  const EFUIExample({super.key});

  @override
  Widget build(BuildContext context) {
    return EzAppProvider(
      app: PlatformApp.router(
        // Production ready!
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

        title: efuiL,
        routerConfig: _router,
      ),
    );
  }
}
