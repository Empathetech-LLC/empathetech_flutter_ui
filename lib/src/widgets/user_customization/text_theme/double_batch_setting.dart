/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
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
    this.delta = 0.1,
    this.iconSize,
  });

  // Define the build data //

  static const List<String> keys = <String>[
    displayFontSizeKey,
    headlineFontSizeKey,
    titleFontSizeKey,
    bodyFontSizeKey,
    labelFontSizeKey,
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
      case displayFontSizeKey:
        return displayProvider;
      case headlineFontSizeKey:
        return headlineProvider;
      case titleFontSizeKey:
        return titleProvider;
      case bodyFontSizeKey:
        return bodyProvider;
      case labelFontSizeKey:
        return labelProvider;
      default:
        throw Exception('Invalid key: $key');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final EzMargin ezRowMargin = EzMargin(vertical: false);

    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Return the build //

    final EFUILang l10n = ezL10n(context);

    return Tooltip(
      message: l10n.tsFontSize,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Minus icon
          atMin
              ? EzIconButton(
                  enabled: false,
                  tooltip: l10n.gMinimum,
                  iconSize: iconSize ?? titleProvider.value.fontSize,
                  icon: Icon(
                    PlatformIcons(context).remove,
                    color: colorScheme.outline,
                  ),
                )
              : EzIconButton(
                  onPressed: () async {
                    for (final String key in keys) {
                      final EzTextStyleProvider provider = providerFromKey(key);

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
                  },
                  tooltip: '${l10n.gDecrease} ${l10n.tsFontSize.toLowerCase()}',
                  iconSize: iconSize ?? titleProvider.value.fontSize,
                  icon: Icon(PlatformIcons(context).remove),
                ),
          ezRowMargin,

          // Core
          GestureDetector(
            onLongPress: () async {
              for (final String key in keys) {
                final EzTextStyleProvider provider = providerFromKey(key);

                await EzConfig.setDouble(key, fontSizeDefaults[key]!);
                provider.resize(fontSizeDefaults[key]!);
              }
            },
            child: Icon(
              Icons.text_fields_sharp,
              size: iconSize ?? titleProvider.value.fontSize,
              color: colorScheme.onSurface,
            ),
          ),
          ezRowMargin,

          // Plus icon
          atMax
              ? EzIconButton(
                  enabled: false,
                  tooltip: l10n.gMaximum,
                  iconSize: iconSize ?? titleProvider.value.fontSize,
                  icon: Icon(
                    PlatformIcons(context).add,
                    color: colorScheme.outline,
                  ),
                )
              : EzIconButton(
                  onPressed: () async {
                    for (final String key in keys) {
                      final EzTextStyleProvider provider = providerFromKey(key);

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
                  },
                  tooltip: '${l10n.gIncrease} ${l10n.tsFontSize.toLowerCase()}',
                  iconSize: iconSize ?? titleProvider.value.fontSize,
                  icon: Icon(PlatformIcons(context).add),
                ),
        ],
      ),
    );
  }
}
