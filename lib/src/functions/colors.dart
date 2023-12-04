/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Returns the RGB invert of the passed color
Color invertColor(Color toInvert) {
  return Color.fromARGB(
    (toInvert.opacity * 255).round(),
    255 - toInvert.red,
    255 - toInvert.green,
    255 - toInvert.blue,
  );
}

/// Returns the guesstimated most readable text color (black/white) for [background]
Color getTextColor(Color background) {
  // Formula credit: https://stackoverflow.com/questions/3942878/how-to-decide-font-color-in-white-or-black-depending-on-background-color
  return Color((((background.red * 0.299) +
              (background.green * 0.587) +
              (background.blue * 0.114)) >=
          150)
      ? blackHex
      : whiteHex);
}

/// Returns the mathematical average of [color1] and [color2]
Color blendColors(Color color1, Color color2) {
  return Color.fromARGB(
    ((color1.opacity + color2.opacity) / 2 * 255).round(),
    ((color1.red + color2.red) / 2).round(),
    ((color1.green + color2.green) / 2).round(),
    ((color1.blue + color2.blue) / 2).round(),
  );
}

/// Generate a [ColorScheme] based on values present in [EzConfig]
ColorScheme ezColorScheme(Brightness brightness) {
  Color? getColor(String key) {
    final int? value = EzConfig.instance.prefs[key];

    return (value == null) ? null : Color(value);
  }

  return brightness == Brightness.light
      ? ColorScheme.fromSeed(
          seedColor: getColor(lightPrimaryKey)!,
          brightness: Brightness.light,
          primary: getColor(lightPrimaryKey),
          onPrimary: getColor(lightOnPrimaryKey),
          primaryContainer: getColor(lightPrimaryContainerKey),
          onPrimaryContainer: getColor(lightOnPrimaryContainerKey),
          secondary: getColor(lightSecondaryKey),
          onSecondary: getColor(lightOnSecondaryKey),
          secondaryContainer: getColor(lightSecondaryContainerKey),
          onSecondaryContainer: getColor(lightOnSecondaryContainerKey),
          tertiary: getColor(lightTertiaryKey),
          onTertiary: getColor(lightOnTertiaryKey),
          tertiaryContainer: getColor(lightTertiaryContainerKey),
          onTertiaryContainer: getColor(lightOnTertiaryContainerKey),
          error: getColor(lightErrorKey),
          onError: getColor(lightOnErrorKey),
          errorContainer: getColor(lightErrorContainerKey),
          onErrorContainer: getColor(lightOnErrorContainerKey),
          outline: getColor(lightOutlineKey),
          outlineVariant: getColor(lightOutlineVariantKey),
          background: getColor(lightBackgroundKey),
          onBackground: getColor(lightOnBackgroundKey),
          surface: getColor(lightSurfaceKey),
          onSurface: getColor(lightOnSurfaceKey),
          surfaceVariant: getColor(lightSurfaceVariantKey),
          onSurfaceVariant: getColor(lightOnSurfaceVariantKey),
          inverseSurface: getColor(lightInverseSurfaceKey),
          onInverseSurface: getColor(lightOnInverseSurfaceKey),
          inversePrimary: getColor(lightInversePrimaryKey),
          shadow: getColor(lightShadowKey),
          scrim: getColor(lightScrimKey),
          surfaceTint: getColor(lightSurfaceTintKey),
        )
      : ColorScheme.fromSeed(
          seedColor: getColor(darkPrimaryKey)!,
          brightness: Brightness.dark,
          primary: getColor(darkPrimaryKey),
          onPrimary: getColor(darkOnPrimaryKey),
          primaryContainer: getColor(darkPrimaryContainerKey),
          onPrimaryContainer: getColor(darkOnPrimaryContainerKey),
          secondary: getColor(darkSecondaryKey),
          onSecondary: getColor(darkOnSecondaryKey),
          secondaryContainer: getColor(darkSecondaryContainerKey),
          onSecondaryContainer: getColor(darkOnSecondaryContainerKey),
          tertiary: getColor(darkTertiaryKey),
          onTertiary: getColor(darkOnTertiaryKey),
          tertiaryContainer: getColor(darkTertiaryContainerKey),
          onTertiaryContainer: getColor(darkOnTertiaryContainerKey),
          error: getColor(darkErrorKey),
          onError: getColor(darkOnErrorKey),
          errorContainer: getColor(darkErrorContainerKey),
          onErrorContainer: getColor(darkOnErrorContainerKey),
          outline: getColor(darkOutlineKey),
          outlineVariant: getColor(darkOutlineVariantKey),
          background: getColor(darkBackgroundKey),
          onBackground: getColor(darkOnBackgroundKey),
          surface: getColor(darkSurfaceKey),
          onSurface: getColor(darkOnSurfaceKey),
          surfaceVariant: getColor(darkSurfaceVariantKey),
          onSurfaceVariant: getColor(darkOnSurfaceVariantKey),
          inverseSurface: getColor(darkInverseSurfaceKey),
          onInverseSurface: getColor(darkOnInverseSurfaceKey),
          inversePrimary: getColor(darkInversePrimaryKey),
          shadow: getColor(darkShadowKey),
          scrim: getColor(darkScrimKey),
          surfaceTint: getColor(darkSurfaceTintKey),
        );
}

