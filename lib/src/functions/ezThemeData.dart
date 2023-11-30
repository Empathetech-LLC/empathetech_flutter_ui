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

  final TextStyle appBarTextStyle = buildHeadlineMedium();
  final TextStyle tabBarTextStyle = buildTitleLarge();
  final TextStyle pageTextStyle = buildBodyLarge();
  final TextStyle buttonTextStyle = buildTitleMedium();
  final TextStyle textButtonStyle = buildTitleMedium();
  final TextStyle dialogTitleStyle = buildTitleLarge();
  final TextStyle dialogContentStyle = buildBodyLarge();

  final TextTheme textTheme = ezTextTheme();

  final IconThemeData iconData = IconThemeData(
    size: buttonTextStyle.fontSize,
  );
  final IconThemeData appBarIconData = IconThemeData(
    size: appBarTextStyle.fontSize,
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
      iconTheme: appBarIconData,
      actionsIconTheme: appBarIconData,
      titleTextStyle: appBarTextStyle,
    ),

    // Bottom navigation
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(
        size: buttonTextStyle.fontSize,
      ),
      unselectedIconTheme: IconThemeData(
        size: buttonTextStyle.fontSize,
      ),
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: buttonTextStyle,
        padding: EdgeInsets.all(padding),
        alignment: Alignment.center,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        textStyle: textButtonStyle,
        padding: EdgeInsets.all(padding),
        alignment: Alignment.center,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
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
        shadowColor: Colors.transparent,
        iconSize: buttonTextStyle.fontSize,
        side: null,
        padding: EdgeInsets.zero,
        alignment: Alignment.center,
      ),
    ),

    // Cards
    cardTheme: CardTheme(margin: EdgeInsets.zero),

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
      ),
    ),

    // Sliders
    sliderTheme: SliderThemeData(
      overlayShape: SliderComponentShape.noOverlay,
      overlayColor: Colors.transparent,
      disabledThumbColor: Colors.transparent,
      disabledActiveTrackColor: Colors.transparent,
      disabledInactiveTrackColor: Colors.transparent,
      disabledActiveTickMarkColor: Colors.transparent,
      disabledInactiveTickMarkColor: Colors.transparent,
      disabledSecondaryActiveTrackColor: Colors.transparent,
    ),

    // TabBar
    tabBarTheme: TabBarTheme(
      labelStyle: tabBarTextStyle,
      unselectedLabelStyle: tabBarTextStyle,
    ),
  );
}
