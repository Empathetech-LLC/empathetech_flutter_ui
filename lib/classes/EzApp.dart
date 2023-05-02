library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzApp extends PlatformApp {
  final String title;
  final Widget homeScreenWidget;

  /// [PlatformApp] wrapper with [EzConfig] theming
  EzApp({
    required this.title,
    required this.homeScreenWidget,
  }) : super(
          title: title,
          debugShowCheckedModeBanner: false,
          routes: {'/': (context) => homeScreenWidget},
          material: (context, platform) => MaterialAppData(
            theme: ezLightThemeData(),
            darkTheme: ezDarkThemeData(),
            themeMode: EzConfig.themeMode,
          ),
        );
}
