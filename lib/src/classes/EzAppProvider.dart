/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzAppProvider extends StatelessWidget {
  final Key? key;

  /// Optionally provide a starting platform (Material/Cupertino)
  final TargetPlatform? initialPlatform;

  /// App to be provided
  /// Shout-out [EzApp]!
  final PlatformApp app;

  /// [PlatformProvider] wrapper with [EzConfig] theming
  /// It's recommended to provide an [EzApp] for [app]
  /// But any [PlatformApp] will work
  EzAppProvider({
    this.key,
    this.initialPlatform,
    required this.app,
  });

  // Gateher theme data //

  final bool? savedLight = EzConfig.instance.preferences.getBool(isLightKey);

  final ThemeData materialLight = ezThemeData(light: true);
  final ThemeData materialDark = ezThemeData(light: false);

  @override
  Widget build(BuildContext context) {
    // Build theme //

    final ThemeMode initialTheme = (savedLight == null)
        ? ThemeMode.system
        : (savedLight == true)
            ? ThemeMode.light
            : ThemeMode.dark;

    final CupertinoThemeData cupertinoLight =
        MaterialBasedCupertinoThemeData(materialTheme: materialLight);

    // Cupertino Dark requires some customization
    // Guide taken from...
    // https://github.com/stryder-dev/flutter_platform_widgets/wiki/Theming
    const darkDefaultCupertinoTheme =
        CupertinoThemeData(brightness: Brightness.dark);

    final CupertinoThemeData cupertinoDark = MaterialBasedCupertinoThemeData(
      materialTheme: materialDark.copyWith(
        cupertinoOverrideTheme: CupertinoThemeData(
          brightness: Brightness.dark,
          barBackgroundColor: darkDefaultCupertinoTheme.barBackgroundColor,
          textTheme: CupertinoTextThemeData(
            navActionTextStyle: darkDefaultCupertinoTheme
                .textTheme.navActionTextStyle
                .copyWith(color: const Color(0xF0F9F9F9)),
            navLargeTitleTextStyle: darkDefaultCupertinoTheme
                .textTheme.navLargeTitleTextStyle
                .copyWith(color: const Color(0xF0F9F9F9)),
          ),
        ),
      ),
    );

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
        cupertinoLightTheme: cupertinoLight,
        cupertinoDarkTheme: cupertinoDark,
        matchCupertinoSystemChromeBrightness: true,
        builder: (context) => app,
      ),
      initialPlatform: initialPlatform,
    );
  }
}
