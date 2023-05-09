library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzApp extends StatelessWidget {
  final Key? key;
  final String title;
  final Widget homeScreenWidget;

  /// [PlatformApp] wrapper with [EzConfig] theming
  EzApp({
    this.key,
    required this.title,
    required this.homeScreenWidget,
  }) : super(key: key);

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
      settings: PlatformSettingsData(iosUsesMaterialWidgets: true),
      builder: (context) => PlatformTheme(
        themeMode: initialTheme,
        materialLightTheme: materialLight,
        materialDarkTheme: materialDark,
        cupertinoLightTheme: cupertinoLight,
        cupertinoDarkTheme: cupertinoDark,
        builder: (context) => PlatformApp(
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
          ],
          title: title,
          home: homeScreenWidget,
        ),
      ),
    );
  }
}
