library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class EzThemeModeSwitch extends StatefulWidget {
  /// Standardized tool for optionally overwriting [ThemeMode.system] via [EzConfig]
  const EzThemeModeSwitch({Key? key}) : super(key: key);

  @override
  _ThemeModeSwitchState createState() => _ThemeModeSwitchState();
}

class _ThemeModeSwitchState extends State<EzThemeModeSwitch> {
  late final TextStyle? style = Theme.of(context).dropdownMenuTheme.textStyle;

  final double space = EzConfig.instance.prefs[buttonSpacingKey];

  late AdaptiveThemeMode? _currMode;

  void _getTheme() async {
    _currMode = await AdaptiveTheme.getThemeMode();
  }

  @override
  void initState() {
    super.initState();
    _getTheme();
  }

  @override
  Widget build(BuildContext context) {
    const List<DropdownMenuItem<AdaptiveThemeMode>> items = [
      DropdownMenuItem<AdaptiveThemeMode>(
        child: Text('System'),
        value: AdaptiveThemeMode.system,
      ),
      DropdownMenuItem<AdaptiveThemeMode>(
        child: Text('Light'),
        value: AdaptiveThemeMode.light,
      ),
      DropdownMenuItem<AdaptiveThemeMode>(
        child: Text('Dark'),
        value: AdaptiveThemeMode.dark,
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
        DropdownButton<AdaptiveThemeMode>(
          value: _currMode,
          items: items,
          onChanged: (AdaptiveThemeMode? newThemeMode) {
            switch (newThemeMode) {
              case AdaptiveThemeMode.system:
                AdaptiveTheme.of(context).setSystem();
                break;

              case AdaptiveThemeMode.light:
                AdaptiveTheme.of(context).setLight();
                break;

              case AdaptiveThemeMode.dark:
                AdaptiveTheme.of(context).setDark();
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
