/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzFontDoubleBatchSetting extends StatefulWidget {
  /// All [EzConfig] keys being edited paired with their default values
  final Map<String, double> keysNDefaults;

  final double min;
  final double max;

  /// Returns whether changes have been made
  final void Function(bool) notifierCallback;

  final String tooltip;

  /// Amount to scale on each click, defaults to 0.1
  /// aka 10%
  final double delta;

  final TextStyle? style;

  /// Standardized tool for batch updating double [TextStyle] values for the passed [keysNDefaults]
  /// The updates will be based on the default from [keysNDefaults] and [delta]
  /// For example: [TextStyle.fontSize]
  const EzFontDoubleBatchSetting({
    super.key,
    required this.keysNDefaults,
    required this.min,
    required this.max,
    required this.notifierCallback,
    required this.tooltip,
    this.delta = 0.1,
    this.style,
  });

  @override
  State<EzFontDoubleBatchSetting> createState() =>
      _FontDoubleBatchSettingState();
}

class _FontDoubleBatchSettingState extends State<EzFontDoubleBatchSetting> {
  // Gather the theme data //

  late final double padding = EzConfig.get(paddingKey);
  late final double lineHeight = EzConfig.get(bodyFontHeightKey) ?? 1.5;

  late final EzSpacer pMSpacer = EzSpacer.row(padding / 4);

  late final EFUILang l10n = EFUILang.of(context)!;

  late final ColorScheme colorScheme = Theme.of(context).colorScheme;
  late final Color onBackground = colorScheme.onSurface;
  late final TextStyle? style = widget.style ??
      Theme.of(context).textTheme.headlineLarge?.copyWith(color: onBackground);

  // Define build data //

  late Map<String, double> upperLimits = widget.keysNDefaults.map(
    (String key, double value) => MapEntry<String, double>(
      key,
      value * widget.max,
    ),
  );

  late bool atMax = upperLimits.entries.every((MapEntry<String, double> max) =>
      max.value == EzConfig.getDouble(max.key));

  late Map<String, double> lowerLimits = widget.keysNDefaults.map(
    (String key, double value) => MapEntry<String, double>(
      key,
      value * widget.min,
    ),
  );

  late bool atMin = lowerLimits.entries.every((MapEntry<String, double> min) =>
      min.value == EzConfig.getDouble(min.key));

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Minus icon
          IconButton(
            icon: Icon(
              PlatformIcons(context).remove,
              color: atMin ? colorScheme.outline : onBackground,
              size: style?.fontSize,
            ),
            onPressed: atMin
                ? doNothing
                : () async {
                    bool somethingChanged = false;

                    for (final MapEntry<String, double> limit
                        in lowerLimits.entries) {
                      final double currValue = EzConfig.getDouble(limit.key) ??
                          widget.keysNDefaults[limit.key]!;

                      if (currValue == limit.value) continue;

                      final double newValue = currValue * (1 - widget.delta);

                      if (newValue > limit.value) {
                        somethingChanged =
                            await EzConfig.setDouble(limit.key, newValue);
                      } else {
                        somethingChanged =
                            await EzConfig.setDouble(limit.key, limit.value);
                      }
                    }

                    setState(() {});
                    widget.notifierCallback(somethingChanged);
                  },
            tooltip: '${l10n.tsDecrease} ${widget.tooltip.toLowerCase()}',
          ),
          pMSpacer,

          // Core
          Icon(
            Icons.text_fields_sharp,
            color: onBackground,
            size: style?.fontSize,
          ),
          pMSpacer,

          // Plus icon
          IconButton(
            icon: Icon(
              PlatformIcons(context).add,
              color: atMax ? colorScheme.outline : onBackground,
              size: style?.fontSize,
            ),
            onPressed: atMax
                ? doNothing
                : () async {
                    bool somethingChanged = false;

                    for (final MapEntry<String, double> limit
                        in upperLimits.entries) {
                      final double currValue = EzConfig.getDouble(limit.key) ??
                          widget.keysNDefaults[limit.key]!;

                      if (currValue == limit.value) continue;

                      final double newValue = currValue * (1 + widget.delta);

                      if (newValue < limit.value) {
                        somethingChanged =
                            await EzConfig.setDouble(limit.key, newValue);
                      } else {
                        somethingChanged =
                            await EzConfig.setDouble(limit.key, limit.value);
                      }
                    }

                    setState(() {});
                    widget.notifierCallback(somethingChanged);
                  },
            tooltip: '${l10n.tsIncrease} ${widget.tooltip.toLowerCase()}',
          ),
        ],
      ),
    );
  }
}
