/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzAppProvider extends StatelessWidget {
  final Key? key;

  /// Optionally provide a starting platform (Material/Cupertino)
  final TargetPlatform? initialPlatform;

  /// App to be provided
  /// Pairs best with [EzApp]
  final PlatformApp app;

  /// [PlatformProvider] wrapper with [EzConfig] theming
  /// It's recommended to provide an [EzApp] for [app]
  /// But any [PlatformApp] will work
  EzAppProvider({
    this.key,
    this.initialPlatform,
    required this.app,
  });

  // Gather theme data //

  final bool? savedLight = EzConfig.instance.preferences.getBool(isLightKey);

  final ThemeData materialLight = empathetechLightTheme();
  final ThemeData materialDark = empathetechDarkTheme();

  @override
  Widget build(BuildContext context) {
    // Build theme //

    final ThemeMode initialTheme = (savedLight == null)
        ? ThemeMode.system
        : (savedLight == true)
            ? ThemeMode.light
            : ThemeMode.dark;

    return PlatformProvider(
      key: key,
      settings: PlatformSettingsData(
        iosUsesMaterialWidgets: true,
        iosUseZeroPaddingForAppbarPlatformIcon: true,
      ),
      builder: (context) => PlatformTheme(
        themeMode: initialTheme,
        materialLightTheme: materialLight,
        materialDarkTheme: materialDark,
        cupertinoLightTheme: MaterialBasedCupertinoThemeData(materialTheme: materialLight),
        cupertinoDarkTheme: MaterialBasedCupertinoThemeData(materialTheme: materialDark),
        matchCupertinoSystemChromeBrightness: true,
        builder: (context) => app,
      ),
      initialPlatform: initialPlatform,
    );
  }
}
