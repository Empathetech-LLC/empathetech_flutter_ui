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
  @override
  Widget build(BuildContext context) {
    // Gather theme data //

    ThemeMode? currMode = PlatformTheme.of(context)?.themeMode;
    final TextStyle? style = Theme.of(context).dropdownMenuTheme.textStyle;

    // Define the items //

    final List<DropdownMenuItem<ThemeMode>> items = [
      DropdownMenuItem<ThemeMode>(
        child: Text(EFUILang.of(context)!.g_System),
        value: ThemeMode.system,
      ),
      DropdownMenuItem<ThemeMode>(
        child: Text(EFUILang.of(context)!.g_Light),
        value: ThemeMode.light,
      ),
      DropdownMenuItem<ThemeMode>(
        child: Text(EFUILang.of(context)!.g_Dark),
        value: ThemeMode.dark,
      ),
    ];

    // Return the build //

    return EzRow(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Label
        EzText(
          EFUILang.of(context)!.hs_ThemeMode,
          style: style,
        ),
        EzSpacer.row(EzConfig.instance.prefs[buttonSpacingKey]),

        // Button
        Semantics(
          hint: EFUILang.of(context)!.hs_ThemeSemantics,
          child: DropdownButton<ThemeMode>(
            value: currMode,
            items: items,
            dropdownColor: Theme.of(context).scaffoldBackgroundColor,
            onChanged: (ThemeMode? newThemeMode) {
              switch (newThemeMode) {
                case ThemeMode.system:
                  EzConfig.instance.preferences.remove(isLightKey);
                  setState(() {
                    currMode = ThemeMode.system;
                    PlatformTheme.of(context)!.themeMode = ThemeMode.system;
                  });
                  break;

                case ThemeMode.light:
                  EzConfig.instance.preferences.setBool(isLightKey, true);
                  setState(() {
                    currMode = ThemeMode.light;
                    PlatformTheme.of(context)!.themeMode = ThemeMode.light;
                  });
                  break;

                case ThemeMode.dark:
                  EzConfig.instance.preferences.setBool(isLightKey, false);
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
      ],
    );
  }
}
