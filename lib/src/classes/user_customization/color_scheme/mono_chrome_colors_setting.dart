/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzMonoChromeColorsSetting extends StatelessWidget {
  final ColorScheme dark;
  final ColorScheme light;

  /// Easily store Flutter's built in high contrast color scheme(s) to EzConfig
  /// Uses flutter_platform_widgets, specifically [PlatformTheme]
  const EzMonoChromeColorsSetting({
    super.key,
    this.dark = const ColorScheme.highContrastDark(
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

      // Error
      error: Colors.black,
      onError: Colors.red,
      errorContainer: Colors.white,
      onErrorContainer: Colors.red,

      // Surface
      surface: Colors.black,
      onSurface: Colors.white,
      surfaceDim: Colors.black,
      surfaceBright: Colors.black,
      surfaceContainerLowest: Colors.black,
      surfaceContainerLow: Colors.black,
      surfaceContainer: Colors.black,
      surfaceContainerHigh: Colors.black,
      surfaceContainerHighest: Colors.black,
      onSurfaceVariant: Colors.white,
      inverseSurface: empathOffBlack,
      onInverseSurface: Colors.white,
      inversePrimary: Colors.black,
      surfaceTint: Colors.transparent,
    ),
    this.light = const ColorScheme.highContrastLight(
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

      // Error
      error: Colors.white,
      onError: Colors.red,
      errorContainer: Colors.black,
      onErrorContainer: Colors.red,

      // Surface
      surface: Colors.white,
      onSurface: Colors.black,
      surfaceDim: Colors.white,
      surfaceBright: Colors.white,
      surfaceContainerLowest: Colors.white,
      surfaceContainerLow: Colors.white,
      surfaceContainer: Colors.white,
      surfaceContainerHigh: Colors.white,
      surfaceContainerHighest: Colors.white,
      onSurfaceVariant: Colors.black,
      inverseSurface: Colors.white,
      onInverseSurface: Colors.black,
      inversePrimary: Colors.white,
      surfaceTint: Colors.transparent,
    ),
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = PlatformTheme.of(context)!.isDark;
    final Color onSurface = Theme.of(context).colorScheme.onSurface;

    return ElevatedButton.icon(
      onPressed: isDark
          ? () {
              storeColorScheme(
                colorScheme: dark,
                brightness: Brightness.dark,
              );
            }
          : () {
              storeColorScheme(
                colorScheme: light,
                brightness: Brightness.light,
              );
            },
      icon: Icon(Icons.contrast, color: onSurface),
      label: Text(
        EFUILang.of(context)!.csMonoChrome,
        style: TextStyle(color: onSurface),
      ),
    );
  }
}
