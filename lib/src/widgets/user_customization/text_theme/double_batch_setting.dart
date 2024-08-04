/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzFontDoubleBatchSetting extends StatefulWidget {
  /// Maximum scale factor, calculated from each provider's relevant [EzConfig.defaults] value
  final double min;

  /// Minimum scale factor, calculated from each provider's relevant [EzConfig.defaults] value
  final double max;

  /// Amount to scale on each click, defaults to 0.1
  /// aka 10%
  final double delta;

  /// Must have each iteration of [BaseTextStyleProvider] in this parent's widget tree
  /// Updates all font size at once by [delta] percent, limited by [min] and [max]
  const EzFontDoubleBatchSetting({
    super.key,
    required this.min,
    required this.max,
    this.delta = 0.1,
  });

  @override
  State<EzFontDoubleBatchSetting> createState() =>
      _FontDoubleBatchSettingState();
}

class _FontDoubleBatchSettingState extends State<EzFontDoubleBatchSetting> {
  // Gather the theme data //

  late final EFUILang l10n = EFUILang.of(context)!;

  late final DisplayTextStyleProvider displayProvider;
  late final HeadlineTextStyleProvider headlineProvider;
  late final TitleTextStyleProvider titleProvider;
  late final BodyTextStyleProvider bodyProvider;
  late final LabelTextStyleProvider labelProvider;

  static const List<String> keys = <String>[
    displayFontSizeKey,
    headlineFontSizeKey,
    titleFontSizeKey,
    bodyFontSizeKey,
    labelFontSizeKey,
  ];

  late final Color onBackground = Theme.of(context).colorScheme.onSurface;
  late final Color outlineColor = Theme.of(context).colorScheme.outline;

  late final EzSpacer pMSpacer = EzSpacer(
    space: EzConfig.get(paddingKey) / 4,
    vertical: false,
  );

  // Define the build data //

  late final Map<String, double> upperLimits = <String, double>{
    for (final String key in keys) key: EzConfig.getDefault(key) * widget.max,
  };

  late bool atMax = upperLimits.entries.every(
    (MapEntry<String, double> max) => max.value == EzConfig.get(max.key),
  );

  late final Map<String, double> lowerLimits = <String, double>{
    for (final String key in keys) key: EzConfig.getDefault(key) * widget.min,
  };

  late bool atMin = lowerLimits.entries.every(
    (MapEntry<String, double> min) => min.value == EzConfig.get(min.key),
  );

  // Define custom functions //

  BaseTextStyleProvider providerFromKey(String key) {
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
    displayProvider = context.watch<DisplayTextStyleProvider>();
    headlineProvider = context.watch<HeadlineTextStyleProvider>();
    titleProvider = context.watch<TitleTextStyleProvider>();
    bodyProvider = context.watch<BodyTextStyleProvider>();
    labelProvider = context.watch<LabelTextStyleProvider>();
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
          IconButton(
            icon: Icon(
              PlatformIcons(context).remove,
              color: atMin ? outlineColor : onBackground,
              size: bodyProvider.value.fontSize,
            ),
            onPressed: atMin
                ? doNothing
                : () async {
                    for (final String key in keys) {
                      final BaseTextStyleProvider provider =
                          providerFromKey(key);

                      final double currSize =
                          provider.value.fontSize ?? EzConfig.get(key);

                      if (currSize != lowerLimits[key]) {
                        final double newSize = currSize * (1 - widget.delta);
                        final double sizeLimit = lowerLimits[key]!;

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
            tooltip: '${l10n.tsDecrease} ${l10n.tsFontSize.toLowerCase()}',
          ),
          pMSpacer,

          // Core
          Icon(
            Icons.text_fields_sharp,
            color: onBackground,
            size: bodyProvider.value.fontSize,
          ),
          pMSpacer,

          // Plus icon
          IconButton(
            icon: Icon(
              PlatformIcons(context).add,
              color: atMax ? outlineColor : onBackground,
              size: bodyProvider.value.fontSize,
            ),
            onPressed: atMax
                ? doNothing
                : () async {
                    for (final String key in keys) {
                      final BaseTextStyleProvider provider =
                          providerFromKey(key);

                      final double currSize =
                          provider.value.fontSize ?? EzConfig.get(key);

                      if (currSize != upperLimits[key]) {
                        final double newSize = currSize * (1 + widget.delta);
                        final double sizeLimit = upperLimits[key]!;

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
            tooltip: '${l10n.tsIncrease} ${l10n.tsFontSize.toLowerCase()}',
          ),
        ],
      ),
    );
  }
}
