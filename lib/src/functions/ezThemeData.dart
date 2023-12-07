/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

ThemeData ezThemeData(Brightness brightness) {
  // Gather values from EzConfig //

  final ColorScheme colorScheme = ezColorScheme(brightness);

  final double padding = EzConfig.get(paddingKey);

  final TextStyle appBarTextStyle = buildHeadlineMedium();
  final TextStyle tabBarTextStyle = buildTitleLarge();
  final TextStyle pageTextStyle = buildBodyLarge();
  final TextStyle buttonTextStyle = buildTitleMedium();
  final TextStyle textButtonStyle = buildTitleMedium();
  final TextStyle dialogTitleStyle = buildTitleLarge();
  final TextStyle dialogContentStyle = buildBodyLarge();

  final TextTheme textTheme = ezTextTheme();

  final IconThemeData iconData = IconThemeData(size: buttonTextStyle.fontSize);

  final IconThemeData appBarIconData =
      IconThemeData(size: appBarTextStyle.fontSize);

  // Build the ThemeData //

  return ThemeData(
    // Colors
    brightness: brightness,
    colorScheme: colorScheme,

    // Text && icons
    fontFamily: EzConfig.get(fontFamilyKey),
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
      selectedIconTheme: iconData,
      unselectedIconTheme: iconData,
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
        textStyle: textButtonStyle,
        alignment: Alignment.center,
        padding: EdgeInsets.all(padding),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: textButtonStyle,
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        side: null,
      ),
    ),

    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        iconSize: buttonTextStyle.fontSize,
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        side: null,
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

    // TabBar
    tabBarTheme: TabBarTheme(labelStyle: tabBarTextStyle),
  );
}
