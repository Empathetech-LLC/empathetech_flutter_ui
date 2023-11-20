/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

ThemeData ezThemeData({required bool lightTheme}) {
  // Gather values from EzConfig //

  final Brightness brightness = lightTheme ? Brightness.light : Brightness.dark;

  final double margin = EzConfig.instance.prefs[marginKey];
  final double padding = EzConfig.instance.prefs[paddingKey];

  final Color primaryColor = Color(EzConfig
      .instance.prefs[lightTheme ? lightPrimaryColor : darkPrimaryColor]);
  final Color onPrimaryColor = Color(EzConfig
      .instance.prefs[lightTheme ? lightOnPrimaryColor : darkOnPrimaryColor]);
  final Color primaryContainerColor = Color(EzConfig.instance.prefs[
      lightTheme ? lightPrimaryContainerColor : darkPrimaryContainerColor]);
  final Color onPrimaryContainerColor = Color(EzConfig.instance.prefs[
      lightTheme ? lightOnPrimaryContainerColor : darkOnPrimaryContainerColor]);

  final Color secondaryColor = Color(EzConfig
      .instance.prefs[lightTheme ? lightSecondaryColor : darkSecondaryColor]);
  final Color onSecondaryColor = Color(EzConfig.instance
      .prefs[lightTheme ? lightOnSecondaryColor : darkOnSecondaryColor]);
  final Color secondaryContainerColor = Color(EzConfig.instance.prefs[
      lightTheme ? lightSecondaryContainerColor : darkSecondaryContainerColor]);
  final Color onSecondaryContainerColor = Color(EzConfig.instance.prefs[
      lightTheme
          ? lightOnSecondaryContainerColor
          : darkOnSecondaryContainerColor]);

  final Color tertiaryColor = Color(EzConfig
      .instance.prefs[lightTheme ? lightTertiaryColor : darkTertiaryColor]);
  final Color onTertiaryColor = Color(EzConfig
      .instance.prefs[lightTheme ? lightOnTertiaryColor : darkOnTertiaryColor]);
  final Color tertiaryContainerColor = Color(EzConfig.instance.prefs[
      lightTheme ? lightTertiaryContainerColor : darkTertiaryContainerColor]);
  final Color onTertiaryContainerColor = Color(EzConfig.instance.prefs[
      lightTheme
          ? lightOnTertiaryContainerColor
          : darkOnTertiaryContainerColor]);

  final Color errorColor = Color(
      EzConfig.instance.prefs[lightTheme ? lightErrorColor : darkErrorColor]);
  final Color onErrorColor = Color(EzConfig
      .instance.prefs[lightTheme ? lightOnErrorColor : darkOnErrorColor]);
  final Color errorContainerColor = Color(EzConfig.instance
      .prefs[lightTheme ? lightErrorContainerColor : darkErrorContainerColor]);
  final Color onErrorContainerColor = Color(EzConfig.instance.prefs[
      lightTheme ? lightOnErrorContainerColor : darkOnErrorContainerColor]);

  final Color backgroundColor = Color(EzConfig
      .instance.prefs[lightTheme ? lightBackgroundColor : darkBackgroundColor]);
  final Color onBackgroundColor = Color(EzConfig.instance
      .prefs[lightTheme ? lightOnBackgroundColor : darkOnBackgroundColor]);
  final Color surfaceColor = Color(EzConfig
      .instance.prefs[lightTheme ? lightSurfaceColor : darkSurfaceColor]);
  final Color onSurfaceColor = Color(EzConfig
      .instance.prefs[lightTheme ? lightOnSurfaceColor : darkOnSurfaceColor]);

  final Color outlineColor = Color(EzConfig
      .instance.prefs[lightTheme ? lightOutlineColor : darkOutlineColor]);

  // Build the ThemeData //

  return ThemeData(
    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        padding: EdgeInsets.all(padding),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.all(padding),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        side: null,
        padding: EdgeInsets.zero,
      ),
    ),

    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        side: null,
        padding: EdgeInsets.zero,
      ),
    ),

    // Cards
    cardTheme: CardTheme(margin: EdgeInsets.all(margin)),

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

    // Font
    fontFamily: EzConfig.instance.fontFamily,
  );
}
