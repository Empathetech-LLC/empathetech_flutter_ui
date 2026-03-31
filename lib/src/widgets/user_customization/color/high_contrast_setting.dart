/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// High contrast Empath green ==
/// 0xFF00FFB4
const int hceGreenHex = 0xFF00FFB4;

/// High contrast Empath green ==
/// 0xFF00FFB4
const Color hceGreen = Color(hceGreenHex);

/// High contrast Empath gold ==
/// 0xFFFFB400
const int hceGoldHex = 0xFFFFB400;

/// High contrast Empath gold ==
/// 0xFFFFB400
const Color hceGold = Color(0xFFFFB400);

/// High contrast Empath purple ==
/// 0xFFB400FF
const int hcePurpleHex = 0xFFB400FF;

/// High contrast Empath purple ==
/// 0xFFB400FF
const Color hcePurple = Color(0xFFB400FF);

/// 0xFFFF6700
const int safetyOrangeHex = 0xFFFF6700;

/// 0xFFFF6700
const Color safetyOrange = Color(safetyOrangeHex);

/// Custom [ColorScheme.highContrastDark]
const ColorScheme ezHighContrastDark = ColorScheme(
  brightness: Brightness.dark,
  // Primary
  primary: hceGreen,
  onPrimary: Colors.black,
  primaryContainer: darkOutline,
  onPrimaryContainer: Colors.black,

  // Secondary
  secondary: hceGold,
  onSecondary: Colors.black,
  secondaryContainer: darkOutline,
  onSecondaryContainer: Colors.black,

  // Tertiary
  tertiary: hcePurple,
  onTertiary: Colors.white,
  tertiaryContainer: darkOutline,
  onTertiaryContainer: Colors.black,

  // Error
  error: safetyOrange,
  onError: Colors.white,
  errorContainer: darkOutline,
  onErrorContainer: Colors.black,

  // Surface
  surfaceContainer: Colors.black,
  surfaceDim: darkSurfaceContainer,
  surface: darkSurfaceDim,
  onSurface: Colors.white,

  // Misc
  outline: darkOutline,
  outlineVariant: darkOutline,
  scrim: Colors.black,
  shadow: Colors.transparent,
  surfaceTint: Colors.transparent,
);

/// Custom [ColorScheme.highContrastLight]
const ColorScheme ezHighContrastLight = ColorScheme(
  brightness: Brightness.light,
  // Primary
  primary: hcePurple,
  onPrimary: Colors.white,
  primaryContainer: lightOutline,
  onPrimaryContainer: Colors.white,

  // Secondary
  secondary: hceGold,
  onSecondary: Colors.black,
  secondaryContainer: lightOutline,
  onSecondaryContainer: Colors.white,

  // Tertiary
  tertiary: hceGreen,
  onTertiary: Colors.black,
  tertiaryContainer: lightOutline,
  onTertiaryContainer: Colors.white,

  // Error
  error: safetyOrange,
  onError: Colors.white,
  errorContainer: lightOutline,
  onErrorContainer: Colors.white,

  // Surface
  surfaceContainer: lightSurfaceContainer,
  surfaceDim: lightSurfaceDim,
  surface: Colors.white,
  onSurface: Colors.black,

  // Misc
  outline: lightOutline,
  outlineVariant: lightOutline,
  scrim: Colors.white,
  shadow: Colors.transparent,
  surfaceTint: Colors.transparent,
);

class EzHighContrastColorsSetting extends StatelessWidget {
  /// [EzConfig.rebuildUI] passthrough
  final void Function() onComplete;

  /// [ThemeData.colorScheme] for [Brightness.dark]
  final ColorScheme dark;

  /// [ThemeData.colorScheme] for [Brightness.light]
  final ColorScheme light;

  /// Easily store a custom mono chrome [ColorScheme] to [EzConfig]
  /// [ezHighContrastDark] and [ezHighContrastLight] by default
  const EzHighContrastColorsSetting(
    this.onComplete, {
    super.key,
    this.dark = ezHighContrastDark,
    this.light = ezHighContrastLight,
  });

  @override
  Widget build(BuildContext context) => EzElevatedIconButton(
        style: EzConfig.isDark
            ? ElevatedButton.styleFrom(
                backgroundColor: darkSurfaceDim,
                foregroundColor: Colors.white,
                shadowColor: Colors.transparent,
                overlayColor: hceGreen,
                side: EzConfig.borderSide(darkOutline),
                textStyle:
                    EzConfig.styles.bodyLarge?.copyWith(color: Colors.white),
              )
            : ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shadowColor: Colors.transparent,
                overlayColor: hcePurple,
                side: EzConfig.borderSide(lightOutline),
                textStyle:
                    EzConfig.styles.bodyLarge?.copyWith(color: Colors.black),
              ),
        onPressed: () async {
          if (EzConfig.updateBoth || EzConfig.isDark) {
            await loadColorScheme(dark, Brightness.dark);
          }
          if ((EzConfig.updateBoth || !EzConfig.isDark)) {
            await loadColorScheme(light, Brightness.light);
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
