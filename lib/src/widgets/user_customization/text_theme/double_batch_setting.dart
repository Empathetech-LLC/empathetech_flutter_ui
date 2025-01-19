/* empathetech_flutter_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzFontDoubleBatchSetting extends StatefulWidget {
  /// Amount to scale on each click
  final double delta;

  /// Defaults to [EzTitleStyleProvider.value]s [TextStyle.fontSize]
  final double? iconSize;

  /// Must have each iteration of [EzTextStyleProvider] in this parent's widget tree
  /// Updates all [TextStyle.fontSize]s at once by [delta]
  /// Follows [EzConfig] limits: [minDisplay], [minHeadline], [maxTitle], etc.
  const EzFontDoubleBatchSetting({super.key, this.delta = 0.1, this.iconSize});

  @override
  State<EzFontDoubleBatchSetting> createState() =>
      _FontDoubleBatchSettingState();
}

class _FontDoubleBatchSettingState extends State<EzFontDoubleBatchSetting> {
  // Gather the theme data //

  late final EFUILang l10n = EFUILang.of(context)!;

  late final EzDisplayStyleProvider displayProvider;
  late final EzHeadlineStyleProvider headlineProvider;
  late final EzTitleStyleProvider titleProvider;
  late final EzBodyStyleProvider bodyProvider;
  late final EzLabelStyleProvider labelProvider;

  static const List<String> keys = <String>[
    displayFontSizeKey,
    headlineFontSizeKey,
    titleFontSizeKey,
    bodyFontSizeKey,
    labelFontSizeKey,
  ];

  late final ColorScheme colorScheme = Theme.of(context).colorScheme;

  late final EzSpacer pMSpacer = EzMargin(vertical: false);

  // Define the build data //

  late bool atMax = fontSizeMaxes.entries.every(
    (MapEntry<String, double> max) => max.value == EzConfig.get(max.key),
  );

  late bool atMin = fontSizeMins.entries.every(
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

  // Initialize the build //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    displayProvider = context.watch<EzDisplayStyleProvider>();
    headlineProvider = context.watch<EzHeadlineStyleProvider>();
    titleProvider = context.watch<EzTitleStyleProvider>();
    bodyProvider = context.watch<EzBodyStyleProvider>();
    labelProvider = context.watch<EzLabelStyleProvider>();
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: l10n.tsFontSize,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Minus icon
          atMin
              ? IconButton(
                  style: IconButton.styleFrom(
                    side: BorderSide(color: colorScheme.outlineVariant),
                    overlayColor: colorScheme.outline,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: doNothing,
                  tooltip: 'Minimum',
                  icon: Icon(
                    PlatformIcons(context).remove,
                    size: widget.iconSize ?? titleProvider.value.fontSize,
                    color: colorScheme.outline,
                  ),
                )
              : IconButton(
                  onPressed: () async {
                    for (final String key in keys) {
                      final EzTextStyleProvider provider = providerFromKey(key);

                      final double currSize =
                          provider.value.fontSize ?? EzConfig.get(key);

                      if (currSize != fontSizeMins[key]) {
                        final double newSize = currSize * (1 - widget.delta);
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
                    setState(() {});
                  },
                  tooltip:
                      '${l10n.tsDecrease} ${l10n.tsFontSize.toLowerCase()}',
                  icon: Icon(
                    PlatformIcons(context).remove,
                    size: widget.iconSize ?? titleProvider.value.fontSize,
                  ),
                ),
          pMSpacer,

          // Core
          Icon(
            Icons.text_fields_sharp,
            size: widget.iconSize ?? titleProvider.value.fontSize,
            color: colorScheme.onSurface,
          ),
          pMSpacer,

          // Plus icon
          atMax
              ? IconButton(
                  style: IconButton.styleFrom(
                    side: BorderSide(color: colorScheme.outlineVariant),
                    overlayColor: colorScheme.outline,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: doNothing,
                  tooltip: 'Maximum',
                  icon: Icon(
                    PlatformIcons(context).add,
                    size: widget.iconSize ?? titleProvider.value.fontSize,
                    color: colorScheme.outline,
                  ),
                )
              : IconButton(
                  onPressed: () async {
                    for (final String key in keys) {
                      final EzTextStyleProvider provider = providerFromKey(key);

                      final double currSize =
                          provider.value.fontSize ?? EzConfig.get(key);

                      if (currSize != fontSizeMaxes[key]) {
                        final double newSize = currSize * (1 + widget.delta);
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
                    setState(() {});
                  },
                  tooltip:
                      '${l10n.tsIncrease} ${l10n.tsFontSize.toLowerCase()}',
                  icon: Icon(
                    PlatformIcons(context).add,
                    size: widget.iconSize ?? titleProvider.value.fontSize,
                  ),
                ),
        ],
      ),
    );
  }
}
