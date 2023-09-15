import 'screens/screens.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/semantics.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize EzConfig
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  EzConfig(assetPaths: [], preferences: prefs);

  // Set device orientations
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const ETechDotNet());
  SemanticsBinding.instance.ensureSemantics();
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      name: 'home',
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          name: 'color-settings',
          path: 'color-settings',
          builder: (BuildContext context, GoRouterState state) {
            return const ColorSettingsScreen();
          },
        ),
        GoRoute(
          name: 'style-settings',
          path: 'style-settings',
          builder: (BuildContext context, GoRouterState state) {
            return const StyleSettingsScreen();
          },
        ),
      ],
    ),
  ],
);

class ETechDotNet extends StatelessWidget {
  final Key? key;

  const ETechDotNet({this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EzApp(
      title: 'EFUI example',
      routerConfig: _router,
    );
  }
}
