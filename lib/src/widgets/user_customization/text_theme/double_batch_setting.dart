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

  /// Use this to live update the [TextStyle] on your UI
  final void Function(double) notifierCallback;

  final String tooltip;

  /// Amount to scale on each click, defaults to 0.1
  /// aka 10%
  final double delta;

  final TextStyle? style;

  /// Optionally provide a [String] for setting the [EzFontDoubleSetting]s size
  /// From the results of [measureText] on [sizingString]
  final String? sizingString;

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
    this.sizingString,
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
      Theme.of(context).textTheme.bodyLarge?.copyWith(color: onBackground);

  late final Size sizeLimit = measureText(
    widget.sizingString ?? widget.max.toString(),
    style: style,
    context: context,
  );

  late final double formFieldWidth = sizeLimit.width + padding;
  late final double formFieldHeight = sizeLimit.height * lineHeight + padding;

  // Define build data //

  late final Map<String, double> startingScales = widget.keysNDefaults.map(
    (String key, double value) {
      return MapEntry<String, double>(key, EzConfig.getDouble(key)! / value);
    },
  );

  late bool isUniform = startingScales.values
      .every((double scale) => scale == startingScales.values.first);

  late double currScale = isUniform
      ? startingScales.values.first
      : startingScales.values.reduce((double a, double b) => a + b) /
          startingScales.values.length;

  // Define custom functions //

  /// Only activated if the user has already edited the text sizes in the advanced settings, and the new scales aren't uniform
  // Confirm that the user wants to continue with batch editing, which will force uniformity
  Future<bool> confirmBatchOverride() async {
    return await showPlatformDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        void onConfirm() => Navigator.of(dialogContext).pop(true);

        void onDeny() => Navigator.of(dialogContext).pop(false);

        return EzAlertDialog(
          title: Text(
            l10n.ssLanguages,
            textAlign: TextAlign.center,
          ),
          content: Text(
            l10n.tsBatchOverride(l10n.tsFontSize),
            textAlign: TextAlign.center,
          ),
          materialActions: ezMaterialActions(
            context: dialogContext,
            onConfirm: onConfirm,
            onDeny: onDeny,
          ),
          cupertinoActions: ezCupertinoActions(
            context: dialogContext,
            onConfirm: onConfirm,
            onDeny: onDeny,
          ),
          needsClose: false,
        );
      },
    );
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Minus icon
        IconButton(
          icon: Icon(
            PlatformIcons(context).remove,
            color:
                (currScale < widget.max) ? onBackground : colorScheme.outline,
          ),
          onPressed: () async {
            if (!isUniform) {
              final bool confirm = await confirmBatchOverride();

              if (confirm) {
                isUniform = true;
              } else {
                return;
              }
            }

            if (currScale > widget.min) {
              final double deltaDiff = (currScale * 100) % (widget.delta * 100);
              if (deltaDiff == 0) {
                currScale -= widget.delta;
              } else {
                currScale -= deltaDiff;
              }
              widget.notifierCallback(currScale);

              for (final MapEntry<String, double> entry
                  in widget.keysNDefaults.entries) {
                EzConfig.setDouble(entry.key, entry.value * currScale);
              }
            }

            setState(() {});
          },
          tooltip: '${l10n.tsDecrease} ${widget.tooltip.toLowerCase()}',
        ),

        // Core icon
        pMSpacer,
        Tooltip(
          message: widget.tooltip,
          child: const Icon(Icons.text_fields_sharp),
        ),
        pMSpacer,

        // Plus icon
        IconButton(
          icon: Icon(
            PlatformIcons(context).add,
            color:
                (currScale < widget.max) ? onBackground : colorScheme.outline,
          ),
          onPressed: () async {
            if (!isUniform) {
              final bool confirm = await confirmBatchOverride();

              if (confirm) {
                isUniform = true;
              } else {
                return;
              }
            }

            if (currScale < widget.max) {
              final double deltaDiff = (currScale * 100) % (widget.delta * 100);
              if (deltaDiff == 0) {
                currScale += widget.delta;
              } else {
                currScale += (widget.delta * 100 - deltaDiff);
              }
              widget.notifierCallback(currScale);

              for (final MapEntry<String, double> entry
                  in widget.keysNDefaults.entries) {
                EzConfig.setDouble(entry.key, entry.value * currScale);
              }
            }

            setState(() {});
          },
          tooltip: '${l10n.tsIncrease} ${widget.tooltip.toLowerCase()}',
        ),
      ],
    );
  }
}
