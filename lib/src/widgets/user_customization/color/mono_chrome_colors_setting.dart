/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
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
  /// [EzConfig.rebuildUI] passthrough
  final void Function() onComplete;

  /// When false (default), updates the current [EzConfig.themeMode]
  final bool both;

  /// [ThemeData.colorScheme] for [Brightness.dark]
  final ColorScheme dark;

  /// [ThemeData.colorScheme] for [Brightness.light]
  final ColorScheme light;

  /// Easily store a custom mono chrome [ColorScheme] to [EzConfig]
  /// [ezHighContrastDark] and [ezHighContrastLight] by default
  const EzMonoChromeColorsSetting(
    this.onComplete, {
    super.key,
    this.both = false,
    this.dark = ezHighContrastDark,
    this.light = ezHighContrastLight,
  });

  @override
  Widget build(BuildContext context) => EzElevatedIconButton(
        style: EzConfig.isDark
            ? ElevatedButton.styleFrom(
                backgroundColor: darkSurface,
                foregroundColor: Colors.white,
                shadowColor: Colors.transparent,
                iconColor: Colors.white,
                overlayColor: Colors.white,
                side: const BorderSide(color: darkOutline),
                textStyle:
                    EzConfig.styles.bodyLarge?.copyWith(color: Colors.white),
              )
            : ElevatedButton.styleFrom(
                backgroundColor: lightSurface,
                foregroundColor: Colors.black,
                shadowColor: Colors.transparent,
                iconColor: Colors.black,
                overlayColor: Colors.black,
                side: const BorderSide(color: lightOutline),
                textStyle:
                    EzConfig.styles.bodyLarge?.copyWith(color: Colors.black),
              ),
        onPressed: () async {
          if (both) {
            await loadColorScheme(dark, Brightness.dark);
            await loadColorScheme(light, Brightness.light);
          } else {
            EzConfig.isDark
                ? await loadColorScheme(dark, Brightness.dark)
                : await loadColorScheme(light, Brightness.light);
          }
          await EzConfig.rebuildUI(onComplete);
        },
        icon: Icon(
          Icons.contrast,
          color: EzConfig.colors.onSurface,
        ),
        label: EzConfig.l10n.csMonoChrome,
      );
}
