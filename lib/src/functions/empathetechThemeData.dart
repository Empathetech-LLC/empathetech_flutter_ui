/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

ThemeData empathetechThemeData({required bool lightTheme}) {
  // Gather values from EzConfig //

  final Brightness brightness = lightTheme ? Brightness.light : Brightness.dark;

  final double margin = EzConfig.instance.prefs[marginKey];
  final double padding = EzConfig.instance.prefs[paddingKey];

  final Color themeColor =
      Color(EzConfig.instance.prefs[lightTheme ? lightThemeColorKey : darkThemeColorKey]);
  final Color themeTextColor =
      Color(EzConfig.instance.prefs[lightTheme ? lightThemeTextColorKey : darkThemeTextColorKey]);
  final Color unSelectedThemeTextColor = EzColorBlend(themeColor, themeTextColor);

  final Color pageColor =
      Color(EzConfig.instance.prefs[lightTheme ? lightPageColorKey : darkPageColorKey]);
  final Color pageTextColor =
      Color(EzConfig.instance.prefs[lightTheme ? lightPageTextColorKey : darkPageTextColorKey]);

  final Color buttonColor =
      Color(EzConfig.instance.prefs[lightTheme ? lightButtonColorKey : darkButtonColorKey]);
  final Color buttonTextColor = Color(
      EzConfig.instance.prefs[lightTheme ? lightButtonTextColorKey : darkButtonTextColorKey]);

  final Color accentColor =
      Color(EzConfig.instance.prefs[lightTheme ? lightAccentColorKey : darkAccentColorKey]);
  final Color accentTextColor = Color(
      EzConfig.instance.prefs[lightTheme ? lightAccentTextColorKey : darkAccentTextColorKey]);

  final TextStyle appBarTextStyle = buildHeadlineMedium(themeTextColor);
  final TextStyle tabBarTextStyle = buildTitleLarge(themeTextColor);
  final TextStyle pageTextStyle = buildBodyLarge(pageTextColor);
  final TextStyle buttonTextStyle = buildTitleMedium(buttonTextColor);
  final TextStyle textButtonTextStyle = buildTitleMedium(buttonColor);
  final TextStyle dialogTitleStyle = buildTitleLarge(themeTextColor);
  final TextStyle dialogContentStyle = buildBodyLarge(themeTextColor);

  final IconThemeData iconData = IconThemeData(
    color: buttonTextColor,
    size: buttonTextStyle.fontSize,
  );
  final IconThemeData appBarIconData = IconThemeData(
    color: themeTextColor,
    size: appBarTextStyle.fontSize,
  );

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

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: textButtonTextStyle,
        alignment: Alignment.center,
        padding: EdgeInsets.all(EzConfig.instance.prefs[paddingKey]),
      ),
    ),

    // Cards
    cardTheme: CardTheme(
      color: pageColor,
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
      surface: pageColor,
      onSurface: pageTextColor,
      error: Colors.red,
      onError: Colors.black,
    ),
    dividerColor: Colors.transparent,
    highlightColor: buttonColor,
    hintColor: themeTextColor,
    indicatorColor: buttonColor,
    primaryColor: themeColor,
    scaffoldBackgroundColor: pageColor,

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
        fillColor: pageColor,
        iconColor: pageTextColor,
        prefixIconColor: pageTextColor,
        suffixIconColor: pageTextColor,
      ),
      menuStyle: MenuStyle(backgroundColor: MaterialStatePropertyAll(pageColor)),
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
    textTheme: EzTextTheme(color: pageTextColor),
    primaryTextTheme: EzTextTheme(color: pageTextColor),
    iconTheme: iconData,
    primaryIconTheme: iconData,

    // Transitions
    pageTransitionsTheme: EzTransitions(),
  );
}
