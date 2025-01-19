/* empathetech_flutter_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzAppProvider extends StatelessWidget {
  /// Provided to [PlatformProvider] with a [ScaffoldMessenger] layer
  final Widget app;

  /// Optionally provide a [ScaffoldMessengerState] typed [GlobalKey]
  /// To track [SnackBar]s, [MaterialBanner]s, etc.
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  /// [PlatformProvider.initialPlatform] passthrough
  final TargetPlatform? initialPlatform;

  /// [PlatformProvider.settings] passthrough
  final PlatformSettingsData? settings;

  /// [PlatformProvider] wrapper with [ezThemeData] defaults
  EzAppProvider({
    super.key,
    this.scaffoldMessengerKey,
    required this.app,
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

  late final ThemeData _materialLight = ezThemeData(Brightness.light);
  late final ThemeData _materialDark = ezThemeData(Brightness.dark);

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
            legacyIosUsesMaterialWidgets: true,
            iosUseZeroPaddingForAppbarPlatformIcon: true,
          ),
    );
  }
}
