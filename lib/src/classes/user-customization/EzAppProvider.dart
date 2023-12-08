/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzAppProvider extends StatelessWidget {
  final Key? key;
  final PlatformSettingsData? settings;
  final Widget Function(BuildContext)? builder;
  final TargetPlatform? initialPlatform;
  final PlatformApp app;

  /// [PlatformProvider] wrapper with [ezThemeData] defaults
  EzAppProvider({
    this.key,
    this.settings,
    this.builder,
    this.initialPlatform,
    required this.app,
  });

  // Gather the theme data //

  late final bool? _savedLight = EzConfig.getBool(isLightThemeKey);

  late final ThemeMode _initialTheme = (_savedLight == null)
      ? ThemeMode.system
      : (_savedLight == true)
          ? ThemeMode.light
          : ThemeMode.dark;

  late final ThemeData _materialLight = ezThemeData(Brightness.light);
  late final ThemeData _materialDark = ezThemeData(Brightness.dark);

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return PlatformProvider(
      key: key,
      settings: settings ??
          PlatformSettingsData(
            iosUsesMaterialWidgets: true,
            iosUseZeroPaddingForAppbarPlatformIcon: true,
          ),
      builder: builder ??
          (context) => PlatformTheme(
                builder: (context) => app,
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
    );
  }
}
