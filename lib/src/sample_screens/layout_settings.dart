/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzLayoutSettings extends StatefulWidget {
  /// Optional additional settings
  /// Before the main settings
  /// See [prefixSpacer] for layout tuning
  final List<Widget>? beforeLayout;

  /// If [beforeLayout] is not null, the spacer between it and the main settings
  final Widget prefixSpacer;

  /// Spacer between the main settings and [afterLayout], if present
  final Widget postfixSpacer;

  /// Optional additional settings
  /// After the main settings
  /// See [postfixSpacer] and [resetSpacer] for layout tuning
  final List<Widget>? afterLayout;

  /// Spacer between the main (or [afterLayout], if present) settings and the trailing [EzResetButton]
  final Widget resetSpacer;

  /// Additional [EzConfig] keys for the local [EzResetButton]
  /// [layoutKeys] are included by default
  final Set<String>? resetKeys;

  /// Empathetech layout settings
  /// Recommended to use as a [Scaffold.body]
  const EzLayoutSettings({
    super.key,
    this.beforeLayout,
    this.prefixSpacer = const EzSeparator(),
    this.postfixSpacer = const EzSeparator(),
    this.afterLayout,
    this.resetSpacer = const EzSeparator(),
    this.resetKeys,
  });

  @override
  State<EzLayoutSettings> createState() => _EzLayoutSettingsState();
}

class _EzLayoutSettingsState extends State<EzLayoutSettings> {
  // Gather the theme data //

  static const EzSpacer spacer = EzSpacer();
  static const EzSeparator separator = EzSeparator();

  final double margin = EzConfig.get(marginKey);
  final double spacing = EzConfig.get(spacingKey);

  late final EFUILang l10n = ezL10n(context);

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ezWindowNamer(context, l10n.lsPageTitle);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return EzScrollView(
      children: <Widget>[
        if (spacing > margin) EzSpacer(space: spacing - margin),

        // Before layout
        if (widget.beforeLayout != null) ...<Widget>[
          ...widget.beforeLayout!,
          widget.prefixSpacer,
        ],

        // Main //
        // Margin
        const EzLayoutSetting(
          configKey: marginKey,
          type: EzLayoutSettingType.margin,
          min: minMargin,
          max: maxMargin,
          steps: 6,
          decimals: 1,
        ),
        spacer,

        // Padding
        const EzLayoutSetting(
          configKey: paddingKey,
          type: EzLayoutSettingType.padding,
          min: minPadding,
          max: maxPadding,
          steps: 12,
          decimals: 1,
        ),
        spacer,

        // Spacing
        const EzLayoutSetting(
          configKey: spacingKey,
          type: EzLayoutSettingType.spacing,
          min: minSpacing,
          max: maxSpacing,
          steps: 13,
          decimals: 0,
        ),
        separator,

        // Hide scroll
        EzSwitchPair(text: l10n.lsScroll, valueKey: hideScrollKey),

        // After layout
        if (widget.afterLayout != null) ...<Widget>[
          widget.postfixSpacer,
          ...widget.afterLayout!,
        ],

        // Local reset all
        widget.resetSpacer,
        EzResetButton(
          dialogTitle: l10n.lsResetAll,
          onConfirm: () async {
            await EzConfig.removeKeys(layoutKeys.keys.toSet());
            if (widget.resetKeys != null) {
              await EzConfig.removeKeys(widget.resetKeys!);
            }
          },
        ),
        separator,
      ],
    );
  }
}
