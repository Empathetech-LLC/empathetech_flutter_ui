library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzThemeModeSwitch extends StatefulWidget {
  /// Standardized tool for optionally overwriting [ThemeMode.system] via [EzConfig]
  EzThemeModeSwitch({Key? key}) : super(key: key);

  @override
  _ThemeModeSwitchState createState() => _ThemeModeSwitchState();
}

class _ThemeModeSwitchState extends State<EzThemeModeSwitch> {
  ThemeMode _currMode = EzConfig.instance.themeMode;

  late TextStyle? style = Theme.of(context).dropdownMenuTheme.textStyle;

  final double space = EzConfig.instance.prefs[buttonSpacingKey];

  @override
  Widget build(BuildContext context) {
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
        EzSelectableText('Theme mode', style: style),
        EzSpacer.row(space),

        // Button
        DropdownButton<ThemeMode>(
          value: _currMode,
          items: items,
          onChanged: (ThemeMode? newThemeMode) {
            switch (newThemeMode) {
              case ThemeMode.system:
                EzConfig.instance.preferences.remove(isLightKey);
                setState(() {
                  _currMode = ThemeMode.system;
                });
                break;

              case ThemeMode.light:
                EzConfig.instance.preferences.remove(isLightKey);
                setState(() {
                  _currMode = ThemeMode.system;
                });
                break;

              case ThemeMode.dark:
                EzConfig.instance.preferences.setBool(isLightKey, false);
                setState(() {
                  _currMode = ThemeMode.dark;
                });
                break;

              default:
                break;
            }
          },
        ),
      ],
    );
  }
}
