/// empathetech_flutter_ui
/// Copyright (c) 2023 Empathetech LLC. All rights reserved.
/// See LICENSE for distribution and usage details.
library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzApp extends StatelessWidget {
  final Key? key;
  final String title;
  final Widget? homeScreenWidget;
  final GoRouter? routerConfig;

  /// [PlatformProvider] wrapper with [EzConfig] theming
  /// Either provide a [homeScreenWidget] for traditional navigation
  /// or a [routerConfig] to enable deep linking
  EzApp({
    this.key,
    required this.title,
    this.homeScreenWidget,
    this.routerConfig,
  }) : assert(routerConfig != null || homeScreenWidget != null);

  @override
  Widget build(BuildContext context) {
    final bool? savedLight = EzConfig.instance.preferences.getBool(isLightKey);

    final ThemeMode initialTheme = (savedLight == null)
        ? ThemeMode.system
        : (savedLight == true)
            ? ThemeMode.light
            : ThemeMode.dark;

    final ThemeData materialLight = ezThemeData(light: true);
    final ThemeData materialDark = ezThemeData(light: false);

    final CupertinoThemeData cupertinoLight =
        MaterialBasedCupertinoThemeData(materialTheme: materialLight);

    // Cupertino Dark requires some customization
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
      settings: PlatformSettingsData(iosUsesMaterialWidgets: true),
      builder: (context) => PlatformTheme(
        themeMode: initialTheme,
        materialLightTheme: materialLight,
        materialDarkTheme: materialDark,
        cupertinoLightTheme: cupertinoLight,
        cupertinoDarkTheme: cupertinoDark,
        builder: (context) => (routerConfig == null)
            ? PlatformApp(
                debugShowCheckedModeBanner: false,
                title: title,
                home: homeScreenWidget,
              )
            : PlatformApp.router(
                debugShowCheckedModeBanner: false,
                title: title,
                routerConfig: routerConfig,
              ),
      ),
    );
  }
}
