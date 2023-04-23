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
  ThemeMode _currentThemeMode = EzConfig.themeMode;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<ThemeMode>> _themeModeItems() {
      return [
        DropdownMenuItem<ThemeMode>(
          child: ezText('System'),
          value: ThemeMode.system,
        ),
        DropdownMenuItem<ThemeMode>(
          child: ezText('Light'),
          value: ThemeMode.light,
        ),
        DropdownMenuItem<ThemeMode>(
          child: ezText('Dark'),
          value: ThemeMode.dark,
        ),
      ];
    }

    return EzScrollView(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      scrollDirection: Axis.horizontal,
      reverseHands: true,
      children: [
        ezText('Theme mode'),
        DropdownButton<ThemeMode>(
          value: _currentThemeMode,
          items: _themeModeItems(),
          onChanged: (ThemeMode? newThemeMode) {
            if (newThemeMode != null) {
              if (newThemeMode == ThemeMode.system) {
                EzConfig.preferences.remove(isLightKey);
              } else {
                bool isLight = newThemeMode == ThemeMode.light;
                EzConfig.preferences.setBool(isLightKey, isLight);
              }

              setState(() {
                _currentThemeMode = newThemeMode;
                EzConfig.themeMode = newThemeMode;
              });
            }
          },
        ),
      ],
    );
  }
}
