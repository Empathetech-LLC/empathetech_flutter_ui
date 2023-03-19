library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Android (Material) [ThemeData] built from [AppConfig.prefs]
MaterialAppData androidAppTheme() {
  Color themeColor = AppConfig.prefs[themeColorKey];
  Color themeTextColor = AppConfig.prefs[themeTextColorKey];
  Color buttonColor = AppConfig.prefs[buttonColorKey];
  Color buttonTextColor = AppConfig.prefs[buttonTextColorKey];

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
    ),
  );
}

/// iOS (Cupertino) app data built from [AppConfig.prefs]
CupertinoAppData iosAppTheme() {
  return CupertinoAppData();
}
