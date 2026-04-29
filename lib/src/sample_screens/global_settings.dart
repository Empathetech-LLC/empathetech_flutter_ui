/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzGlobalSettings extends StatelessWidget {
  /// Optionally remove the locale setting
  final bool excludeLocaleSetting;

  /// [EzLocaleSetting.inDistress] passthrough
  final Set<String> inDistress;

  /// Locales to skip in the [EzLocaleSetting]
  /// Defaults to [english] to not dupe [americanEnglish]
  final Set<Locale>? skipLocales;

  /// [Widget]s to be added below the [EzLocaleSetting]
  /// BYO leading spacer, see [quickConfigSpacer] for trailing spacer
  final List<Widget>? additionalSettings;

  /// [EzConfig.saveConfig] passthrough
  final Set<String>? saveSkip;

  /// Spacer before the [EzQuickConfig]
  /// If null, [EzQuickConfig] will not be included
  final Widget? quickConfigSpacer;

  /// Spacer before the [EzConfigRandomizer]
  /// If null, [EzConfigRandomizer] will not be included
  final Widget? randomSpacer;

  /// Spacer before the [EzResetButton]
  /// [EzResetButton] is always included
  final Widget resetSpacer;

  /// [EzResetButton.resetSkip] passthrough
  final Set<String>? resetSkip;

  /// [EzResetButton.dynamicTitle] passthrough
  final String Function()? resetTitle;

  /// Widgets to be added below the [EzResetButton]
  /// Defaults to an [EzSeparator], if provided BYO trailing spacer
  final List<Widget> footer;

  /// Empathetech settings landing page
  /// Contains global settings and [EzElevatedIconButton]s that lead to the rest of the settings pages
  /// Recommended to use as a [Scaffold.body]
  const EzGlobalSettings({
    super.key,
    this.excludeLocaleSetting = false,
    this.skipLocales,
    this.inDistress = const <String>{'US'},
    this.additionalSettings,
    this.saveSkip,
    this.quickConfigSpacer = const EzSeparator(),
    this.randomSpacer = const EzSpacer(),
    this.resetSpacer = const EzSeparator(),
    this.resetSkip,
    this.resetTitle,
    this.footer = const <Widget>[EzSeparator()],
  });

  @override
  Widget build(BuildContext context) => EzCol(children: <Widget>[
        EzConfig.spacer,

        // Right/left
        const EzDominantHandSwitch(),
        EzConfig.spacer,

        // Theme mode
        const EzThemeModeSwitch(),

        // Language
        if (!excludeLocaleSetting) ...<Widget>[
          EzConfig.spacer,
          EzLocaleSetting(
            skip: skipLocales ?? <Locale>{english},
            inDistress: inDistress,
          ),
        ],

        // Additional settings
        if (additionalSettings != null) ...additionalSettings!,

        // Quick config
        if (quickConfigSpacer != null) ...<Widget>[
          quickConfigSpacer!,
          const EzQuickConfig(),
        ],

        // Feeling lucky
        if (randomSpacer != null) ...<Widget>[
          randomSpacer!,
          EzConfigRandomizer(saveSkip: saveSkip),
        ],

        // Reset button
        resetSpacer,
        EzResetButton(
          resetSkip: resetSkip,
          saveSkip: saveSkip,
          dynamicTitle: resetTitle,
        ),
      ]);
}
