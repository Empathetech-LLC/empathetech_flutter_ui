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
  onPrimary: Colors.black,
  onPrimaryContainer: Colors.black,
  onPrimaryFixed: Colors.black,
  onPrimaryFixedVariant: Colors.black,

  // Secondary
  secondary: Colors.white,
  onSecondary: Colors.black,
  onSecondaryContainer: Colors.black,
  onSecondaryFixed: Colors.black,
  onSecondaryFixedVariant: Colors.black,

  // Tertiary
  tertiary: Colors.white,
  onTertiary: Colors.black,
  onTertiaryContainer: Colors.black,
  onTertiaryFixed: Colors.black,
  onTertiaryFixedVariant: Colors.black,

  // Surface
  surface: Colors.black,
  onSurface: Colors.white,
  surfaceContainer: empathOffBlack,
  inversePrimary: Colors.white,
  surfaceTint: Colors.transparent,
);

/// Custom [ColorScheme.highContrastLight]
const ColorScheme ezHighContrastLight = ColorScheme.highContrastLight(
  // Primary
  primary: Colors.black,
  onPrimary: Colors.white,
  onPrimaryContainer: Colors.white,
  onPrimaryFixed: Colors.white,
  onPrimaryFixedVariant: Colors.white,

  // Secondary
  secondary: Colors.black,
  onSecondary: Colors.white,
  onSecondaryContainer: Colors.white,
  onSecondaryFixed: Colors.white,
  onSecondaryFixedVariant: Colors.white,

  // Tertiary
  tertiary: Colors.black,
  onTertiary: Colors.white,
  onTertiaryContainer: Colors.white,
  onTertiaryFixed: Colors.white,
  onTertiaryFixedVariant: Colors.white,

  // Surface
  surface: Colors.white,
  onSurface: Colors.black,
  surfaceContainer: empathOffWhite,
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
            message: (kIsWeb ? l10n.ssSettingsGuideWeb : l10n.ssSettingsGuide)
                .split('\n')[0],
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
