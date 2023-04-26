library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Material [ThemeData] using [EzConfig] values
ThemeData ezThemeData({required bool light}) {
  Color themeColor =
      Color(EzConfig.prefs[light ? lightThemeColorKey : darkThemeColorKey]);
  Color themeTextColor = Color(
      EzConfig.prefs[light ? lightThemeTextColorKey : darkThemeTextColorKey]);

  Color backgroundColor = Color(
      EzConfig.prefs[light ? lightBackgroundColorKey : darkBackgroundColorKey]);
  Color backgroundTextColor = Color(EzConfig
      .prefs[light ? lightBackgroundTextColorKey : darkBackgroundTextColorKey]);

  Color buttonColor =
      Color(EzConfig.prefs[light ? lightButtonColorKey : darkButtonColorKey]);
  Color buttonTextColor = Color(
      EzConfig.prefs[light ? lightButtonTextColorKey : darkButtonTextColorKey]);

  TextStyle appBarTextStyle = buildHeadlineMedium(themeTextColor);
  IconThemeData appBarIconData = IconThemeData(
    color: themeTextColor,
    size: appBarTextStyle.fontSize,
  );

  TextStyle buttonTextStyle = buildHeadlineMedium(buttonTextColor);
  IconThemeData buttonIconData = IconThemeData(
    color: buttonTextColor,
    size: buttonTextStyle.fontSize,
  );

  TextStyle pageSelection = buildHeadlineMedium(backgroundTextColor);

  return ThemeData(
    // General colors
    dividerColor: themeTextColor,
    highlightColor: buttonColor,
    hintColor: themeTextColor,
    indicatorColor: buttonColor,
    primaryColor: themeColor,
    scaffoldBackgroundColor: backgroundColor,

    // Text && icons
    fontFamily: googleStyles[(EzConfig.prefs[fontFamilyKey])]?.fontFamily,
    iconTheme: buttonIconData,
    primaryIconTheme: buttonIconData,
    primaryTextTheme: materialTextTheme(backgroundTextColor),
    textTheme: materialTextTheme(backgroundTextColor),

    // AppBar
    appBarTheme: AppBarTheme(
      color: themeColor,
      iconTheme: appBarIconData,
      actionsIconTheme: appBarIconData,
      titleTextStyle: appBarTextStyle,
    ),

    // Drawer
    drawerTheme: DrawerThemeData(backgroundColor: themeColor),

    // Bottom navigation
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: themeColor,
      selectedItemColor: buttonColor,
      selectedIconTheme: IconThemeData(color: buttonColor),
      unselectedItemColor: themeTextColor,
      unselectedIconTheme: IconThemeData(color: themeTextColor),
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        textStyle: buttonTextStyle,
        padding: EdgeInsets.all(EzConfig.prefs[paddingKey]),
      ),
    ),

    // Dropdown Menu
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: pageSelection,
    ),

    // Checkbox
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return buttonColor;
          } else {
            return themeTextColor;
          }
        },
      ),
      checkColor: MaterialStateProperty.all(buttonColor),
    ),

    // Dialogs
    dialogTheme: DialogTheme(
      backgroundColor: themeColor,
      iconColor: themeTextColor,
      alignment: Alignment.center,
    ),

    // Sliders
    sliderTheme: SliderThemeData(
      thumbColor: buttonColor,
      disabledThumbColor: themeColor,
      overlayColor: buttonColor,
      activeTrackColor: buttonColor,
      activeTickMarkColor: buttonTextColor,
      inactiveTrackColor: themeColor,
      inactiveTickMarkColor: themeTextColor,
      overlayShape: SliderComponentShape.noOverlay,
    ),
  );
}

/// [CupertinoThemeData] using [EzConfig] values
CupertinoThemeData ezCupertinoThemeData({required bool light}) {
  Color themeColor =
      Color(EzConfig.prefs[light ? lightThemeColorKey : darkThemeColorKey]);
  Color themeTextColor = Color(
      EzConfig.prefs[light ? lightThemeTextColorKey : darkThemeTextColorKey]);

  Color backgroundColor = Color(
      EzConfig.prefs[light ? lightBackgroundColorKey : darkBackgroundColorKey]);

  return CupertinoThemeData(
    primaryColor: themeColor,
    primaryContrastingColor: themeTextColor,
    textTheme: cupertinoTextTheme(themeTextColor),
    barBackgroundColor: backgroundColor,
    scaffoldBackgroundColor: backgroundColor,
  );
}
