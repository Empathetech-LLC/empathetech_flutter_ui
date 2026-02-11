/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzLayoutSettings extends StatefulWidget {
  /// [EzConfig.redrawUI]/[EzConfig.rebuildUI] passthrough
  final void Function() onUpdate;

  /// When true, updates both dark and light theme settings simultaneously
  final bool updateBoth;

  /// If provided, the "Editing: X theme" text will be a link with this callback
  final void Function()? themeLink;

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

  /// Empathetech layout settings
  /// Recommended to use as a [Scaffold.body]
  const EzLayoutSettings({
    super.key,
    required this.onUpdate,
    this.updateBoth = false,
    this.themeLink,
    this.beforeLayout,
    this.afterLayout,
    this.resetSpacer = const EzSeparator(),
    this.resetExtraDark,
    this.resetExtraLight,
    required this.appName,
    this.androidPackage,
    this.resetSkip,
    this.saveSkip,
  });

  @override
  State<EzLayoutSettings> createState() => _EzLayoutSettingsState();
}

class _EzLayoutSettingsState extends State<EzLayoutSettings> {
  // Init //

  @override
  void initState() {
    super.initState();
    ezWindowNamer(EzConfig.l10n.lsPageTitle);
  }

  void redraw() {
    widget.onUpdate();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final String themeString = (widget.updateBoth
            ? EzConfig.l10n.gBothThemes
            : EzConfig.isDark
                ? EzConfig.l10n.gDarkTheme
                : EzConfig.l10n.gLightTheme)
        .toLowerCase();

    // Return the build //

    return EzScrollView(
      children: <Widget>[
        (widget.themeLink != null)
            ? EzLink(
                EzConfig.l10n.gEditing + themeString,
                onTap: widget.themeLink,
                hint: EzConfig.l10n.gEditingThemeHint,
                style: EzConfig.styles.labelLarge,
                textAlign: TextAlign.center,
              )
            : EzText(
                EzConfig.l10n.gEditing + themeString,
                style: EzConfig.styles.labelLarge,
                textAlign: TextAlign.center,
              ),
        EzConfig.spacer,

        if (widget.beforeLayout != null) ...widget.beforeLayout!,

        EzMarginSetting(
          onUpdate: redraw,
          updateBoth: widget.updateBoth,
          min: minMargin,
          max: maxMargin,
          steps: 6,
          decimals: 1,
        ),
        EzConfig.spacer,

        EzPaddingSetting(
          onUpdate: redraw,
          updateBoth: widget.updateBoth,
          min: minPadding,
          max: maxPadding,
          steps: 12,
          decimals: 1,
        ),
        EzConfig.spacer,

        EzSpacingSetting(
          onUpdate: redraw,
          updateBoth: widget.updateBoth,
          min: minSpacing,
          max: maxSpacing,
          steps: 13,
          decimals: 0,
        ),
        EzConfig.separator,

        // Hide scroll
        EzSwitchPair(
          valueKey: EzConfig.isDark ? darkHideScrollKey : lightHideScrollKey,
          afterChanged: (bool? value) async {
            if (value == null) return;
            if (widget.updateBoth) {
              await EzConfig.setBool(
                  EzConfig.isDark ? lightHideScrollKey : darkHideScrollKey,
                  value);
            }
            await EzConfig.redrawUI(redraw);
          },
          text: EzConfig.l10n.lsScroll,
        ),

        if (widget.afterLayout != null) ...widget.afterLayout!,

        // Local reset all
        widget.resetSpacer,
        EzResetButton(
          redraw,
          androidPackage: widget.androidPackage,
          appName: widget.appName,
          dialogTitle: EzConfig.l10n.lsReset(widget.updateBoth &&
                  EzConfig.locale.languageCode == english.languageCode
              ? "$themeString'"
              : themeString),
          onConfirm: () async {
            if (widget.updateBoth || EzConfig.isDark) {
              await EzConfig.removeKeys(darkLayoutKeys.keys.toSet());
              if (widget.resetExtraDark != null) {
                await EzConfig.removeKeys(widget.resetExtraDark!);
              }
            }

            if (widget.updateBoth || !EzConfig.isDark) {
              await EzConfig.removeKeys(lightLayoutKeys.keys.toSet());
              if (widget.resetExtraLight != null) {
                await EzConfig.removeKeys(widget.resetExtraLight!);
              }
            }
          },
          resetBoth: widget.updateBoth,
          resetSkip: widget.resetSkip,
          saveSkip: widget.saveSkip,
        ),
        EzConfig.separator,
      ],
    );
  }
}
