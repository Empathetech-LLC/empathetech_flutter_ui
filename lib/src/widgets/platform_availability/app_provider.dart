/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzAppProvider extends StatelessWidget {
  /// Optionally provide a [ScaffoldMessengerState] typed [GlobalKey]
  /// To track [SnackBar]s, [MaterialBanner]s, etc.
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  /// Provided to [PlatformProvider] with a [ScaffoldMessenger] layer
  final Widget app;

  /// Optional [PlatformTheme.materialDarkTheme] override
  /// Defaults to [ezThemeData] with [Brightness.dark]
  final ThemeData? darkTheme;

  /// Optional [PlatformTheme.materialLightTheme] override
  /// Defaults to [ezThemeData] with [Brightness.light]
  final ThemeData? lightTheme;

  /// [PlatformProvider.initialPlatform] passthrough
  final TargetPlatform? initialPlatform;

  /// [PlatformProvider.settings] passthrough
  final PlatformSettingsData? settings;

  /// [PlatformProvider] wrapper with [ezThemeData] defaults
  EzAppProvider({
    super.key,
    this.scaffoldMessengerKey,
    required this.app,
    this.darkTheme,
    this.lightTheme,
    this.initialPlatform,
    this.settings,
  });

  // Gather the theme data //

  late final bool? _savedDark = EzConfig.get(isDarkThemeKey);

  late final ThemeMode _initialTheme = (_savedDark == null)
      ? ThemeMode.system
      : (_savedDark == true)
          ? ThemeMode.dark
          : ThemeMode.light;

  late final ThemeData _materialDark =
      darkTheme ?? ezThemeData(Brightness.dark);
  late final ThemeData _materialLight =
      lightTheme ?? ezThemeData(Brightness.light);

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return PlatformProvider(
      builder: (_) => PlatformTheme(
        builder: (_) => ScaffoldMessenger(
          key: scaffoldMessengerKey,
          child: app,
        ),
        themeMode: _initialTheme,
        materialLightTheme: _materialLight,
        materialDarkTheme: _materialDark,
        cupertinoLightTheme: MaterialBasedCupertinoThemeData(
          materialTheme: _materialLight,
        ).copyWith(
          primaryColor: _materialLight.colorScheme.secondary,
        ),
        cupertinoDarkTheme: MaterialBasedCupertinoThemeData(
          materialTheme: _materialDark,
        ).copyWith(
          primaryColor: _materialDark.colorScheme.secondary,
        ),
        matchCupertinoSystemChromeBrightness: true,
      ),
      initialPlatform: initialPlatform,
      settings: settings ??
          PlatformSettingsData(
            iosUsesMaterialWidgets: true,
            legacyIosUsesMaterialWidgets: true,
            iosUseZeroPaddingForAppbarPlatformIcon: true,
          ),
    );
  }
}
