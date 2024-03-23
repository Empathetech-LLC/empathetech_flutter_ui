/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzAppProvider extends StatelessWidget {
  final Widget Function(BuildContext)? builder;
  final TargetPlatform? initialPlatform;
  final PlatformSettingsData? settings;

  /// Optionally provide a [PlatformApp] that will be wrapped in the Empathetech theme [builder]
  final PlatformApp? app;

  /// [PlatformProvider] wrapper with [ezThemeData] defaults
  EzAppProvider({
    super.key,
    this.builder,
    this.initialPlatform,
    this.settings,
    this.app,
  }) : assert(
          (builder == null) != (app == null),
          'Either builder or app should be provided, but not both.',
        );

  // Gather the theme data //

  late final bool? _savedDark = EzConfig.get(isDarkThemeKey);

  late final ThemeMode _initialTheme = (_savedDark == null)
      ? ThemeMode.system
      : (_savedDark == true)
          ? ThemeMode.dark
          : ThemeMode.light;

  late final ThemeData _materialLight = ezThemeData(Brightness.light);
  late final ThemeData _materialDark = ezThemeData(Brightness.dark);

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return PlatformProvider(
      builder: builder ??
          (BuildContext context) => PlatformTheme(
                builder: (BuildContext context) => app!,
                themeMode: _initialTheme,
                materialLightTheme: _materialLight,
                materialDarkTheme: _materialDark,
                cupertinoLightTheme: MaterialBasedCupertinoThemeData(
                  materialTheme: _materialLight,
                ),
                cupertinoDarkTheme: MaterialBasedCupertinoThemeData(
                  materialTheme: _materialDark,
                ),
                matchCupertinoSystemChromeBrightness: true,
              ),
      initialPlatform: initialPlatform,
      settings: settings ??
          PlatformSettingsData(
            iosUsesMaterialWidgets: true,
            iosUseZeroPaddingForAppbarPlatformIcon: true,
          ),
      key: key,
    );
  }
}
