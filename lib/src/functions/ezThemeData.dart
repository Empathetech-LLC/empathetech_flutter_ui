/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

ThemeData ezThemeData({required bool light}) {
  // Gather values from EzConfig //

  final Brightness brightness = light ? Brightness.light : Brightness.dark;

  final Color themeColor =
      Color(EzConfig.instance.prefs[light ? lightThemeColorKey : darkThemeColorKey]);
  final Color themeTextColor =
      Color(EzConfig.instance.prefs[light ? lightThemeTextColorKey : darkThemeTextColorKey]);
  final Color unSelectedThemeTextColor = EzColorBlend(themeColor, themeTextColor);

  final Color backgroundColor =
      Color(EzConfig.instance.prefs[light ? lightBackgroundColorKey : darkBackgroundColorKey]);
  final Color backgroundTextColor = Color(
      EzConfig.instance.prefs[light ? lightBackgroundTextColorKey : darkBackgroundTextColorKey]);

  final Color buttonColor =
      Color(EzConfig.instance.prefs[light ? lightButtonColorKey : darkButtonColorKey]);
  final Color buttonTextColor =
      Color(EzConfig.instance.prefs[light ? lightButtonTextColorKey : darkButtonTextColorKey]);

  final Color accentColor =
      Color(EzConfig.instance.prefs[light ? lightAccentColorKey : darkAccentColorKey]);
  final Color accentTextColor =
      Color(EzConfig.instance.prefs[light ? lightAccentTextColorKey : darkAccentTextColorKey]);

  final double margin = EzConfig.instance.prefs[marginKey];
  final double padding = EzConfig.instance.prefs[paddingKey];

  final TextStyle appBarTextStyle = buildHeadlineMedium(themeTextColor);
  final TextStyle tabBarTextStyle = buildTitleLarge(themeTextColor);
  final IconThemeData appBarIconData = IconThemeData(
    color: themeTextColor,
    size: appBarTextStyle.fontSize,
  );

  final TextStyle buttonTextStyle = buildTitleMedium(buttonTextColor);
  final IconThemeData buttonIconData = IconThemeData(
    color: buttonTextColor,
    size: buttonTextStyle.fontSize,
  );

  final TextStyle pageTextStyle = buildBodyLarge(backgroundTextColor);

  final TextStyle dialogTitleStyle = buildTitleLarge(themeTextColor);
  final TextStyle dialogContentStyle = buildBodyLarge(themeTextColor);

  // Build the ThemeData //

  return ThemeData(
    brightness: brightness,

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
      color: backgroundColor,
      margin: EdgeInsets.all(margin),
      shadowColor: accentColor,
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
    colorScheme: ColorScheme(
      brightness: brightness,
      primary: buttonColor,
      onPrimary: buttonTextColor,
      secondary: accentColor,
      onSecondary: accentTextColor,
      background: themeColor,
      onBackground: themeTextColor,
      surface: backgroundColor,
      onSurface: backgroundTextColor,
      error: Colors.red,
      onError: Colors.black,
    ),
    dividerColor: Colors.transparent,
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
      textStyle: pageTextStyle,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(padding),
        fillColor: backgroundColor,
        iconColor: backgroundTextColor,
        prefixIconColor: backgroundTextColor,
        suffixIconColor: backgroundTextColor,
      ),
      menuStyle: MenuStyle(
        backgroundColor: MaterialStatePropertyAll(backgroundColor),
      ),
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
    textTheme: EzTextTheme(color: backgroundTextColor),
    primaryTextTheme: EzTextTheme(color: backgroundTextColor),
    iconTheme: buttonIconData,
    primaryIconTheme: buttonIconData,

    // Transitions
    pageTransitionsTheme: EzTransitions(),
  );
}
