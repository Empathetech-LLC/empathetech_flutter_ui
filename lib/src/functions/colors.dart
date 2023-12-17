/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
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

/// Generates a [ColorScheme] based on the image found at [path]
/// Then stores the values in [EzConfig.preferences]
Future<void> storeImageColorScheme({
  required Brightness brightness,
  required String path,
}) async {
  final ColorScheme colorScheme = await ColorScheme.fromImageProvider(
    provider: provideImage(path),
    brightness: brightness,
  );

  if (brightness == Brightness.light) {
    EzConfig.setInt(lightPrimaryKey, colorScheme.primary.value);
    EzConfig.setInt(lightOnPrimaryKey, colorScheme.onPrimary.value);
    EzConfig.setInt(
        lightPrimaryContainerKey, colorScheme.primaryContainer.value);
    EzConfig.setInt(
        lightOnPrimaryContainerKey, colorScheme.onPrimaryContainer.value);
    EzConfig.setInt(lightSecondaryKey, colorScheme.secondary.value);
    EzConfig.setInt(lightOnSecondaryKey, colorScheme.onSecondary.value);
    EzConfig.setInt(
        lightSecondaryContainerKey, colorScheme.secondaryContainer.value);
    EzConfig.setInt(
        lightOnSecondaryContainerKey, colorScheme.onSecondaryContainer.value);
    EzConfig.setInt(lightTertiaryKey, colorScheme.tertiary.value);
    EzConfig.setInt(lightOnTertiaryKey, colorScheme.onTertiary.value);
    EzConfig.setInt(
        lightTertiaryContainerKey, colorScheme.tertiaryContainer.value);
    EzConfig.setInt(
        lightOnTertiaryContainerKey, colorScheme.onTertiaryContainer.value);
    EzConfig.setInt(lightErrorKey, colorScheme.error.value);
    EzConfig.setInt(lightOnErrorKey, colorScheme.onError.value);
    EzConfig.setInt(lightErrorContainerKey, colorScheme.errorContainer.value);
    EzConfig.setInt(
        lightOnErrorContainerKey, colorScheme.onErrorContainer.value);
    EzConfig.setInt(lightOutlineKey, colorScheme.outline.value);
    EzConfig.setInt(lightOutlineVariantKey, colorScheme.outlineVariant.value);
    EzConfig.setInt(lightBackgroundKey, colorScheme.background.value);
    EzConfig.setInt(lightOnBackgroundKey, colorScheme.onBackground.value);
    EzConfig.setInt(lightSurfaceKey, colorScheme.surface.value);
    EzConfig.setInt(lightOnSurfaceKey, colorScheme.onSurface.value);
    EzConfig.setInt(lightSurfaceVariantKey, colorScheme.surfaceVariant.value);
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
    EzConfig.setInt(darkPrimaryKey, colorScheme.primary.value);
    EzConfig.setInt(darkOnPrimaryKey, colorScheme.onPrimary.value);
    EzConfig.setInt(
        darkPrimaryContainerKey, colorScheme.primaryContainer.value);
    EzConfig.setInt(
        lightOnPrimaryContainerKey, colorScheme.onPrimaryContainer.value);
    EzConfig.setInt(darkSecondaryKey, colorScheme.secondary.value);
    EzConfig.setInt(darkOnSecondaryKey, colorScheme.onSecondary.value);
    EzConfig.setInt(
        lightSecondaryContainerKey, colorScheme.secondaryContainer.value);
    EzConfig.setInt(
        lightOnSecondaryContainerKey, colorScheme.onSecondaryContainer.value);
    EzConfig.setInt(darkTertiaryKey, colorScheme.tertiary.value);
    EzConfig.setInt(darkOnTertiaryKey, colorScheme.onTertiary.value);
    EzConfig.setInt(
        darkTertiaryContainerKey, colorScheme.tertiaryContainer.value);
    EzConfig.setInt(
        lightOnTertiaryContainerKey, colorScheme.onTertiaryContainer.value);
    EzConfig.setInt(darkErrorKey, colorScheme.error.value);
    EzConfig.setInt(darkOnErrorKey, colorScheme.onError.value);
    EzConfig.setInt(darkErrorContainerKey, colorScheme.errorContainer.value);
    EzConfig.setInt(
        darkOnErrorContainerKey, colorScheme.onErrorContainer.value);
    EzConfig.setInt(darkOutlineKey, colorScheme.outline.value);
    EzConfig.setInt(darkOutlineVariantKey, colorScheme.outlineVariant.value);
    EzConfig.setInt(darkBackgroundKey, colorScheme.background.value);
    EzConfig.setInt(darkOnBackgroundKey, colorScheme.onBackground.value);
    EzConfig.setInt(darkSurfaceKey, colorScheme.surface.value);
    EzConfig.setInt(darkOnSurfaceKey, colorScheme.onSurface.value);
    EzConfig.setInt(darkSurfaceVariantKey, colorScheme.surfaceVariant.value);
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
  switch (key) {
    case lightPrimaryKey:
    case darkPrimaryKey:
      return EFUILang.of(context)!.csPrimary;

    case lightOnPrimaryKey:
    case darkOnPrimaryKey:
      return EFUILang.of(context)!.csOnPrimary;

    case lightPrimaryContainerKey:
    case darkPrimaryContainerKey:
      return EFUILang.of(context)!.csPrimaryContainer;

    case lightOnPrimaryContainerKey:
    case darkOnPrimaryContainerKey:
      return EFUILang.of(context)!.csOnPrimaryContainer;

    case lightSecondaryKey:
    case darkSecondaryKey:
      return EFUILang.of(context)!.csSecondary;

    case lightOnSecondaryKey:
    case darkOnSecondaryKey:
      return EFUILang.of(context)!.csOnSecondary;

    case lightSecondaryContainerKey:
    case darkSecondaryContainerKey:
      return EFUILang.of(context)!.csSecondaryContainer;

    case lightOnSecondaryContainerKey:
    case darkOnSecondaryContainerKey:
      return EFUILang.of(context)!.csOnSecondaryContainer;

    case lightTertiaryKey:
    case darkTertiaryKey:
      return EFUILang.of(context)!.csTertiary;

    case lightOnTertiaryKey:
    case darkOnTertiaryKey:
      return EFUILang.of(context)!.csOnTertiary;

    case lightTertiaryContainerKey:
    case darkTertiaryContainerKey:
      return EFUILang.of(context)!.csTertiaryContainer;

    case lightOnTertiaryContainerKey:
    case darkOnTertiaryContainerKey:
      return EFUILang.of(context)!.csOnTertiaryContainer;

    case lightErrorKey:
    case darkErrorKey:
      return EFUILang.of(context)!.csError;

    case lightOnErrorKey:
    case darkOnErrorKey:
      return EFUILang.of(context)!.csOnError;

    case lightErrorContainerKey:
    case darkErrorContainerKey:
      return EFUILang.of(context)!.csErrorContainer;

    case lightOnErrorContainerKey:
    case darkOnErrorContainerKey:
      return EFUILang.of(context)!.csOnErrorContainer;

    case lightOutlineKey:
    case darkOutlineKey:
      return EFUILang.of(context)!.csOutline;

    case lightOutlineVariantKey:
    case darkOutlineVariantKey:
      return EFUILang.of(context)!.csOutlineVariant;

    case lightBackgroundKey:
    case darkBackgroundKey:
      return EFUILang.of(context)!.csBackground;

    case lightOnBackgroundKey:
    case darkOnBackgroundKey:
      return EFUILang.of(context)!.csOnBackground;

    case lightSurfaceKey:
    case darkSurfaceKey:
      return EFUILang.of(context)!.csSurface;

    case lightOnSurfaceKey:
    case darkOnSurfaceKey:
      return EFUILang.of(context)!.csOnSurface;

    case lightSurfaceVariantKey:
    case darkSurfaceVariantKey:
      return EFUILang.of(context)!.csSurfaceVariant;

    case lightOnSurfaceVariantKey:
    case darkOnSurfaceVariantKey:
      return EFUILang.of(context)!.csOnSurfaceVariant;

    case lightInverseSurfaceKey:
    case darkInverseSurfaceKey:
      return EFUILang.of(context)!.csInverseSurface;

    case lightOnInverseSurfaceKey:
    case darkOnInverseSurfaceKey:
      return EFUILang.of(context)!.csOnInverseSurface;

    case lightInversePrimaryKey:
    case darkInversePrimaryKey:
      return EFUILang.of(context)!.csInversePrimary;

    case lightScrimKey:
    case darkScrimKey:
      return EFUILang.of(context)!.csScrim;

    case lightShadowKey:
    case darkShadowKey:
      return EFUILang.of(context)!.csShadow;

    case lightSurfaceTintKey:
    case darkSurfaceTintKey:
      return EFUILang.of(context)!.csSurfaceTint;

    default:
      return "null";
  }
}

/// Resolve the color [key] to the live [ColorScheme] value
Color getLiveColor(BuildContext context, String key) {
  switch (key) {
    case lightPrimaryKey:
    case darkPrimaryKey:
      return Theme.of(context).colorScheme.primary;

    case lightOnPrimaryKey:
    case darkOnPrimaryKey:
      return Theme.of(context).colorScheme.onPrimary;

    case lightPrimaryContainerKey:
    case darkPrimaryContainerKey:
      return Theme.of(context).colorScheme.onPrimaryContainer;

    case lightOnPrimaryContainerKey:
    case darkOnPrimaryContainerKey:
      return Theme.of(context).colorScheme.onPrimaryContainer;

    case lightSecondaryKey:
    case darkSecondaryKey:
      return Theme.of(context).colorScheme.secondary;

    case lightOnSecondaryKey:
    case darkOnSecondaryKey:
      return Theme.of(context).colorScheme.onSecondary;

    case lightSecondaryContainerKey:
    case darkSecondaryContainerKey:
      return Theme.of(context).colorScheme.secondaryContainer;

    case lightOnSecondaryContainerKey:
    case darkOnSecondaryContainerKey:
      return Theme.of(context).colorScheme.onSecondaryContainer;

    case lightTertiaryKey:
    case darkTertiaryKey:
      return Theme.of(context).colorScheme.tertiary;

    case lightOnTertiaryKey:
    case darkOnTertiaryKey:
      return Theme.of(context).colorScheme.onTertiary;

    case lightTertiaryContainerKey:
    case darkTertiaryContainerKey:
      return Theme.of(context).colorScheme.tertiaryContainer;

    case lightOnTertiaryContainerKey:
    case darkOnTertiaryContainerKey:
      return Theme.of(context).colorScheme.onTertiaryContainer;

    case lightErrorKey:
    case darkErrorKey:
      return Theme.of(context).colorScheme.error;

    case lightOnErrorKey:
    case darkOnErrorKey:
      return Theme.of(context).colorScheme.onError;

    case lightErrorContainerKey:
    case darkErrorContainerKey:
      return Theme.of(context).colorScheme.errorContainer;

    case lightOnErrorContainerKey:
    case darkOnErrorContainerKey:
      return Theme.of(context).colorScheme.onErrorContainer;

    case lightOutlineKey:
    case darkOutlineKey:
      return Theme.of(context).colorScheme.outline;

    case lightOutlineVariantKey:
    case darkOutlineVariantKey:
      return Theme.of(context).colorScheme.outlineVariant;

    case lightBackgroundKey:
    case darkBackgroundKey:
      return Theme.of(context).colorScheme.background;

    case lightOnBackgroundKey:
    case darkOnBackgroundKey:
      return Theme.of(context).colorScheme.background;

    case lightSurfaceKey:
    case darkSurfaceKey:
      return Theme.of(context).colorScheme.surface;

    case lightOnSurfaceKey:
    case darkOnSurfaceKey:
      return Theme.of(context).colorScheme.onSurface;

    case lightSurfaceVariantKey:
    case darkSurfaceVariantKey:
      return Theme.of(context).colorScheme.surfaceVariant;

    case lightOnSurfaceVariantKey:
    case darkOnSurfaceVariantKey:
      return Theme.of(context).colorScheme.onSurfaceVariant;

    case lightInverseSurfaceKey:
    case darkInverseSurfaceKey:
      return Theme.of(context).colorScheme.inverseSurface;

    case lightOnInverseSurfaceKey:
    case darkOnInverseSurfaceKey:
      return Theme.of(context).colorScheme.onInverseSurface;

    case lightInversePrimaryKey:
    case darkInversePrimaryKey:
      return Theme.of(context).colorScheme.inversePrimary;

    case lightScrimKey:
    case darkScrimKey:
      return Theme.of(context).colorScheme.scrim;

    case lightShadowKey:
    case darkShadowKey:
      return Theme.of(context).colorScheme.shadow;

    case lightSurfaceTintKey:
    case darkSurfaceTintKey:
      return Theme.of(context).colorScheme.surfaceTint;

    default:
      return Colors.transparent;
  }
}
