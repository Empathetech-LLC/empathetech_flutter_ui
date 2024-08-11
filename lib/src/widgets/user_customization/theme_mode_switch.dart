/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzThemeModeSwitch extends StatefulWidget {
  /// Defaults to [DropdownMenuThemeData.textStyle]
  final TextStyle? labelStyle;

  /// Defaults to [ColorScheme.surfaceContainer]
  final Color? backgroundColor;

  /// Standardized tool for changing the [ThemeMode]
  const EzThemeModeSwitch({
    super.key,
    this.labelStyle,
    this.backgroundColor,
  });

  @override
  State<EzThemeModeSwitch> createState() => _ThemeModeSwitchState();
}

class _ThemeModeSwitchState extends State<EzThemeModeSwitch> {
  // Gather the theme data //

  late final ThemeData theme = Theme.of(context);
  late final EFUILang l10n = EFUILang.of(context)!;

  late ThemeMode? platformTheme = PlatformTheme.of(context)!.themeMode;

  // Define the build data //

  late final List<DropdownMenuEntry<ThemeMode>> entries =
      <DropdownMenuEntry<ThemeMode>>[
    DropdownMenuEntry<ThemeMode>(
      value: ThemeMode.system,
      label: l10n.gSystem,
    ),
    DropdownMenuEntry<ThemeMode>(
      value: ThemeMode.light,
      label: l10n.gLight,
    ),
    DropdownMenuEntry<ThemeMode>(
      value: ThemeMode.dark,
      label: l10n.gDark,
    ),
  ];

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          color: widget.backgroundColor ?? theme.colorScheme.surfaceContainer),
      child: EzRow(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Label
          Flexible(
            child: Text(
              l10n.ssThemeMode,
              style: widget.labelStyle ?? theme.dropdownMenuTheme.textStyle,
              textAlign: TextAlign.center,
            ),
          ),
          EzSpacer(space: EzConfig.get(paddingKey), vertical: false),

          // Button
          DropdownMenu<ThemeMode>(
            enableSearch: false,
            initialSelection: platformTheme,
            dropdownMenuEntries: entries,
            onSelected: (ThemeMode? newThemeMode) async {
              switch (newThemeMode) {
                case ThemeMode.system:
                  await EzConfig.remove(isDarkThemeKey);
                  platformTheme = ThemeMode.system;
                  setState(() {});
                  break;

                case ThemeMode.light:
                  await EzConfig.setBool(isDarkThemeKey, false);
                  platformTheme = ThemeMode.light;
                  setState(() {});
                  break;

                case ThemeMode.dark:
                  await EzConfig.setBool(isDarkThemeKey, true);
                  platformTheme = ThemeMode.dark;
                  setState(() {});
                  break;

                default:
                  break;
              }
            },
          ),
        ],
      ),
    );
  }
}
