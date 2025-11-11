/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:feedback/feedback.dart';

/// 0.667
/// Shadow opacity should be "faster" than surface
/// 1:1 looks... well, foggy
const double shadowMod = 0.667;

/// Crucial opacity threshold - some things are too important to be broken by user settings
const double crucialOT = 0.25;

/// Creates a [ThemeData] from [EzConfig] values
ThemeData ezThemeData(Brightness brightness) {
  //* Gather values from EzConfig *//

  // Shared //

  final ColorScheme colorScheme = ezColorScheme(brightness);
  final Color highlightColor =
      colorScheme.primary.withValues(alpha: highlightOpacity);

  final TextTheme textTheme = ezTextTheme(colorScheme.onSurface);

  final double margin = EzConfig.get(marginKey);
  final double padding = EzConfig.get(paddingKey);
  final double spacing = EzConfig.get(spacingKey);

  final int animDuration = EzConfig.get(animationDurationKey);

  // Icons //

  final double iconSize = EzConfig.get(iconSizeKey);

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

  final double textOpacity = EzConfig.get(
    brightness == Brightness.dark
        ? darkTextBackgroundOpacityKey
        : lightTextBackgroundOpacityKey,
  );
  final bool calcText = textOpacity < 1.0;

  final Color textSurfaceColor = calcText
      ? colorScheme.surface.withValues(alpha: textOpacity)
      : colorScheme.surface;

  // Buttons //

  final double buttonOpacity = EzConfig.get(
    brightness == Brightness.dark
        ? darkButtonOpacityKey
        : lightButtonOpacityKey,
  );
  final double outlineOpacity = EzConfig.get(
    brightness == Brightness.dark
        ? darkButtonOutlineOpacityKey
        : lightButtonOutlineOpacityKey,
  );

  final bool calcButton = buttonOpacity < 1.0;
  final bool calcOutline = outlineOpacity < 1.0;

  final bool clearButton = buttonOpacity < 0.01;
  final bool clearOutline = outlineOpacity < 0.01;

  final Color buttonBackground = calcButton
      ? clearButton
          ? Colors.transparent
          : colorScheme.surface.withValues(alpha: buttonOpacity)
      : colorScheme.surface;
  final Color primaryButtonBackground = calcButton
      ? clearButton
          ? Colors.transparent
          : colorScheme.primary.withValues(alpha: buttonOpacity)
      : colorScheme.primary;
  final Color buttonShadow = calcButton
      ? clearButton
          ? Colors.transparent
          : colorScheme.shadow.withValues(alpha: buttonOpacity * shadowMod)
      : colorScheme.shadow;

  final Color buttonContainer = calcOutline
      ? clearOutline
          ? Colors.transparent
          : colorScheme.primaryContainer.withValues(alpha: outlineOpacity)
      : colorScheme.primaryContainer;
  final Color enabledOutline = calcOutline
      ? clearOutline
          ? Colors.transparent
          : colorScheme.outline.withValues(alpha: outlineOpacity)
      : colorScheme.outline;
  final Color disabledOutline = calcOutline
      ? clearOutline
          ? Colors.transparent
          : colorScheme.outlineVariant.withValues(alpha: outlineOpacity)
      : colorScheme.outlineVariant;

  // Misc //

  final double crucialOpacity =
      <double>[buttonOpacity, textOpacity, crucialOT].reduce(max);

  final bool calcCrucial = crucialOpacity < 1.0;

  final Color crucialSurface = calcCrucial
      ? colorScheme.surface.withValues(alpha: crucialOpacity)
      : colorScheme.surface;

  //* Return the ThemeData *//

  return ThemeData(
    // UX //

    materialTapTargetSize: MaterialTapTargetSize.padded,

    // Color scheme //

    brightness: brightness,
    colorScheme: colorScheme,

    dividerColor: colorScheme.secondary,
    hoverColor: highlightColor,
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
      color: calcCrucial
          ? colorScheme.surfaceDim.withValues(alpha: crucialOpacity)
          : colorScheme.surfaceDim,
      shadowColor: calcCrucial
          ? colorScheme.shadow.withValues(alpha: crucialOpacity * shadowMod)
          : colorScheme.shadow,
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
      overlayColor: WidgetStateProperty.all(highlightColor),
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

    // Floating action button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: calcCrucial
          ? colorScheme.primary.withValues(alpha: crucialOpacity)
          : colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      hoverColor: highlightColor,
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
        backgroundColor: calcButton
            ? colorScheme.surfaceDim.withValues(alpha: buttonOpacity)
            : colorScheme.surfaceDim,
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
      fillColor: crucialSurface,
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
    radioTheme: RadioThemeData(
      overlayColor: WidgetStateProperty.all(highlightColor),
    ),

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
      trackColor: WidgetStateProperty.all(crucialSurface),
      trackOutlineColor: WidgetStateProperty.all(buttonContainer),
      overlayColor: WidgetStateProperty.all(highlightColor),
    ),

    // Text button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: textSurfaceColor,
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

/// For open source consumers: this is Empathetech LLC's feedback theme
/// You have permission to modify this code
/// You do not have permission to use this theme in your app
final FeedbackThemeData empathFeedbackDark = FeedbackThemeData(
  background: Colors.grey,
  feedbackSheetColor: Colors.black,
  activeFeedbackModeColor: empathEucalyptus,
  bottomSheetDescriptionStyle: ezBodyStyle(Colors.white),
  bottomSheetTextInputStyle: ezBodyStyle(Colors.white),
  sheetIsDraggable: true,
  dragHandleColor: Colors.white,
);

/// For open source consumers: this is Empathetech LLC's feedback theme
/// You have permission to modify this code
/// You do not have permission to use this theme in your app
final FeedbackThemeData empathFeedbackLight = FeedbackThemeData(
  background: Colors.grey,
  feedbackSheetColor: Colors.white,
  activeFeedbackModeColor: empathPurple,
  bottomSheetDescriptionStyle: ezBodyStyle(Colors.black),
  bottomSheetTextInputStyle: ezBodyStyle(Colors.black),
  sheetIsDraggable: true,
  dragHandleColor: Colors.black,
);
