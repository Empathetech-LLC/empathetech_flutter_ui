/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzThemeModeSwitch extends StatefulWidget {
  /// [EzConfig.rebuildThemeMode] passthrough
  final void Function() onComplete;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? labelStyle;

  /// Defaults to [ColorScheme.surface]
  final Color? backgroundColor;

  /// Standardized tool for changing the [ThemeMode]
  const EzThemeModeSwitch(
    this.onComplete, {
    super.key,
    this.labelStyle,
    this.backgroundColor,
  });

  @override
  State<EzThemeModeSwitch> createState() => _ThemeModeSwitchState();
}

class _ThemeModeSwitchState extends State<EzThemeModeSwitch> {
  // Define the build data //

  final List<DropdownMenuEntry<ThemeMode>> entries =
      <DropdownMenuEntry<ThemeMode>>[
    DropdownMenuEntry<ThemeMode>(
        value: ThemeMode.system, label: EzConfig.l10n.gSystem),
    DropdownMenuEntry<ThemeMode>(
        value: ThemeMode.light, label: EzConfig.l10n.gLight),
    DropdownMenuEntry<ThemeMode>(
        value: ThemeMode.dark, label: EzConfig.l10n.gDark),
  ];

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return EzScrollView(
      scrollDirection: Axis.horizontal,
      reverseHands: true,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Label
        EzText(
          EzConfig.l10n.ssThemeMode,
          style: widget.labelStyle,
          textAlign: TextAlign.center,
        ),
        EzConfig.margin,

        // Button
        EzDropdownMenu<ThemeMode>(
          widthEntries: entries
              .map((DropdownMenuEntry<ThemeMode> entry) => entry.label)
              .toList(),
          dropdownMenuEntries: entries,
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
            await EzConfig.rebuildThemeMode(widget.onComplete);
          },
        ),
      ],
    );
  }
}
