/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// 0.1
const double _delta = 0.1;

const List<String> _darkKeys = <String>[
  darkDisplayFontSizeKey,
  darkHeadlineFontSizeKey,
  darkTitleFontSizeKey,
  darkBodyFontSizeKey,
  darkLabelFontSizeKey,
];

const List<String> _lightKeys = <String>[
  lightDisplayFontSizeKey,
  lightHeadlineFontSizeKey,
  lightTitleFontSizeKey,
  lightBodyFontSizeKey,
  lightLabelFontSizeKey,
];

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

  /// Amount to scale (relative to the default value) on each click
  final double delta;

  final double? _iconSize;

  /// Must have each iteration of [EzTextStyleProvider] in this parent's widget tree
  /// Updates all [TextStyle.fontSize]s at once by [delta], calculated individually based on each [TextStyle.fontSize]s default value
  /// Follows [EzConfig] limits: [minDisplay], [minHeadline], [maxTitle], etc.
  EzFontDoubleBatchSetting({
    super.key,
    required this.displayProvider,
    required this.headlineProvider,
    required this.titleProvider,
    required this.bodyProvider,
    required this.labelProvider,
    this.delta = _delta,
  }) : _iconSize = titleProvider.value.fontSize;

  // Define the build data //

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

  // Return the build //

  @override
  Widget build(BuildContext context) => Tooltip(
        message: EzConfig.l10n.tsFontSize,
        child: EzRow(
          reverseHands: false,
          children: <Widget>[
            // Minus icon
            atMin
                ? EzIconButton(
                    enabled: false,
                    tooltip: EzConfig.l10n.gMinimum,
                    iconSize: _iconSize,
                    icon: Icon(
                      Icons.remove,
                      color: EzConfig.colors.outline,
                    ),
                  )
                : EzIconButton(
                    onPressed: () async {
                      if (EzConfig.updateBoth || EzConfig.isDark) {
                        for (final String key in _darkKeys) {
                          final EzTextStyleProvider provider = providerFromKey(key);

                          final double currSize = provider.value.fontSize ?? EzConfig.get(key);

                          if (currSize != fontSizeMins[key]) {
                            final double newSize = currSize - (fontSizeDefaults[key]! * delta);
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

                      if (EzConfig.updateBoth || !EzConfig.isDark) {
                        for (final String key in _lightKeys) {
                          final EzTextStyleProvider provider = providerFromKey(key);

                          final double currSize = provider.value.fontSize ?? EzConfig.get(key);

                          if (currSize != fontSizeMins[key]) {
                            final double newSize = currSize - (fontSizeDefaults[key]! * delta);
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

                      if (context.mounted) {
                        EzConfig.pingRebuild(ezTextRebuildCheck(context));
                      }
                    },
                    tooltip: '${EzConfig.l10n.gDecrease} ${EzConfig.l10n.tsFontSize.toLowerCase()}',
                    iconSize: _iconSize,
                    icon: const Icon(Icons.remove),
                  ),
            EzConfig.rowMargin,

            // Core
            GestureDetector(
              onLongPress: () async {
                if (EzConfig.updateBoth || EzConfig.isDark) {
                  for (final String key in _darkKeys) {
                    final EzTextStyleProvider provider = providerFromKey(key);

                    await EzConfig.setDouble(key, fontSizeDefaults[key]!);
                    provider.resize(fontSizeDefaults[key]!);
                  }
                }

                if (EzConfig.updateBoth || !EzConfig.isDark) {
                  for (final String key in _lightKeys) {
                    final EzTextStyleProvider provider = providerFromKey(key);

                    await EzConfig.setDouble(key, fontSizeDefaults[key]!);
                    provider.resize(fontSizeDefaults[key]!);
                  }
                }

                if (context.mounted) {
                  EzConfig.pingRebuild(ezTextRebuildCheck(context));
                }
              },
              child: Icon(
                Icons.text_fields_sharp,
                size: _iconSize,
                color: EzConfig.colors.onSurface,
              ),
            ),
            EzConfig.rowMargin,

            // Plus icon
            atMax
                ? EzIconButton(
                    enabled: false,
                    tooltip: EzConfig.l10n.gMaximum,
                    iconSize: _iconSize,
                    icon: Icon(
                      Icons.add,
                      color: EzConfig.colors.outline,
                    ),
                  )
                : EzIconButton(
                    onPressed: () async {
                      if (EzConfig.updateBoth || EzConfig.isDark) {
                        for (final String key in _darkKeys) {
                          final EzTextStyleProvider provider = providerFromKey(key);

                          final double currSize = provider.value.fontSize ?? EzConfig.get(key);

                          if (currSize != fontSizeMaxes[key]) {
                            final double newSize = currSize + (fontSizeDefaults[key]! * delta);
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

                      if (EzConfig.updateBoth || !EzConfig.isDark) {
                        for (final String key in _lightKeys) {
                          final EzTextStyleProvider provider = providerFromKey(key);

                          final double currSize = provider.value.fontSize ?? EzConfig.get(key);

                          if (currSize != fontSizeMaxes[key]) {
                            final double newSize = currSize + (fontSizeDefaults[key]! * delta);
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

                      if (context.mounted) {
                        EzConfig.pingRebuild(ezTextRebuildCheck(context));
                      }
                    },
                    tooltip: '${EzConfig.l10n.gIncrease} ${EzConfig.l10n.tsFontSize.toLowerCase()}',
                    iconSize: _iconSize,
                    icon: const Icon(Icons.add),
                  ),
          ],
        ),
      );
}
