/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzThemeModeSwitch extends StatefulWidget {
  /// Standardized tool for changing the [ThemeMode]
  const EzThemeModeSwitch({super.key});

  @override
  State<EzThemeModeSwitch> createState() => _ThemeModeSwitchState();
}

class _ThemeModeSwitchState extends State<EzThemeModeSwitch> {
  // Gather the theme data //
  late final ThemeData theme = Theme.of(context);
  late ThemeMode? platformTheme = PlatformTheme.of(context)!.themeMode;

  final double padding = EzConfig.get(paddingKey);

  late final EFUILang l10n = EFUILang.of(context)!;

  @override
  Widget build(BuildContext context) {
    // Define the build //

    final String label = l10n.ssThemeMode;

    final List<DropdownMenuEntry<ThemeMode>> entries =
        <DropdownMenuEntry<ThemeMode>>[
      DropdownMenuEntry<ThemeMode>(
        value: ThemeMode.system,
        label: l10n.gSystem,
      ),
      DropdownMenuEntry<ThemeMode>(
        value: ThemeMode.light,
        label: l10n.gLight,
      ),
      DropdownMenuEntry<ThemeMode>(
        value: ThemeMode.dark,
        label: l10n.gDark,
      ),
    ];

    // Return the build //

    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
      ),
      child: EzRow(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Label
          Text(
            label,
            style: theme.dropdownMenuTheme.textStyle,
            textAlign: TextAlign.center,
            semanticsLabel: l10n.gSettingX(label),
          ),
          EzSpacer.row(padding),

          // Button
          DropdownMenu<ThemeMode>(
            initialSelection: platformTheme,
            dropdownMenuEntries: entries,
            onSelected: (ThemeMode? newThemeMode) {
              switch (newThemeMode) {
                case ThemeMode.system:
                  EzConfig.remove(isDarkThemeKey);
                  setState(() {
                    platformTheme = ThemeMode.system;
                  });
                  break;

                case ThemeMode.light:
                  EzConfig.setBool(isDarkThemeKey, false);
                  setState(() {
                    platformTheme = ThemeMode.light;
                  });
                  break;

                case ThemeMode.dark:
                  EzConfig.setBool(isDarkThemeKey, true);
                  setState(() {
                    platformTheme = ThemeMode.dark;
                  });
                  break;

                default:
                  break;
              }
            },
          ),
        ],
      ),
    );
  }
}
