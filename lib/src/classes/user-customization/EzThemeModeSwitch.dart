/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzThemeModeSwitch extends StatefulWidget {
  /// Standardized tool for changing the [ThemeMode]
  const EzThemeModeSwitch({Key? key}) : super(key: key);

  @override
  _ThemeModeSwitchState createState() => _ThemeModeSwitchState();
}

class _ThemeModeSwitchState extends State<EzThemeModeSwitch> {
  // Gather the theme data //
  final double padding = EzConfig.get(paddingKey);

  late ThemeMode? currMode = PlatformTheme.of(context)?.themeMode;

  // Define functions //
  String _getName(ThemeMode? curr) {
    switch (curr) {
      case ThemeMode.light:
        return EFUILang.of(context)!.gLight;
      case ThemeMode.dark:
        return EFUILang.of(context)!.gDark;
      case ThemeMode.system:
      default:
        return EFUILang.of(context)!.gSystem;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define the items //

    final String label = EFUILang.of(context)!.ssThemeMode;

    final List<DropdownMenuItem<ThemeMode>> items = [
      DropdownMenuItem<ThemeMode>(
        child: Text(EFUILang.of(context)!.gSystem),
        value: ThemeMode.system,
      ),
      DropdownMenuItem<ThemeMode>(
        child: Text(EFUILang.of(context)!.gLight),
        value: ThemeMode.light,
      ),
      DropdownMenuItem<ThemeMode>(
        child: Text(EFUILang.of(context)!.gDark),
        value: ThemeMode.dark,
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
        children: [
          // Label
          Text(
            label,
            style: Theme.of(context).dropdownMenuTheme.textStyle,
            textAlign: TextAlign.center,
            semanticsLabel: EFUILang.of(context)!.gSettingX(label),
          ),
          EzSpacer.row(padding),

          // Button
          Semantics(
            button: true,
            hint:
                "${EFUILang.of(context)!.ssThemeSemantics} ${_getName(currMode)}",
            child: ExcludeSemantics(
              child: DropdownButton<ThemeMode>(
                value: currMode,
                items: items,
                onChanged: (ThemeMode? newThemeMode) {
                  switch (newThemeMode) {
                    case ThemeMode.system:
                      EzConfig.remove(isLightThemeKey);
                      setState(() {
                        currMode = ThemeMode.system;
                        PlatformTheme.of(context)!.themeMode = ThemeMode.system;
                      });
                      break;

                    case ThemeMode.light:
                      EzConfig.setBool(isLightThemeKey, true);
                      setState(() {
                        currMode = ThemeMode.light;
                        PlatformTheme.of(context)!.themeMode = ThemeMode.light;
                      });
                      break;

                    case ThemeMode.dark:
                      EzConfig.setBool(isLightThemeKey, false);
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
            ),
          ),
        ],
      ),
    );
  }
}
