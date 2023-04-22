library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzThemeModeSwitch extends StatefulWidget {
  /// Standardized tool for optionally overwriting [ThemeMode.system] via [EzConfig]
  EzThemeModeSwitch({Key? key}) : super(key: key);

  @override
  _ThemeModeSwitchState createState() => _ThemeModeSwitchState();
}

class _ThemeModeSwitchState extends State<EzThemeModeSwitch> {
  bool useSystem = true;

  @override
  Widget build(BuildContext context) {
    double buttonSpacer = EzConfig.prefs[buttonSpacingKey];

    List<Widget> _buildButtons() {
      // Use system theme?
      List<Widget> buttons = [
        EzText.simple('Use system setting?'),
        Container(width: buttonSpacer),
        Checkbox(
          value: useSystem,
          onChanged: (bool? changedTo) {
            if (changedTo == true) {
              EzConfig.preferences.remove(isLightKey);
              setState(() {
                useSystem = true;
              });
            } else {
              bool isLight = (ThemeMode.system == ThemeMode.light);

              EzConfig.preferences.setBool(isLightKey, isLight);

              setState(() {
                useSystem = false;
                EzConfig.themeMode = ThemeMode.system;
              });
            }
          },
        ),
      ];

      // Light/dark switch
      if (!useSystem) {
        bool isLight = (EzConfig.themeMode == ThemeMode.light);
        String message = (isLight) ? 'Light' : 'Dark';

        buttons.addAll([
          EzText.simple(message),
          Container(width: buttonSpacer),
          PlatformSwitch(
            value: isLight,
            onChanged: (bool on) {
              EzConfig.preferences.setBool(isLightKey, on);

              setState(() {
                EzConfig.themeMode = (on) ? ThemeMode.light : ThemeMode.dark;
              });
            },
          )
        ]);
      }
      return buttons;
    }

    return EzScrollView(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      scrollDirection: Axis.horizontal,
      reverseHands: true,
      children: _buildButtons(),
    );
  }
}
