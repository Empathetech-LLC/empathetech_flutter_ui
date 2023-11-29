/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzLocaleSetting extends StatefulWidget {
  /// Pass in any custom [supportedLocales]
  final List<Locale>? locales;

  /// Standardized tool for updating [EzConfig] Locale
  const EzLocaleSetting({Key? key, this.locales}) : super(key: key);

  @override
  _LocaleSettingState createState() => _LocaleSettingState();
}

class _LocaleSettingState extends State<EzLocaleSetting> {
  // Gather theme data //

  Locale currLocale = EzConfig.instance.locale;

  @override
  Widget build(BuildContext context) {
    // Gather the list items //

    final TextStyle? style = Theme.of(context).dropdownMenuTheme.textStyle;

    final List<Locale> _locales = (widget.locales == null)
        ? EFUILang.supportedLocales
        : EFUILang.supportedLocales + widget.locales!;

    final List<DropdownMenuItem<Locale>> items = _locales.map((locale) {
      return DropdownMenuItem<Locale>(
        child: Text(locale.toString()),
        value: locale,
      );
    }).toList();

    // Return the build //

    return EzRow(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Label
        Text(
          EFUILang.of(context)!.hsLanguage,
          style: style,
          textAlign: TextAlign.center,
        ),
        EzSpacer.row(EzConfig.instance.prefs[buttonSpacingKey]),

        // Button
        Semantics(
          button: true,
          hint:
              "${EFUILang.of(context)!.hsThemeSemantics} ${_getName(currMode)}",
          child: ExcludeSemantics(
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
        ),
      ],
    );
  }
}
