/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

ThemeData ezThemeData(Brightness brightness) {
  // Gather values from EzConfig //

  final ColorScheme colorScheme = ezColorScheme(brightness);

  final double padding = EzConfig.instance.prefs[paddingKey];

  final TextStyle appBarTextStyle =
      buildHeadlineMedium(color: colorScheme.onSurface);
  final TextStyle tabBarTextStyle =
      buildTitleLarge(color: colorScheme.onSurface);
  final TextStyle pageTextStyle =
      buildBodyLarge(color: colorScheme.onBackground);
  final TextStyle buttonTextStyle =
      buildTitleMedium(color: colorScheme.primary);
  final TextStyle textButtonStyle =
      buildTitleMedium(color: colorScheme.primary);
  final TextStyle dialogTitleStyle =
      buildTitleLarge(color: colorScheme.onSurface);
  final TextStyle dialogContentStyle =
      buildBodyLarge(color: colorScheme.onSurface);

  final TextTheme textTheme = ezTextTheme();

  final IconThemeData iconData = IconThemeData(
    size: buttonTextStyle.fontSize,
    color: colorScheme.onSurface,
  );

  final IconThemeData appBarIconData = IconThemeData(
    size: appBarTextStyle.fontSize,
    color: colorScheme.onSurface,
  );

  // Build the ThemeData //

  return ThemeData(
    // Colors
    brightness: brightness,
    colorScheme: colorScheme,

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
      color: colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      iconTheme: appBarIconData,
      actionsIconTheme: appBarIconData,
      titleTextStyle: appBarTextStyle,
    ),

    // Bottom navigation
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: colorScheme.surface,
      selectedIconTheme: iconData,
      unselectedIconTheme: iconData.copyWith(color: colorScheme.outline),
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: buttonTextStyle,
        alignment: Alignment.center,
        padding: EdgeInsets.all(padding),
        backgroundColor: colorScheme.surface,
        side: BorderSide(color: colorScheme.primaryContainer),
        shadowColor: colorScheme.primaryContainer,
        surfaceTintColor: Colors.transparent,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle: textButtonStyle,
        alignment: Alignment.center,
        padding: EdgeInsets.all(padding),
        backgroundColor: Colors.transparent,
        side: BorderSide(color: colorScheme.primaryContainer),
        shadowColor: colorScheme.primaryContainer,
        surfaceTintColor: Colors.transparent,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: textButtonStyle,
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        side: null,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
    ),

    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        iconSize: buttonTextStyle.fontSize,
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        side: null,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
    ),

    // Cards
    cardTheme: CardTheme(
      margin: EdgeInsets.zero,
      color: colorScheme.surface,
      surfaceTintColor: Colors.transparent,
    ),

    // Dialogs
    dialogTheme: DialogTheme(
      titleTextStyle: dialogTitleStyle,
      contentTextStyle: dialogContentStyle,
      alignment: Alignment.center,
      backgroundColor: colorScheme.surface,
      iconColor: colorScheme.onSurface,
    ),

    drawerTheme: DrawerThemeData(backgroundColor: colorScheme.surface),

    // Dropdown menu
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: pageTextStyle,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(padding),
        fillColor: colorScheme.background,
        iconColor: colorScheme.onBackground,
      ),
    ),

    // Sliders
    sliderTheme: SliderThemeData(
      overlayShape: SliderComponentShape.noOverlay,
      overlayColor: Colors.transparent,
      thumbColor: colorScheme.primary,
      activeTrackColor: colorScheme.primaryContainer,
      inactiveTrackColor: colorScheme.outline,
      valueIndicatorColor: colorScheme.primary,
      activeTickMarkColor: colorScheme.onPrimaryContainer,
      inactiveTickMarkColor: colorScheme.onPrimaryContainer,
      disabledThumbColor: Colors.transparent,
      disabledActiveTrackColor: Colors.transparent,
      disabledInactiveTrackColor: Colors.transparent,
      disabledActiveTickMarkColor: Colors.transparent,
      disabledInactiveTickMarkColor: Colors.transparent,
    ),

    // TabBar
    tabBarTheme: TabBarTheme(
      labelStyle: tabBarTextStyle,
      labelColor: colorScheme.onSurface,
      unselectedLabelStyle: tabBarTextStyle.copyWith(
        color: colorScheme.outline,
      ),
      unselectedLabelColor: colorScheme.outline,
    ),
  );
}
