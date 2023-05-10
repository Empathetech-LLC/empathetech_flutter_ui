library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

ThemeData ezThemeData({required bool light}) {
  final Color themeColor = Color(
      EzConfig.instance.prefs[light ? lightThemeColorKey : darkThemeColorKey]);
  final Color themeTextColor = Color(EzConfig
      .instance.prefs[light ? lightThemeTextColorKey : darkThemeTextColorKey]);
  final Color unSelectedThemeTextColor =
      EzColorBlend(themeColor, themeTextColor);

  final Color backgroundColor = Color(EzConfig.instance
      .prefs[light ? lightBackgroundColorKey : darkBackgroundColorKey]);
  final Color backgroundTextColor = Color(EzConfig.instance
      .prefs[light ? lightBackgroundTextColorKey : darkBackgroundTextColorKey]);

  final Color buttonColor = Color(EzConfig
      .instance.prefs[light ? lightButtonColorKey : darkButtonColorKey]);
  final Color buttonTextColor = Color(EzConfig.instance
      .prefs[light ? lightButtonTextColorKey : darkButtonTextColorKey]);

  final double margin = EzConfig.instance.prefs[marginKey];

  final TextStyle appBarTextStyle = buildHeadlineMedium(themeTextColor);
  final TextStyle tabBarTextStyle = buildHeadlineSmall(themeTextColor);
  final IconThemeData appBarIconData = IconThemeData(
    color: themeTextColor,
    size: appBarTextStyle.fontSize,
  );

  final TextStyle buttonTextStyle = buildTitleMedium(buttonTextColor);
  final IconThemeData buttonIconData = IconThemeData(
    color: buttonTextColor,
    size: buttonTextStyle.fontSize,
  );

  final TextStyle pageSelection = buildTitleMedium(backgroundTextColor);

  final TextStyle dialogTitleStyle = buildHeadlineSmall(themeTextColor);
  final TextStyle dialogContentStyle = buildTitleMedium(themeTextColor);

  return ThemeData(
    brightness: light ? Brightness.light : Brightness.dark,

    // AppBar
    appBarTheme: AppBarTheme(
      color: themeColor,
      iconTheme: appBarIconData,
      actionsIconTheme: appBarIconData,
      titleTextStyle: appBarTextStyle,
    ),

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
        textStyle: buttonTextStyle,
        alignment: Alignment.center,
        backgroundColor: buttonColor,
        shadowColor: buttonColor,
        side: BorderSide(color: buttonColor),
        padding: EdgeInsets.all(EzConfig.instance.prefs[paddingKey]),
      ),
    ),

    // Cards
    cardTheme: CardTheme(
      color: light ? Colors.white : offBlack,
      margin: EdgeInsets.all(margin),
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

    // Colors
    highlightColor: buttonColor,
    hintColor: themeTextColor,
    indicatorColor: buttonColor,
    primaryColor: themeColor,
    scaffoldBackgroundColor: backgroundColor,

    // Dialogs
    dialogTheme: DialogTheme(
      titleTextStyle: dialogTitleStyle,
      backgroundColor: themeColor,
      contentTextStyle: dialogContentStyle,
      iconColor: themeTextColor,
      alignment: Alignment.center,
    ),

    // Drawer
    drawerTheme: DrawerThemeData(backgroundColor: themeColor),

    // Dropdown Menu
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: pageSelection,
    ),

    // Sliders
    sliderTheme: SliderThemeData(
      overlayShape: SliderComponentShape.noOverlay,
      overlayColor: Colors.transparent,
      thumbColor: buttonColor,
      activeTrackColor: buttonColor,
      valueIndicatorColor: buttonColor,
      activeTickMarkColor: buttonTextColor,
      disabledThumbColor: Colors.transparent,
      disabledActiveTrackColor: Colors.transparent,
      disabledInactiveTrackColor: Colors.transparent,
      disabledActiveTickMarkColor: Colors.transparent,
      disabledInactiveTickMarkColor: Colors.transparent,
      disabledSecondaryActiveTrackColor: Colors.transparent,
      inactiveTrackColor: unSelectedThemeTextColor,
      inactiveTickMarkColor: themeTextColor,
    ),

    // TabBar
    tabBarTheme: TabBarTheme(
      labelStyle: tabBarTextStyle,
      labelColor: themeTextColor,
      unselectedLabelStyle: tabBarTextStyle.copyWith(
        color: unSelectedThemeTextColor,
      ),
      unselectedLabelColor: unSelectedThemeTextColor,
    ),

    // Text && icons
    fontFamily: EzConfig.instance.fontFamily,
    iconTheme: buttonIconData,
    primaryIconTheme: buttonIconData,
    primaryTextTheme: EzTextTheme(color: backgroundTextColor),
    textTheme: EzTextTheme(color: backgroundTextColor),

    // Transitions
    pageTransitionsTheme: EzTransitions(),
  );
}
