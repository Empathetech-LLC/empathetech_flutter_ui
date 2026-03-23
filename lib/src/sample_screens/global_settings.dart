/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzGlobalSettings extends StatefulWidget {
  /// [Widget] at the top of the page
  final Widget header;

  /// [EzLocaleSetting.inDistress] passthrough
  final Set<String> inDistress;

  /// Locales to skip in the [EzLocaleSetting]
  /// Defaults to [english] to not dupe [americanEnglish]
  final Set<Locale>? skipLocales;

  /// [Widget]s to be added below the [EzLocaleSetting]
  /// BYO leading spacer, see [quickConfigSpacer] for trailing spacer
  final List<Widget>? additionalSettings;

  /// [EzConfig.saveConfig] passthrough
  final String appName;

  /// [EzConfig.saveConfig] passthrough
  final String? androidPackage;

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

  /// Widgets to be added below the [EzResetButton]
  /// Defaults to an [EzSeparator], if provided BYO trailing spacer
  final List<Widget> footer;

  /// Empathetech settings landing page
  /// Contains global settings and [EzElevatedIconButton]s that lead to the rest of the settings pages
  /// Recommended to use as a [Scaffold.body]
  const EzGlobalSettings({
    super.key,
    this.header = const EzSpacer(),
    this.skipLocales,
    this.inDistress = const <String>{'US'},
    this.additionalSettings,
    required this.appName,
    required this.androidPackage,
    this.saveSkip,
    this.quickConfigSpacer = const EzDivider(),
    this.randomSpacer = const EzSpacer(),
    this.resetSpacer = const EzSeparator(),
    this.resetSkip,
    this.footer = const <Widget>[EzSeparator()],
  });

  @override
  State<EzGlobalSettings> createState() => _EzGlobalSettingsState();
}

class _EzGlobalSettingsState extends State<EzGlobalSettings> {
  // Set the page title //

  @override
  void initState() {
    super.initState();
    ezWindowNamer(EzConfig.l10n.gSettings);
  }

  // Return the build //

  void redraw() => setState(() {});

  @override
  Widget build(BuildContext context) => EzScrollView(children: <Widget>[
        widget.header,

        // Right/left
        EzDominantHandSwitch(redraw),
        EzConfig.spacer,

        // Theme mode
        EzThemeModeSwitch(redraw),
        EzConfig.spacer,

        // Language
        EzLocaleSetting(
          redraw,
          skip: widget.skipLocales ?? <Locale>{english},
          inDistress: widget.inDistress,
        ),

        // Additional settings
        if (widget.additionalSettings != null) ...widget.additionalSettings!,

        // Quick config
        if (widget.quickConfigSpacer != null) ...<Widget>[
          widget.quickConfigSpacer!,
          EzQuickConfig(redraw),
        ],

        // Feeling lucky
        if (widget.randomSpacer != null) ...<Widget>[
          widget.randomSpacer!,
          EzConfigRandomizer(
            redraw,
            appName: widget.appName,
            androidPackage: widget.androidPackage,
            saveSkip: widget.saveSkip,
          ),
        ],

        // Reset button
        widget.resetSpacer,
        EzResetButton(
          redraw,
          appName: widget.appName,
          androidPackage: widget.androidPackage,
          resetSkip: widget.resetSkip,
          saveSkip: widget.saveSkip,
        ),

        // Footer
        ...widget.footer,
      ]);
}
