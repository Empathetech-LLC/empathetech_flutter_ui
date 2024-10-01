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
    color: colorScheme.primary,
    size: textTheme.titleLarge?.fontSize,
    applyTextScaling: true,
  );
  final IconThemeData appBarIconData = IconThemeData(
    color: colorScheme.primary,
    size: textTheme.headlineLarge?.fontSize,
    applyTextScaling: true,
  );

  final double textBackgroundOpacity = EzConfig.get(
    brightness == Brightness.dark
        ? darkTextBackgroundOKey
        : lightTextBackgroundOKey,
  );

  final double margin = EzConfig.get(marginKey);
  final double padding = EzConfig.get(paddingKey);
  final double spacing = EzConfig.get(spacingKey);

  // Build the ThemeData //

  return ThemeData(
    // UX //

    materialTapTargetSize: MaterialTapTargetSize.padded,

    // Color scheme //

    brightness: brightness,
    colorScheme: colorScheme,
    dividerColor: colorScheme.secondary,
    primaryColor: colorScheme.primary,
    scaffoldBackgroundColor: colorScheme.surfaceContainer,

    // Transitions //

    pageTransitionsTheme: EzTransitions(),

    // Typography //

    textTheme: textTheme,
    primaryTextTheme: textTheme,

    iconTheme: iconData,
    primaryIconTheme: iconData,

    // Widgets //

    // App bar
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      titleTextStyle: textTheme.headlineLarge,
      iconTheme: appBarIconData,
      actionsIconTheme: appBarIconData,
      centerTitle: true,
      titleSpacing: 0,
    ),

    // Bottom sheet
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: colorScheme.surfaceContainer,
      modalBackgroundColor: colorScheme.surfaceContainer,
      dragHandleColor: colorScheme.onSurface,
    ),

    // Card
    cardTheme: CardTheme(
      color: colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      margin: EdgeInsets.zero,
    ),

    // Checkbox
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return colorScheme.surface.withOpacity(textBackgroundOpacity);
        } else if (states.contains(WidgetState.selected)) {
          return colorScheme.primary;
        }
        return null;
      }),
      checkColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.onPrimary;
        }
        return null;
      }),
      side: BorderSide(color: colorScheme.primary),
    ),

    // Dialog
    dialogTheme: DialogTheme(
      backgroundColor: colorScheme.surfaceContainer,
      titleTextStyle: textTheme.titleLarge,
      contentTextStyle: textTheme.bodyLarge,
      alignment: Alignment.center,
    ),

    // Divider
    dividerTheme: DividerThemeData(
      color: colorScheme.secondary,
      space: spacing * 4, // Double separator
      thickness: 1,
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
        filled: true,
        fillColor: colorScheme.surface,
        prefixIconColor: colorScheme.primary,
        iconColor: colorScheme.primary,
        suffixIconColor: colorScheme.primary,
        hintStyle: textTheme.bodyLarge,
        labelStyle: textTheme.labelLarge,
        helperStyle: textTheme.labelLarge,
        errorStyle: textTheme.labelLarge?.copyWith(color: colorScheme.error),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.primaryContainer),
          borderRadius: ezRoundEdge,
          gapPadding: 0,
        ),
      ),
    ),

    // Elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        iconColor: colorScheme.primary,
        disabledIconColor: colorScheme.outline,
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
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.primary,
        iconSize: textTheme.titleLarge?.fontSize,
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        side: null,
      ),
    ),

    // Input decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surface.withOpacity(textBackgroundOpacity),
      hintStyle: textTheme.bodyLarge,
      labelStyle: textTheme.labelLarge,
      errorStyle: textTheme.labelLarge?.copyWith(color: colorScheme.error),
      errorMaxLines: 1,
    ),

    // Menu
    menuTheme: MenuThemeData(
      style: MenuStyle(
        backgroundColor: WidgetStateProperty.all(colorScheme.surface),
        side: WidgetStateProperty.all(
          BorderSide(color: colorScheme.primaryContainer),
        ),
        padding: WidgetStateProperty.all(EdgeInsets.only(bottom: padding)),
        alignment: Alignment.center,
      ),
    ),

    // Menu button
    menuButtonTheme: MenuButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: colorScheme.surface,
        disabledBackgroundColor: colorScheme.outline,
        foregroundColor: colorScheme.onSurface,
        disabledForegroundColor: colorScheme.onSurface,
        textStyle: textTheme.bodyLarge,
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: padding, right: padding, top: padding),
        side: null,
      ),
    ),

    // Progress indicator
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: colorScheme.secondary,
    ),

    // Segmented button
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: SegmentedButton.styleFrom(
        backgroundColor: colorScheme.surface,
        selectedBackgroundColor: colorScheme.primary,
        disabledBackgroundColor: colorScheme.outline,
        foregroundColor: colorScheme.primary,
        selectedForegroundColor: colorScheme.onPrimary,
        disabledForegroundColor: colorScheme.onSurface,
        textStyle: textTheme.bodyLarge,
        alignment: Alignment.center,
        padding: EdgeInsets.all(padding),
        side: BorderSide(color: colorScheme.primaryContainer),
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
        backgroundColor: Colors.transparent,
        foregroundColor: colorScheme.primary,
        textStyle: textTheme.bodyLarge,
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        side: null,
      ),
    ),

    // Tooltip
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border.all(color: colorScheme.secondary),
        borderRadius: ezRoundEdge,
      ),
      textStyle: textTheme.bodyLarge,
      textAlign: TextAlign.center,
      margin: EdgeInsets.all(margin),
      padding: EdgeInsets.all(padding),
      waitDuration: const Duration(milliseconds: 750),
    ),
  );
}
