/* empathetech_flutter_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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
  final ColorScheme dark;
  final ColorScheme light;

  /// Easily store Flutter's built in high contrast color scheme(s) to EzConfig
  /// Uses flutter_platform_widgets, specifically [PlatformTheme]
  const EzMonoChromeColorsSetting({
    super.key,
    this.dark = ezHighContrastDark,
    this.light = ezHighContrastLight,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = isDarkTheme(context);
    final EFUILang l10n = EFUILang.of(context)!;

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
      label: EFUILang.of(context)!.csMonoChrome,
    );
  }
}
