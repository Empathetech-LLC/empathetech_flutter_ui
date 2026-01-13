/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzFontDoubleBatchSetting extends StatelessWidget {
  /// Required for max/min awareness
  final EzDisplayStyleProvider displayProvider;

  /// Required for max/min awareness
  final EzHeadlineStyleProvider headlineProvider;

  /// Required for max/min awareness
  final EzTitleStyleProvider titleProvider;

  /// Required for max/min awareness
  final EzBodyStyleProvider bodyProvider;

  /// Required for max/min awareness
  final EzLabelStyleProvider labelProvider;

  /// Null will update both theme modes
  /// Quantum computing
  final bool? isDark;

  /// Amount to scale on each click
  final double delta;

  /// Defaults to [EzTitleStyleProvider.value]s [TextStyle.fontSize]
  final double? iconSize;

  /// Must have each iteration of [EzTextStyleProvider] in this parent's widget tree
  /// Updates all [TextStyle.fontSize]s at once by [delta]
  /// Follows [EzConfig] limits: [minDisplay], [minHeadline], [maxTitle], etc.
  EzFontDoubleBatchSetting({
    super.key,
    required this.displayProvider,
    required this.headlineProvider,
    required this.titleProvider,
    required this.bodyProvider,
    required this.labelProvider,
    required this.isDark,
    this.delta = 0.1,
    this.iconSize,
  });

  // Define the build data //

  static const List<String> darkKeys = <String>[
    darkDisplayFontSizeKey,
    darkHeadlineFontSizeKey,
    darkTitleFontSizeKey,
    darkBodyFontSizeKey,
    darkLabelFontSizeKey,
  ];

  static const List<String> lightKeys = <String>[
    lightDisplayFontSizeKey,
    lightHeadlineFontSizeKey,
    lightTitleFontSizeKey,
    lightBodyFontSizeKey,
    lightLabelFontSizeKey,
  ];

  final bool atMax = fontSizeMaxes.entries.every(
    (MapEntry<String, double> max) => max.value == EzConfig.get(max.key),
  );

  final bool atMin = fontSizeMins.entries.every(
    (MapEntry<String, double> min) => min.value == EzConfig.get(min.key),
  );

  // Define custom functions //

  EzTextStyleProvider providerFromKey(String key) {
    switch (key) {
      case darkDisplayFontSizeKey:
      case lightDisplayFontSizeKey:
        return displayProvider;
      case darkHeadlineFontSizeKey:
      case lightHeadlineFontSizeKey:
        return headlineProvider;
      case darkTitleFontSizeKey:
      case lightTitleFontSizeKey:
        return titleProvider;
      case darkBodyFontSizeKey:
      case lightBodyFontSizeKey:
        return bodyProvider;
      case darkLabelFontSizeKey:
      case lightLabelFontSizeKey:
        return labelProvider;
      default:
        throw Exception('Invalid key: $key');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Return the build //

    return Tooltip(
      message: EzConfig.l10n.tsFontSize,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Minus icon
          atMin
              ? EzIconButton(
                  enabled: false,
                  tooltip: EzConfig.l10n.gMinimum,
                  iconSize: iconSize ?? titleProvider.value.fontSize,
                  icon: Icon(
                    PlatformIcons(context).remove,
                    color: colorScheme.outline,
                  ),
                )
              : EzIconButton(
                  onPressed: () async {
                    if (isDark == null || isDark == true) {
                      for (final String key in darkKeys) {
                        final EzTextStyleProvider provider =
                            providerFromKey(key);

                        final double currSize =
                            provider.value.fontSize ?? EzConfig.get(key);

                        if (currSize != fontSizeMins[key]) {
                          final double newSize = currSize * (1 - delta);
                          final double sizeLimit = fontSizeMins[key]!;

                          if (newSize >= sizeLimit) {
                            await EzConfig.setDouble(key, newSize);
                            provider.resize(newSize);
                          } else {
                            await EzConfig.setDouble(key, sizeLimit);
                            provider.resize(sizeLimit);
                          }
                        }
                      }
                    }

                    if (isDark == null || isDark == false) {
                      for (final String key in lightKeys) {
                        final EzTextStyleProvider provider =
                            providerFromKey(key);

                        final double currSize =
                            provider.value.fontSize ?? EzConfig.get(key);

                        if (currSize != fontSizeMins[key]) {
                          final double newSize = currSize * (1 - delta);
                          final double sizeLimit = fontSizeMins[key]!;

                          if (newSize >= sizeLimit) {
                            await EzConfig.setDouble(key, newSize);
                            provider.resize(newSize);
                          } else {
                            await EzConfig.setDouble(key, sizeLimit);
                            provider.resize(sizeLimit);
                          }
                        }
                      }
                    }
                  },
                  tooltip:
                      '${EzConfig.l10n.gDecrease} ${EzConfig.l10n.tsFontSize.toLowerCase()}',
                  iconSize: iconSize ?? titleProvider.value.fontSize,
                  icon: Icon(PlatformIcons(context).remove),
                ),
          EzConfig.layout.rowMargin,

          // Core
          GestureDetector(
            onLongPress: () async {
              if (isDark == null || isDark == true) {
                for (final String key in darkKeys) {
                  final EzTextStyleProvider provider = providerFromKey(key);

                  await EzConfig.setDouble(key, fontSizeDefaults[key]!);
                  provider.resize(fontSizeDefaults[key]!);
                }
              }

              if (isDark == null || isDark == false) {
                for (final String key in lightKeys) {
                  final EzTextStyleProvider provider = providerFromKey(key);

                  await EzConfig.setDouble(key, fontSizeDefaults[key]!);
                  provider.resize(fontSizeDefaults[key]!);
                }
              }
            },
            child: Icon(
              Icons.text_fields_sharp,
              size: iconSize ?? titleProvider.value.fontSize,
              color: colorScheme.onSurface,
            ),
          ),
          EzConfig.layout.rowMargin,

          // Plus icon
          atMax
              ? EzIconButton(
                  enabled: false,
                  tooltip: EzConfig.l10n.gMaximum,
                  iconSize: iconSize ?? titleProvider.value.fontSize,
                  icon: Icon(
                    PlatformIcons(context).add,
                    color: colorScheme.outline,
                  ),
                )
              : EzIconButton(
                  onPressed: () async {
                    if (isDark == null || isDark == true) {
                      for (final String key in darkKeys) {
                        final EzTextStyleProvider provider =
                            providerFromKey(key);

                        final double currSize =
                            provider.value.fontSize ?? EzConfig.get(key);

                        if (currSize != fontSizeMaxes[key]) {
                          final double newSize = currSize * (1 + delta);
                          final double sizeLimit = fontSizeMaxes[key]!;

                          if (newSize <= sizeLimit) {
                            await EzConfig.setDouble(key, newSize);
                            provider.resize(newSize);
                          } else {
                            await EzConfig.setDouble(key, sizeLimit);
                            provider.resize(sizeLimit);
                          }
                        }
                      }
                    }

                    if (isDark == null || isDark == false) {
                      for (final String key in lightKeys) {
                        final EzTextStyleProvider provider =
                            providerFromKey(key);

                        final double currSize =
                            provider.value.fontSize ?? EzConfig.get(key);

                        if (currSize != fontSizeMaxes[key]) {
                          final double newSize = currSize * (1 + delta);
                          final double sizeLimit = fontSizeMaxes[key]!;

                          if (newSize <= sizeLimit) {
                            await EzConfig.setDouble(key, newSize);
                            provider.resize(newSize);
                          } else {
                            await EzConfig.setDouble(key, sizeLimit);
                            provider.resize(sizeLimit);
                          }
                        }
                      }
                    }
                  },
                  tooltip:
                      '${EzConfig.l10n.gIncrease} ${EzConfig.l10n.tsFontSize.toLowerCase()}',
                  iconSize: iconSize ?? titleProvider.value.fontSize,
                  icon: Icon(PlatformIcons(context).add),
                ),
        ],
      ),
    );
  }
}
