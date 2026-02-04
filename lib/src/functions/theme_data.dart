/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';

/// Creates a [ThemeData] from [EzConfig] values
ThemeData ezThemeData(Brightness brightness, bool ltr) {
  //* Gather values from EzConfig *//

  final bool isDark = Brightness.dark == brightness;

  // Shared //

  final ColorScheme colorScheme = ezColorScheme(brightness);
  final Color focusColor = colorScheme.primary.withValues(alpha: focusOpacity);

  final int animDuration = Brightness.dark == brightness
      ? EzConfig.get(darkAnimationDurationKey)
      : EzConfig.get(lightAnimationDurationKey);

  final double margin =
      isDark ? EzConfig.get(darkMarginKey) : EzConfig.get(lightMarginKey);
  final double padding =
      isDark ? EzConfig.get(darkPaddingKey) : EzConfig.get(lightPaddingKey);
  final double spacing =
      isDark ? EzConfig.get(darkSpacingKey) : EzConfig.get(lightSpacingKey);

  final double iconSize =
      isDark ? EzConfig.get(darkIconSizeKey) : EzConfig.get(lightIconSizeKey);

  final TextTheme textTheme =
      ezTextTheme(colorScheme.onSurface, isDark: isDark);

  // Buttons //

  final double buttonOpacity =
      EzConfig.get(isDark ? darkButtonOpacityKey : lightButtonOpacityKey);

  final Color buttonBackground =
      colorScheme.surface.withValues(alpha: buttonOpacity);
  final Color primaryButtonBackground =
      colorScheme.primary.withValues(alpha: buttonOpacity);
  final Color buttonShadow =
      colorScheme.shadow.withValues(alpha: buttonOpacity * shadowMod);

  final double crucialButtonOpacity = max(buttonOpacity, focusOpacity);

  final Color crucialButtonBackground =
      colorScheme.surface.withValues(alpha: crucialButtonOpacity);
  final Color crucialPrimaryButtonBackground =
      colorScheme.primary.withValues(alpha: crucialButtonOpacity);

  final double outlineOpacity = EzConfig.get(
      isDark ? darkButtonOutlineOpacityKey : lightButtonOutlineOpacityKey);

  final Color buttonContainer =
      colorScheme.primaryContainer.withValues(alpha: outlineOpacity);
  final Color enabledOutline =
      colorScheme.outline.withValues(alpha: outlineOpacity);
  final Color disabledOutline =
      colorScheme.outlineVariant.withValues(alpha: outlineOpacity);

  // Icons //

  final IconThemeData iconData = IconThemeData(
    color: colorScheme.primary,
    size: iconSize,
    applyTextScaling: true,
  );
  final IconThemeData appBarIconData = IconThemeData(
    color: colorScheme.primary,
    size: textTheme.headlineLarge!.fontSize,
    applyTextScaling: true,
  );

  // Text //

  final double textBackgroundOpacity = EzConfig.get(
      isDark ? darkTextBackgroundOpacityKey : lightTextBackgroundOpacityKey);

  final Color textBackgroundColor =
      colorScheme.surface.withValues(alpha: textBackgroundOpacity);

  final double crucialTextBackgroundOpacity =
      max(textBackgroundOpacity, focusOpacity);

  final Color crucialTextBackgroundColor =
      colorScheme.surface.withValues(alpha: crucialTextBackgroundOpacity);

  //* Return the ThemeData *//

  return ThemeData(
    // UX //

    materialTapTargetSize: MaterialTapTargetSize.padded,

    // Color scheme //

    brightness: brightness,
    colorScheme: colorScheme,

    dividerColor: colorScheme.secondary,
    hoverColor: focusColor,
    scaffoldBackgroundColor: colorScheme.surfaceContainer,

    // Transitions //

    pageTransitionsTheme: animDuration > minAnimationDuration
        ? EzTransitions()
        : EzNoTransitions(),

    // Typography //

    textTheme: textTheme,
    primaryTextTheme: textTheme,

    iconTheme: iconData,
    primaryIconTheme: iconData,

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: colorScheme.secondary,
      selectionColor: colorScheme.secondary.withValues(alpha: selectionOpacity),
      selectionHandleColor: colorScheme.primary,
    ),

    // Widgets //

    // App bar
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.surfaceDim,
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
      showDragHandle: true,
      dragHandleColor: colorScheme.onSurface,
    ),

    // Card
    cardTheme: CardThemeData(
      color: colorScheme.surfaceDim
          .withValues(alpha: crucialTextBackgroundOpacity),
      shadowColor: colorScheme.shadow
          .withValues(alpha: crucialTextBackgroundOpacity * shadowMod),
      margin: EdgeInsets.zero,
    ),

    // Checkbox
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) => (states.contains(WidgetState.selected))
            ? colorScheme.primary
            : colorScheme.surface,
      ),
      checkColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) => (states.contains(WidgetState.selected))
            ? colorScheme.onPrimary
            : null,
      ),
      overlayColor: WidgetStateProperty.all(focusColor),
      side: BorderSide(color: colorScheme.primary),
    ),

    // Dialog
    dialogTheme: DialogThemeData(
      backgroundColor: colorScheme.surfaceDim,
      titleTextStyle: textTheme.titleLarge,
      contentTextStyle: textTheme.bodyLarge,
      alignment: Alignment.center,
    ),

    // Divider
    dividerTheme: DividerThemeData(
      color: colorScheme.secondary,
      space: spacing * 3,
    ),

    // Drawer
    navigationDrawerTheme: NavigationDrawerThemeData(
      backgroundColor: colorScheme.surfaceDim,
    ),

    // Dropdown menu
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: textTheme.bodyLarge,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: buttonBackground,
        prefixIconColor: colorScheme.primary,
        iconColor: colorScheme.primary,
        suffixIconColor: colorScheme.primary,
        hintStyle: textTheme.bodyLarge?.copyWith(color: colorScheme.outline),
        labelStyle: textTheme.labelLarge,
        helperStyle: textTheme.labelLarge,
        errorStyle: textTheme.labelLarge?.copyWith(color: colorScheme.error),
        errorMaxLines: 1,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: buttonContainer),
          borderRadius: ezRoundEdge,
          gapPadding: 0,
        ),
      ),
    ),

    // Elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonBackground,
        foregroundColor: colorScheme.onSurface,
        shadowColor: buttonShadow,
        disabledForegroundColor: colorScheme.outline,
        iconColor: colorScheme.primary,
        disabledIconColor: colorScheme.outline,
        overlayColor: colorScheme.primary,
        side: BorderSide(color: buttonContainer),
        textStyle: textTheme.bodyLarge,
        alignment: Alignment.center,
        padding: EdgeInsets.all(padding),
      ),
    ),

    // Expansion tile
    expansionTileTheme: ltr
        ? ExpansionTileThemeData(
            backgroundColor: colorScheme.surface,
            collapsedBackgroundColor: colorScheme.surfaceContainer,
            iconColor: colorScheme.primary,
            collapsedIconColor: colorScheme.primary,
            tilePadding: EdgeInsets.only(
              left: margin,
              right: spacing,
              top: margin,
              bottom: margin,
            ),
            childrenPadding: EdgeInsets.only(
              left: margin * 2,
              right: spacing,
              bottom: margin,
            ),
            expandedAlignment: Alignment.centerLeft,
          )
        : ExpansionTileThemeData(
            backgroundColor: colorScheme.surface,
            collapsedBackgroundColor: colorScheme.surfaceContainer,
            iconColor: colorScheme.primary,
            collapsedIconColor: colorScheme.primary,
            tilePadding: EdgeInsets.only(
              left: spacing,
              right: margin,
              top: margin,
              bottom: margin,
            ),
            childrenPadding: EdgeInsets.only(
              left: spacing,
              right: margin * 2,
              bottom: margin,
            ),
            expandedAlignment: Alignment.centerRight,
          ),

    // Floating action button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: crucialPrimaryButtonBackground,
      foregroundColor: colorScheme.onPrimary,
      hoverColor: focusColor,
      extendedPadding: EdgeInsets.zero,
      shape: const CircleBorder(),
      iconSize: iconSize,
      sizeConstraints: BoxConstraints(
        minWidth: (iconSize * 1.25) + padding,
        maxWidth: (iconSize * 1.25) + padding,
        minHeight: (iconSize * 1.25) + padding,
        maxHeight: (iconSize * 1.25) + padding,
      ),
    ),

    // Icon button; styled for Scaffolds
    // EzIconButtons are styled for page content
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        backgroundColor:
            colorScheme.surfaceDim.withValues(alpha: buttonOpacity),
        foregroundColor: colorScheme.primary,
        disabledForegroundColor: colorScheme.outline,
        overlayColor: colorScheme.primary,
        side: BorderSide.none,
        iconSize: iconSize,
        alignment: Alignment.center,
        padding: EzInsets.wrap(padding),
      ),
    ),

    // Input decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: crucialTextBackgroundColor,
      prefixIconColor: colorScheme.primary,
      iconColor: colorScheme.primary,
      suffixIconColor: colorScheme.primary,
      hintStyle: textTheme.bodyLarge?.copyWith(color: colorScheme.outline),
      labelStyle: textTheme.labelLarge,
      helperStyle: textTheme.labelLarge,
      errorStyle: textTheme.labelLarge!.copyWith(color: colorScheme.error),
      errorMaxLines: 1,
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colorScheme.errorContainer),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: buttonContainer),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colorScheme.error),
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: disabledOutline),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: enabledOutline),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: enabledOutline),
      ),
    ),

    // Menu
    menuTheme: MenuThemeData(
      style: MenuStyle(
        backgroundColor: WidgetStateProperty.all(colorScheme.surface),
        side: WidgetStateProperty.all(BorderSide(color: buttonContainer)),
        alignment: Alignment.center,
      ),
    ),

    // Menu button
    menuButtonTheme: MenuButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        disabledForegroundColor: colorScheme.outline,
        iconColor: colorScheme.primary,
        disabledIconColor: colorScheme.outline,
        overlayColor: colorScheme.primary,
        side: null,
        textStyle: textTheme.bodyLarge,
        alignment: Alignment.center,
        padding: EzInsets.wrap(padding),
      ),
    ),

    // Progress indicator
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: colorScheme.secondary,
    ),

    // Radio button
    radioTheme:
        RadioThemeData(overlayColor: WidgetStateProperty.all(focusColor)),

    // Slider
    sliderTheme: SliderThemeData(
      thumbShape: RoundSliderThumbShape(
        enabledThumbRadius: iconSize / 2,
        disabledThumbRadius: iconSize / 2,
      ),
    ),

    // Segmented button
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: SegmentedButton.styleFrom(
        backgroundColor: buttonBackground,
        selectedBackgroundColor: primaryButtonBackground,
        foregroundColor: colorScheme.primary,
        selectedForegroundColor: colorScheme.onPrimary,
        disabledForegroundColor: colorScheme.outline,
        side: BorderSide(color: buttonContainer),
        textStyle: textTheme.bodyLarge,
        alignment: Alignment.center,
        padding: EdgeInsets.all(padding),
      ),
    ),

    // Snackbar
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: colorScheme.surfaceDim,
      closeIconColor: colorScheme.primary,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: colorScheme.secondary),
        borderRadius: ezRoundEdge,
      ),
      contentTextStyle: textTheme.bodyLarge,
      insetPadding: EdgeInsets.all(margin),
    ),

    // Switch
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) => (states.contains(WidgetState.selected))
            ? colorScheme.primary
            : colorScheme.outline,
      ),
      trackColor: WidgetStateProperty.all(crucialButtonBackground),
      trackOutlineColor: WidgetStateProperty.all(buttonContainer),
      overlayColor: WidgetStateProperty.all(focusColor),
    ),

    // Text button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: textBackgroundColor,
        foregroundColor: colorScheme.onSurface,
        disabledForegroundColor: colorScheme.outline,
        iconColor: colorScheme.primary,
        disabledIconColor: colorScheme.outline,
        overlayColor: colorScheme.primary,
        side: null,
        textStyle: textTheme.bodyLarge,
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
      ),
    ),

    // Tooltip
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: colorScheme.surfaceDim,
        border: Border.all(color: colorScheme.secondary),
        borderRadius: ezRoundEdge,
      ),
      textStyle: textTheme.bodyLarge,
      textAlign: TextAlign.center,
      margin: EdgeInsets.all(margin),
      padding: EdgeInsets.all(margin),
      waitDuration: const Duration(milliseconds: 750),
    ),
  );
}
