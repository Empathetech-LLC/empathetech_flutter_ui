/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Custom [ColorScheme.highContrastDark]
const ColorScheme ezHighContrastDark = ColorScheme(
  brightness: Brightness.dark,
  // Primary
  primary: Color(0xFF00FFB4),
  onPrimary: Colors.black,
  primaryContainer: Colors.white,
  onPrimaryContainer: Colors.black,

  // Secondary
  secondary: Color(0xFFFFB400),
  onSecondary: Colors.black,
  secondaryContainer: Colors.white,
  onSecondaryContainer: Colors.black,

  // Tertiary
  tertiary: Color(0xFFB400FF),
  onTertiary: Colors.white,
  tertiaryContainer: Colors.white,
  onTertiaryContainer: Colors.black,

  // Error
  error: Color(0xFFB400FF),
  onError: Colors.white,
  errorContainer: Colors.white,
  onErrorContainer: Colors.black,

  // Surface
  surface: Colors.black,
  onSurface: Colors.white,
  surfaceContainer: Colors.black,
  surfaceDim: Colors.black,

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
  primary: Color(0xFFB400FF),
  onPrimary: Colors.white,
  primaryContainer: Colors.black,
  onPrimaryContainer: Colors.white,

  // Secondary
  secondary: Color(0xFFFFB400),
  onSecondary: Colors.black,
  secondaryContainer: Colors.black,
  onSecondaryContainer: Colors.white,

  // Tertiary
  tertiary: Color(0xFF00FFB4),
  onTertiary: Colors.black,
  tertiaryContainer: Colors.black,
  onTertiaryContainer: Colors.white,

  // Error
  error: Color(0xFF00FFB4),
  onError: Colors.black,
  errorContainer: Colors.black,
  onErrorContainer: Colors.white,

  // Surface
  surface: Colors.white,
  onSurface: Colors.black,
  surfaceContainer: Colors.white,
  surfaceDim: Colors.white,

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
                backgroundColor: darkSurface,
                foregroundColor: Colors.white,
                shadowColor: Colors.transparent,
                iconColor: Colors.white,
                overlayColor: Colors.white,
                side: EzConfig.borderSide(darkOutline),
                textStyle:
                    EzConfig.styles.bodyLarge?.copyWith(color: Colors.white),
              )
            : ElevatedButton.styleFrom(
                backgroundColor: lightSurface,
                foregroundColor: Colors.black,
                shadowColor: Colors.transparent,
                iconColor: Colors.black,
                overlayColor: Colors.black,
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
