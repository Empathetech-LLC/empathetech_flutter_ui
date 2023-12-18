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

  final double margin = EzConfig.get(marginKey);
  final double padding = EzConfig.get(paddingKey);

  final TextTheme textTheme = ezTextTheme();

  final TextStyle appBarTextStyle = buildHeadlineMedium(
    color: colorScheme.onSurface,
  );
  final TextStyle tabBarTextStyle = buildTitleLarge(
    color: colorScheme.onSurface,
  );
  final TextStyle pageTextStyle = buildBodyLarge(
    color: colorScheme.onBackground,
  );
  final TextStyle buttonTextStyle = buildTitleMedium();
  final TextStyle textButtonStyle = buildTitleMedium();
  final TextStyle dialogTitleStyle = buildTitleLarge(
    color: colorScheme.onBackground,
  );
  final TextStyle dialogContentStyle = buildBodyLarge(
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
      selectedIconTheme: appBarIconData,
      unselectedIconTheme: appBarIconData.copyWith(
        color: colorScheme.outline,
      ),
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: buttonTextStyle,
        alignment: Alignment.center,
        padding: EdgeInsets.all(padding),
        side: BorderSide(color: colorScheme.primaryContainer),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      extendedPadding: EdgeInsets.all(padding),
      shape: const CircleBorder(),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle: textButtonStyle,
        alignment: Alignment.center,
        padding: EdgeInsets.all(padding),
        backgroundColor: colorScheme.background,
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

    // Popup menu
    popupMenuTheme: PopupMenuThemeData(textStyle: dialogContentStyle),

    // TabBar
    tabBarTheme: TabBarTheme(
      labelStyle: tabBarTextStyle,
      unselectedLabelStyle: tabBarTextStyle.copyWith(
        color: colorScheme.outline,
      ),
    ),

    // Tooltip
    tooltipTheme: TooltipThemeData(
      margin: EdgeInsets.all(margin),
      padding: EdgeInsets.all(padding),
      textStyle: pageTextStyle,
      textAlign: TextAlign.center,
      decoration: BoxDecoration(
        color: colorScheme.background,
        border: Border.all(color: colorScheme.secondary),
      ),
    ),
  );
}
