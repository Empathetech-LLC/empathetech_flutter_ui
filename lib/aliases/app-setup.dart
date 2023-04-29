library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Quickly setup a standard [PlatformProvider]
PlatformProvider ezAppProvider({required PlatformApp app}) {
  return PlatformProvider(
    settings: PlatformSettingsData(iosUsesMaterialWidgets: true),
    builder: (context) => app,
  );
}

/// Quickly setup a standard [PlatformApp]
PlatformApp ezApp({
  required String title,
  required Widget homeScreenWidget,
}) {
  return PlatformApp(
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
