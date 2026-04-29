/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzThemeModeSwitch extends StatelessWidget {
  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? labelStyle;

  /// Defaults to [ColorScheme.surface]
  final Color? backgroundColor;

  /// Standardized tool for changing the [ThemeMode]
  const EzThemeModeSwitch({
    super.key,
    this.labelStyle,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) => EzScrollView(
        scrollDirection: Axis.horizontal,
        reverseHands: true,
        children: <Widget>[
          // Label
          EzText(
            EzConfig.l10n.ssThemeMode,
            style: labelStyle,
            textAlign: TextAlign.center,
          ),
          EzConfig.margin,

          // Button
          EzDropdownMenu<ThemeMode>(
            widthEntry: EzConfig.l10n.gSystem,
            dropdownMenuEntries: <DropdownMenuEntry<ThemeMode>>[
              DropdownMenuEntry<ThemeMode>(value: ThemeMode.system, label: EzConfig.l10n.gSystem),
              DropdownMenuEntry<ThemeMode>(value: ThemeMode.light, label: EzConfig.l10n.gLight),
              DropdownMenuEntry<ThemeMode>(value: ThemeMode.dark, label: EzConfig.l10n.gDark),
            ],
            enableSearch: false,
            initialSelection: EzConfig.themeMode,
            onSelected: (ThemeMode? choice) async {
              if (choice == null || choice == EzConfig.themeMode) return;

              switch (choice) {
                case ThemeMode.dark:
                  await EzConfig.setBool(isDarkThemeKey, true);
                  break;
                case ThemeMode.light:
                  await EzConfig.setBool(isDarkThemeKey, false);
                  break;
                case ThemeMode.system:
                  await EzConfig.remove(isDarkThemeKey);
                  break;
              }
              await EzConfig.rebuildThemeMode();
            },
          ),
        ],
      );
}
