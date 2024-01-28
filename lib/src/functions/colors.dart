/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Returns the guesstimated most readable text color (black/white) for [background]
/// Formula credit: https://stackoverflow.com/questions/3942878/how-to-decide-font-color-in-white-or-black-depending-on-background-color
Color getTextColor(Color background) {
  return Color(
      (((background.red * 0.299) + (background.green * 0.587) + (background.blue * 0.114)) >= 150)
          ? blackHex
          : whiteHex);
}

/// Generate a [ColorScheme] based on values present in [EzConfig.prefs]
ColorScheme ezColorScheme(Brightness brightness) {
  Color? getColor(String key) {
    final int? value = EzConfig.get(key);

    return (value == null) ? null : Color(value);
  }

  final String prefix = (brightness == Brightness.light) ? light : dark;

  return ColorScheme.fromSeed(
    seedColor: getColor('$prefix$primaryKey')!,
    brightness: brightness,
    primary: getColor('$prefix$primaryKey'),
    onPrimary: getColor('$prefix$onPrimaryKey'),
    primaryContainer: getColor('$prefix$primaryContainerKey'),
    onPrimaryContainer: getColor('$prefix$onPrimaryContainerKey'),
    secondary: getColor('$prefix$secondaryKey'),
    onSecondary: getColor('$prefix$onSecondaryKey'),
    secondaryContainer: getColor('$prefix$secondaryContainerKey'),
    onSecondaryContainer: getColor('$prefix$onSecondaryContainerKey'),
    tertiary: getColor('$prefix$tertiaryKey'),
    onTertiary: getColor('$prefix$onTertiaryKey'),
    tertiaryContainer: getColor('$prefix$tertiaryContainerKey'),
    onTertiaryContainer: getColor('$prefix$onTertiaryContainerKey'),
    error: getColor('$prefix$errorKey'),
    onError: getColor('$prefix$onErrorKey'),
    errorContainer: getColor('$prefix$errorContainerKey'),
    onErrorContainer: getColor('$prefix$onErrorContainerKey'),
    outline: getColor('$prefix$outlineKey'),
    outlineVariant: getColor('$prefix$outlineVariantKey'),
    background: getColor('$prefix$backgroundKey'),
    onBackground: getColor('$prefix$onBackgroundKey'),
    surface: getColor('$prefix$surfaceKey'),
    onSurface: getColor('$prefix$onSurfaceKey'),
    surfaceVariant: getColor('$prefix$surfaceVariantKey'),
    onSurfaceVariant: getColor('$prefix$onSurfaceVariantKey'),
    inverseSurface: getColor('$prefix$inverseSurfaceKey'),
    onInverseSurface: getColor('$prefix$onInverseSurfaceKey'),
    inversePrimary: getColor('$prefix$inversePrimaryKey'),
    shadow: getColor('$prefix$shadowKey'),
    scrim: getColor('$prefix$scrimKey'),
    surfaceTint: getColor('$prefix$surfaceTintKey'),
  );
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

  final String prefix = (brightness == Brightness.light) ? light : dark;

  EzConfig.setInt('$prefix$primaryKey', colorScheme.primary.value);
  EzConfig.setInt('$prefix$onPrimaryKey', colorScheme.onPrimary.value);
  EzConfig.setInt('$prefix$primaryContainerKey', colorScheme.primaryContainer.value);
  EzConfig.setInt('$prefix$onPrimaryContainerKey', colorScheme.onPrimaryContainer.value);
  EzConfig.setInt('$prefix$secondaryKey', colorScheme.secondary.value);
  EzConfig.setInt('$prefix$onSecondaryKey', colorScheme.onSecondary.value);
  EzConfig.setInt('$prefix$secondaryContainerKey', colorScheme.secondaryContainer.value);
  EzConfig.setInt('$prefix$onSecondaryContainerKey', colorScheme.onSecondaryContainer.value);
  EzConfig.setInt('$prefix$tertiaryKey', colorScheme.tertiary.value);
  EzConfig.setInt('$prefix$onTertiaryKey', colorScheme.onTertiary.value);
  EzConfig.setInt('$prefix$tertiaryContainerKey', colorScheme.tertiaryContainer.value);
  EzConfig.setInt('$prefix$onTertiaryContainerKey', colorScheme.onTertiaryContainer.value);
  EzConfig.setInt('$prefix$errorKey', colorScheme.error.value);
  EzConfig.setInt('$prefix$onErrorKey', colorScheme.onError.value);
  EzConfig.setInt('$prefix$errorContainerKey', colorScheme.errorContainer.value);
  EzConfig.setInt('$prefix$onErrorContainerKey', colorScheme.onErrorContainer.value);
  EzConfig.setInt('$prefix$outlineKey', colorScheme.outline.value);
  EzConfig.setInt('$prefix$outlineVariantKey', colorScheme.outlineVariant.value);
  EzConfig.setInt('$prefix$backgroundKey', colorScheme.background.value);
  EzConfig.setInt('$prefix$onBackgroundKey', colorScheme.onBackground.value);
  EzConfig.setInt('$prefix$surfaceKey', colorScheme.surface.value);
  EzConfig.setInt('$prefix$onSurfaceKey', colorScheme.onSurface.value);
  EzConfig.setInt('$prefix$surfaceVariantKey', colorScheme.surfaceVariant.value);
  EzConfig.setInt('$prefix$onSurfaceVariantKey', colorScheme.onSurfaceVariant.value);
  EzConfig.setInt('$prefix$inverseSurfaceKey', colorScheme.inverseSurface.value);
  EzConfig.setInt('$prefix$onInverseSurfaceKey', colorScheme.onInverseSurface.value);
  EzConfig.setInt('$prefix$inversePrimaryKey', colorScheme.inversePrimary.value);
  EzConfig.setInt('$prefix$shadowKey', colorScheme.shadow.value);
  EzConfig.setInt('$prefix$scrimKey', colorScheme.scrim.value);
  EzConfig.setInt('$prefix$surfaceTintKey', colorScheme.surfaceTint.value);
}

