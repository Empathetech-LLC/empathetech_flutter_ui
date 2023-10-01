import 'screens/screens.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Most apps need this
  // https://stackoverflow.com/questions/63873338/
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize EzConfig
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  EzConfig(
    // your image paths for this app
    assetPaths: [],

    preferences: prefs,

    // your brand colors, custom styling, etc
    customDefaults: {},
  );

  // Set device orientation(s)
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const EFUIExample());
}

// Initialize a path based router for web apps
// Or any other app that you want to enable deep linking
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
    return EzAppProvider(
      app: EzApp(
        title: 'EFUI example',
        routerConfig: _router,
      ),
    );
  }
}
