/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzThemeModeSwitch extends StatefulWidget {
  /// Standardized tool for optionally overwriting [ThemeMode.system] via [EzConfig]
  const EzThemeModeSwitch({Key? key}) : super(key: key);

  @override
  _ThemeModeSwitchState createState() => _ThemeModeSwitchState();
}

class _ThemeModeSwitchState extends State<EzThemeModeSwitch> {
  final double space = EzConfig.instance.prefs[buttonSpacingKey];

  @override
  Widget build(BuildContext context) {
    ThemeMode? _currMode = PlatformTheme.of(context)?.themeMode;
    final TextStyle? style = Theme.of(context).dropdownMenuTheme.textStyle;

    const List<DropdownMenuItem<ThemeMode>> items = [
      DropdownMenuItem<ThemeMode>(
        child: Text('System'),
        value: ThemeMode.system,
      ),
      DropdownMenuItem<ThemeMode>(
        child: Text('Light'),
        value: ThemeMode.light,
      ),
      DropdownMenuItem<ThemeMode>(
        child: Text('Dark'),
        value: ThemeMode.dark,
      ),
    ];

    return EzRow(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Label
        Semantics(
          label: 'Select theme mode',
          readOnly: true,
          child: EzSelectableText('Theme mode', style: style),
        ),
        EzSpacer.row(space),

        // Button
        Semantics(
          hint: 'Open to select a theme mode',
          child: DropdownButton<ThemeMode>(
            value: _currMode,
            items: items,
            dropdownColor: Theme.of(context).scaffoldBackgroundColor,
            onChanged: (ThemeMode? newThemeMode) {
              switch (newThemeMode) {
                case ThemeMode.system:
                  EzConfig.instance.preferences.remove(isLightKey);
                  setState(() {
                    _currMode = ThemeMode.system;
                    PlatformTheme.of(context)!.themeMode = ThemeMode.system;
                  });
                  break;

                case ThemeMode.light:
                  EzConfig.instance.preferences.setBool(isLightKey, true);
                  setState(() {
                    _currMode = ThemeMode.light;
                    PlatformTheme.of(context)!.themeMode = ThemeMode.light;
                  });
                  break;

                case ThemeMode.dark:
                  EzConfig.instance.preferences.setBool(isLightKey, false);
                  setState(() {
                    _currMode = ThemeMode.dark;
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
