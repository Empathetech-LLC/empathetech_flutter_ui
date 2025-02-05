/* empathetech_flutter_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzHighContrastColorsSetting extends StatelessWidget {
  /// [ThemeData.colorScheme] for [Brightness.dark]
  final ColorScheme dark;

  /// [ThemeData.colorScheme] for [Brightness.light]
  final ColorScheme light;

  /// Easily store Flutter's built in high contrast [ColorScheme]s to [EzConfig]
  /// [ColorScheme]s can be overridden
  const EzHighContrastColorsSetting({
    super.key,
    this.dark = const ColorScheme.highContrastDark(),
    this.light = const ColorScheme.highContrastLight(),
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = isDarkTheme(context);

    return EzElevatedIconButton(
      onPressed: isDark
          ? () async {
              await storeColorScheme(
                colorScheme: dark,
                brightness: Brightness.dark,
              );
            }
          : () async {
              await storeColorScheme(
                colorScheme: light,
                brightness: Brightness.light,
              );
            },
      icon: EzIcon(
        Icons.contrast,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      label: EFUILang.of(context)!.csHighContrast,
    );
  }
}