Future<void> storeColorScheme({
  required Brightness brightness,
  required String path,
}) async {
  final ColorScheme colorScheme = await ColorScheme.fromImageProvider(
    provider: provideImage(path),
    brightness: brightness,
  );

  if (brightness == Brightness.light) {
    EzConfig.instance.preferences
        .setInt(lightPrimaryKey, colorScheme.primary.value);
    EzConfig.instance.preferences
        .setInt(lightOnPrimaryKey, colorScheme.onPrimary.value);
    EzConfig.instance.preferences
        .setInt(lightPrimaryContainerKey, colorScheme.primaryContainer.value);
    EzConfig.instance.preferences.setInt(
        lightOnPrimaryContainerKey, colorScheme.onPrimaryContainer.value);
    EzConfig.instance.preferences
        .setInt(lightSecondaryKey, colorScheme.secondary.value);
    EzConfig.instance.preferences
        .setInt(lightOnSecondaryKey, colorScheme.onSecondary.value);
    EzConfig.instance.preferences.setInt(
        lightSecondaryContainerKey, colorScheme.secondaryContainer.value);
    EzConfig.instance.preferences.setInt(
        lightOnSecondaryContainerKey, colorScheme.onSecondaryContainer.value);
    EzConfig.instance.preferences
        .setInt(lightTertiaryKey, colorScheme.tertiary.value);
    EzConfig.instance.preferences
        .setInt(lightOnTertiaryKey, colorScheme.onTertiary.value);
    EzConfig.instance.preferences
        .setInt(lightTertiaryContainerKey, colorScheme.tertiaryContainer.value);
    EzConfig.instance.preferences.setInt(
        lightOnTertiaryContainerKey, colorScheme.onTertiaryContainer.value);
    EzConfig.instance.preferences
        .setInt(lightErrorKey, colorScheme.error.value);
    EzConfig.instance.preferences
        .setInt(lightOnErrorKey, colorScheme.onError.value);
    EzConfig.instance.preferences
        .setInt(lightErrorContainerKey, colorScheme.errorContainer.value);
    EzConfig.instance.preferences
        .setInt(lightOnErrorContainerKey, colorScheme.onErrorContainer.value);
    EzConfig.instance.preferences
        .setInt(lightOutlineKey, colorScheme.outline.value);
    EzConfig.instance.preferences
        .setInt(lightOutlineVariantKey, colorScheme.outlineVariant.value);
    EzConfig.instance.preferences
        .setInt(lightBackgroundKey, colorScheme.background.value);
    EzConfig.instance.preferences
        .setInt(lightOnBackgroundKey, colorScheme.onBackground.value);
    EzConfig.instance.preferences
        .setInt(lightSurfaceKey, colorScheme.surface.value);
    EzConfig.instance.preferences
        .setInt(lightOnSurfaceKey, colorScheme.onSurface.value);
    EzConfig.instance.preferences
        .setInt(lightSurfaceVariantKey, colorScheme.surfaceVariant.value);
    EzConfig.instance.preferences
        .setInt(lightOnSurfaceVariantKey, colorScheme.onSurfaceVariant.value);
    EzConfig.instance.preferences
        .setInt(lightInverseSurfaceKey, colorScheme.inverseSurface.value);
    EzConfig.instance.preferences
        .setInt(lightOnInverseSurfaceKey, colorScheme.onInverseSurface.value);
    EzConfig.instance.preferences
        .setInt(lightInversePrimaryKey, colorScheme.inversePrimary.value);
    EzConfig.instance.preferences
        .setInt(lightShadowKey, colorScheme.shadow.value);
    EzConfig.instance.preferences
        .setInt(lightScrimKey, colorScheme.scrim.value);
    EzConfig.instance.preferences
        .setInt(lightSurfaceTintKey, colorScheme.surfaceTint.value);
  } else {
    EzConfig.instance.preferences
        .setInt(darkPrimaryKey, colorScheme.primary.value);
    EzConfig.instance.preferences
        .setInt(darkOnPrimaryKey, colorScheme.onPrimary.value);
    EzConfig.instance.preferences
        .setInt(darkPrimaryContainerKey, colorScheme.primaryContainer.value);
    EzConfig.instance.preferences.setInt(
        lightOnPrimaryContainerKey, colorScheme.onPrimaryContainer.value);
    EzConfig.instance.preferences
        .setInt(darkSecondaryKey, colorScheme.secondary.value);
    EzConfig.instance.preferences
        .setInt(darkOnSecondaryKey, colorScheme.onSecondary.value);
    EzConfig.instance.preferences.setInt(
        lightSecondaryContainerKey, colorScheme.secondaryContainer.value);
    EzConfig.instance.preferences.setInt(
        lightOnSecondaryContainerKey, colorScheme.onSecondaryContainer.value);
    EzConfig.instance.preferences
        .setInt(darkTertiaryKey, colorScheme.tertiary.value);
    EzConfig.instance.preferences
        .setInt(darkOnTertiaryKey, colorScheme.onTertiary.value);
    EzConfig.instance.preferences
        .setInt(darkTertiaryContainerKey, colorScheme.tertiaryContainer.value);
    EzConfig.instance.preferences.setInt(
        lightOnTertiaryContainerKey, colorScheme.onTertiaryContainer.value);
    EzConfig.instance.preferences.setInt(darkErrorKey, colorScheme.error.value);
    EzConfig.instance.preferences
        .setInt(darkOnErrorKey, colorScheme.onError.value);
    EzConfig.instance.preferences
        .setInt(darkErrorContainerKey, colorScheme.errorContainer.value);
    EzConfig.instance.preferences
        .setInt(darkOnErrorContainerKey, colorScheme.onErrorContainer.value);
    EzConfig.instance.preferences
        .setInt(darkOutlineKey, colorScheme.outline.value);
    EzConfig.instance.preferences
        .setInt(darkOutlineVariantKey, colorScheme.outlineVariant.value);
    EzConfig.instance.preferences
        .setInt(darkBackgroundKey, colorScheme.background.value);
    EzConfig.instance.preferences
        .setInt(darkOnBackgroundKey, colorScheme.onBackground.value);
    EzConfig.instance.preferences
        .setInt(darkSurfaceKey, colorScheme.surface.value);
    EzConfig.instance.preferences
        .setInt(darkOnSurfaceKey, colorScheme.onSurface.value);
    EzConfig.instance.preferences
        .setInt(darkSurfaceVariantKey, colorScheme.surfaceVariant.value);
    EzConfig.instance.preferences
        .setInt(darkOnSurfaceVariantKey, colorScheme.onSurfaceVariant.value);
    EzConfig.instance.preferences
        .setInt(darkInverseSurfaceKey, colorScheme.inverseSurface.value);
    EzConfig.instance.preferences
        .setInt(darkOnInverseSurfaceKey, colorScheme.onInverseSurface.value);
    EzConfig.instance.preferences
        .setInt(darkInversePrimaryKey, colorScheme.inversePrimary.value);
    EzConfig.instance.preferences
        .setInt(darkShadowKey, colorScheme.shadow.value);
    EzConfig.instance.preferences.setInt(darkScrimKey, colorScheme.scrim.value);
    EzConfig.instance.preferences
        .setInt(darkSurfaceTintKey, colorScheme.surfaceTint.value);
  }
}
