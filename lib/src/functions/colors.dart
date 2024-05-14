/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Returns the guesstimated most readable text color (black/white) for [background]
/// Formula credit: https://stackoverflow.com/questions/3942878/how-to-decide-font-color-in-white-or-black-depending-on-background-color
Color getTextColor(Color background) {
  return Color((((background.red * 0.299) +
              (background.green * 0.587) +
              (background.blue * 0.114)) >=
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
void storeColorScheme({
  required ColorScheme colorScheme,
  required Brightness brightness,
}) {
  if (brightness == Brightness.light) {
    EzConfig.removeKeys(lightColors.toSet());

    EzConfig.setInt(lightPrimaryKey, colorScheme.primary.value);
    EzConfig.setInt(lightOnPrimaryKey, colorScheme.onPrimary.value);
    EzConfig.setInt(
        lightPrimaryContainerKey, colorScheme.primaryContainer.value);
    EzConfig.setInt(
        lightOnPrimaryContainerKey, colorScheme.onPrimaryContainer.value);
    EzConfig.setInt(lightPrimaryFixedKey, colorScheme.primaryFixed.value);
    EzConfig.setInt(lightPrimaryFixedDimKey, colorScheme.primaryFixedDim.value);
    EzConfig.setInt(lightOnPrimaryFixedKey, colorScheme.onPrimaryFixed.value);
    EzConfig.setInt(
        lightOnPrimaryFixedVariantKey, colorScheme.onPrimaryFixedVariant.value);
    EzConfig.setInt(lightSecondaryKey, colorScheme.secondary.value);
    EzConfig.setInt(lightOnSecondaryKey, colorScheme.onSecondary.value);
    EzConfig.setInt(
        lightSecondaryContainerKey, colorScheme.secondaryContainer.value);
    EzConfig.setInt(
        lightOnSecondaryContainerKey, colorScheme.onSecondaryContainer.value);
    EzConfig.setInt(lightSecondaryFixedKey, colorScheme.secondaryFixed.value);
    EzConfig.setInt(
        lightSecondaryFixedDimKey, colorScheme.secondaryFixedDim.value);
    EzConfig.setInt(
        lightOnSecondaryFixedKey, colorScheme.onSecondaryFixed.value);
    EzConfig.setInt(lightOnSecondaryFixedVariantKey,
        colorScheme.onSecondaryFixedVariant.value);
    EzConfig.setInt(lightTertiaryKey, colorScheme.tertiary.value);
    EzConfig.setInt(lightOnTertiaryKey, colorScheme.onTertiary.value);
    EzConfig.setInt(
        lightTertiaryContainerKey, colorScheme.tertiaryContainer.value);
    EzConfig.setInt(
        lightOnTertiaryContainerKey, colorScheme.onTertiaryContainer.value);
    EzConfig.setInt(lightTertiaryFixedKey, colorScheme.tertiaryFixed.value);
    EzConfig.setInt(
        lightTertiaryFixedDimKey, colorScheme.tertiaryFixedDim.value);
    EzConfig.setInt(lightOnTertiaryFixedKey, colorScheme.onTertiaryFixed.value);
    EzConfig.setInt(lightOnTertiaryFixedVariantKey,
        colorScheme.onTertiaryFixedVariant.value);
    EzConfig.setInt(lightErrorKey, colorScheme.error.value);
    EzConfig.setInt(lightOnErrorKey, colorScheme.onError.value);
    EzConfig.setInt(lightErrorContainerKey, colorScheme.errorContainer.value);
    EzConfig.setInt(
        lightOnErrorContainerKey, colorScheme.onErrorContainer.value);
    EzConfig.setInt(lightOutlineKey, colorScheme.outline.value);
    EzConfig.setInt(lightOutlineVariantKey, colorScheme.outlineVariant.value);
    EzConfig.setInt(lightSurfaceKey, colorScheme.surface.value);
    EzConfig.setInt(lightOnSurfaceKey, colorScheme.onSurface.value);
    EzConfig.setInt(lightSurfaceDimKey, colorScheme.surfaceDim.value);
    EzConfig.setInt(lightSurfaceBrightKey, colorScheme.surfaceBright.value);
    EzConfig.setInt(lightSurfaceContainerLowestKey,
        colorScheme.surfaceContainerLowest.value);
    EzConfig.setInt(
        lightSurfaceContainerLowKey, colorScheme.surfaceContainerLow.value);
    EzConfig.setInt(
        lightSurfaceContainerKey, colorScheme.surfaceContainer.value);
    EzConfig.setInt(
        lightSurfaceContainerHighKey, colorScheme.surfaceContainerHigh.value);
    EzConfig.setInt(lightSurfaceContainerHighestKey,
        colorScheme.surfaceContainerHighest.value);
    EzConfig.setInt(
        lightOnSurfaceVariantKey, colorScheme.onSurfaceVariant.value);
    EzConfig.setInt(lightInverseSurfaceKey, colorScheme.inverseSurface.value);
    EzConfig.setInt(
        lightOnInverseSurfaceKey, colorScheme.onInverseSurface.value);
    EzConfig.setInt(lightInversePrimaryKey, colorScheme.inversePrimary.value);
    EzConfig.setInt(lightShadowKey, colorScheme.shadow.value);
    EzConfig.setInt(lightScrimKey, colorScheme.scrim.value);
    EzConfig.setInt(lightSurfaceTintKey, colorScheme.surfaceTint.value);
  } else {
    EzConfig.removeKeys(darkColors.toSet());

    EzConfig.setInt(darkPrimaryKey, colorScheme.primary.value);
    EzConfig.setInt(darkOnPrimaryKey, colorScheme.onPrimary.value);
    EzConfig.setInt(
        darkPrimaryContainerKey, colorScheme.primaryContainer.value);
    EzConfig.setInt(
        darkOnPrimaryContainerKey, colorScheme.onPrimaryContainer.value);
    EzConfig.setInt(darkPrimaryFixedKey, colorScheme.primaryFixed.value);
    EzConfig.setInt(darkPrimaryFixedDimKey, colorScheme.primaryFixedDim.value);
    EzConfig.setInt(darkOnPrimaryFixedKey, colorScheme.onPrimaryFixed.value);
    EzConfig.setInt(
        darkOnPrimaryFixedVariantKey, colorScheme.onPrimaryFixedVariant.value);
    EzConfig.setInt(darkSecondaryKey, colorScheme.secondary.value);
    EzConfig.setInt(darkOnSecondaryKey, colorScheme.onSecondary.value);
    EzConfig.setInt(
        darkSecondaryContainerKey, colorScheme.secondaryContainer.value);
    EzConfig.setInt(
        darkOnSecondaryContainerKey, colorScheme.onSecondaryContainer.value);
    EzConfig.setInt(darkSecondaryFixedKey, colorScheme.secondaryFixed.value);
    EzConfig.setInt(
        darkSecondaryFixedDimKey, colorScheme.secondaryFixedDim.value);
    EzConfig.setInt(
        darkOnSecondaryFixedKey, colorScheme.onSecondaryFixed.value);
    EzConfig.setInt(darkOnSecondaryFixedVariantKey,
        colorScheme.onSecondaryFixedVariant.value);
    EzConfig.setInt(darkTertiaryKey, colorScheme.tertiary.value);
    EzConfig.setInt(darkOnTertiaryKey, colorScheme.onTertiary.value);
    EzConfig.setInt(
        darkTertiaryContainerKey, colorScheme.tertiaryContainer.value);
    EzConfig.setInt(
        darkOnTertiaryContainerKey, colorScheme.onTertiaryContainer.value);
    EzConfig.setInt(darkTertiaryFixedKey, colorScheme.tertiaryFixed.value);
    EzConfig.setInt(
        darkTertiaryFixedDimKey, colorScheme.tertiaryFixedDim.value);
    EzConfig.setInt(darkOnTertiaryFixedKey, colorScheme.onTertiaryFixed.value);
    EzConfig.setInt(darkOnTertiaryFixedVariantKey,
        colorScheme.onTertiaryFixedVariant.value);
    EzConfig.setInt(darkErrorKey, colorScheme.error.value);
    EzConfig.setInt(darkOnErrorKey, colorScheme.onError.value);
    EzConfig.setInt(darkErrorContainerKey, colorScheme.errorContainer.value);
    EzConfig.setInt(
        darkOnErrorContainerKey, colorScheme.onErrorContainer.value);
    EzConfig.setInt(darkOutlineKey, colorScheme.outline.value);
    EzConfig.setInt(darkOutlineVariantKey, colorScheme.outlineVariant.value);
    EzConfig.setInt(darkSurfaceKey, colorScheme.surface.value);
    EzConfig.setInt(darkOnSurfaceKey, colorScheme.onSurface.value);
    EzConfig.setInt(darkSurfaceDimKey, colorScheme.surfaceDim.value);
    EzConfig.setInt(darkSurfaceBrightKey, colorScheme.surfaceBright.value);
    EzConfig.setInt(darkSurfaceContainerLowestKey,
        colorScheme.surfaceContainerLowest.value);
    EzConfig.setInt(
        darkSurfaceContainerLowKey, colorScheme.surfaceContainerLow.value);
    EzConfig.setInt(
        darkSurfaceContainerKey, colorScheme.surfaceContainer.value);
    EzConfig.setInt(
        darkSurfaceContainerHighKey, colorScheme.surfaceContainerHigh.value);
    EzConfig.setInt(darkSurfaceContainerHighestKey,
        colorScheme.surfaceContainerHighest.value);
    EzConfig.setInt(
        darkOnSurfaceVariantKey, colorScheme.onSurfaceVariant.value);
    EzConfig.setInt(darkInverseSurfaceKey, colorScheme.inverseSurface.value);
    EzConfig.setInt(
        darkOnInverseSurfaceKey, colorScheme.onInverseSurface.value);
    EzConfig.setInt(darkInversePrimaryKey, colorScheme.inversePrimary.value);
    EzConfig.setInt(darkShadowKey, colorScheme.shadow.value);
    EzConfig.setInt(darkScrimKey, colorScheme.scrim.value);
    EzConfig.setInt(darkSurfaceTintKey, colorScheme.surfaceTint.value);
  }
}

/// Generates a [ColorScheme] based on the image found at [path]
/// Then stores the values in [EzConfig.preferences]
Future<void> storeImageColorScheme({
  required String path,
  required Brightness brightness,
}) async {
  final ColorScheme colorScheme = await ColorScheme.fromImageProvider(
    provider: provideImage(path),
    brightness: brightness,
  );

  if (brightness == Brightness.light) {
    EzConfig.removeKeys(lightColors.toSet());

    EzConfig.setInt(lightPrimaryKey, colorScheme.primary.value);
    EzConfig.setInt(lightOnPrimaryKey, colorScheme.onPrimary.value);
    EzConfig.setInt(
        lightPrimaryContainerKey, colorScheme.primaryContainer.value);
    EzConfig.setInt(
        lightOnPrimaryContainerKey, colorScheme.onPrimaryContainer.value);
    EzConfig.setInt(lightPrimaryFixedKey, colorScheme.primaryFixed.value);
    EzConfig.setInt(lightPrimaryFixedDimKey, colorScheme.primaryFixedDim.value);
    EzConfig.setInt(lightOnPrimaryFixedKey, colorScheme.onPrimaryFixed.value);
    EzConfig.setInt(
        lightOnPrimaryFixedVariantKey, colorScheme.onPrimaryFixedVariant.value);
    EzConfig.setInt(lightSecondaryKey, colorScheme.secondary.value);
    EzConfig.setInt(lightOnSecondaryKey, colorScheme.onSecondary.value);
    EzConfig.setInt(
        lightSecondaryContainerKey, colorScheme.secondaryContainer.value);
    EzConfig.setInt(
        lightOnSecondaryContainerKey, colorScheme.onSecondaryContainer.value);
    EzConfig.setInt(lightSecondaryFixedKey, colorScheme.secondaryFixed.value);
    EzConfig.setInt(
        lightSecondaryFixedDimKey, colorScheme.secondaryFixedDim.value);
    EzConfig.setInt(
        lightOnSecondaryFixedKey, colorScheme.onSecondaryFixed.value);
    EzConfig.setInt(lightOnSecondaryFixedVariantKey,
        colorScheme.onSecondaryFixedVariant.value);
    EzConfig.setInt(lightTertiaryKey, colorScheme.tertiary.value);
    EzConfig.setInt(lightOnTertiaryKey, colorScheme.onTertiary.value);
    EzConfig.setInt(
        lightTertiaryContainerKey, colorScheme.tertiaryContainer.value);
    EzConfig.setInt(
        lightOnTertiaryContainerKey, colorScheme.onTertiaryContainer.value);
    EzConfig.setInt(lightTertiaryFixedKey, colorScheme.tertiaryFixed.value);
    EzConfig.setInt(
        lightTertiaryFixedDimKey, colorScheme.tertiaryFixedDim.value);
    EzConfig.setInt(lightOnTertiaryFixedKey, colorScheme.onTertiaryFixed.value);
    EzConfig.setInt(lightOnTertiaryFixedVariantKey,
        colorScheme.onTertiaryFixedVariant.value);
    EzConfig.setInt(lightErrorKey, colorScheme.error.value);
    EzConfig.setInt(lightOnErrorKey, colorScheme.onError.value);
    EzConfig.setInt(lightErrorContainerKey, colorScheme.errorContainer.value);
    EzConfig.setInt(
        lightOnErrorContainerKey, colorScheme.onErrorContainer.value);
    EzConfig.setInt(lightOutlineKey, colorScheme.outline.value);
    EzConfig.setInt(lightOutlineVariantKey, colorScheme.outlineVariant.value);
    EzConfig.setInt(lightSurfaceKey, colorScheme.surface.value);
    EzConfig.setInt(lightOnSurfaceKey, colorScheme.onSurface.value);
    EzConfig.setInt(lightSurfaceDimKey, colorScheme.surfaceDim.value);
    EzConfig.setInt(lightSurfaceBrightKey, colorScheme.surfaceBright.value);
    EzConfig.setInt(lightSurfaceContainerLowestKey,
        colorScheme.surfaceContainerLowest.value);
    EzConfig.setInt(
        lightSurfaceContainerLowKey, colorScheme.surfaceContainerLow.value);
    EzConfig.setInt(
        lightSurfaceContainerKey, colorScheme.surfaceContainer.value);
    EzConfig.setInt(
        lightSurfaceContainerHighKey, colorScheme.surfaceContainerHigh.value);
    EzConfig.setInt(lightSurfaceContainerHighestKey,
        colorScheme.surfaceContainerHighest.value);
    EzConfig.setInt(
        lightOnSurfaceVariantKey, colorScheme.onSurfaceVariant.value);
    EzConfig.setInt(lightInverseSurfaceKey, colorScheme.inverseSurface.value);
    EzConfig.setInt(
        lightOnInverseSurfaceKey, colorScheme.onInverseSurface.value);
    EzConfig.setInt(lightInversePrimaryKey, colorScheme.inversePrimary.value);
    EzConfig.setInt(lightShadowKey, colorScheme.shadow.value);
    EzConfig.setInt(lightScrimKey, colorScheme.scrim.value);
    EzConfig.setInt(lightSurfaceTintKey, colorScheme.surfaceTint.value);
  } else {
    EzConfig.removeKeys(darkColors.toSet());

    EzConfig.setInt(darkPrimaryKey, colorScheme.primary.value);
    EzConfig.setInt(darkOnPrimaryKey, colorScheme.onPrimary.value);
    EzConfig.setInt(
        darkPrimaryContainerKey, colorScheme.primaryContainer.value);
    EzConfig.setInt(
        darkOnPrimaryContainerKey, colorScheme.onPrimaryContainer.value);
    EzConfig.setInt(darkPrimaryFixedKey, colorScheme.primaryFixed.value);
    EzConfig.setInt(darkPrimaryFixedDimKey, colorScheme.primaryFixedDim.value);
    EzConfig.setInt(darkOnPrimaryFixedKey, colorScheme.onPrimaryFixed.value);
    EzConfig.setInt(
        darkOnPrimaryFixedVariantKey, colorScheme.onPrimaryFixedVariant.value);
    EzConfig.setInt(darkSecondaryKey, colorScheme.secondary.value);
    EzConfig.setInt(darkOnSecondaryKey, colorScheme.onSecondary.value);
    EzConfig.setInt(
        darkSecondaryContainerKey, colorScheme.secondaryContainer.value);
    EzConfig.setInt(
        darkOnSecondaryContainerKey, colorScheme.onSecondaryContainer.value);
    EzConfig.setInt(darkSecondaryFixedKey, colorScheme.secondaryFixed.value);
    EzConfig.setInt(
        darkSecondaryFixedDimKey, colorScheme.secondaryFixedDim.value);
    EzConfig.setInt(
        darkOnSecondaryFixedKey, colorScheme.onSecondaryFixed.value);
    EzConfig.setInt(darkOnSecondaryFixedVariantKey,
        colorScheme.onSecondaryFixedVariant.value);
    EzConfig.setInt(darkTertiaryKey, colorScheme.tertiary.value);
    EzConfig.setInt(darkOnTertiaryKey, colorScheme.onTertiary.value);
    EzConfig.setInt(
        darkTertiaryContainerKey, colorScheme.tertiaryContainer.value);
    EzConfig.setInt(
        darkOnTertiaryContainerKey, colorScheme.onTertiaryContainer.value);
    EzConfig.setInt(darkTertiaryFixedKey, colorScheme.tertiaryFixed.value);
    EzConfig.setInt(
        darkTertiaryFixedDimKey, colorScheme.tertiaryFixedDim.value);
    EzConfig.setInt(darkOnTertiaryFixedKey, colorScheme.onTertiaryFixed.value);
    EzConfig.setInt(darkOnTertiaryFixedVariantKey,
        colorScheme.onTertiaryFixedVariant.value);
    EzConfig.setInt(darkErrorKey, colorScheme.error.value);
    EzConfig.setInt(darkOnErrorKey, colorScheme.onError.value);
    EzConfig.setInt(darkErrorContainerKey, colorScheme.errorContainer.value);
    EzConfig.setInt(
        darkOnErrorContainerKey, colorScheme.onErrorContainer.value);
    EzConfig.setInt(darkOutlineKey, colorScheme.outline.value);
    EzConfig.setInt(darkOutlineVariantKey, colorScheme.outlineVariant.value);
    EzConfig.setInt(darkSurfaceKey, colorScheme.surface.value);
    EzConfig.setInt(darkOnSurfaceKey, colorScheme.onSurface.value);
    EzConfig.setInt(darkSurfaceDimKey, colorScheme.surfaceDim.value);
    EzConfig.setInt(darkSurfaceBrightKey, colorScheme.surfaceBright.value);
    EzConfig.setInt(darkSurfaceContainerLowestKey,
        colorScheme.surfaceContainerLowest.value);
    EzConfig.setInt(
        darkSurfaceContainerLowKey, colorScheme.surfaceContainerLow.value);
    EzConfig.setInt(
        darkSurfaceContainerKey, colorScheme.surfaceContainer.value);
    EzConfig.setInt(
        darkSurfaceContainerHighKey, colorScheme.surfaceContainerHigh.value);
    EzConfig.setInt(darkSurfaceContainerHighestKey,
        colorScheme.surfaceContainerHighest.value);
    EzConfig.setInt(
        darkOnSurfaceVariantKey, colorScheme.onSurfaceVariant.value);
    EzConfig.setInt(darkInverseSurfaceKey, colorScheme.inverseSurface.value);
    EzConfig.setInt(
        darkOnInverseSurfaceKey, colorScheme.onInverseSurface.value);
    EzConfig.setInt(darkInversePrimaryKey, colorScheme.inversePrimary.value);
    EzConfig.setInt(darkShadowKey, colorScheme.shadow.value);
    EzConfig.setInt(darkScrimKey, colorScheme.scrim.value);
    EzConfig.setInt(darkSurfaceTintKey, colorScheme.surfaceTint.value);
  }
}

/// Get the human readable name of a [key]s color
String getColorName(BuildContext context, String key) {
  final EFUILang l10n = EFUILang.of(context)!;

  switch (key) {
    case lightPrimaryKey:
    case darkPrimaryKey:
      return l10n.csPrimary;
    case lightOnPrimaryKey:
    case darkOnPrimaryKey:
      return l10n.csOnPrimary;
    case lightPrimaryContainerKey:
    case darkPrimaryContainerKey:
      return l10n.csPrimaryContainer;
    case lightOnPrimaryContainerKey:
    case darkOnPrimaryContainerKey:
      return l10n.csOnPrimaryContainer;
    case lightPrimaryFixedKey:
    case darkPrimaryFixedKey:
      return l10n.csPrimaryFixed;
    case lightPrimaryFixedDimKey:
    case darkPrimaryFixedDimKey:
      return l10n.csPrimaryFixedDim;
    case lightOnPrimaryFixedKey:
    case darkOnPrimaryFixedKey:
      return l10n.csOnPrimaryFixed;
    case lightOnPrimaryFixedVariantKey:
    case darkOnPrimaryFixedVariantKey:
      return l10n.csOnPrimaryFixedVariant;
    case lightSecondaryKey:
    case darkSecondaryKey:
      return l10n.csSecondary;
    case lightOnSecondaryKey:
    case darkOnSecondaryKey:
      return l10n.csOnSecondary;
    case lightSecondaryContainerKey:
    case darkSecondaryContainerKey:
      return l10n.csSecondaryContainer;
    case lightOnSecondaryContainerKey:
    case darkOnSecondaryContainerKey:
      return l10n.csOnSecondaryContainer;
    case lightSecondaryFixedKey:
    case darkSecondaryFixedKey:
      return l10n.csSecondaryFixed;
    case lightSecondaryFixedDimKey:
    case darkSecondaryFixedDimKey:
      return l10n.csSecondaryFixedDim;
    case lightOnSecondaryFixedKey:
    case darkOnSecondaryFixedKey:
      return l10n.csOnSecondaryFixed;
    case lightOnSecondaryFixedVariantKey:
    case darkOnSecondaryFixedVariantKey:
      return l10n.csOnSecondaryFixedVariant;
    case lightTertiaryKey:
    case darkTertiaryKey:
      return l10n.csTertiary;
    case lightOnTertiaryKey:
    case darkOnTertiaryKey:
      return l10n.csOnTertiary;
    case lightTertiaryContainerKey:
    case darkTertiaryContainerKey:
      return l10n.csTertiaryContainer;
    case lightOnTertiaryContainerKey:
    case darkOnTertiaryContainerKey:
      return l10n.csOnTertiaryContainer;
    case lightTertiaryFixedKey:
    case darkTertiaryFixedKey:
      return l10n.csTertiaryFixed;
    case lightTertiaryFixedDimKey:
    case darkTertiaryFixedDimKey:
      return l10n.csTertiaryFixedDim;
    case lightOnTertiaryFixedKey:
    case darkOnTertiaryFixedKey:
      return l10n.csOnTertiaryFixed;
    case lightOnTertiaryFixedVariantKey:
    case darkOnTertiaryFixedVariantKey:
      return l10n.csOnTertiaryFixedVariant;
    case lightErrorKey:
    case darkErrorKey:
      return l10n.csError;
    case lightOnErrorKey:
    case darkOnErrorKey:
      return l10n.csOnError;
    case lightErrorContainerKey:
    case darkErrorContainerKey:
      return l10n.csErrorContainer;
    case lightOnErrorContainerKey:
    case darkOnErrorContainerKey:
      return l10n.csOnErrorContainer;
    case lightOutlineKey:
    case darkOutlineKey:
      return l10n.csOutline;
    case lightOutlineVariantKey:
    case darkOutlineVariantKey:
      return l10n.csOutlineVariant;
    case lightSurfaceKey:
    case darkSurfaceKey:
      return l10n.csSurface;
    case lightOnSurfaceKey:
    case darkOnSurfaceKey:
      return l10n.csOnSurface;
    case lightSurfaceDimKey:
    case darkSurfaceDimKey:
      return l10n.csSurfaceDim;
    case lightSurfaceBrightKey:
    case darkSurfaceBrightKey:
      return l10n.csSurfaceBright;
    case lightSurfaceContainerLowestKey:
    case darkSurfaceContainerLowestKey:
      return l10n.csSurfaceContainerLowest;
    case lightSurfaceContainerLowKey:
    case darkSurfaceContainerLowKey:
      return l10n.csSurfaceContainerLow;
    case lightSurfaceContainerKey:
    case darkSurfaceContainerKey:
      return l10n.csSurfaceContainer;
    case lightSurfaceContainerHighKey:
    case darkSurfaceContainerHighKey:
      return l10n.csSurfaceContainerHigh;
    case lightSurfaceContainerHighestKey:
    case darkSurfaceContainerHighestKey:
      return l10n.csSurfaceContainerHighest;
    case lightOnSurfaceVariantKey:
    case darkOnSurfaceVariantKey:
      return l10n.csOnSurfaceVariant;
    case lightInverseSurfaceKey:
    case darkInverseSurfaceKey:
      return l10n.csInverseSurface;
    case lightOnInverseSurfaceKey:
    case darkOnInverseSurfaceKey:
      return l10n.csOnInverseSurface;
    case lightInversePrimaryKey:
    case darkInversePrimaryKey:
      return l10n.csInversePrimary;
    case lightScrimKey:
    case darkScrimKey:
      return l10n.csScrim;
    case lightShadowKey:
    case darkShadowKey:
      return l10n.csShadow;
    case lightSurfaceTintKey:
    case darkSurfaceTintKey:
      return l10n.csSurfaceTint;
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