/// Get the human readable name of a [key]s color
String getColorName(BuildContext context, String key) {
  switch (key) {
    case primaryKey:
      return EFUILang.of(context)!.csPrimary;
    case onPrimaryKey:
      return EFUILang.of(context)!.csOnPrimary;
    case primaryContainerKey:
      return EFUILang.of(context)!.csPrimaryContainer;
    case onPrimaryContainerKey:
      return EFUILang.of(context)!.csOnPrimaryContainer;
    case secondaryKey:
      return EFUILang.of(context)!.csSecondary;
    case onSecondaryKey:
      return EFUILang.of(context)!.csOnSecondary;
    case secondaryContainerKey:
      return EFUILang.of(context)!.csSecondaryContainer;
    case onSecondaryContainerKey:
      return EFUILang.of(context)!.csOnSecondaryContainer;
    case tertiaryKey:
      return EFUILang.of(context)!.csTertiary;
    case onTertiaryKey:
      return EFUILang.of(context)!.csOnTertiary;
    case tertiaryContainerKey:
      return EFUILang.of(context)!.csTertiaryContainer;
    case onTertiaryContainerKey:
      return EFUILang.of(context)!.csOnTertiaryContainer;
    case errorKey:
      return EFUILang.of(context)!.csError;
    case onErrorKey:
      return EFUILang.of(context)!.csOnError;
    case errorContainerKey:
      return EFUILang.of(context)!.csErrorContainer;
    case onErrorContainerKey:
      return EFUILang.of(context)!.csOnErrorContainer;
    case outlineKey:
      return EFUILang.of(context)!.csOutline;
    case outlineVariantKey:
      return EFUILang.of(context)!.csOutlineVariant;
    case backgroundKey:
      return EFUILang.of(context)!.csBackground;
    case onBackgroundKey:
      return EFUILang.of(context)!.csOnBackground;
    case surfaceKey:
      return EFUILang.of(context)!.csSurface;
    case onSurfaceKey:
      return EFUILang.of(context)!.csOnSurface;
    case surfaceVariantKey:
      return EFUILang.of(context)!.csSurfaceVariant;
    case onSurfaceVariantKey:
      return EFUILang.of(context)!.csOnSurfaceVariant;
    case inverseSurfaceKey:
      return EFUILang.of(context)!.csInverseSurface;
    case onInverseSurfaceKey:
      return EFUILang.of(context)!.csOnInverseSurface;
    case inversePrimaryKey:
      return EFUILang.of(context)!.csInversePrimary;
    case scrimKey:
      return EFUILang.of(context)!.csScrim;
    case shadowKey:
      return EFUILang.of(context)!.csShadow;
    case surfaceTintKey:
      return EFUILang.of(context)!.csSurfaceTint;
    default:
      return 'null';
  }
}

