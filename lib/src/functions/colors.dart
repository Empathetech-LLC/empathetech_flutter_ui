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
  return brightness == Brightness.light
      ? ColorScheme.fromSeed(
          seedColor: EzConfig.instance.prefs[lightPrimaryKey],
          brightness: Brightness.light,
          primary: EzConfig.instance.prefs[lightPrimaryKey],
          onPrimary: EzConfig.instance.prefs[lightOnPrimaryKey],
          primaryContainer: EzConfig.instance.prefs[lightPrimaryContainerKey],
          onPrimaryContainer:
              EzConfig.instance.prefs[lightOnPrimaryContainerKey],
          secondary: EzConfig.instance.prefs[lightSecondaryKey],
          onSecondary: EzConfig.instance.prefs[lightOnSecondaryKey],
          secondaryContainer:
              EzConfig.instance.prefs[lightSecondaryContainerKey],
          onSecondaryContainer:
              EzConfig.instance.prefs[lightOnSecondaryContainerKey],
          tertiary: EzConfig.instance.prefs[lightTertiaryKey],
          onTertiary: EzConfig.instance.prefs[lightOnTertiaryKey],
          tertiaryContainer: EzConfig.instance.prefs[lightTertiaryContainerKey],
          onTertiaryContainer:
              EzConfig.instance.prefs[lightOnTertiaryContainerKey],
          error: EzConfig.instance.prefs[lightErrorKey],
          onError: EzConfig.instance.prefs[lightOnErrorKey],
          errorContainer: EzConfig.instance.prefs[lightErrorContainerKey],
          onErrorContainer: EzConfig.instance.prefs[lightOnErrorContainerKey],
          outline: EzConfig.instance.prefs[lightOutlineKey],
          outlineVariant: EzConfig.instance.prefs[lightOutlineVariantKey],
          background: EzConfig.instance.prefs[lightBackgroundKey],
          onBackground: EzConfig.instance.prefs[lightOnBackgroundKey],
          surface: EzConfig.instance.prefs[lightSurfaceKey],
          onSurface: EzConfig.instance.prefs[lightOnSurfaceKey],
          surfaceVariant: EzConfig.instance.prefs[lightSurfaceVariantKey],
          onSurfaceVariant: EzConfig.instance.prefs[lightOnSurfaceVariantKey],
          inverseSurface: EzConfig.instance.prefs[lightInverseSurfaceKey],
          onInverseSurface: EzConfig.instance.prefs[lightOnInverseSurfaceKey],
          inversePrimary: EzConfig.instance.prefs[lightInversePrimaryKey],
          shadow: EzConfig.instance.prefs[lightShadowKey],
          scrim: EzConfig.instance.prefs[lightScrimKey],
          surfaceTint: EzConfig.instance.prefs[lightSurfaceTintKey],
        )
      : ColorScheme.fromSeed(
          seedColor: EzConfig.instance.prefs[darkPrimaryKey],
          brightness: Brightness.dark,
          primary: EzConfig.instance.prefs[darkPrimaryKey],
          onPrimary: EzConfig.instance.prefs[darkOnPrimaryKey],
          primaryContainer: EzConfig.instance.prefs[darkPrimaryContainerKey],
          onPrimaryContainer:
              EzConfig.instance.prefs[darkOnPrimaryContainerKey],
          secondary: EzConfig.instance.prefs[darkSecondaryKey],
          onSecondary: EzConfig.instance.prefs[darkOnSecondaryKey],
          secondaryContainer:
              EzConfig.instance.prefs[darkSecondaryContainerKey],
          onSecondaryContainer:
              EzConfig.instance.prefs[darkOnSecondaryContainerKey],
          tertiary: EzConfig.instance.prefs[darkTertiaryKey],
          onTertiary: EzConfig.instance.prefs[darkOnTertiaryKey],
          tertiaryContainer: EzConfig.instance.prefs[darkTertiaryContainerKey],
          onTertiaryContainer:
              EzConfig.instance.prefs[darkOnTertiaryContainerKey],
          error: EzConfig.instance.prefs[darkErrorKey],
          onError: EzConfig.instance.prefs[darkOnErrorKey],
          errorContainer: EzConfig.instance.prefs[darkErrorContainerKey],
          onErrorContainer: EzConfig.instance.prefs[darkOnErrorContainerKey],
          outline: EzConfig.instance.prefs[darkOutlineKey],
          outlineVariant: EzConfig.instance.prefs[darkOutlineVariantKey],
          background: EzConfig.instance.prefs[darkBackgroundKey],
          onBackground: EzConfig.instance.prefs[darkOnBackgroundKey],
          surface: EzConfig.instance.prefs[darkSurfaceKey],
          onSurface: EzConfig.instance.prefs[darkOnSurfaceKey],
          surfaceVariant: EzConfig.instance.prefs[darkSurfaceVariantKey],
          onSurfaceVariant: EzConfig.instance.prefs[darkOnSurfaceVariantKey],
          inverseSurface: EzConfig.instance.prefs[darkInverseSurfaceKey],
          onInverseSurface: EzConfig.instance.prefs[darkOnInverseSurfaceKey],
          inversePrimary: EzConfig.instance.prefs[darkInversePrimaryKey],
          shadow: EzConfig.instance.prefs[darkShadowKey],
          scrim: EzConfig.instance.prefs[darkScrimKey],
          surfaceTint: EzConfig.instance.prefs[darkSurfaceTintKey],
        );
}
