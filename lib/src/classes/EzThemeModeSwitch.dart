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

  // At the time of writing, Semantics does not have a const constructor
  final List<DropdownMenuItem<ThemeMode>> items = [
    DropdownMenuItem<ThemeMode>(
      child: Semantics(
        hint: 'Copy the devices theme mode',
        child: ExcludeSemantics(child: Text('System')),
      ),
      value: ThemeMode.system,
    ),
    DropdownMenuItem<ThemeMode>(
      child: Semantics(
        hint: 'Always use the light theme',
        child: ExcludeSemantics(child: Text('Light')),
      ),
      value: ThemeMode.light,
    ),
    DropdownMenuItem<ThemeMode>(
      child: Semantics(
        hint: 'Always use the dark theme',
        child: ExcludeSemantics(child: Text('Dark')),
      ),
      value: ThemeMode.dark,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    ThemeMode? _currMode = PlatformTheme.of(context)?.themeMode;
    final TextStyle? style = Theme.of(context).dropdownMenuTheme.textStyle;

    return EzRow(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Label
        EzSelectableText(
          'Theme mode',
          style: style,
          semanticsLabel: 'Select theme mode',
        ),

        EzSpacer.row(space),

        // Button
        Semantics(
          hint: 'Open to select a theme mode. Currently set to:',
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
