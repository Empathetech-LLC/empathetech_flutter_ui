/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzFontDoubleSetting extends StatefulWidget {
  final String configKey;
  final double min;
  final double max;

  /// Use this to live update the [TextStyle] on your UI
  final void Function(double) notifierCallback;

  final String tooltip;

  /// Optionally provide a [String] for setting the [EzFontDoubleSetting]s size
  /// From the results of [measureText] on [sizingString]
  final String? sizingString;

  /// Standardized tool for updating double [TextStyle] values for the passed [configKey]
  /// For example: [TextStyle.letterSpacing]
  const EzFontDoubleSetting({
    super.key,
    required this.configKey,
    required this.min,
    required this.max,
    required this.tooltip,
    required this.notifierCallback,
    this.sizingString,
  });

  @override
  State<EzFontDoubleSetting> createState() => _FontDoubleSettingState();
}

class _FontDoubleSettingState extends State<EzFontDoubleSetting> {
  // Gather the theme data //

  late double currValue = EzConfig.get(widget.configKey);

  late final double padding = EzConfig.get(paddingKey);
  late final double lineHeight = EzConfig.get(bodyFontHeightKey) ?? 1.5;

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final TextStyle? bodyStyle = Theme.of(context)
        .textTheme
        .bodyLarge
        ?.copyWith(color: Theme.of(context).colorScheme.onBackground);

    final Size sizeLimit = measureText(
      widget.sizingString ?? widget.max.toString(),
      style: bodyStyle,
      context: context,
    );

    return Tooltip(
      message: widget.tooltip,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: sizeLimit.width + padding,
          maxHeight: sizeLimit.height * lineHeight + padding,
        ),
        child: PlatformTextFormField(
          keyboardType: TextInputType.number,
          initialValue: currValue.toString(),
          onChanged: (String stringVal) {
            final double? doubleVal = double.tryParse(stringVal);
            if (doubleVal == null) return;

            setState(() {
              currValue = doubleVal;
              widget.notifierCallback(doubleVal);
            });
            EzConfig.setDouble(widget.configKey, doubleVal);
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (String? value) {
            if (value == null) return null;

            final double? doubleVale = double.tryParse(value);

            if (doubleVale == null ||
                doubleVale < widget.min ||
                doubleVale > widget.max) {
              return '${widget.min}-${widget.max}';
            }

            return null;
          },
          style: bodyStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
