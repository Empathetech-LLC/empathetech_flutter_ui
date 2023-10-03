/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzThemeModeSwitch extends StatefulWidget {
  /// Standardized tool for changing the [ThemeMode]
  const EzThemeModeSwitch({Key? key}) : super(key: key);

  @override
  _ThemeModeSwitchState createState() => _ThemeModeSwitchState();
}

class _ThemeModeSwitchState extends State<EzThemeModeSwitch> {
  final List<DropdownMenuItem<ThemeMode>> _items = [
    DropdownMenuItem<ThemeMode>(
      child: Semantics(
        hint: 'Copy the devices theme mode',
        child: ExcludeSemantics(child: const Text('System')),
      ),
      value: ThemeMode.system,
    ),
    DropdownMenuItem<ThemeMode>(
      child: Semantics(
        hint: 'Always use the light theme',
        child: ExcludeSemantics(child: const Text('Light')),
      ),
      value: ThemeMode.light,
    ),
    DropdownMenuItem<ThemeMode>(
      child: Semantics(
        hint: 'Always use the dark theme',
        child: ExcludeSemantics(child: const Text('Dark')),
      ),
      value: ThemeMode.dark,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    ThemeMode? currMode = PlatformTheme.of(context)?.themeMode;
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
        EzSpacer.row(EzConfig.instance.prefs[buttonSpacingKey]),

        // Button
        Semantics(
          hint: 'Open to select a theme mode. Currently set to:',
          child: DropdownButton<ThemeMode>(
            value: currMode,
            items: _items,
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
