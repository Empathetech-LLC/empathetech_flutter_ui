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

  final double padding = EzConfig.get(paddingKey);

  late ThemeMode? currMode = PlatformTheme.of(context)?.themeMode;

  @override
  Widget build(BuildContext context) {
    // Define the build //

    final String label = EFUILang.of(context)!.ssThemeMode;

    final List<DropdownMenuItem<ThemeMode>> items =
        <DropdownMenuItem<ThemeMode>>[
      DropdownMenuItem<ThemeMode>(
        value: ThemeMode.system,
        child: Text(EFUILang.of(context)!.gSystem),
      ),
      DropdownMenuItem<ThemeMode>(
        value: ThemeMode.light,
        child: Text(EFUILang.of(context)!.gLight),
      ),
      DropdownMenuItem<ThemeMode>(
        value: ThemeMode.dark,
        child: Text(EFUILang.of(context)!.gDark),
      ),
    ];

    // Return the build //

    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
      ),
      child: EzRow(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Label
          Text(
            label,
            style: Theme.of(context).dropdownMenuTheme.textStyle,
            textAlign: TextAlign.center,
            semanticsLabel: EFUILang.of(context)!.gSettingX(label),
          ),
          EzSpacer.row(padding),

          // Button
          DropdownButton<ThemeMode>(
            value: currMode,
            items: items,
            onChanged: (ThemeMode? newThemeMode) {
              switch (newThemeMode) {
                case ThemeMode.system:
                  EzConfig.remove(isDarkThemeKey);
                  setState(() {
                    currMode = ThemeMode.system;
                    PlatformTheme.of(context)!.themeMode = ThemeMode.system;
                  });
                  break;

                case ThemeMode.light:
                  EzConfig.setBool(isDarkThemeKey, false);
                  setState(() {
                    currMode = ThemeMode.light;
                    PlatformTheme.of(context)!.themeMode = ThemeMode.light;
                  });
                  break;

                case ThemeMode.dark:
                  EzConfig.setBool(isDarkThemeKey, true);
                  setState(() {
                    currMode = ThemeMode.dark;
                    PlatformTheme.of(context)!.themeMode = ThemeMode.dark;
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
