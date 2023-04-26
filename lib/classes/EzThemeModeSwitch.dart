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
  ThemeMode _currMode = EzConfig.themeMode;

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
            value: _currMode,
            items: _themeModeItems(),
            onChanged: (ThemeMode? newThemeMode) {
              // System
              if (newThemeMode == ThemeMode.system) {
                EzConfig.preferences.remove(isLightKey);
                setState(() {
                  EzConfig.themeMode = ThemeMode.system;
                  _currMode = ThemeMode.system;
                });
              }

              // Light
              else if (newThemeMode == ThemeMode.light) {
                EzConfig.preferences.setBool(isLightKey, true);
                setState(() {
                  EzConfig.themeMode = ThemeMode.light;
                  _currMode = ThemeMode.light;
                });
              }

              // Dark
              else if (newThemeMode == ThemeMode.dark) {
                EzConfig.preferences.setBool(isLightKey, false);
                setState(() {
                  EzConfig.themeMode = ThemeMode.dark;
                  _currMode = ThemeMode.dark;
                });
              }
            }),
      ],
    );
  }
}
