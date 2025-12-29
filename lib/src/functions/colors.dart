/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
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

/// Store the passed [ColorScheme] in [EzConfig.prefs]
Future<void> storeColorScheme({
  required ColorScheme colorScheme,
  required Brightness? brightness,
  bool notifyTheme = false,
  void Function()? onNotify,
}) async {
  if (brightness == null || brightness == Brightness.dark) {
    await EzConfig.removeKeys(
      darkColorKeys.keys.toSet(),
    );

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
    await EzConfig.removeKeys(
      lightColorKeys.keys.toSet(),
    );

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

  if (notifyTheme) {
    EzConfig.provider.rebuild(onComplete: onNotify);
  }
}

/// Generates a [ColorScheme] based on the image found at [path]
/// Then stores the values in [EzConfig]
Future<String> storeImageColorScheme({
  required String path,
  required Brightness brightness,
  bool notifyTheme = false,
  void Function()? onNotify,
}) async {
  late final ColorScheme colorScheme;

  try {
    colorScheme = await ColorScheme.fromImageProvider(
      provider: ezImageProvider(path),
      brightness: brightness,
    );
  } catch (e) {
    return e.toString();
  }

  await storeColorScheme(
    colorScheme: colorScheme,
    brightness: brightness,
    notifyTheme: notifyTheme,
    onNotify: onNotify,
  );
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
