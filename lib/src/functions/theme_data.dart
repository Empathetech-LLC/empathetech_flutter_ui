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

  // Colors
  final ColorScheme colorScheme = ezColorScheme(brightness);
  final Color focusColor = colorScheme.primary.withValues(alpha: focusOpacity);

  // Design

  final double padding = isDark ? EzConfig.get(darkPaddingKey) : EzConfig.get(lightPaddingKey);

  final double margin = isDark ? EzConfig.get(darkMarginKey) : EzConfig.get(lightMarginKey);
  final double spacing = isDark ? EzConfig.get(darkSpacingKey) : EzConfig.get(lightSpacingKey);

  final int animDuration = isDark
      ? EzConfig.get(darkAnimationDurationKey)
      : EzConfig.get(lightAnimationDurationKey);
  final int threeQAnim = (animDuration * 0.75).toInt();

  // Text
  final TextTheme textTheme = ezTextTheme(colorScheme.onSurface, isDark: isDark);

  final double iconSize =
      isDark ? EzConfig.get(darkIconSizeKey) : EzConfig.get(lightIconSizeKey);

  // Buttons //

  // Pointer
  const WidgetStateProperty<MouseCursor?> enabledClicks =
      WidgetStateProperty<MouseCursor?>.fromMap(<WidgetStatesConstraint, MouseCursor?>{
    WidgetState.dragged: SystemMouseCursors.click,
    WidgetState.focused: SystemMouseCursors.click,
    WidgetState.hovered: SystemMouseCursors.click,
    WidgetState.pressed: SystemMouseCursors.click,
    WidgetState.scrolledUnder: SystemMouseCursors.click,
    WidgetState.selected: SystemMouseCursors.click,
  });

  // Shape/style
  final OutlinedBorder buttonShape =
      EBSConfig.lookup(EzConfig.get(isDark ? darkButtonShapeKey : lightButtonShapeKey)).shape;

  final double borderWidth = EzConfig.get(isDark ? darkBorderWidthKey : lightBorderWidthKey);
  BorderSide buildBorder(Color color) =>
      borderWidth == 0 ? BorderSide.none : BorderSide(color: color, width: borderWidth);

  // Core opacity
  final double buttonOpacity =
      EzConfig.get(isDark ? darkButtonOpacityKey : lightButtonOpacityKey);

  final Color buttonBackground = colorScheme.surface.withValues(alpha: buttonOpacity);
  final Color primaryButtonBackground = colorScheme.primary.withValues(alpha: buttonOpacity);
  final Color buttonShadow = buttonOpacity < 1.0
      ? colorScheme.shadow.withValues(alpha: buttonOpacity * shadowMod)
      : colorScheme.shadow;

  final double crucialButtonOpacity = max(buttonOpacity, focusOpacity);

  final Color crucialButtonBackground =
      colorScheme.surface.withValues(alpha: crucialButtonOpacity);
  final Color crucialPrimaryButtonBackground =
      colorScheme.primary.withValues(alpha: crucialButtonOpacity);

  // Border opacity
  final double borderOpacity =
      EzConfig.get(isDark ? darkBorderOpacityKey : lightBorderOpacityKey);

  final Color buttonBorder = colorScheme.primaryContainer.withValues(alpha: borderOpacity);
  final Color disabledBorder = colorScheme.outlineVariant.withValues(alpha: borderOpacity);

  final double crucialBorderOpacity = max(borderOpacity, focusOpacity);

  final Color crucialBorder =
      colorScheme.primaryContainer.withValues(alpha: crucialBorderOpacity);
  final Color crucialDisabledBorder =
      colorScheme.outlineVariant.withValues(alpha: crucialBorderOpacity);

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

  final double textBackgroundOpacity =
      EzConfig.get(isDark ? darkTextBackgroundOpacityKey : lightTextBackgroundOpacityKey);

  final Color textBackgroundColor =
      colorScheme.surface.withValues(alpha: textBackgroundOpacity);

  final double crucialTextBackgroundOpacity = max(textBackgroundOpacity, focusOpacity);

  final Color inputBackgroundColor =
      colorScheme.surface.withValues(alpha: max(buttonOpacity, crucialTextBackgroundOpacity));
  final Color crucialTextShadow = crucialTextBackgroundOpacity < 1.0
      ? colorScheme.shadow.withValues(alpha: crucialTextBackgroundOpacity * shadowMod)
      : colorScheme.shadow;

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

    pageTransitionsTheme:
        animDuration > minAnimationDuration ? EzTransitions() : EzNoTransitions(),

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
      color: colorScheme.surfaceDim.withValues(alpha: crucialTextBackgroundOpacity),
      shadowColor: crucialTextShadow,
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
        (Set<WidgetState> states) =>
            (states.contains(WidgetState.selected)) ? colorScheme.onPrimary : null,
      ),
      overlayColor: WidgetStateProperty.all(focusColor),
      side: buildBorder(colorScheme.primary),
      shape: buttonShape,
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
        border: OutlineInputBorder(
          borderSide: buildBorder(buttonBorder),
          gapPadding: 0,
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: buildBorder(disabledBorder),
          gapPadding: 0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: buildBorder(buttonBorder),
          gapPadding: 0,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: buildBorder(colorScheme.error),
          gapPadding: 0,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: buildBorder(colorScheme.secondary.withValues(alpha: borderOpacity)),
          gapPadding: 0,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: buildBorder(colorScheme.error),
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
        side: buildBorder(buttonBorder),
        enabledMouseCursor: SystemMouseCursors.click,
        shape: buttonShape,
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
            tilePadding: EdgeInsets.symmetric(vertical: margin),
            childrenPadding: EdgeInsets.only(left: margin * 2),
            expandedAlignment: Alignment.centerLeft,
            expansionAnimationStyle: AnimationStyle(
              curve: Curves.easeInOut,
              reverseCurve: Curves.easeInOut,
              duration: Duration(milliseconds: threeQAnim),
              reverseDuration: Duration(milliseconds: threeQAnim),
            ),
          )
        : ExpansionTileThemeData(
            backgroundColor: colorScheme.surface,
            collapsedBackgroundColor: colorScheme.surfaceContainer,
            iconColor: colorScheme.primary,
            collapsedIconColor: colorScheme.primary,
            tilePadding: EdgeInsets.symmetric(vertical: margin),
            childrenPadding: EdgeInsets.only(left: margin * 2),
            expandedAlignment: Alignment.centerRight,
            expansionAnimationStyle: AnimationStyle(
              curve: Curves.easeInOut,
              reverseCurve: Curves.easeInOut,
              duration: Duration(milliseconds: threeQAnim),
              reverseDuration: Duration(milliseconds: threeQAnim),
            ),
          ),

    // Floating action button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: crucialPrimaryButtonBackground,
      foregroundColor: colorScheme.onPrimary,
      hoverColor: focusColor,
      extendedPadding: EdgeInsets.zero,
      shape: buttonShape,
      mouseCursor: enabledClicks,
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
        backgroundColor: colorScheme.surfaceDim.withValues(alpha: buttonOpacity),
        foregroundColor: colorScheme.primary,
        disabledForegroundColor: colorScheme.outline,
        overlayColor: colorScheme.primary,
        side: BorderSide.none,
        enabledMouseCursor: SystemMouseCursors.click,
        shape: buttonShape,
        iconSize: iconSize,
        alignment: Alignment.center,
        padding: EzInsets.wrap(padding),
      ),
    ),

    // Input decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: inputBackgroundColor,
      prefixIconColor: colorScheme.primary,
      iconColor: colorScheme.primary,
      suffixIconColor: colorScheme.primary,
      hintStyle: textTheme.bodyLarge?.copyWith(color: colorScheme.outline),
      labelStyle: textTheme.labelLarge,
      helperStyle: textTheme.labelLarge,
      errorStyle: textTheme.labelLarge!.copyWith(color: colorScheme.error),
      errorMaxLines: 1,
      border: UnderlineInputBorder(borderSide: buildBorder(crucialBorder)),
      disabledBorder: UnderlineInputBorder(borderSide: buildBorder(crucialDisabledBorder)),
      enabledBorder: UnderlineInputBorder(borderSide: buildBorder(crucialBorder)),
      errorBorder: UnderlineInputBorder(borderSide: buildBorder(colorScheme.error)),
      focusedBorder: UnderlineInputBorder(
          borderSide:
              buildBorder(colorScheme.secondary.withValues(alpha: crucialBorderOpacity))),
      focusedErrorBorder: UnderlineInputBorder(borderSide: buildBorder(colorScheme.error)),
    ),

    // Menu
    menuTheme: MenuThemeData(
      style: MenuStyle(
        backgroundColor: WidgetStateProperty.all(crucialButtonBackground),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        side: WidgetStateProperty.all(buildBorder(buttonBorder)),
        alignment: Alignment.center,
      ),
    ),

    // Menu button
    menuButtonTheme: MenuButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: crucialButtonBackground,
        foregroundColor: colorScheme.onSurface,
        disabledForegroundColor: colorScheme.outline,
        iconColor: colorScheme.primary,
        disabledIconColor: colorScheme.outline,
        enabledMouseCursor: SystemMouseCursors.click,
        overlayColor: colorScheme.primary,
        side: null,
        shape: null,
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
      overlayColor: WidgetStateProperty.all(focusColor),
      mouseCursor: enabledClicks,
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
        enabledMouseCursor: SystemMouseCursors.click,
        foregroundColor: colorScheme.primary,
        selectedForegroundColor: colorScheme.onPrimary,
        disabledForegroundColor: colorScheme.outline,
        side: buildBorder(buttonBorder),
        shape: buttonShape,
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
      shape: buttonShape.copyWith(side: buildBorder(colorScheme.secondary)),
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
      trackOutlineColor: WidgetStateProperty.all(buttonBorder),
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
        enabledMouseCursor: SystemMouseCursors.click,
        overlayColor: colorScheme.primary,
        side: null,
        shape: null,
        textStyle: textTheme.bodyLarge,
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
      ),
    ),

    // Tooltip
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: colorScheme.surfaceDim,
        border: Border.all(
          color: colorScheme.secondary,
          width: borderWidth,
        ),
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
