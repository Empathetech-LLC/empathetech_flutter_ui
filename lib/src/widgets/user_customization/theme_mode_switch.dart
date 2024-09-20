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

  final double padding = EzConfig.get(paddingKey);

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
        color: widget.backgroundColor ?? theme.colorScheme.surfaceContainer,
        borderRadius: ezRoundEdge,
      ),
      child: EzScrollView(
        scrollDirection: Axis.horizontal,
        reverseHands: true,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Label
          EzSpacer(space: padding / 2, vertical: false),
          Text(
            l10n.ssThemeMode,
            style: widget.labelStyle ?? theme.dropdownMenuTheme.textStyle,
            textAlign: TextAlign.center,
          ),
          EzSpacer(space: padding, vertical: false),

          // Button
          DropdownMenu<ThemeMode>(
            enableSearch: false,
            initialSelection: platformTheme,
            dropdownMenuEntries: entries,
            onSelected: (ThemeMode? newThemeMode) async {
              switch (newThemeMode) {
                case ThemeMode.system:
                  await EzConfig.remove(isDarkThemeKey);
                  setState(() => platformTheme = ThemeMode.system);
                  break;

                case ThemeMode.light:
                  await EzConfig.setBool(isDarkThemeKey, false);
                  setState(() => platformTheme = ThemeMode.light);
                  break;

                case ThemeMode.dark:
                  await EzConfig.setBool(isDarkThemeKey, true);
                  setState(() => platformTheme = ThemeMode.dark);
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
