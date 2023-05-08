library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzApp extends StatelessWidget {
  final Key? key;
  final String title;
  final Widget homeScreenWidget;
  final AdaptiveThemeMode? initialTheme;

  /// [PlatformApp] wrapper with [EzConfig] theming
  EzApp({
    this.key,
    required this.title,
    required this.homeScreenWidget,
    this.initialTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ezThemeData(light: true),
      dark: ezThemeData(light: false),
      initial: initialTheme ?? AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => PlatformApp(
        title: title,
        debugShowCheckedModeBanner: false,
        routes: {'/': (context) => homeScreenWidget},
        material: (context, platform) => MaterialAppData(
          theme: theme,
          darkTheme: darkTheme,
        ),
      ),
    );
  }
}
