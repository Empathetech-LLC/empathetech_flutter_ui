/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Custom [ColorScheme.highContrastDark]
const ColorScheme ezHighContrastDark = ColorScheme.highContrastDark(
  // Primary
  primary: Colors.white,
  primaryContainer: darkOutline,
  onPrimary: Colors.black,
  onPrimaryContainer: Colors.black,

  // Secondary
  secondary: Colors.white,
  secondaryContainer: darkOutline,
  onSecondary: Colors.black,
  onSecondaryContainer: Colors.black,

  // Tertiary
  tertiary: Colors.white,
  tertiaryContainer: darkOutline,
  onTertiary: Colors.black,
  onTertiaryContainer: Colors.black,

  // Misc
  surface: darkSurface,
  onSurface: Colors.white,
  surfaceDim: darkSurfaceDim,
  surfaceContainer: darkSurfaceContainer,
  outline: darkOutline,
  outlineVariant: darkOutlineVariant,
  inversePrimary: Colors.white,
  shadow: Colors.transparent,
  surfaceTint: Colors.transparent,
);

/// Custom [ColorScheme.highContrastLight]
const ColorScheme ezHighContrastLight = ColorScheme.highContrastLight(
  // Primary
  primary: Colors.black,
  primaryContainer: lightOutline,
  onPrimary: Colors.white,
  onPrimaryContainer: Colors.white,

  // Secondary
  secondary: Colors.black,
  secondaryContainer: lightOutline,
  onSecondary: Colors.white,
  onSecondaryContainer: Colors.white,

  // Tertiary
  tertiary: Colors.black,
  tertiaryContainer: lightOutline,
  onTertiary: Colors.white,
  onTertiaryContainer: Colors.white,

  // Surface
  surface: lightSurface,
  onSurface: Colors.black,
  surfaceDim: lightSurfaceDim,
  surfaceContainer: lightSurfaceContainer,
  outline: lightOutline,
  outlineVariant: lightOutlineVariant,
  inversePrimary: Colors.black,
  shadow: Colors.transparent,
  surfaceTint: Colors.transparent,
);

class EzMonoChromeColorsSetting extends StatelessWidget {
  /// [ThemeData.colorScheme] for [Brightness.dark]
  final ColorScheme dark;

  /// [ThemeData.colorScheme] for [Brightness.light]
  final ColorScheme light;

  /// Easily store a custom mono chrome [ColorScheme] to [EzConfig]
  /// [ezHighContrastDark] and [ezHighContrastLight] by default
  const EzMonoChromeColorsSetting({
    super.key,
    this.dark = ezHighContrastDark,
    this.light = ezHighContrastLight,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = isDarkTheme(context);

    return EzElevatedIconButton(
      style: isDark
          ? ElevatedButton.styleFrom(
              backgroundColor: darkSurface,
              foregroundColor: Colors.white,
              shadowColor: Colors.transparent,
              iconColor: Colors.white,
              overlayColor: Colors.white,
              side: const BorderSide(color: darkOutline),
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.white),
            )
          : ElevatedButton.styleFrom(
              backgroundColor: lightSurface,
              foregroundColor: Colors.black,
              shadowColor: Colors.transparent,
              iconColor: Colors.black,
              overlayColor: Colors.black,
              side: const BorderSide(color: lightOutline),
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.black),
            ),
      onPressed: () async {
        isDark
            ? await storeColorScheme(
                colorScheme: dark,
                brightness: Brightness.dark,
              )
            : await storeColorScheme(
                colorScheme: light,
                brightness: Brightness.light,
              );
        EzConfig.provider.rebuild();
      },
      icon: EzIcon(
        Icons.contrast,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      label: EzConfig.l10n.csMonoChrome,
    );
  }
}
