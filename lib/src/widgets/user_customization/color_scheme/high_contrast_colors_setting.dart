/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzHighContrastColorsSetting extends StatelessWidget {
  final ColorScheme dark;
  final ColorScheme light;

  /// Easily store Flutter's built in high contrast color scheme(s) to EzConfig
  /// Uses flutter_platform_widgets, specifically [PlatformTheme]
  const EzHighContrastColorsSetting({
    super.key,
    this.dark = const ColorScheme.highContrastDark(),
    this.light = const ColorScheme.highContrastLight(),
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
        EFUILang.of(context)!.csHighContrast,
        style: TextStyle(color: onSurface),
      ),
    );
  }
}
