/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';

class EzLayoutSettings extends StatefulWidget {
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

  /// [EzResetButton.skip] passthrough
  final Set<String>? resetSkip;

  /// Empathetech layout settings
  /// Recommended to use as a [Scaffold.body]
  const EzLayoutSettings({
    super.key,
    this.beforeLayout,
    this.afterLayout,
    this.resetSpacer = const EzSeparator(),
    this.resetExtraDark,
    this.resetExtraLight,
    required this.appName,
    this.androidPackage,
    this.resetSkip,
  });

  @override
  State<EzLayoutSettings> createState() => _EzLayoutSettingsState();
}

class _EzLayoutSettingsState extends State<EzLayoutSettings> {
  // Define the build data //

  late int redraw = 0;

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ezWindowNamer(context, EzConfig.l10n.lsPageTitle);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) => EzScrollView(
        children: <Widget>[
          EzHeader(),

          // Before layout
          if (widget.beforeLayout != null) ...widget.beforeLayout!,

          // Main //
          ...EzConfig.isDark
              ? <Widget>[
                  // Margin
                  EzLayoutSetting(
                    key: ValueKey<String>('margin_$redraw'),
                    configKey: darkMarginKey,
                    type: EzLayoutSettingType.margin,
                    min: minMargin,
                    max: maxMargin,
                    steps: 6,
                    decimals: 1,
                  ),
                  EzConfig.spacer,

                  // Padding
                  EzLayoutSetting(
                    key: ValueKey<String>('padding_$redraw'),
                    configKey: darkPaddingKey,
                    type: EzLayoutSettingType.padding,
                    min: minPadding,
                    max: maxPadding,
                    steps: 12,
                    decimals: 1,
                  ),
                  EzConfig.spacer,

                  // Spacing
                  EzLayoutSetting(
                    key: ValueKey<String>('spacing_$redraw'),
                    configKey: darkSpacingKey,
                    type: EzLayoutSettingType.spacing,
                    min: minSpacing,
                    max: maxSpacing,
                    steps: 13,
                    decimals: 0,
                  ),
                  EzConfig.separator,

                  // Hide scroll
                  EzSwitchPair(
                    key: ValueKey<String>('scroll_$redraw'),
                    text: EzConfig.l10n.lsScroll,
                    valueKey: darkHideScrollKey,
                  ),
                ]
              : <Widget>[
                  // Margin
                  EzLayoutSetting(
                    key: ValueKey<String>('margin_$redraw'),
                    configKey: lightMarginKey,
                    type: EzLayoutSettingType.margin,
                    min: minMargin,
                    max: maxMargin,
                    steps: 6,
                    decimals: 1,
                  ),
                  EzConfig.spacer,

                  // Padding
                  EzLayoutSetting(
                    key: ValueKey<String>('padding_$redraw'),
                    configKey: lightPaddingKey,
                    type: EzLayoutSettingType.padding,
                    min: minPadding,
                    max: maxPadding,
                    steps: 12,
                    decimals: 1,
                  ),
                  EzConfig.spacer,

                  // Spacing
                  EzLayoutSetting(
                    key: ValueKey<String>('spacing_$redraw'),
                    configKey: lightSpacingKey,
                    type: EzLayoutSettingType.spacing,
                    min: minSpacing,
                    max: maxSpacing,
                    steps: 13,
                    decimals: 0,
                  ),
                  EzConfig.separator,

                  // Hide scroll
                  EzSwitchPair(
                    key: ValueKey<String>('scroll_$redraw'),
                    text: EzConfig.l10n.lsScroll,
                    valueKey: lightHideScrollKey,
                  ),
                ],

          // After layout
          if (widget.afterLayout != null) ...widget.afterLayout!,

          // Local reset all
          widget.resetSpacer,
          EzResetButton(
            dialogTitle: EzConfig.l10n.lsResetAll,
            onConfirm: () async {
              if (EzConfig.isDark) {
                await EzConfig.removeKeys(darkLayoutKeys.keys.toSet());
                if (widget.resetExtraDark != null) {
                  await EzConfig.removeKeys(widget.resetExtraDark!);
                }
              } else {
                await EzConfig.removeKeys(lightLayoutKeys.keys.toSet());
                if (widget.resetExtraLight != null) {
                  await EzConfig.removeKeys(widget.resetExtraLight!);
                }
              }
              setState(() => redraw = Random().nextInt(rMax));
            },
            skip: widget.resetSkip,
            appName: widget.appName,
            androidPackage: widget.androidPackage,
          ),
          EzConfig.separator,
        ],
      );
}
