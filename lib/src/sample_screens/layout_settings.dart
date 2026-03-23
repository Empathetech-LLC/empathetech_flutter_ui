/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzLayoutSettings extends StatefulWidget {
  /// [EzConfig.redrawUI]/[EzConfig.rebuildUI] passthrough
  final void Function() onUpdate;

  /// Optional additional settings, before the main settings
  /// BYO spacers
  final List<Widget>? beforeLayout;

  /// Optional additional settings, after the main settings
  /// BYO spacers
  final List<Widget>? afterLayout;

  /// Spacer between the main (or [afterLayout], if present) settings and the trailing [EzResetButton]
  final Widget resetSpacer;

  /// Optional additional reset keys for the dark theme
  /// [allTextKeys] and [darkOnSurfaceKey] are included by default
  final Set<String>? resetExtraDark;

  /// Optional additional reset keys for the light theme
  /// [allTextKeys] and [lightOnSurfaceKey] are included by default
  final Set<String>? resetExtraLight;

  /// [EzResetButton.appName] passthrough
  final String appName;

  /// [EzResetButton.androidPackage] passthrough
  final String? androidPackage;

  /// [EzResetButton.resetSkip] passthrough
  final Set<String>? resetSkip;

  /// [EzResetButton.saveSkip] passthrough
  final Set<String>? saveSkip;

  /// Defaults to [EzSeparator]
  final Widget trail;

  /// Empathetech layout settings
  /// Recommended to use as a [Scaffold.body]
  const EzLayoutSettings({
    super.key,
    required this.onUpdate,
    this.beforeLayout,
    this.afterLayout,
    this.resetSpacer = const EzSeparator(),
    this.resetExtraDark,
    this.resetExtraLight,
    required this.appName,
    this.androidPackage,
    this.resetSkip,
    this.saveSkip,
    this.trail = const EzSeparator(),
  });

  @override
  State<EzLayoutSettings> createState() => _EzLayoutSettingsState();
}

class _EzLayoutSettingsState extends State<EzLayoutSettings> {
  // Define custom functions //

  void redraw() {
    widget.onUpdate();
    setState(() {});
  }

  // Init //

  @override
  void initState() {
    super.initState();
    ezWindowNamer(EzConfig.l10n.lsPageTitle);
  }

  // Return the build //
  @override
  Widget build(BuildContext context) {
    return EzScrollView(mainAxisSize: MainAxisSize.min, children: <Widget>[
      EzConfig.margin,

      // Update both switch
      EzSwitchPair(
        valueKey: updateBothKey,
        text: EzConfig.l10n.ssUpdateBoth,
      ),
      EzConfig.spacer,

      if (widget.beforeLayout != null) ...widget.beforeLayout!,

      EzMarginSetting(
        onUpdate: redraw,
        min: minMargin,
        max: maxMargin,
        steps: 6,
        decimals: 1,
      ),
      EzConfig.spacer,

      EzPaddingSetting(
        onUpdate: redraw,
        min: minPadding,
        max: maxPadding,
        steps: 12,
        decimals: 1,
      ),
      EzConfig.spacer,

      EzSpacingSetting(
        onUpdate: redraw,
        min: minSpacing,
        max: maxSpacing,
        steps: 13,
        decimals: 0,
      ),
      EzConfig.separator,

      // Show back FAB
      EzSwitchPair(
        valueKey: EzConfig.isDark ? darkShowBackFABKey : lightShowBackFABKey,
        afterChanged: (bool? value) async {
          if (value == null) return;

          if (EzConfig.updateBoth) {
            await EzConfig.setBool(
                EzConfig.isDark ? lightShowBackFABKey : darkShowBackFABKey,
                value);
          }

          await EzConfig.rebuildUI(redraw);
        },
        text: EzConfig.l10n.lsShowBack,
      ),
      EzConfig.spacer,

      // Show scroll
      EzSwitchPair(
        valueKey: EzConfig.isDark ? darkShowScrollKey : lightShowScrollKey,
        afterChanged: (bool? value) async {
          if (value == null) return;

          if (EzConfig.updateBoth) {
            await EzConfig.setBool(
                EzConfig.isDark ? lightShowScrollKey : darkShowScrollKey,
                value);
          }

          await EzConfig.rebuildUI(redraw);
        },
        text: EzConfig.l10n.lsShowScroll,
      ),

      if (widget.afterLayout != null) ...widget.afterLayout!,

      // Local reset all
      widget.resetSpacer,
      EzResetButton(
        redraw,
        androidPackage: widget.androidPackage,
        appName: widget.appName,
        dialogTitle: EzConfig.l10n.lsReset(EzConfig.updateBoth &&
                EzConfig.locale.languageCode == english.languageCode
            ? "${ezThemeString()}'"
            : ezThemeString()),
        onConfirm: () async {
          if (EzConfig.updateBoth || EzConfig.isDark) {
            await EzConfig.removeKeys(darkLayoutKeys.keys.toSet());
            if (widget.resetExtraDark != null) {
              await EzConfig.removeKeys(widget.resetExtraDark!);
            }
          }

          if (EzConfig.updateBoth || !EzConfig.isDark) {
            await EzConfig.removeKeys(lightLayoutKeys.keys.toSet());
            if (widget.resetExtraLight != null) {
              await EzConfig.removeKeys(widget.resetExtraLight!);
            }
          }
        },
        resetSkip: widget.resetSkip,
        saveSkip: widget.saveSkip,
      ),
      widget.trail,
    ]);
  }
}
