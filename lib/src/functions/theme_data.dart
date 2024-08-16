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

  final TextTheme textTheme = ezTextTheme(colorScheme.onSurface);

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
    scaffoldBackgroundColor: colorScheme.surfaceContainer,

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
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      titleTextStyle: textTheme.headlineLarge,
      centerTitle: true,
      titleSpacing: 0,
    ),

    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: colorScheme.surfaceContainer,
      modalBackgroundColor: colorScheme.surfaceContainer,
      dragHandleColor: colorScheme.onSurface,
    ),

    // Cards
    cardTheme: CardTheme(
      margin: EdgeInsets.zero,
      color: colorScheme.surface,
    ),

    // Dialogs
    dialogTheme: DialogTheme(
      backgroundColor: colorScheme.surfaceContainer,
      titleTextStyle: textTheme.titleLarge,
      contentTextStyle: textTheme.bodyLarge,
      alignment: Alignment.center,
      actionsPadding: EdgeInsets.only(
        top: (spacing > padding) ? (spacing - padding) : 0.0,
        left: spacing,
        right: spacing,
        bottom: spacing,
      ),
    ),

    // Dropdown menu
    dropdownMenuTheme: DropdownMenuThemeData(textStyle: textTheme.bodyLarge),

    // Elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: colorScheme.primary,
        backgroundColor: colorScheme.surface,
        textStyle: textTheme.bodyLarge,
        padding: EdgeInsets.all(padding),
        side: BorderSide(color: colorScheme.primaryContainer),
        alignment: Alignment.center,
      ),
    ),

    // Floating action button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: colorScheme.onPrimary,
      backgroundColor: colorScheme.primary,
      shape: const CircleBorder(),
      extendedPadding: EdgeInsets.all(padding),
    ),

    // Icon button
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        iconSize: textTheme.bodyLarge?.fontSize,
        side: null,
        padding: EdgeInsets.zero,
        alignment: Alignment.center,
      ),
    ),

    // Segmented button
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: SegmentedButton.styleFrom(
        selectedForegroundColor: colorScheme.onPrimary,
        selectedBackgroundColor: colorScheme.primary,
        disabledForegroundColor: colorScheme.onSurface,
        disabledBackgroundColor: colorScheme.surface,
        textStyle: textTheme.bodyLarge,
        padding: EdgeInsets.all(padding),
        alignment: Alignment.center,
      ),
    ),

    // Snackbar
    snackBarTheme: SnackBarThemeData(
      backgroundColor: colorScheme.surface,
      contentTextStyle: textTheme.bodyLarge,
    ),

    // Text button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: textTheme.bodyLarge,
        padding: EdgeInsets.zero,
        side: null,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.center,
      ),
    ),

    // Tooltip
    tooltipTheme: TooltipThemeData(
      padding: EdgeInsets.all(padding),
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border.all(color: colorScheme.secondary),
      ),
      textStyle: textTheme.bodyLarge,
      textAlign: TextAlign.center,
      waitDuration: const Duration(milliseconds: 750),
    ),
  );
}
