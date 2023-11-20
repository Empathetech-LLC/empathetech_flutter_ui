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

  final TextTheme textTheme = ezTextTheme(onPrimaryColor);

  final double margin = EzConfig.instance.prefs[marginKey];
  final double padding = EzConfig.instance.prefs[paddingKey];

  final TextStyle appBarTextStyle = buildHeadlineMedium(onBackgroundColor);
  final TextStyle tabBarTextStyle = buildTitleLarge(onBackgroundColor);
  final TextStyle buttonTextStyle = buildTitleMedium(onPrimaryColor);
  final TextStyle dialogTitleStyle = buildTitleLarge(onBackgroundColor);
  final TextStyle dialogContentStyle = buildBodyLarge(onBackgroundColor);

  final IconThemeData iconData = IconThemeData(
    color: buttonTextStyle.color,
    size: buttonTextStyle.fontSize,
  );
  final IconThemeData appBarIconData = IconThemeData(
    color: appBarTextStyle.color,
    size: appBarTextStyle.fontSize,
  );

  final Color unselectedColor = blendColors(backgroundColor, onBackgroundColor);

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
    iconTheme: iconData,

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
        textStyle: buttonTextStyle,
        alignment: Alignment.center,
        padding: EdgeInsets.all(padding),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle: buttonTextStyle,
        alignment: Alignment.center,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.all(padding),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: TextStyle(
          color: primaryColor,
          fontSize: buttonTextStyle.fontSize,
        ),
        alignment: Alignment.center,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        side: null,
        padding: EdgeInsets.zero,
      ),
    ),

    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        iconSize: buttonTextStyle.fontSize,
        alignment: Alignment.center,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        side: null,
        padding: EdgeInsets.zero,
      ),
    ),

    // Cards
    cardTheme: CardTheme(margin: EdgeInsets.all(margin)),

    // Dialogs
    dialogTheme: DialogTheme(
      titleTextStyle: dialogTitleStyle,
      contentTextStyle: dialogContentStyle,
      alignment: Alignment.center,
    ),

    // TabBar
    tabBarTheme: TabBarTheme(
      labelColor: onBackgroundColor,
      labelStyle: tabBarTextStyle,
      unselectedLabelColor: unselectedColor,
      unselectedLabelStyle: tabBarTextStyle.copyWith(color: unselectedColor),
    ),
  );
}
