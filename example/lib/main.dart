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

  // Spin up the theme factory!
  EzConfig(
    // Paths to any locally stored images the app uses
    assetPaths: {},

    preferences: prefs,

    // Your brand colors, custom styling, etc
    customDefaults: {},
  );

  // Set device orientation(s)
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Run the app!
  runApp(const EFUIExample());
}

// Initialize a path based router for web-enabled apps
// Or any other app that requires deep linking
// https://docs.flutter.dev/ui/navigation/deep-linking
final GoRouter _router = GoRouter(
  initialLocation: homeRoute,
  routes: <RouteBase>[
    GoRoute(
      name: homeRoute,
      path: homeRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          name: imageSettingsRoute,
          path: imageSettingsRoute,
          builder: (BuildContext context, GoRouterState state) {
            return const ImageSettingsScreen();
          },
        ),
        GoRoute(
          name: colorSettingsRoute,
          path: colorSettingsRoute,
          builder: (BuildContext context, GoRouterState state) {
            return const ColorSettingsScreen();
          },
        ),
        GoRoute(
          name: styleSettingsRoute,
          path: styleSettingsRoute,
          builder: (BuildContext context, GoRouterState state) {
            return const StyleSettingsScreen();
          },
        ),
      ],
    ),
  ],
);

class EFUIExample extends StatelessWidget {
  final Key? key;

  const EFUIExample({this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String>? localeData = EzConfig.get(localeKey);

    return EzAppProvider(
      app: PlatformApp.router(
        // Production ready!
        debugShowCheckedModeBanner: false,

        // Language handlers
        localizationsDelegates: [
          LocaleNamesLocalizationsDelegate(),
          ...EFUILang.localizationsDelegates,
        ],

        // Supported languages
        supportedLocales: EFUILang.supportedLocales,

        // Current language
        locale: (localeData == null)
            ? null
            : Locale(
                localeData[0],
                localeData.length > 1 ? localeData[1] : null,
              ),

        title: "Empathetech Flutter UI",
        routerConfig: _router,
      ),
    );
  }
}
