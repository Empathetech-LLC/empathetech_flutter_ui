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
      titleTextStyle: textTheme.titleLarge?.copyWith(
        color: colorScheme.onSurface,
      ),
      contentTextStyle: textTheme.bodyLarge?.copyWith(
        color: colorScheme.onSurface,
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
      textStyle: textTheme.bodyLarge?.copyWith(
        color: colorScheme.onSurface,
      ),
    ),

    // Elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.primary,
        padding: EdgeInsets.all(padding),
        side: BorderSide(color: colorScheme.primaryContainer),
        textStyle: textTheme.bodyLarge,
        alignment: Alignment.center,
      ),
    ),

    // Floating action button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      extendedPadding: EdgeInsets.all(padding),
      shape: const CircleBorder(),
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
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
      ),
    ),

    // Segmented button
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: SegmentedButton.styleFrom(
        textStyle: textTheme.bodyLarge,
        alignment: Alignment.center,
        padding: EdgeInsets.all(padding),
        selectedBackgroundColor: colorScheme.primary,
        selectedForegroundColor: colorScheme.onPrimary,
        disabledBackgroundColor: colorScheme.surface,
        disabledForegroundColor: colorScheme.onSurface,
      ),
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
