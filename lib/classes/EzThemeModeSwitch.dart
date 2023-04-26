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
  late TextStyle? style = headlineMedium(context);

  List<DropdownMenuItem<ThemeMode>> _themeModeItems() {
    return [
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
  }

  @override
  Widget build(BuildContext context) {
    return EzScrollView(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      scrollDirection: Axis.horizontal,
      children: [
        // Label
        ezText('Theme mode', style: style),
        Container(width: EzConfig.prefs[buttonSpacingKey]),

        // Button
        DropdownButton<ThemeMode>(
            value: EzConfig.themeMode,
            items: _themeModeItems(),
            onChanged: (ThemeMode? newThemeMode) {
              if (newThemeMode == ThemeMode.system) {
                EzConfig.preferences.remove(isLightKey);
                EzConfig.themeMode = ThemeMode.system;
              } else if (newThemeMode == ThemeMode.light) {
                EzConfig.preferences.setBool(isLightKey, true);
                EzConfig.themeMode = ThemeMode.light;
              } else if (newThemeMode == ThemeMode.dark) {
                EzConfig.preferences.setBool(isLightKey, false);
                EzConfig.themeMode = ThemeMode.dark;
              }
            }),
      ],
    );
  }
}
