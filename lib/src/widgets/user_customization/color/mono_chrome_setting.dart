/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Custom [ColorScheme.highContrastDark]
const ColorScheme ezMonoChromeDark = ColorScheme.highContrastDark(
  // Primary
  primary: Colors.white,
  onPrimary: Colors.black,
  primaryContainer: darkOutline,
  onPrimaryContainer: Colors.black,

  // Secondary
  secondary: Colors.white,
  onSecondary: Colors.black,
  secondaryContainer: darkOutline,
  onSecondaryContainer: Colors.black,

  // Tertiary
  tertiary: Colors.white,
  onTertiary: Colors.black,
  tertiaryContainer: darkOutline,
  onTertiaryContainer: Colors.black,

  // Error
  error: Colors.red,
  onError: Colors.white,
  errorContainer: Colors.redAccent,
  onErrorContainer: Colors.white,

  // Surface
  surfaceContainer: darkSurfaceContainer,
  surfaceDim: darkSurfaceDim,
  surface: darkSurface,
  onSurface: Colors.white,

  // Misc
  outline: darkOutline,
  outlineVariant: darkOutlineVariant,
  scrim: Colors.black,
  shadow: Colors.transparent,
  surfaceTint: Colors.transparent,
);

/// Custom [ColorScheme.highContrastLight]
const ColorScheme ezMonoChromeLight = ColorScheme.highContrastLight(
  // Primary
  primary: Colors.black,
  onPrimary: Colors.white,
  primaryContainer: lightOutline,
  onPrimaryContainer: Colors.white,

  // Secondary
  secondary: Colors.black,
  onSecondary: Colors.white,
  secondaryContainer: lightOutline,
  onSecondaryContainer: Colors.white,

  // Tertiary
  tertiary: Colors.black,
  onTertiary: Colors.white,
  tertiaryContainer: lightOutline,
  onTertiaryContainer: Colors.white,

  // Error
  error: Colors.red,
  onError: Colors.white,
  errorContainer: Colors.redAccent,
  onErrorContainer: Colors.white,

  // Surface
  surfaceContainer: lightSurfaceContainer,
  surfaceDim: lightSurfaceDim,
  surface: lightSurface,
  onSurface: Colors.black,

  // Misc
  outline: lightOutline,
  outlineVariant: lightOutlineVariant,
  scrim: Colors.white,
  shadow: Colors.transparent,
  surfaceTint: Colors.transparent,
);

class EzMonoChromeColorsSetting extends StatelessWidget {
  /// [EzConfig.rebuildUI] passthrough
  final void Function() onComplete;

  /// [ThemeData.colorScheme] for [Brightness.dark]
  final ColorScheme dark;

  /// [ThemeData.colorScheme] for [Brightness.light]
  final ColorScheme light;

  /// Easily store a custom mono chrome [ColorScheme] to [EzConfig]
  /// [ezHighContrastDark] and [ezHighContrastLight] by default
  const EzMonoChromeColorsSetting(
    this.onComplete, {
    super.key,
    this.dark = ezMonoChromeDark,
    this.light = ezMonoChromeLight,
  });

  @override
  Widget build(BuildContext context) => EzElevatedIconButton(
        style: EzConfig.isDark
            ? ElevatedButton.styleFrom(
                backgroundColor: darkSurface,
                foregroundColor: Colors.white,
                iconColor: Colors.white,
                shadowColor: Colors.transparent,
                overlayColor: Colors.white,
                side: EzConfig.borderSide(
                    darkOutline.withValues(alpha: EzConfig.borderOpacity)),
                textStyle:
                    EzConfig.styles.bodyLarge?.copyWith(color: Colors.white),
              )
            : ElevatedButton.styleFrom(
                backgroundColor: lightSurface,
                foregroundColor: Colors.black,
                iconColor: Colors.black,
                shadowColor: Colors.transparent,
                overlayColor: Colors.black,
                side: EzConfig.borderSide(
                    lightOutline.withValues(alpha: EzConfig.borderOpacity)),
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
        icon: const Icon(Icons.contrast),
        label: EzConfig.l10n.csMonoChrome,
      );
}
