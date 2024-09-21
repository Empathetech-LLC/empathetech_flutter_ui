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

  final double textBackgroundOpacity = EzConfig.get(textBackgroundOKey);

  final double margin = EzConfig.get(marginKey);
  final double padding = EzConfig.get(paddingKey);
  final double spacing = EzConfig.get(spacingKey);

  // Build the ThemeData //

  return ThemeData(
    // Color scheme //

    brightness: brightness,
    colorScheme: colorScheme,
    dividerColor: colorScheme.secondary,
    primaryColor: colorScheme.primary,
    scaffoldBackgroundColor: colorScheme.surfaceContainer,

    // Transitions //

    pageTransitionsTheme: EzTransitions(),

    // Typography //

    iconTheme: iconData,
    textTheme: textTheme,
    primaryIconTheme: iconData,
    primaryTextTheme: textTheme,

    // Widgets //

    // App bar
    appBarTheme: AppBarTheme(
      actionsIconTheme: appBarIconData,
      backgroundColor: colorScheme.surface,
      centerTitle: true,
      iconTheme: appBarIconData,
      foregroundColor: colorScheme.onSurface,
      titleSpacing: 0,
      titleTextStyle: textTheme.headlineLarge,
    ),

    // Bottom sheet
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: colorScheme.surfaceContainer,
      dragHandleColor: colorScheme.onSurface,
      modalBackgroundColor: colorScheme.surfaceContainer,
    ),

    // Card
    cardTheme: CardTheme(
      color: colorScheme.surface,
      margin: EdgeInsets.zero,
    ),

    // Dialog
    dialogTheme: DialogTheme(
      actionsPadding: EdgeInsets.only(
        top: (spacing > padding) ? (spacing - padding) : 0.0,
        left: spacing,
        right: spacing,
        bottom: spacing,
      ),
      alignment: Alignment.center,
      backgroundColor: colorScheme.surfaceContainer,
      contentTextStyle: textTheme.bodyLarge,
      titleTextStyle: textTheme.titleLarge,
    ),

    // Divider
    dividerTheme: DividerThemeData(
      color: colorScheme.secondary,
      space: (spacing + padding) * 2,
      thickness: 0.75,
    ),

    // Drawer
    navigationDrawerTheme: NavigationDrawerThemeData(
      backgroundColor: colorScheme.surfaceContainer,
      surfaceTintColor: colorScheme.surfaceTint,
    ),

    // Dropdown menu
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: textTheme.bodyLarge,
      inputDecorationTheme: InputDecorationTheme(
        errorStyle: textTheme.labelLarge?.copyWith(color: colorScheme.error),
        hintStyle: textTheme.bodyLarge,
        labelStyle: textTheme.labelLarge,
        fillColor: colorScheme.surface,
        filled: true,
      ),
    ),

    // Elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.primary,
        textStyle: textTheme.bodyLarge,
        padding: EdgeInsets.all(padding),
        side: BorderSide(color: colorScheme.primaryContainer),
      ),
    ),

    // Floating action button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primary,
      extendedPadding: EdgeInsets.all(padding),
      foregroundColor: colorScheme.onPrimary,
      shape: const CircleBorder(),
    ),

    // Icon button
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        alignment: Alignment.center,
        iconSize: textTheme.bodyLarge?.fontSize,
        padding: EdgeInsets.zero,
        side: null,
      ),
    ),

    // Input decoration
    inputDecorationTheme: InputDecorationTheme(
      errorStyle: textTheme.labelLarge?.copyWith(color: colorScheme.error),
      hintStyle: textTheme.bodyLarge,
      labelStyle: textTheme.labelLarge,
      fillColor: colorScheme.surface.withOpacity(textBackgroundOpacity),
      filled: true,
    ),

    // Segmented button
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: SegmentedButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: colorScheme.surface,
        disabledBackgroundColor: colorScheme.outline,
        disabledForegroundColor: colorScheme.onSurface,
        foregroundColor: colorScheme.onSurface,
        padding: EdgeInsets.all(padding),
        selectedBackgroundColor: colorScheme.primary,
        selectedForegroundColor: colorScheme.onPrimary,
        textStyle: textTheme.bodyLarge,
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
        alignment: Alignment.center,
        backgroundColor: colorScheme.surface.withOpacity(textBackgroundOpacity),
        padding: EdgeInsets.all(margin),
        side: null,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textStyle: textTheme.bodyLarge,
      ),
    ),

    // Tooltip
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border.all(color: colorScheme.secondary),
      ),
      margin: EdgeInsets.all(margin),
      padding: EdgeInsets.all(padding),
      textAlign: TextAlign.center,
      textStyle: textTheme.bodyLarge,
      waitDuration: const Duration(milliseconds: 750),
    ),
  );
}
