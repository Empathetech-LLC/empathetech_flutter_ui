// ignore_for_file: deprecated_member_use
// Color.value was deprecated without replacement, .toARGB32() should be in next stable release

/* empathetech_flutter_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Returns the guesstimated most readable text color (black/white) for [background]
/// Formula credit: https://stackoverflow.com/questions/3942878/how-to-decide-font-color-in-white-or-black-depending-on-background-color
Color getTextColor(Color background) {
  return Color((((background.r * 0.299) +
              (background.g * 0.587) +
              (background.b * 0.114)) >=
          150)
      ? blackHex
      : whiteHex);
}

/// Generate a [ColorScheme] based on values present in [EzConfig.prefs]
ColorScheme ezColorScheme(Brightness brightness) {
  Color? getColor(String key) {
    final int? value = EzConfig.get(key);

    return (value == null) ? null : Color(value);
  }

  return (brightness == Brightness.light)
      ? ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: getColor(lightPrimaryKey)!,
          primary: getColor(lightPrimaryKey),
          onPrimary: getColor(lightOnPrimaryKey),
          primaryContainer: getColor(lightPrimaryContainerKey),
          onPrimaryContainer: getColor(lightOnPrimaryContainerKey),
          primaryFixed: getColor(lightPrimaryFixedKey),
          primaryFixedDim: getColor(lightPrimaryFixedDimKey),
          onPrimaryFixed: getColor(lightOnPrimaryFixedKey),
          onPrimaryFixedVariant: getColor(lightOnPrimaryFixedVariantKey),
          secondary: getColor(lightSecondaryKey),
          onSecondary: getColor(lightOnSecondaryKey),
          secondaryContainer: getColor(lightSecondaryContainerKey),
          onSecondaryContainer: getColor(lightOnSecondaryContainerKey),
          secondaryFixed: getColor(lightSecondaryFixedKey),
          secondaryFixedDim: getColor(lightSecondaryFixedDimKey),
          onSecondaryFixed: getColor(lightOnSecondaryFixedKey),
          onSecondaryFixedVariant: getColor(lightOnSecondaryFixedVariantKey),
          tertiary: getColor(lightTertiaryKey),
          onTertiary: getColor(lightOnTertiaryKey),
          tertiaryContainer: getColor(lightTertiaryContainerKey),
          onTertiaryContainer: getColor(lightOnTertiaryContainerKey),
          tertiaryFixed: getColor(lightTertiaryFixedKey),
          tertiaryFixedDim: getColor(lightTertiaryFixedDimKey),
          onTertiaryFixed: getColor(lightOnTertiaryFixedKey),
          onTertiaryFixedVariant: getColor(lightOnTertiaryFixedVariantKey),
          error: getColor(lightErrorKey),
          onError: getColor(lightOnErrorKey),
          errorContainer: getColor(lightErrorContainerKey),
          onErrorContainer: getColor(lightOnErrorContainerKey),
          outline: getColor(lightOutlineKey),
          outlineVariant: getColor(lightOutlineVariantKey),
          surface: getColor(lightSurfaceKey),
          onSurface: getColor(lightOnSurfaceKey),
          surfaceDim: getColor(lightSurfaceDimKey),
          surfaceBright: getColor(lightSurfaceBrightKey),
          surfaceContainerLowest: getColor(lightSurfaceContainerLowestKey),
          surfaceContainerLow: getColor(lightSurfaceContainerLowKey),
          surfaceContainer: getColor(lightSurfaceContainerKey),
          surfaceContainerHigh: getColor(lightSurfaceContainerHighKey),
          surfaceContainerHighest: getColor(lightSurfaceContainerHighestKey),
          onSurfaceVariant: getColor(lightOnSurfaceVariantKey),
          inverseSurface: getColor(lightInverseSurfaceKey),
          onInverseSurface: getColor(lightOnInverseSurfaceKey),
          inversePrimary: getColor(lightInversePrimaryKey),
          shadow: getColor(lightShadowKey),
          scrim: getColor(lightScrimKey),
          surfaceTint: getColor(lightSurfaceTintKey),
        )
      : ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: getColor(darkPrimaryKey)!,
          primary: getColor(darkPrimaryKey),
          onPrimary: getColor(darkOnPrimaryKey),
          primaryContainer: getColor(darkPrimaryContainerKey),
          onPrimaryContainer: getColor(darkOnPrimaryContainerKey),
          primaryFixed: getColor(darkPrimaryFixedKey),
          primaryFixedDim: getColor(darkPrimaryFixedDimKey),
          onPrimaryFixed: getColor(darkOnPrimaryFixedKey),
          onPrimaryFixedVariant: getColor(darkOnPrimaryFixedVariantKey),
          secondary: getColor(darkSecondaryKey),
          onSecondary: getColor(darkOnSecondaryKey),
          secondaryContainer: getColor(darkSecondaryContainerKey),
          onSecondaryContainer: getColor(darkOnSecondaryContainerKey),
          secondaryFixed: getColor(darkSecondaryFixedKey),
          secondaryFixedDim: getColor(darkSecondaryFixedDimKey),
          onSecondaryFixed: getColor(darkOnSecondaryFixedKey),
          onSecondaryFixedVariant: getColor(darkOnSecondaryFixedVariantKey),
          tertiary: getColor(darkTertiaryKey),
          onTertiary: getColor(darkOnTertiaryKey),
          tertiaryContainer: getColor(darkTertiaryContainerKey),
          onTertiaryContainer: getColor(darkOnTertiaryContainerKey),
          tertiaryFixed: getColor(darkTertiaryFixedKey),
          tertiaryFixedDim: getColor(darkTertiaryFixedDimKey),
          onTertiaryFixed: getColor(darkOnTertiaryFixedKey),
          onTertiaryFixedVariant: getColor(darkOnTertiaryFixedVariantKey),
          error: getColor(darkErrorKey),
          onError: getColor(darkOnErrorKey),
          errorContainer: getColor(darkErrorContainerKey),
          onErrorContainer: getColor(darkOnErrorContainerKey),
          outline: getColor(darkOutlineKey),
          outlineVariant: getColor(darkOutlineVariantKey),
          surface: getColor(darkSurfaceKey),
          onSurface: getColor(darkOnSurfaceKey),
          surfaceDim: getColor(darkSurfaceDimKey),
          surfaceBright: getColor(darkSurfaceBrightKey),
          surfaceContainerLowest: getColor(darkSurfaceContainerLowestKey),
          surfaceContainerLow: getColor(darkSurfaceContainerLowKey),
          surfaceContainer: getColor(darkSurfaceContainerKey),
          surfaceContainerHigh: getColor(darkSurfaceContainerHighKey),
          surfaceContainerHighest: getColor(darkSurfaceContainerHighestKey),
          onSurfaceVariant: getColor(darkOnSurfaceVariantKey),
          inverseSurface: getColor(darkInverseSurfaceKey),
          onInverseSurface: getColor(darkOnInverseSurfaceKey),
          inversePrimary: getColor(darkInversePrimaryKey),
          shadow: getColor(darkShadowKey),
          scrim: getColor(darkScrimKey),
          surfaceTint: getColor(darkSurfaceTintKey),
        );
}

/// Store the passed [ColorScheme] in [EzConfig.prefs]
Future<void> storeColorScheme({
  required ColorScheme colorScheme,
  required Brightness brightness,
}) async {
  if (brightness == Brightness.light) {
    await EzConfig.removeKeys(lightColors.toSet());

    await EzConfig.setInt(lightPrimaryKey, colorScheme.primary.value);
    await EzConfig.setInt(lightOnPrimaryKey, colorScheme.onPrimary.value);
    await EzConfig.setInt(
        lightPrimaryContainerKey, colorScheme.primaryContainer.value);
    await EzConfig.setInt(
        lightOnPrimaryContainerKey, colorScheme.onPrimaryContainer.value);
    await EzConfig.setInt(lightPrimaryFixedKey, colorScheme.primaryFixed.value);
    await EzConfig.setInt(
        lightPrimaryFixedDimKey, colorScheme.primaryFixedDim.value);
    await EzConfig.setInt(
        lightOnPrimaryFixedKey, colorScheme.onPrimaryFixed.value);
    await EzConfig.setInt(
        lightOnPrimaryFixedVariantKey, colorScheme.onPrimaryFixedVariant.value);
    await EzConfig.setInt(lightSecondaryKey, colorScheme.secondary.value);
    await EzConfig.setInt(lightOnSecondaryKey, colorScheme.onSecondary.value);
    await EzConfig.setInt(
        lightSecondaryContainerKey, colorScheme.secondaryContainer.value);
    await EzConfig.setInt(
        lightOnSecondaryContainerKey, colorScheme.onSecondaryContainer.value);
    await EzConfig.setInt(
        lightSecondaryFixedKey, colorScheme.secondaryFixed.value);
    await EzConfig.setInt(
        lightSecondaryFixedDimKey, colorScheme.secondaryFixedDim.value);
    await EzConfig.setInt(
        lightOnSecondaryFixedKey, colorScheme.onSecondaryFixed.value);
    await EzConfig.setInt(lightOnSecondaryFixedVariantKey,
        colorScheme.onSecondaryFixedVariant.value);
    await EzConfig.setInt(lightTertiaryKey, colorScheme.tertiary.value);
    await EzConfig.setInt(lightOnTertiaryKey, colorScheme.onTertiary.value);
    await EzConfig.setInt(
        lightTertiaryContainerKey, colorScheme.tertiaryContainer.value);
    await EzConfig.setInt(
        lightOnTertiaryContainerKey, colorScheme.onTertiaryContainer.value);
    await EzConfig.setInt(
        lightTertiaryFixedKey, colorScheme.tertiaryFixed.value);
    await EzConfig.setInt(
        lightTertiaryFixedDimKey, colorScheme.tertiaryFixedDim.value);
    await EzConfig.setInt(
        lightOnTertiaryFixedKey, colorScheme.onTertiaryFixed.value);
    await EzConfig.setInt(lightOnTertiaryFixedVariantKey,
        colorScheme.onTertiaryFixedVariant.value);
    await EzConfig.setInt(lightErrorKey, colorScheme.error.value);
    await EzConfig.setInt(lightOnErrorKey, colorScheme.onError.value);
    await EzConfig.setInt(
        lightErrorContainerKey, colorScheme.errorContainer.value);
    await EzConfig.setInt(
        lightOnErrorContainerKey, colorScheme.onErrorContainer.value);
    await EzConfig.setInt(lightOutlineKey, colorScheme.outline.value);
    await EzConfig.setInt(
        lightOutlineVariantKey, colorScheme.outlineVariant.value);
    await EzConfig.setInt(lightSurfaceKey, colorScheme.surface.value);
    await EzConfig.setInt(lightOnSurfaceKey, colorScheme.onSurface.value);
    await EzConfig.setInt(lightSurfaceDimKey, colorScheme.surfaceDim.value);
    await EzConfig.setInt(
        lightSurfaceBrightKey, colorScheme.surfaceBright.value);
    await EzConfig.setInt(lightSurfaceContainerLowestKey,
        colorScheme.surfaceContainerLowest.value);
    await EzConfig.setInt(
        lightSurfaceContainerLowKey, colorScheme.surfaceContainerLow.value);
    await EzConfig.setInt(
        lightSurfaceContainerKey, colorScheme.surfaceContainer.value);
    await EzConfig.setInt(
        lightSurfaceContainerHighKey, colorScheme.surfaceContainerHigh.value);
    await EzConfig.setInt(lightSurfaceContainerHighestKey,
        colorScheme.surfaceContainerHighest.value);
    await EzConfig.setInt(
        lightOnSurfaceVariantKey, colorScheme.onSurfaceVariant.value);
    await EzConfig.setInt(
        lightInverseSurfaceKey, colorScheme.inverseSurface.value);
    await EzConfig.setInt(
        lightOnInverseSurfaceKey, colorScheme.onInverseSurface.value);
    await EzConfig.setInt(
        lightInversePrimaryKey, colorScheme.inversePrimary.value);
    await EzConfig.setInt(lightShadowKey, colorScheme.shadow.value);
    await EzConfig.setInt(lightScrimKey, colorScheme.scrim.value);
    await EzConfig.setInt(lightSurfaceTintKey, colorScheme.surfaceTint.value);
  } else {
    await EzConfig.removeKeys(darkColors.toSet());

    await EzConfig.setInt(darkPrimaryKey, colorScheme.primary.value);
    await EzConfig.setInt(darkOnPrimaryKey, colorScheme.onPrimary.value);
    await EzConfig.setInt(
        darkPrimaryContainerKey, colorScheme.primaryContainer.value);
    await EzConfig.setInt(
        darkOnPrimaryContainerKey, colorScheme.onPrimaryContainer.value);
    await EzConfig.setInt(darkPrimaryFixedKey, colorScheme.primaryFixed.value);
    await EzConfig.setInt(
        darkPrimaryFixedDimKey, colorScheme.primaryFixedDim.value);
    await EzConfig.setInt(
        darkOnPrimaryFixedKey, colorScheme.onPrimaryFixed.value);
    await EzConfig.setInt(
        darkOnPrimaryFixedVariantKey, colorScheme.onPrimaryFixedVariant.value);
    await EzConfig.setInt(darkSecondaryKey, colorScheme.secondary.value);
    await EzConfig.setInt(darkOnSecondaryKey, colorScheme.onSecondary.value);
    await EzConfig.setInt(
        darkSecondaryContainerKey, colorScheme.secondaryContainer.value);
    await EzConfig.setInt(
        darkOnSecondaryContainerKey, colorScheme.onSecondaryContainer.value);
    await EzConfig.setInt(
        darkSecondaryFixedKey, colorScheme.secondaryFixed.value);
    await EzConfig.setInt(
        darkSecondaryFixedDimKey, colorScheme.secondaryFixedDim.value);
    await EzConfig.setInt(
        darkOnSecondaryFixedKey, colorScheme.onSecondaryFixed.value);
    await EzConfig.setInt(darkOnSecondaryFixedVariantKey,
        colorScheme.onSecondaryFixedVariant.value);
    await EzConfig.setInt(darkTertiaryKey, colorScheme.tertiary.value);
    await EzConfig.setInt(darkOnTertiaryKey, colorScheme.onTertiary.value);
    await EzConfig.setInt(
        darkTertiaryContainerKey, colorScheme.tertiaryContainer.value);
    await EzConfig.setInt(
        darkOnTertiaryContainerKey, colorScheme.onTertiaryContainer.value);
    await EzConfig.setInt(
        darkTertiaryFixedKey, colorScheme.tertiaryFixed.value);
    await EzConfig.setInt(
        darkTertiaryFixedDimKey, colorScheme.tertiaryFixedDim.value);
    await EzConfig.setInt(
        darkOnTertiaryFixedKey, colorScheme.onTertiaryFixed.value);
    await EzConfig.setInt(darkOnTertiaryFixedVariantKey,
        colorScheme.onTertiaryFixedVariant.value);
    await EzConfig.setInt(darkErrorKey, colorScheme.error.value);
    await EzConfig.setInt(darkOnErrorKey, colorScheme.onError.value);
    await EzConfig.setInt(
        darkErrorContainerKey, colorScheme.errorContainer.value);
    await EzConfig.setInt(
        darkOnErrorContainerKey, colorScheme.onErrorContainer.value);
    await EzConfig.setInt(darkOutlineKey, colorScheme.outline.value);
    await EzConfig.setInt(
        darkOutlineVariantKey, colorScheme.outlineVariant.value);
    await EzConfig.setInt(darkSurfaceKey, colorScheme.surface.value);
    await EzConfig.setInt(darkOnSurfaceKey, colorScheme.onSurface.value);
    await EzConfig.setInt(darkSurfaceDimKey, colorScheme.surfaceDim.value);
    await EzConfig.setInt(
        darkSurfaceBrightKey, colorScheme.surfaceBright.value);
    await EzConfig.setInt(darkSurfaceContainerLowestKey,
        colorScheme.surfaceContainerLowest.value);
    await EzConfig.setInt(
        darkSurfaceContainerLowKey, colorScheme.surfaceContainerLow.value);
    await EzConfig.setInt(
        darkSurfaceContainerKey, colorScheme.surfaceContainer.value);
    await EzConfig.setInt(
        darkSurfaceContainerHighKey, colorScheme.surfaceContainerHigh.value);
    await EzConfig.setInt(darkSurfaceContainerHighestKey,
        colorScheme.surfaceContainerHighest.value);
    await EzConfig.setInt(
        darkOnSurfaceVariantKey, colorScheme.onSurfaceVariant.value);
    await EzConfig.setInt(
        darkInverseSurfaceKey, colorScheme.inverseSurface.value);
    await EzConfig.setInt(
        darkOnInverseSurfaceKey, colorScheme.onInverseSurface.value);
    await EzConfig.setInt(
        darkInversePrimaryKey, colorScheme.inversePrimary.value);
    await EzConfig.setInt(darkShadowKey, colorScheme.shadow.value);
    await EzConfig.setInt(darkScrimKey, colorScheme.scrim.value);
    await EzConfig.setInt(darkSurfaceTintKey, colorScheme.surfaceTint.value);
  }
}

/// Generates a [ColorScheme] based on the image found at [path]
/// Then stores the values in [EzConfig.preferences]
Future<String> storeImageColorScheme({
  required String path,
  required Brightness brightness,
}) async {
  late final ColorScheme colorScheme;

  try {
    colorScheme = await ColorScheme.fromImageProvider(
      provider: provideImage(path),
      brightness: brightness,
    );
  } catch (e) {
    return e.toString();
  }

  if (brightness == Brightness.light) {
    await EzConfig.removeKeys(lightColors.toSet());

    await EzConfig.setInt(lightPrimaryKey, colorScheme.primary.value);
    await EzConfig.setInt(lightOnPrimaryKey, colorScheme.onPrimary.value);
    await EzConfig.setInt(
        lightPrimaryContainerKey, colorScheme.primaryContainer.value);
    await EzConfig.setInt(
        lightOnPrimaryContainerKey, colorScheme.onPrimaryContainer.value);
    await EzConfig.setInt(lightPrimaryFixedKey, colorScheme.primaryFixed.value);
    await EzConfig.setInt(
        lightPrimaryFixedDimKey, colorScheme.primaryFixedDim.value);
    await EzConfig.setInt(
        lightOnPrimaryFixedKey, colorScheme.onPrimaryFixed.value);
    await EzConfig.setInt(
        lightOnPrimaryFixedVariantKey, colorScheme.onPrimaryFixedVariant.value);
    await EzConfig.setInt(lightSecondaryKey, colorScheme.secondary.value);
    await EzConfig.setInt(lightOnSecondaryKey, colorScheme.onSecondary.value);
    await EzConfig.setInt(
        lightSecondaryContainerKey, colorScheme.secondaryContainer.value);
    await EzConfig.setInt(
        lightOnSecondaryContainerKey, colorScheme.onSecondaryContainer.value);
    await EzConfig.setInt(
        lightSecondaryFixedKey, colorScheme.secondaryFixed.value);
    await EzConfig.setInt(
        lightSecondaryFixedDimKey, colorScheme.secondaryFixedDim.value);
    await EzConfig.setInt(
        lightOnSecondaryFixedKey, colorScheme.onSecondaryFixed.value);
    await EzConfig.setInt(lightOnSecondaryFixedVariantKey,
        colorScheme.onSecondaryFixedVariant.value);
    await EzConfig.setInt(lightTertiaryKey, colorScheme.tertiary.value);
    await EzConfig.setInt(lightOnTertiaryKey, colorScheme.onTertiary.value);
    await EzConfig.setInt(
        lightTertiaryContainerKey, colorScheme.tertiaryContainer.value);
    await EzConfig.setInt(
        lightOnTertiaryContainerKey, colorScheme.onTertiaryContainer.value);
    await EzConfig.setInt(
        lightTertiaryFixedKey, colorScheme.tertiaryFixed.value);
    await EzConfig.setInt(
        lightTertiaryFixedDimKey, colorScheme.tertiaryFixedDim.value);
    await EzConfig.setInt(
        lightOnTertiaryFixedKey, colorScheme.onTertiaryFixed.value);
    await EzConfig.setInt(lightOnTertiaryFixedVariantKey,
        colorScheme.onTertiaryFixedVariant.value);
    await EzConfig.setInt(lightErrorKey, colorScheme.error.value);
    await EzConfig.setInt(lightOnErrorKey, colorScheme.onError.value);
    await EzConfig.setInt(
        lightErrorContainerKey, colorScheme.errorContainer.value);
    await EzConfig.setInt(
        lightOnErrorContainerKey, colorScheme.onErrorContainer.value);
    await EzConfig.setInt(lightOutlineKey, colorScheme.outline.value);
    await EzConfig.setInt(
        lightOutlineVariantKey, colorScheme.outlineVariant.value);
    await EzConfig.setInt(lightSurfaceKey, colorScheme.surface.value);
    await EzConfig.setInt(lightOnSurfaceKey, colorScheme.onSurface.value);
    await EzConfig.setInt(lightSurfaceDimKey, colorScheme.surfaceDim.value);
    await EzConfig.setInt(
        lightSurfaceBrightKey, colorScheme.surfaceBright.value);
    await EzConfig.setInt(lightSurfaceContainerLowestKey,
        colorScheme.surfaceContainerLowest.value);
    await EzConfig.setInt(
        lightSurfaceContainerLowKey, colorScheme.surfaceContainerLow.value);
    await EzConfig.setInt(
        lightSurfaceContainerKey, colorScheme.surfaceContainer.value);
    await EzConfig.setInt(
        lightSurfaceContainerHighKey, colorScheme.surfaceContainerHigh.value);
    await EzConfig.setInt(lightSurfaceContainerHighestKey,
        colorScheme.surfaceContainerHighest.value);
    await EzConfig.setInt(
        lightOnSurfaceVariantKey, colorScheme.onSurfaceVariant.value);
    await EzConfig.setInt(
        lightInverseSurfaceKey, colorScheme.inverseSurface.value);
    await EzConfig.setInt(
        lightOnInverseSurfaceKey, colorScheme.onInverseSurface.value);
    await EzConfig.setInt(
        lightInversePrimaryKey, colorScheme.inversePrimary.value);
    await EzConfig.setInt(lightShadowKey, colorScheme.shadow.value);
    await EzConfig.setInt(lightScrimKey, colorScheme.scrim.value);
    await EzConfig.setInt(lightSurfaceTintKey, colorScheme.surfaceTint.value);
  } else {
    await EzConfig.removeKeys(darkColors.toSet());

    await EzConfig.setInt(darkPrimaryKey, colorScheme.primary.value);
    await EzConfig.setInt(darkOnPrimaryKey, colorScheme.onPrimary.value);
    await EzConfig.setInt(
        darkPrimaryContainerKey, colorScheme.primaryContainer.value);
    await EzConfig.setInt(
        darkOnPrimaryContainerKey, colorScheme.onPrimaryContainer.value);
    await EzConfig.setInt(darkPrimaryFixedKey, colorScheme.primaryFixed.value);
    await EzConfig.setInt(
        darkPrimaryFixedDimKey, colorScheme.primaryFixedDim.value);
    await EzConfig.setInt(
        darkOnPrimaryFixedKey, colorScheme.onPrimaryFixed.value);
    await EzConfig.setInt(
        darkOnPrimaryFixedVariantKey, colorScheme.onPrimaryFixedVariant.value);
    await EzConfig.setInt(darkSecondaryKey, colorScheme.secondary.value);
    await EzConfig.setInt(darkOnSecondaryKey, colorScheme.onSecondary.value);
    await EzConfig.setInt(
        darkSecondaryContainerKey, colorScheme.secondaryContainer.value);
    await EzConfig.setInt(
        darkOnSecondaryContainerKey, colorScheme.onSecondaryContainer.value);
    await EzConfig.setInt(
        darkSecondaryFixedKey, colorScheme.secondaryFixed.value);
    await EzConfig.setInt(
        darkSecondaryFixedDimKey, colorScheme.secondaryFixedDim.value);
    await EzConfig.setInt(
        darkOnSecondaryFixedKey, colorScheme.onSecondaryFixed.value);
    await EzConfig.setInt(darkOnSecondaryFixedVariantKey,
        colorScheme.onSecondaryFixedVariant.value);
    await EzConfig.setInt(darkTertiaryKey, colorScheme.tertiary.value);
    await EzConfig.setInt(darkOnTertiaryKey, colorScheme.onTertiary.value);
    await EzConfig.setInt(
        darkTertiaryContainerKey, colorScheme.tertiaryContainer.value);
    await EzConfig.setInt(
        darkOnTertiaryContainerKey, colorScheme.onTertiaryContainer.value);
    await EzConfig.setInt(
        darkTertiaryFixedKey, colorScheme.tertiaryFixed.value);
    await EzConfig.setInt(
        darkTertiaryFixedDimKey, colorScheme.tertiaryFixedDim.value);
    await EzConfig.setInt(
        darkOnTertiaryFixedKey, colorScheme.onTertiaryFixed.value);
    await EzConfig.setInt(darkOnTertiaryFixedVariantKey,
        colorScheme.onTertiaryFixedVariant.value);
    await EzConfig.setInt(darkErrorKey, colorScheme.error.value);
    await EzConfig.setInt(darkOnErrorKey, colorScheme.onError.value);
    await EzConfig.setInt(
        darkErrorContainerKey, colorScheme.errorContainer.value);
    await EzConfig.setInt(
        darkOnErrorContainerKey, colorScheme.onErrorContainer.value);
    await EzConfig.setInt(darkOutlineKey, colorScheme.outline.value);
    await EzConfig.setInt(
        darkOutlineVariantKey, colorScheme.outlineVariant.value);
    await EzConfig.setInt(darkSurfaceKey, colorScheme.surface.value);
    await EzConfig.setInt(darkOnSurfaceKey, colorScheme.onSurface.value);
    await EzConfig.setInt(darkSurfaceDimKey, colorScheme.surfaceDim.value);
    await EzConfig.setInt(
        darkSurfaceBrightKey, colorScheme.surfaceBright.value);
    await EzConfig.setInt(darkSurfaceContainerLowestKey,
        colorScheme.surfaceContainerLowest.value);
    await EzConfig.setInt(
        darkSurfaceContainerLowKey, colorScheme.surfaceContainerLow.value);
    await EzConfig.setInt(
        darkSurfaceContainerKey, colorScheme.surfaceContainer.value);
    await EzConfig.setInt(
        darkSurfaceContainerHighKey, colorScheme.surfaceContainerHigh.value);
    await EzConfig.setInt(darkSurfaceContainerHighestKey,
        colorScheme.surfaceContainerHighest.value);
    await EzConfig.setInt(
        darkOnSurfaceVariantKey, colorScheme.onSurfaceVariant.value);
    await EzConfig.setInt(
        darkInverseSurfaceKey, colorScheme.inverseSurface.value);
    await EzConfig.setInt(
        darkOnInverseSurfaceKey, colorScheme.onInverseSurface.value);
    await EzConfig.setInt(
        darkInversePrimaryKey, colorScheme.inversePrimary.value);
    await EzConfig.setInt(darkShadowKey, colorScheme.shadow.value);
    await EzConfig.setInt(darkScrimKey, colorScheme.scrim.value);
    await EzConfig.setInt(darkSurfaceTintKey, colorScheme.surfaceTint.value);
  }

  return success;
}

/// Get the human readable name of a [key]s color
String getColorName(String key) {
  switch (key) {
    case lightPrimaryKey:
    case darkPrimaryKey:
      return csPrimary;
    case lightOnPrimaryKey:
    case darkOnPrimaryKey:
      return csOnPrimary;
    case lightPrimaryContainerKey:
    case darkPrimaryContainerKey:
      return csPrimaryContainer;
    case lightOnPrimaryContainerKey:
    case darkOnPrimaryContainerKey:
      return csOnPrimaryContainer;
    case lightPrimaryFixedKey:
    case darkPrimaryFixedKey:
      return csPrimaryFixed;
    case lightPrimaryFixedDimKey:
    case darkPrimaryFixedDimKey:
      return csPrimaryFixedDim;
    case lightOnPrimaryFixedKey:
    case darkOnPrimaryFixedKey:
      return csOnPrimaryFixed;
    case lightOnPrimaryFixedVariantKey:
    case darkOnPrimaryFixedVariantKey:
      return csOnPrimaryFixedVariant;
    case lightSecondaryKey:
    case darkSecondaryKey:
      return csSecondary;
    case lightOnSecondaryKey:
    case darkOnSecondaryKey:
      return csOnSecondary;
    case lightSecondaryContainerKey:
    case darkSecondaryContainerKey:
      return csSecondaryContainer;
    case lightOnSecondaryContainerKey:
    case darkOnSecondaryContainerKey:
      return csOnSecondaryContainer;
    case lightSecondaryFixedKey:
    case darkSecondaryFixedKey:
      return csSecondaryFixed;
    case lightSecondaryFixedDimKey:
    case darkSecondaryFixedDimKey:
      return csSecondaryFixedDim;
    case lightOnSecondaryFixedKey:
    case darkOnSecondaryFixedKey:
      return csOnSecondaryFixed;
    case lightOnSecondaryFixedVariantKey:
    case darkOnSecondaryFixedVariantKey:
      return csOnSecondaryFixedVariant;
    case lightTertiaryKey:
    case darkTertiaryKey:
      return csTertiary;
    case lightOnTertiaryKey:
    case darkOnTertiaryKey:
      return csOnTertiary;
    case lightTertiaryContainerKey:
    case darkTertiaryContainerKey:
      return csTertiaryContainer;
    case lightOnTertiaryContainerKey:
    case darkOnTertiaryContainerKey:
      return csOnTertiaryContainer;
    case lightTertiaryFixedKey:
    case darkTertiaryFixedKey:
      return csTertiaryFixed;
    case lightTertiaryFixedDimKey:
    case darkTertiaryFixedDimKey:
      return csTertiaryFixedDim;
    case lightOnTertiaryFixedKey:
    case darkOnTertiaryFixedKey:
      return csOnTertiaryFixed;
    case lightOnTertiaryFixedVariantKey:
    case darkOnTertiaryFixedVariantKey:
      return csOnTertiaryFixedVariant;
    case lightErrorKey:
    case darkErrorKey:
      return csError;
    case lightOnErrorKey:
    case darkOnErrorKey:
      return csOnError;
    case lightErrorContainerKey:
    case darkErrorContainerKey:
      return csErrorContainer;
    case lightOnErrorContainerKey:
    case darkOnErrorContainerKey:
      return csOnErrorContainer;
    case lightOutlineKey:
    case darkOutlineKey:
      return csOutline;
    case lightOutlineVariantKey:
    case darkOutlineVariantKey:
      return csOutlineVariant;
    case lightSurfaceKey:
    case darkSurfaceKey:
      return csSurface;
    case lightOnSurfaceKey:
    case darkOnSurfaceKey:
      return csOnSurface;
    case lightSurfaceDimKey:
    case darkSurfaceDimKey:
      return csSurfaceDim;
    case lightSurfaceBrightKey:
    case darkSurfaceBrightKey:
      return csSurfaceBright;
    case lightSurfaceContainerLowestKey:
    case darkSurfaceContainerLowestKey:
      return csSurfaceContainerLowest;
    case lightSurfaceContainerLowKey:
    case darkSurfaceContainerLowKey:
      return csSurfaceContainerLow;
    case lightSurfaceContainerKey:
    case darkSurfaceContainerKey:
      return csSurfaceContainer;
    case lightSurfaceContainerHighKey:
    case darkSurfaceContainerHighKey:
      return csSurfaceContainerHigh;
    case lightSurfaceContainerHighestKey:
    case darkSurfaceContainerHighestKey:
      return csSurfaceContainerHighest;
    case lightOnSurfaceVariantKey:
    case darkOnSurfaceVariantKey:
      return csOnSurfaceVariant;
    case lightInverseSurfaceKey:
    case darkInverseSurfaceKey:
      return csInverseSurface;
    case lightOnInverseSurfaceKey:
    case darkOnInverseSurfaceKey:
      return csOnInverseSurface;
    case lightInversePrimaryKey:
    case darkInversePrimaryKey:
      return csInversePrimary;
    case lightScrimKey:
    case darkScrimKey:
      return csScrim;
    case lightShadowKey:
    case darkShadowKey:
      return csShadow;
    case lightSurfaceTintKey:
    case darkSurfaceTintKey:
      return csSurfaceTint;
    default:
      return 'null';
  }
}

/// Resolve the color [key] to the live [ColorScheme] value
Color getLiveColor(BuildContext context, String key) {
  final ColorScheme colorScheme = Theme.of(context).colorScheme;

  switch (key) {
    case lightPrimaryKey:
    case darkPrimaryKey:
      return colorScheme.primary;
    case lightOnPrimaryKey:
    case darkOnPrimaryKey:
      return colorScheme.onPrimary;
    case lightPrimaryContainerKey:
    case darkPrimaryContainerKey:
      return colorScheme.onPrimaryContainer;
    case lightOnPrimaryContainerKey:
    case darkOnPrimaryContainerKey:
      return colorScheme.onPrimaryContainer;
    case lightPrimaryFixedKey:
    case darkPrimaryFixedKey:
      return colorScheme.primaryFixed;
    case lightPrimaryFixedDimKey:
    case darkPrimaryFixedDimKey:
      return colorScheme.primaryFixedDim;
    case lightOnPrimaryFixedKey:
    case darkOnPrimaryFixedKey:
      return colorScheme.onPrimaryFixed;
    case lightOnPrimaryFixedVariantKey:
    case darkOnPrimaryFixedVariantKey:
      return colorScheme.onPrimaryFixedVariant;
    case lightSecondaryKey:
    case darkSecondaryKey:
      return colorScheme.secondary;
    case lightOnSecondaryKey:
    case darkOnSecondaryKey:
      return colorScheme.onSecondary;
    case lightSecondaryContainerKey:
    case darkSecondaryContainerKey:
      return colorScheme.secondaryContainer;
    case lightOnSecondaryContainerKey:
    case darkOnSecondaryContainerKey:
      return colorScheme.onSecondaryContainer;
    case lightSecondaryFixedKey:
    case darkSecondaryFixedKey:
      return colorScheme.secondaryFixed;
    case lightSecondaryFixedDimKey:
    case darkSecondaryFixedDimKey:
      return colorScheme.secondaryFixedDim;
    case lightOnSecondaryFixedKey:
    case darkOnSecondaryFixedKey:
      return colorScheme.onSecondaryFixed;
    case lightOnSecondaryFixedVariantKey:
    case darkOnSecondaryFixedVariantKey:
      return colorScheme.onSecondaryFixedVariant;
    case lightTertiaryKey:
    case darkTertiaryKey:
      return colorScheme.tertiary;
    case lightOnTertiaryKey:
    case darkOnTertiaryKey:
      return colorScheme.onTertiary;
    case lightTertiaryContainerKey:
    case darkTertiaryContainerKey:
      return colorScheme.tertiaryContainer;
    case lightOnTertiaryContainerKey:
    case darkOnTertiaryContainerKey:
      return colorScheme.onTertiaryContainer;
    case lightTertiaryFixedKey:
    case darkTertiaryFixedKey:
      return colorScheme.tertiaryFixed;
    case lightTertiaryFixedDimKey:
    case darkTertiaryFixedDimKey:
      return colorScheme.tertiaryFixedDim;
    case lightOnTertiaryFixedKey:
    case darkOnTertiaryFixedKey:
      return colorScheme.onTertiaryFixed;
    case lightOnTertiaryFixedVariantKey:
    case darkOnTertiaryFixedVariantKey:
      return colorScheme.onTertiaryFixedVariant;
    case lightErrorKey:
    case darkErrorKey:
      return colorScheme.error;
    case lightOnErrorKey:
    case darkOnErrorKey:
      return colorScheme.onError;
    case lightErrorContainerKey:
    case darkErrorContainerKey:
      return colorScheme.errorContainer;
    case lightOnErrorContainerKey:
    case darkOnErrorContainerKey:
      return colorScheme.onErrorContainer;
    case lightOutlineKey:
    case darkOutlineKey:
      return colorScheme.outline;
    case lightOutlineVariantKey:
    case darkOutlineVariantKey:
      return colorScheme.outlineVariant;
    case lightSurfaceKey:
    case darkSurfaceKey:
      return colorScheme.surface;
    case lightOnSurfaceKey:
    case darkOnSurfaceKey:
      return colorScheme.onSurface;
    case lightSurfaceDimKey:
    case darkSurfaceDimKey:
      return colorScheme.surfaceDim;
    case lightSurfaceBrightKey:
    case darkSurfaceBrightKey:
      return colorScheme.surfaceBright;
    case lightSurfaceContainerLowestKey:
    case darkSurfaceContainerLowestKey:
      return colorScheme.surfaceContainerLowest;
    case lightSurfaceContainerLowKey:
    case darkSurfaceContainerLowKey:
      return colorScheme.surfaceContainerLow;
    case lightSurfaceContainerKey:
    case darkSurfaceContainerKey:
      return colorScheme.surfaceContainer;
    case lightSurfaceContainerHighKey:
    case darkSurfaceContainerHighKey:
      return colorScheme.surfaceContainerHigh;
    case lightSurfaceContainerHighestKey:
    case darkSurfaceContainerHighestKey:
      return colorScheme.surfaceContainerHighest;
    case lightOnSurfaceVariantKey:
    case darkOnSurfaceVariantKey:
      return colorScheme.onSurfaceVariant;
    case lightInverseSurfaceKey:
    case darkInverseSurfaceKey:
      return colorScheme.inverseSurface;
    case lightOnInverseSurfaceKey:
    case darkOnInverseSurfaceKey:
      return colorScheme.onInverseSurface;
    case lightInversePrimaryKey:
    case darkInversePrimaryKey:
      return colorScheme.inversePrimary;
    case lightScrimKey:
    case darkScrimKey:
      return colorScheme.scrim;
    case lightShadowKey:
    case darkShadowKey:
      return colorScheme.shadow;
    case lightSurfaceTintKey:
    case darkSurfaceTintKey:
      return colorScheme.surfaceTint;
    default:
      return Colors.transparent;
  }
}
