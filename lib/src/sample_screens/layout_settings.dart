/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
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

  /// Additional [EzConfig] keys for the local [EzResetButton]
  /// [allLayoutKeys] are included by default
  final Set<String>? resetKeys;

  /// [EzResetButton.extraKeys] passthrough
  final List<String>? extraSaveKeys;

  /// [EzResetButton.appName] passthrough
  final String appName;

  /// [EzResetButton.androidPackage] passthrough
  final String? androidPackage;

  /// Empathetech layout settings
  /// Recommended to use as a [Scaffold.body]
  const EzLayoutSettings({
    super.key,
    this.beforeLayout,
    this.afterLayout,
    this.resetSpacer = ezSeparator,
    this.resetKeys,
    this.extraSaveKeys,
    required this.appName,
    this.androidPackage,
  });

  @override
  State<EzLayoutSettings> createState() => _EzLayoutSettingsState();
}

class _EzLayoutSettingsState extends State<EzLayoutSettings> {
  // Define the build data //

  late final EFUILang l10n = ezL10n(context);

  int redraw = 0;

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ezWindowNamer(context, l10n.lsPageTitle);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final double margin = EzConfig.margin;
    final double spacing = EzConfig.spacing;

    return EzScrollView(
      children: <Widget>[
        if (spacing > margin) EzSpacer(space: spacing - margin),

        // Before layout
        if (widget.beforeLayout != null) ...widget.beforeLayout!,

        // Main //
        // Margin
        EzLayoutSetting(
          key: ValueKey<String>('margin_$redraw'),
          configKey: marginKey,
          type: EzLayoutSettingType.margin,
          min: minMargin,
          max: maxMargin,
          steps: 6,
          decimals: 1,
        ),
        ezSpacer,

        // Padding
        EzLayoutSetting(
          key: ValueKey<String>('padding_$redraw'),
          configKey: paddingKey,
          type: EzLayoutSettingType.padding,
          min: minPadding,
          max: maxPadding,
          steps: 12,
          decimals: 1,
        ),
        ezSpacer,

        // Spacing
        EzLayoutSetting(
          key: ValueKey<String>('spacing_$redraw'),
          configKey: spacingKey,
          type: EzLayoutSettingType.spacing,
          min: minSpacing,
          max: maxSpacing,
          steps: 13,
          decimals: 0,
        ),
        ezSeparator,

        // Hide scroll
        EzSwitchPair(
          key: ValueKey<String>('scroll_$redraw'),
          text: l10n.lsScroll,
          valueKey: hideScrollKey,
        ),

        // After layout
        if (widget.afterLayout != null) ...widget.afterLayout!,

        // Local reset all
        widget.resetSpacer,
        EzResetButton(
          dialogTitle: l10n.lsResetAll,
          onConfirm: () async {
            await EzConfig.removeKeys(allLayoutKeys.keys.toSet());
            if (widget.resetKeys != null) {
              await EzConfig.removeKeys(widget.resetKeys!);
            }
            setState(() => redraw = Random().nextInt(rMax));
          },
          extraKeys: widget.extraSaveKeys,
          appName: widget.appName,
          androidPackage: widget.androidPackage,
        ),
        ezSeparator,
      ],
    );
  }
}
