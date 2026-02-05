/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Returns the guesstimated most readable text color (black/white) for [background]
Color getTextColor(Color background) {
  final int lumR = (background.r * 255.0 * 0.299).round();
  final int lumG = (background.g * 255.0 * 0.587).round();
  final int lumB = (background.b * 255.0 * 0.114).round();

  return Color(((lumR + lumG + lumB) >= 150) ? blackHex : whiteHex);
}

/// Generate a [ColorScheme] based on values present in [EzConfig.prefs]
ColorScheme ezColorScheme(Brightness brightness) {
  Color? getColor(String key) {
    final int? value = EzConfig.get(key);
    return (value == null) ? null : Color(value);
  }

  return (brightness == Brightness.dark)
      ? ColorScheme.fromSeed(
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
        )
      : ColorScheme.fromSeed(
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
        );
}

/// Store the passed [ColorScheme] in [EzConfig]
/// When [brightness] is null, both dark and light color schemes are updated
Future<void> loadColorScheme(
  ColorScheme colorScheme,
  Brightness? brightness,
) async {
  if (brightness == null || brightness == Brightness.dark) {
    // Reset
    await EzConfig.removeKeys(darkColorKeys.keys.toSet());

    // Rebuild
    await EzConfig.setInt(
      darkPrimaryKey,
      colorScheme.primary.toARGB32(),
    );
    await EzConfig.setInt(
      darkOnPrimaryKey,
      colorScheme.onPrimary.toARGB32(),
    );
    await EzConfig.setInt(
      darkPrimaryContainerKey,
      colorScheme.primaryContainer.toARGB32(),
    );
    await EzConfig.setInt(
      darkOnPrimaryContainerKey,
      colorScheme.onPrimaryContainer.toARGB32(),
    );
    await EzConfig.setInt(
      darkPrimaryFixedKey,
      colorScheme.primaryFixed.toARGB32(),
    );
    await EzConfig.setInt(
      darkPrimaryFixedDimKey,
      colorScheme.primaryFixedDim.toARGB32(),
    );
    await EzConfig.setInt(
      darkOnPrimaryFixedKey,
      colorScheme.onPrimaryFixed.toARGB32(),
    );
    await EzConfig.setInt(
      darkOnPrimaryFixedVariantKey,
      colorScheme.onPrimaryFixedVariant.toARGB32(),
    );
    await EzConfig.setInt(
      darkSecondaryKey,
      colorScheme.secondary.toARGB32(),
    );
    await EzConfig.setInt(
      darkOnSecondaryKey,
      colorScheme.onSecondary.toARGB32(),
    );
    await EzConfig.setInt(
      darkSecondaryContainerKey,
      colorScheme.secondaryContainer.toARGB32(),
    );
    await EzConfig.setInt(
      darkOnSecondaryContainerKey,
      colorScheme.onSecondaryContainer.toARGB32(),
    );
    await EzConfig.setInt(
      darkSecondaryFixedKey,
      colorScheme.secondaryFixed.toARGB32(),
    );
    await EzConfig.setInt(
      darkSecondaryFixedDimKey,
      colorScheme.secondaryFixedDim.toARGB32(),
    );
    await EzConfig.setInt(
      darkOnSecondaryFixedKey,
      colorScheme.onSecondaryFixed.toARGB32(),
    );
    await EzConfig.setInt(
      darkOnSecondaryFixedVariantKey,
      colorScheme.onSecondaryFixedVariant.toARGB32(),
    );
    await EzConfig.setInt(
      darkTertiaryKey,
      colorScheme.tertiary.toARGB32(),
    );
    await EzConfig.setInt(
      darkOnTertiaryKey,
      colorScheme.onTertiary.toARGB32(),
    );
    await EzConfig.setInt(
      darkTertiaryContainerKey,
      colorScheme.tertiaryContainer.toARGB32(),
    );
    await EzConfig.setInt(
      darkOnTertiaryContainerKey,
      colorScheme.onTertiaryContainer.toARGB32(),
    );
    await EzConfig.setInt(
      darkTertiaryFixedKey,
      colorScheme.tertiaryFixed.toARGB32(),
    );
    await EzConfig.setInt(
      darkTertiaryFixedDimKey,
      colorScheme.tertiaryFixedDim.toARGB32(),
    );
    await EzConfig.setInt(
      darkOnTertiaryFixedKey,
      colorScheme.onTertiaryFixed.toARGB32(),
    );
    await EzConfig.setInt(
      darkOnTertiaryFixedVariantKey,
      colorScheme.onTertiaryFixedVariant.toARGB32(),
    );
    await EzConfig.setInt(
      darkErrorKey,
      colorScheme.error.toARGB32(),
    );
    await EzConfig.setInt(
      darkOnErrorKey,
      colorScheme.onError.toARGB32(),
    );
    await EzConfig.setInt(
      darkErrorContainerKey,
      colorScheme.errorContainer.toARGB32(),
    );
    await EzConfig.setInt(
      darkOnErrorContainerKey,
      colorScheme.onErrorContainer.toARGB32(),
    );
    await EzConfig.setInt(
      darkOutlineKey,
      colorScheme.outline.toARGB32(),
    );
    await EzConfig.setInt(
      darkOutlineVariantKey,
      colorScheme.outlineVariant.toARGB32(),
    );
    await EzConfig.setInt(
      darkSurfaceKey,
      colorScheme.surface.toARGB32(),
    );
    await EzConfig.setInt(
      darkOnSurfaceKey,
      colorScheme.onSurface.toARGB32(),
    );
    await EzConfig.setInt(
      darkSurfaceDimKey,
      colorScheme.surfaceDim.toARGB32(),
    );
    await EzConfig.setInt(
      darkSurfaceBrightKey,
      colorScheme.surfaceBright.toARGB32(),
    );
    await EzConfig.setInt(
      darkSurfaceContainerLowestKey,
      colorScheme.surfaceContainerLowest.toARGB32(),
    );
    await EzConfig.setInt(
      darkSurfaceContainerLowKey,
      colorScheme.surfaceContainerLow.toARGB32(),
    );
    await EzConfig.setInt(
      darkSurfaceContainerKey,
      colorScheme.surfaceContainer.toARGB32(),
    );
    await EzConfig.setInt(
      darkSurfaceContainerHighKey,
      colorScheme.surfaceContainerHigh.toARGB32(),
    );
    await EzConfig.setInt(
      darkSurfaceContainerHighestKey,
      colorScheme.surfaceContainerHighest.toARGB32(),
    );
    await EzConfig.setInt(
      darkOnSurfaceVariantKey,
      colorScheme.onSurfaceVariant.toARGB32(),
    );
    await EzConfig.setInt(
      darkInverseSurfaceKey,
      colorScheme.inverseSurface.toARGB32(),
    );
    await EzConfig.setInt(
      darkOnInverseSurfaceKey,
      colorScheme.onInverseSurface.toARGB32(),
    );
    await EzConfig.setInt(
      darkInversePrimaryKey,
      colorScheme.inversePrimary.toARGB32(),
    );
    await EzConfig.setInt(
      darkShadowKey,
      colorScheme.shadow.toARGB32(),
    );
    await EzConfig.setInt(
      darkScrimKey,
      colorScheme.scrim.toARGB32(),
    );
    await EzConfig.setInt(
      darkSurfaceTintKey,
      colorScheme.surfaceTint.toARGB32(),
    );
  }

  if (brightness == null || brightness == Brightness.light) {
    // Reset
    await EzConfig.removeKeys(lightColorKeys.keys.toSet());

    // Rebuild
    await EzConfig.setInt(
      lightPrimaryKey,
      colorScheme.primary.toARGB32(),
    );
    await EzConfig.setInt(
      lightOnPrimaryKey,
      colorScheme.onPrimary.toARGB32(),
    );
    await EzConfig.setInt(
      lightPrimaryContainerKey,
      colorScheme.primaryContainer.toARGB32(),
    );
    await EzConfig.setInt(
      lightOnPrimaryContainerKey,
      colorScheme.onPrimaryContainer.toARGB32(),
    );
    await EzConfig.setInt(
      lightPrimaryFixedKey,
      colorScheme.primaryFixed.toARGB32(),
    );
    await EzConfig.setInt(
      lightPrimaryFixedDimKey,
      colorScheme.primaryFixedDim.toARGB32(),
    );
    await EzConfig.setInt(
      lightOnPrimaryFixedKey,
      colorScheme.onPrimaryFixed.toARGB32(),
    );
    await EzConfig.setInt(
      lightOnPrimaryFixedVariantKey,
      colorScheme.onPrimaryFixedVariant.toARGB32(),
    );
    await EzConfig.setInt(
      lightSecondaryKey,
      colorScheme.secondary.toARGB32(),
    );
    await EzConfig.setInt(
      lightOnSecondaryKey,
      colorScheme.onSecondary.toARGB32(),
    );
    await EzConfig.setInt(
      lightSecondaryContainerKey,
      colorScheme.secondaryContainer.toARGB32(),
    );
    await EzConfig.setInt(
      lightOnSecondaryContainerKey,
      colorScheme.onSecondaryContainer.toARGB32(),
    );
    await EzConfig.setInt(
      lightSecondaryFixedKey,
      colorScheme.secondaryFixed.toARGB32(),
    );
    await EzConfig.setInt(
      lightSecondaryFixedDimKey,
      colorScheme.secondaryFixedDim.toARGB32(),
    );
    await EzConfig.setInt(
      lightOnSecondaryFixedKey,
      colorScheme.onSecondaryFixed.toARGB32(),
    );
    await EzConfig.setInt(
      lightOnSecondaryFixedVariantKey,
      colorScheme.onSecondaryFixedVariant.toARGB32(),
    );
    await EzConfig.setInt(
      lightTertiaryKey,
      colorScheme.tertiary.toARGB32(),
    );
    await EzConfig.setInt(
      lightOnTertiaryKey,
      colorScheme.onTertiary.toARGB32(),
    );
    await EzConfig.setInt(
      lightTertiaryContainerKey,
      colorScheme.tertiaryContainer.toARGB32(),
    );
    await EzConfig.setInt(
      lightOnTertiaryContainerKey,
      colorScheme.onTertiaryContainer.toARGB32(),
    );
    await EzConfig.setInt(
      lightTertiaryFixedKey,
      colorScheme.tertiaryFixed.toARGB32(),
    );
    await EzConfig.setInt(
      lightTertiaryFixedDimKey,
      colorScheme.tertiaryFixedDim.toARGB32(),
    );
    await EzConfig.setInt(
      lightOnTertiaryFixedKey,
      colorScheme.onTertiaryFixed.toARGB32(),
    );
    await EzConfig.setInt(
      lightOnTertiaryFixedVariantKey,
      colorScheme.onTertiaryFixedVariant.toARGB32(),
    );
    await EzConfig.setInt(
      lightErrorKey,
      colorScheme.error.toARGB32(),
    );
    await EzConfig.setInt(
      lightOnErrorKey,
      colorScheme.onError.toARGB32(),
    );
    await EzConfig.setInt(
      lightErrorContainerKey,
      colorScheme.errorContainer.toARGB32(),
    );
    await EzConfig.setInt(
      lightOnErrorContainerKey,
      colorScheme.onErrorContainer.toARGB32(),
    );
    await EzConfig.setInt(
      lightOutlineKey,
      colorScheme.outline.toARGB32(),
    );
    await EzConfig.setInt(
      lightOutlineVariantKey,
      colorScheme.outlineVariant.toARGB32(),
    );
    await EzConfig.setInt(
      lightSurfaceKey,
      colorScheme.surface.toARGB32(),
    );
    await EzConfig.setInt(
      lightOnSurfaceKey,
      colorScheme.onSurface.toARGB32(),
    );
    await EzConfig.setInt(
      lightSurfaceDimKey,
      colorScheme.surfaceDim.toARGB32(),
    );
    await EzConfig.setInt(
      lightSurfaceBrightKey,
      colorScheme.surfaceBright.toARGB32(),
    );
    await EzConfig.setInt(
      lightSurfaceContainerLowestKey,
      colorScheme.surfaceContainerLowest.toARGB32(),
    );
    await EzConfig.setInt(
      lightSurfaceContainerLowKey,
      colorScheme.surfaceContainerLow.toARGB32(),
    );
    await EzConfig.setInt(
      lightSurfaceContainerKey,
      colorScheme.surfaceContainer.toARGB32(),
    );
    await EzConfig.setInt(
      lightSurfaceContainerHighKey,
      colorScheme.surfaceContainerHigh.toARGB32(),
    );
    await EzConfig.setInt(
      lightSurfaceContainerHighestKey,
      colorScheme.surfaceContainerHighest.toARGB32(),
    );
    await EzConfig.setInt(
      lightOnSurfaceVariantKey,
      colorScheme.onSurfaceVariant.toARGB32(),
    );
    await EzConfig.setInt(
      lightInverseSurfaceKey,
      colorScheme.inverseSurface.toARGB32(),
    );
    await EzConfig.setInt(
      lightOnInverseSurfaceKey,
      colorScheme.onInverseSurface.toARGB32(),
    );
    await EzConfig.setInt(
      lightInversePrimaryKey,
      colorScheme.inversePrimary.toARGB32(),
    );
    await EzConfig.setInt(
      lightShadowKey,
      colorScheme.shadow.toARGB32(),
    );
    await EzConfig.setInt(
      lightScrimKey,
      colorScheme.scrim.toARGB32(),
    );
    await EzConfig.setInt(
      lightSurfaceTintKey,
      colorScheme.surfaceTint.toARGB32(),
    );
  }
}

