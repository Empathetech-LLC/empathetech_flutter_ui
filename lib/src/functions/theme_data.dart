/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
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

  final IconThemeData iconData = IconThemeData(
    size: textTheme.bodyLarge?.fontSize,
    color: colorScheme.onSurface,
  );
  final IconThemeData appBarIconData = IconThemeData(
    size: textTheme.headlineLarge?.fontSize,
    color: colorScheme.onSurface,
  );

  final double margin = EzConfig.get(marginKey);
  final double padding = EzConfig.get(paddingKey);
  final double spacing = EzConfig.get(spacingKey);

  // Build the ThemeData //

  return ThemeData(
    // Color scheme //

    brightness: brightness,
    colorScheme: colorScheme,

    // Typography //

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
      titleTextStyle: textTheme.headlineLarge?.copyWith(
        color: colorScheme.onSurface,
      ),
      centerTitle: true,
      titleSpacing: 0,
    ),

    bannerTheme: MaterialBannerThemeData(
      backgroundColor: colorScheme.onSurface,
      surfaceTintColor: Colors.transparent,
      contentTextStyle: textTheme.bodyLarge?.copyWith(
        color: colorScheme.surface,
      ),
      padding: EdgeInsets.all(margin),
    ),

    // Bottom navigation bar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: appBarIconData,
      unselectedIconTheme: appBarIconData,
    ),

    // Cards
    cardTheme: const CardTheme(margin: EdgeInsets.zero),

    // Dialogs
    dialogTheme: DialogTheme(
      titleTextStyle: textTheme.titleLarge?.copyWith(
        color: colorScheme.onBackground,
      ),
      contentTextStyle: textTheme.bodyLarge?.copyWith(
        color: colorScheme.onBackground,
      ),
      alignment: Alignment.center,
      actionsPadding: EdgeInsets.only(
        top: (spacing > padding) ? (spacing - padding) : 0.0,
        left: spacing,
        right: spacing,
        bottom: spacing,
      ),
    ),

    // Dropdown menu
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: textTheme.bodyLarge,
    ),

    // Elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: textTheme.bodyLarge,
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
        iconSize: textTheme.bodyLarge?.fontSize,
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        side: null,
      ),
    ),

    // Outlined button
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle: textTheme.bodyLarge,
        alignment: Alignment.center,
        padding: EdgeInsets.all(padding),
        backgroundColor: colorScheme.background,
      ),
    ),

    // TabBar
    tabBarTheme: TabBarTheme(
      labelStyle: textTheme.bodyLarge,
      unselectedLabelStyle: textTheme.bodyLarge,
    ),

    // Text button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: textTheme.bodyLarge,
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        side: null,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),

    // Tooltip
    tooltipTheme: TooltipThemeData(
      margin: EdgeInsets.all(margin),
      padding: EdgeInsets.all(padding),
      textStyle: textTheme.bodyLarge,
      textAlign: TextAlign.center,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border.all(color: colorScheme.secondary),
      ),
      waitDuration: const Duration(milliseconds: 750),
    ),
  );
}
