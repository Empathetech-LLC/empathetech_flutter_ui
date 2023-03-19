library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Android (Material) [ThemeData] built from [AppConfig.prefs]
MaterialAppData androidAppTheme() {
  Color themeColor = Color(AppConfig.prefs[themeColorKey]);
  Color themeTextColor = Color(AppConfig.prefs[themeTextColorKey]);
  Color buttonColor = Color(AppConfig.prefs[buttonColorKey]);
  Color buttonTextColor = Color(AppConfig.prefs[buttonTextColorKey]);

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
      textTheme: defaultTextTheme(),
      primaryTextTheme: defaultTextTheme(),
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

/// iOS (Cupertino) app data built from [AppConfig.prefs]
CupertinoAppData iosAppTheme() {
  return CupertinoAppData();
}
