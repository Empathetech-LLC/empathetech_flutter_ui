/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Creates a [ThemeData] with a [ColorScheme] generated via [ezColorScheme]
/// Also has some tweaks to the base Material [ThemeData], such as...
///   margin, padding, [TextStyle]s, [IconData]
ThemeData ezThemeData(Brightness brightness) {
  // Gather values from EzConfig //

  final ColorScheme colorScheme = ezColorScheme(brightness);

  final TextTheme textTheme = ezTextTheme();

  final TextStyle appBarTextStyle = buildHeadline(
    color: colorScheme.onSurface,
  );
  final TextStyle tabBarTextStyle = buildTitle(
    color: colorScheme.onSurface,
  );

  final TextStyle pageTextStyle = buildTitle(
    color: colorScheme.onBackground,
  );
  final TextStyle buttonTextStyle = buildTitle();

  final TextStyle dialogTitleStyle = buildHeadline(
    color: colorScheme.onBackground,
  );
  final TextStyle dialogContentStyle = buildTitle(
    color: colorScheme.onBackground,
  );

  final IconThemeData iconData = IconThemeData(
    size: buttonTextStyle.fontSize,
    color: colorScheme.onSurface,
  );
  final IconThemeData appBarIconData = IconThemeData(
    size: appBarTextStyle.fontSize,
    color: colorScheme.onSurface,
  );

  final double margin = EzConfig.get(marginKey);
  final double padding = EzConfig.get(paddingKey);
  final double buttonSpacing = EzConfig.get(buttonSpacingKey);

  // Build the ThemeData //

  return ThemeData(
    // Color scheme //

    brightness: brightness,
    colorScheme: colorScheme,

    // Typography //

    fontFamily: EzConfig.get(fontFamilyKey),
    textTheme: textTheme,
    primaryTextTheme: textTheme,
    iconTheme: iconData,
    primaryIconTheme: iconData,

    // Transitions //

    pageTransitionsTheme: EzTransitions(),

    // Widgets //

    // AppBar
    appBarTheme: AppBarTheme(
      iconTheme: appBarIconData,
      actionsIconTheme: appBarIconData,
      titleTextStyle: appBarTextStyle,
    ),

    // Bottom navigation bar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: appBarIconData,
      unselectedIconTheme: appBarIconData.copyWith(
        color: colorScheme.outline,
      ),
    ),

    // Cards
    cardTheme: CardTheme(margin: EdgeInsets.zero),

    // Dialogs
    dialogTheme: DialogTheme(
      titleTextStyle: dialogTitleStyle,
      contentTextStyle: dialogContentStyle,
      alignment: Alignment.center,
      actionsPadding: EdgeInsets.only(
        top: (buttonSpacing > padding) ? (buttonSpacing - padding) : 0.0,
        left: buttonSpacing,
        right: buttonSpacing,
        bottom: buttonSpacing,
      ),
    ),

    // Dropdown menu
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: pageTextStyle,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(padding),
      ),
    ),

    // Elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: buttonTextStyle,
        alignment: Alignment.center,
        padding: EdgeInsets.all(padding),
        side: BorderSide(color: colorScheme.primaryContainer),
      ),
    ),

    // Floating action button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      extendedPadding: EdgeInsets.all(padding),
      shape: const CircleBorder(),
    ),

    // Icon button
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        iconSize: buttonTextStyle.fontSize,
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        side: null,
      ),
    ),

    // Outlined button
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle: buttonTextStyle,
        alignment: Alignment.center,
        padding: EdgeInsets.all(padding),
        backgroundColor: colorScheme.background,
      ),
    ),

    // TabBar
    tabBarTheme: TabBarTheme(
      labelStyle: tabBarTextStyle,
      unselectedLabelStyle: tabBarTextStyle.copyWith(
        color: colorScheme.outline,
      ),
    ),

    // Text button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: buttonTextStyle,
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        side: null,
      ),
    ),

    // Tooltip
    tooltipTheme: TooltipThemeData(
      margin: EdgeInsets.all(margin),
      padding: EdgeInsets.all(padding),
      textStyle: pageTextStyle,
      textAlign: TextAlign.center,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border.all(color: colorScheme.secondary),
      ),
      waitDuration: const Duration(seconds: 1),
    ),
  );
}