/// Generates a [ColorScheme] based on the image found at [path]
/// Then stores the values in [EzConfig]
/// When [brightness] is null, both dark and light color schemes are updated
Future<String> loadImageColorScheme(String path, Brightness? brightness) async {
  try {
    if (brightness == null) {
      loadColorScheme(
        await ColorScheme.fromImageProvider(
          provider: ezImageProvider(path),
          brightness: Brightness.dark,
        ),
        Brightness.dark,
      );
      loadColorScheme(
        await ColorScheme.fromImageProvider(
          provider: ezImageProvider(path),
          brightness: Brightness.light,
        ),
        Brightness.light,
      );
    } else {
      loadColorScheme(
        await ColorScheme.fromImageProvider(
          provider: ezImageProvider(path),
          brightness: brightness,
        ),
        brightness,
      );
    }
  } catch (e) {
    return e.toString();
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
      return key;
  }
}

/// Get the live [ColorScheme] value of [key]
Color getLiveColor(String key) {
  switch (key) {
    case lightPrimaryKey:
    case darkPrimaryKey:
      return EzConfig.colors.primary;
    case lightOnPrimaryKey:
    case darkOnPrimaryKey:
      return EzConfig.colors.onPrimary;
    case lightPrimaryContainerKey:
    case darkPrimaryContainerKey:
      return EzConfig.colors.onPrimaryContainer;
    case lightOnPrimaryContainerKey:
    case darkOnPrimaryContainerKey:
      return EzConfig.colors.onPrimaryContainer;
    case lightPrimaryFixedKey:
    case darkPrimaryFixedKey:
      return EzConfig.colors.primaryFixed;
    case lightPrimaryFixedDimKey:
    case darkPrimaryFixedDimKey:
      return EzConfig.colors.primaryFixedDim;
    case lightOnPrimaryFixedKey:
    case darkOnPrimaryFixedKey:
      return EzConfig.colors.onPrimaryFixed;
    case lightOnPrimaryFixedVariantKey:
    case darkOnPrimaryFixedVariantKey:
      return EzConfig.colors.onPrimaryFixedVariant;
    case lightSecondaryKey:
    case darkSecondaryKey:
      return EzConfig.colors.secondary;
    case lightOnSecondaryKey:
    case darkOnSecondaryKey:
      return EzConfig.colors.onSecondary;
    case lightSecondaryContainerKey:
    case darkSecondaryContainerKey:
      return EzConfig.colors.secondaryContainer;
    case lightOnSecondaryContainerKey:
    case darkOnSecondaryContainerKey:
      return EzConfig.colors.onSecondaryContainer;
    case lightSecondaryFixedKey:
    case darkSecondaryFixedKey:
      return EzConfig.colors.secondaryFixed;
    case lightSecondaryFixedDimKey:
    case darkSecondaryFixedDimKey:
      return EzConfig.colors.secondaryFixedDim;
    case lightOnSecondaryFixedKey:
    case darkOnSecondaryFixedKey:
      return EzConfig.colors.onSecondaryFixed;
    case lightOnSecondaryFixedVariantKey:
    case darkOnSecondaryFixedVariantKey:
      return EzConfig.colors.onSecondaryFixedVariant;
    case lightTertiaryKey:
    case darkTertiaryKey:
      return EzConfig.colors.tertiary;
    case lightOnTertiaryKey:
    case darkOnTertiaryKey:
      return EzConfig.colors.onTertiary;
    case lightTertiaryContainerKey:
    case darkTertiaryContainerKey:
      return EzConfig.colors.tertiaryContainer;
    case lightOnTertiaryContainerKey:
    case darkOnTertiaryContainerKey:
      return EzConfig.colors.onTertiaryContainer;
    case lightTertiaryFixedKey:
    case darkTertiaryFixedKey:
      return EzConfig.colors.tertiaryFixed;
    case lightTertiaryFixedDimKey:
    case darkTertiaryFixedDimKey:
      return EzConfig.colors.tertiaryFixedDim;
    case lightOnTertiaryFixedKey:
    case darkOnTertiaryFixedKey:
      return EzConfig.colors.onTertiaryFixed;
    case lightOnTertiaryFixedVariantKey:
    case darkOnTertiaryFixedVariantKey:
      return EzConfig.colors.onTertiaryFixedVariant;
    case lightErrorKey:
    case darkErrorKey:
      return EzConfig.colors.error;
    case lightOnErrorKey:
    case darkOnErrorKey:
      return EzConfig.colors.onError;
    case lightErrorContainerKey:
    case darkErrorContainerKey:
      return EzConfig.colors.errorContainer;
    case lightOnErrorContainerKey:
    case darkOnErrorContainerKey:
      return EzConfig.colors.onErrorContainer;
    case lightOutlineKey:
    case darkOutlineKey:
      return EzConfig.colors.outline;
    case lightOutlineVariantKey:
    case darkOutlineVariantKey:
      return EzConfig.colors.outlineVariant;
    case lightSurfaceKey:
    case darkSurfaceKey:
      return EzConfig.colors.surface;
    case lightOnSurfaceKey:
    case darkOnSurfaceKey:
      return EzConfig.colors.onSurface;
    case lightSurfaceDimKey:
    case darkSurfaceDimKey:
      return EzConfig.colors.surfaceDim;
    case lightSurfaceBrightKey:
    case darkSurfaceBrightKey:
      return EzConfig.colors.surfaceBright;
    case lightSurfaceContainerLowestKey:
    case darkSurfaceContainerLowestKey:
      return EzConfig.colors.surfaceContainerLowest;
    case lightSurfaceContainerLowKey:
    case darkSurfaceContainerLowKey:
      return EzConfig.colors.surfaceContainerLow;
    case lightSurfaceContainerKey:
    case darkSurfaceContainerKey:
      return EzConfig.colors.surfaceContainer;
    case lightSurfaceContainerHighKey:
    case darkSurfaceContainerHighKey:
      return EzConfig.colors.surfaceContainerHigh;
    case lightSurfaceContainerHighestKey:
    case darkSurfaceContainerHighestKey:
      return EzConfig.colors.surfaceContainerHighest;
    case lightOnSurfaceVariantKey:
    case darkOnSurfaceVariantKey:
      return EzConfig.colors.onSurfaceVariant;
    case lightInverseSurfaceKey:
    case darkInverseSurfaceKey:
      return EzConfig.colors.inverseSurface;
    case lightOnInverseSurfaceKey:
    case darkOnInverseSurfaceKey:
      return EzConfig.colors.onInverseSurface;
    case lightInversePrimaryKey:
    case darkInversePrimaryKey:
      return EzConfig.colors.inversePrimary;
    case lightScrimKey:
    case darkScrimKey:
      return EzConfig.colors.scrim;
    case lightShadowKey:
    case darkShadowKey:
      return EzConfig.colors.shadow;
    case lightSurfaceTintKey:
    case darkSurfaceTintKey:
      return EzConfig.colors.surfaceTint;
    default:
      return Colors.transparent;
  }
}
