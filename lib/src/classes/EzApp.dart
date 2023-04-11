library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

const String homeRoute = '/';

class EzApp extends PlatformProvider {
  final String appTitle;
  final Map<String, Widget Function(BuildContext)> routes;

  /// Quickly setup a [PlatformProvider] to pair with [EzConfig]
  EzApp({
    required this.appTitle,
    required this.routes,
  }) : super(
          builder: (context) => PlatformApp(
            debugShowCheckedModeBanner: false,
            title: appTitle,
            routes: routes,
            localizationsDelegates: <LocalizationsDelegate<dynamic>>[
              DefaultMaterialLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
            ],
            material: (context, platform) => materialAppTheme(),
            cupertino: (context, platform) => cupertinoAppTheme(),
          ),
          settings: PlatformSettingsData(iosUsesMaterialWidgets: true),
        );
}

/// Material (Android) [ThemeData] built from [EzConfig.prefs]
MaterialAppData materialAppTheme() {
  Color themeColor = Color(EzConfig.prefs[themeColorKey]);
  Color themeTextColor = Color(EzConfig.prefs[themeTextColorKey]);
  Color buttonColor = Color(EzConfig.prefs[buttonColorKey]);
  Color buttonTextColor = Color(EzConfig.prefs[buttonTextColorKey]);

  TextStyle dialogTitleText = getTextStyle(dialogTitleStyleKey);
  TextStyle dialogContentText = getTextStyle(dialogContentStyleKey);

  return MaterialAppData(
    theme: ThemeData(
      primaryColor: themeColor,

      // App bar
      appBarTheme: AppBarTheme(
        backgroundColor: themeColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: themeTextColor),
        titleTextStyle: getTextStyle(titleStyleKey),
      ),

      // Nav bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: themeColor,
        selectedItemColor: buttonColor,
        selectedIconTheme: IconThemeData(color: buttonColor),
        unselectedItemColor: themeTextColor,
        unselectedIconTheme: IconThemeData(color: themeTextColor),
      ),

      // Text
      textTheme: materialTextTheme(),
      primaryTextTheme: materialTextTheme(),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: themeTextColor,
        selectionColor: themeColor,
        selectionHandleColor: buttonColor,
      ),
      hintColor: themeTextColor,

      // Icons
      iconTheme: IconThemeData(color: themeTextColor),

      // Sliders
      sliderTheme: SliderThemeData(
        thumbColor: buttonColor,
        disabledThumbColor: themeColor,
        overlayColor: buttonColor,
        activeTrackColor: buttonColor,
        activeTickMarkColor: buttonTextColor,
        inactiveTrackColor: themeColor,
        inactiveTickMarkColor: themeTextColor,
        valueIndicatorTextStyle: dialogContentText,
        overlayShape: SliderComponentShape.noOverlay,
      ),

      // Dialogs
      dialogTheme: DialogTheme(
        backgroundColor: themeColor,
        iconColor: themeTextColor,
        alignment: Alignment.center,
        titleTextStyle: dialogTitleText,
        contentTextStyle: dialogContentText,
      ),
    ),
  );
}

/// (iOS) [CupertinoAppData] data built [from] the passed in [MaterialAppData]
CupertinoAppData cupertinoAppTheme() {
  Color themeColor = Color(EzConfig.prefs[themeColorKey]);
  Color themeTextColor = Color(EzConfig.prefs[themeTextColorKey]);

  return CupertinoAppData(
    color: themeColor,
    theme: CupertinoThemeData(
      primaryColor: themeColor,
      primaryContrastingColor: themeTextColor,
      textTheme: cupertinoTextTheme(),
    ),
  );
}
