/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

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
    final EFUILang l10n = ezL10n(context);

    return EzElevatedIconButton(
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

        if (context.mounted) {
          ezSnackBar(
            context: context,
            message:
                kIsWeb ? l10n.ssRestartReminderWeb : l10n.ssRestartReminder,
          );
        }
      },
      icon: EzIcon(
        Icons.contrast,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      label: ezL10n(context).csMonoChrome,
    );
  }
}
