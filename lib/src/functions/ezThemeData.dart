/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

ThemeData ezThemeData({required bool lightTheme}) {
  // Gather values from EzConfig //

  final Brightness brightness = lightTheme ? Brightness.light : Brightness.dark;

  final Color primaryColor = Color(EzConfig
      .instance.prefs[lightTheme ? lightPrimaryColorKey : darkPrimaryColorKey]);
  final Color onPrimaryColor = Color(EzConfig.instance
      .prefs[lightTheme ? lightOnPrimaryColorKey : darkOnPrimaryColorKey]);
  final Color primaryContainerColor = Color(EzConfig.instance.prefs[lightTheme
      ? lightPrimaryContainerColorKey
      : darkPrimaryContainerColorKey]);
  final Color onPrimaryContainerColor = Color(EzConfig.instance.prefs[lightTheme
      ? lightOnPrimaryContainerColorKey
      : darkOnPrimaryContainerColorKey]);

  final Color secondaryColor = Color(EzConfig.instance
      .prefs[lightTheme ? lightSecondaryColorKey : darkSecondaryColorKey]);
  final Color onSecondaryColor = Color(EzConfig.instance
      .prefs[lightTheme ? lightOnSecondaryColorKey : darkOnSecondaryColorKey]);
  final Color secondaryContainerColor = Color(EzConfig.instance.prefs[lightTheme
      ? lightSecondaryContainerColorKey
      : darkSecondaryContainerColorKey]);
  final Color onSecondaryContainerColor = Color(EzConfig.instance.prefs[
      lightTheme
          ? lightOnSecondaryContainerColorKey
          : darkOnSecondaryContainerColorKey]);

  final Color tertiaryColor = Color(EzConfig.instance
      .prefs[lightTheme ? lightTertiaryColorKey : darkTertiaryColorKey]);
  final Color onTertiaryColor = Color(EzConfig.instance
      .prefs[lightTheme ? lightOnTertiaryColorKey : darkOnTertiaryColorKey]);
  final Color tertiaryContainerColor = Color(EzConfig.instance.prefs[lightTheme
      ? lightTertiaryContainerColorKey
      : darkTertiaryContainerColorKey]);
  final Color onTertiaryContainerColor = Color(EzConfig.instance.prefs[
      lightTheme
          ? lightOnTertiaryContainerColorKey
          : darkOnTertiaryContainerColorKey]);

  final Color errorColor = Color(EzConfig
      .instance.prefs[lightTheme ? lightErrorColorKey : darkErrorColorKey]);
  final Color onErrorColor = Color(EzConfig
      .instance.prefs[lightTheme ? lightOnErrorColorKey : darkOnErrorColorKey]);
  final Color errorContainerColor = Color(EzConfig.instance.prefs[
      lightTheme ? lightErrorContainerColorKey : darkErrorContainerColorKey]);
  final Color onErrorContainerColor = Color(EzConfig.instance.prefs[lightTheme
      ? lightOnErrorContainerColorKey
      : darkOnErrorContainerColorKey]);

  final Color backgroundColor = Color(EzConfig.instance
      .prefs[lightTheme ? lightBackgroundColorKey : darkBackgroundColorKey]);
  final Color onBackgroundColor = Color(EzConfig.instance.prefs[
      lightTheme ? lightOnBackgroundColorKey : darkOnBackgroundColorKey]);
  final Color surfaceColor = Color(EzConfig
      .instance.prefs[lightTheme ? lightSurfaceColorKey : darkSurfaceColorKey]);
  final Color onSurfaceColor = Color(EzConfig.instance
      .prefs[lightTheme ? lightOnSurfaceColorKey : darkOnSurfaceColorKey]);

  final Color outlineColor = Color(EzConfig
      .instance.prefs[lightTheme ? lightOutlineColorKey : darkOutlineColorKey]);

  final double padding = EzConfig.instance.prefs[paddingKey];

  final TextStyle appBarTextStyle = buildHeadlineMedium(onBackgroundColor);
  final TextStyle tabBarTextStyle = buildTitleLarge(onBackgroundColor);
  final TextStyle pageTextStyle = buildBodyLarge(onBackgroundColor);
  final TextStyle buttonTextStyle = buildTitleMedium(onPrimaryColor);
  final TextStyle textButtonStyle = buildTitleMedium(primaryColor);
  final TextStyle dialogTitleStyle = buildTitleLarge(onBackgroundColor);
  final TextStyle dialogContentStyle = buildBodyLarge(onBackgroundColor);

  final TextTheme textTheme = ezTextTheme(onBackgroundColor);

  final IconThemeData iconData = IconThemeData(
    color: buttonTextStyle.color,
    size: buttonTextStyle.fontSize,
  );
  final IconThemeData appBarIconData = IconThemeData(
    color: appBarTextStyle.color,
    size: appBarTextStyle.fontSize,
  );

  // Build the ThemeData //

  return ThemeData(
    // Colors
    brightness: brightness,
    colorScheme: ColorScheme(
      brightness: brightness,
      primary: primaryColor,
      onPrimary: onPrimaryColor,
      primaryContainer: primaryContainerColor,
      onPrimaryContainer: onPrimaryContainerColor,
      secondary: secondaryColor,
      onSecondary: onSecondaryColor,
      secondaryContainer: secondaryContainerColor,
      onSecondaryContainer: onSecondaryContainerColor,
      tertiary: tertiaryColor,
      onTertiary: onTertiaryColor,
      tertiaryContainer: tertiaryContainerColor,
      onTertiaryContainer: onTertiaryContainerColor,
      error: errorColor,
      onError: onErrorColor,
      errorContainer: errorContainerColor,
      onErrorContainer: onErrorContainerColor,
      background: backgroundColor,
      onBackground: onBackgroundColor,
      surface: surfaceColor,
      onSurface: onSurfaceColor,
      outline: outlineColor,
    ),

    // Text && icons
    fontFamily: EzConfig.instance.fontFamily,
    textTheme: textTheme,
    primaryTextTheme: textTheme,
    iconTheme: iconData,
    primaryIconTheme: iconData,

    // Animations
    pageTransitionsTheme: EzTransitions(),

    // AppBar
    appBarTheme: AppBarTheme(
      iconTheme: appBarIconData,
      actionsIconTheme: appBarIconData,
      titleTextStyle: appBarTextStyle,
    ),

    // Bottom navigation
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primaryColor,
      selectedIconTheme: IconThemeData(
        color: primaryColor,
        size: buttonTextStyle.fontSize,
      ),
      unselectedItemColor: onPrimaryColor,
      unselectedIconTheme: IconThemeData(
        color: onPrimaryColor,
        size: buttonTextStyle.fontSize,
      ),
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        shadowColor: primaryColor,
        foregroundColor: onPrimaryColor,
        textStyle: buttonTextStyle,
        side: BorderSide(color: primaryColor),
        padding: EdgeInsets.all(padding),
        alignment: Alignment.center,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: primaryColor,
        foregroundColor: primaryColor,
        textStyle: textButtonStyle,
        side: BorderSide(color: primaryColor),
        padding: EdgeInsets.all(padding),
        alignment: Alignment.center,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: primaryColor,
        shadowColor: Colors.transparent,
        textStyle: textButtonStyle,
        side: null,
        padding: EdgeInsets.zero,
        alignment: Alignment.center,
      ),
    ),

    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: onSurfaceColor,
        shadowColor: Colors.transparent,
        iconSize: buttonTextStyle.fontSize,
        side: null,
        padding: EdgeInsets.zero,
        alignment: Alignment.center,
      ),
    ),

    // Cards
    cardTheme: CardTheme(
      color: surfaceColor,
      shadowColor: secondaryColor,
      margin: EdgeInsets.zero,
    ),

    // Checkbox
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColor;
          } else {
            return onBackgroundColor;
          }
        },
      ),
      checkColor: MaterialStateProperty.all(primaryColor),
    ),

    // Dialogs
    dialogTheme: DialogTheme(
      titleTextStyle: dialogTitleStyle,
      contentTextStyle: dialogContentStyle,
      alignment: Alignment.center,
    ),

    // Dropdown menu
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: pageTextStyle,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(padding),
        fillColor: primaryColor,
        iconColor: onPrimaryColor,
        prefixIconColor: onPrimaryColor,
        suffixIconColor: onPrimaryColor,
      ),
      menuStyle: MenuStyle(
        backgroundColor: MaterialStatePropertyAll(primaryColor),
      ),
    ),

    // Sliders
    sliderTheme: SliderThemeData(
      overlayShape: SliderComponentShape.noOverlay,
      overlayColor: Colors.transparent,
      thumbColor: primaryColor,
      activeTrackColor: primaryColor,
      valueIndicatorColor: primaryColor,
      activeTickMarkColor: onPrimaryColor,
      disabledThumbColor: Colors.transparent,
      disabledActiveTrackColor: Colors.transparent,
      disabledInactiveTrackColor: Colors.transparent,
      disabledActiveTickMarkColor: Colors.transparent,
      disabledInactiveTickMarkColor: Colors.transparent,
      disabledSecondaryActiveTrackColor: Colors.transparent,
      inactiveTrackColor: outlineColor,
      inactiveTickMarkColor: onBackgroundColor,
    ),

    // TabBar
    tabBarTheme: TabBarTheme(
      labelColor: onBackgroundColor,
      labelStyle: tabBarTextStyle,
      unselectedLabelColor: outlineColor,
      unselectedLabelStyle: tabBarTextStyle.copyWith(color: outlineColor),
    ),
  );
}