/// Resolve the color [key] to the live [ColorScheme] value
Color getLiveColor(BuildContext context, String key) {
  switch (key) {
    case primaryKey:
      return Theme.of(context).colorScheme.primary;
    case onPrimaryKey:
      return Theme.of(context).colorScheme.onPrimary;
    case primaryContainerKey:
      return Theme.of(context).colorScheme.onPrimaryContainer;
    case onPrimaryContainerKey:
      return Theme.of(context).colorScheme.onPrimaryContainer;
    case secondaryKey:
      return Theme.of(context).colorScheme.secondary;
    case onSecondaryKey:
      return Theme.of(context).colorScheme.onSecondary;
    case secondaryContainerKey:
      return Theme.of(context).colorScheme.secondaryContainer;
    case onSecondaryContainerKey:
      return Theme.of(context).colorScheme.onSecondaryContainer;
    case tertiaryKey:
      return Theme.of(context).colorScheme.tertiary;
    case onTertiaryKey:
      return Theme.of(context).colorScheme.onTertiary;
    case tertiaryContainerKey:
      return Theme.of(context).colorScheme.tertiaryContainer;
    case onTertiaryContainerKey:
      return Theme.of(context).colorScheme.onTertiaryContainer;
    case errorKey:
      return Theme.of(context).colorScheme.error;
    case onErrorKey:
      return Theme.of(context).colorScheme.onError;
    case errorContainerKey:
      return Theme.of(context).colorScheme.errorContainer;
    case onErrorContainerKey:
      return Theme.of(context).colorScheme.onErrorContainer;
    case outlineKey:
      return Theme.of(context).colorScheme.outline;
    case outlineVariantKey:
      return Theme.of(context).colorScheme.outlineVariant;
    case backgroundKey:
      return Theme.of(context).colorScheme.background;
    case onBackgroundKey:
      return Theme.of(context).colorScheme.background;
    case surfaceKey:
      return Theme.of(context).colorScheme.surface;
    case onSurfaceKey:
      return Theme.of(context).colorScheme.onSurface;
    case surfaceVariantKey:
      return Theme.of(context).colorScheme.surfaceVariant;
    case onSurfaceVariantKey:
      return Theme.of(context).colorScheme.onSurfaceVariant;
    case inverseSurfaceKey:
      return Theme.of(context).colorScheme.inverseSurface;
    case onInverseSurfaceKey:
      return Theme.of(context).colorScheme.onInverseSurface;
    case inversePrimaryKey:
      return Theme.of(context).colorScheme.inversePrimary;
    case scrimKey:
      return Theme.of(context).colorScheme.scrim;
    case shadowKey:
      return Theme.of(context).colorScheme.shadow;
    case surfaceTintKey:
      return Theme.of(context).colorScheme.surfaceTint;
    default:
      return Colors.transparent;
  }
}
