/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';

class EzCheckbox extends StatelessWidget {
  /// Defaults to [EdgeInsets.all] with [EzConfig.marginVal] when [scale] > 1.1
  final EdgeInsetsGeometry? padding;

  /// [Checkbox.value] passthrough
  final bool? value;

  /// [Checkbox.onChanged] passthrough
  final ValueChanged<bool?>? onChanged;

  /// Defaults to [ezIconRatio]
  final double? scale;

  /// [Checkbox.isError] passthrough
  final bool isError;

  /// [Checkbox.semanticLabel] passthrough
  final String? semanticLabel;

  /// [Checkbox] with custom styling and scaling
  const EzCheckbox({
    super.key,
    this.padding,
    this.value,
    this.onChanged,
    this.scale,
    this.isError = false,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final double ratio = scale ?? ezIconRatio();

    return Padding(
      padding: ratio > 1.1
          ? padding ?? EzInsets.wrap(EzConfig.marginVal)
          : EdgeInsets.zero,
      child: Transform.scale(
        scale: max(1.0, ratio),
        child: Checkbox(
          value: value,
          onChanged: onChanged,
          isError: isError,
          semanticLabel: semanticLabel,
        ),
      ),
    );
  }
}

class EzCheckboxPair extends StatelessWidget {
  /// [EzRow.reverseHands] passthrough
  final bool reverseHands;

  /// [EzRow.mainAxisSize] passthrough
  final MainAxisSize mainAxisSize;

  /// [EzRow.mainAxisAlignment] passthrough
  final MainAxisAlignment mainAxisAlignment;

  /// [EzRow.crossAxisAlignment] passthrough
  final CrossAxisAlignment crossAxisAlignment;

  /// [EzText.data] passthrough
  final String text;

  /// [EzText.useSurface] passthrough
  /// true: [ColorScheme.surface]
  /// false: [ColorScheme.surfaceContainer]
  /// null: [ColorScheme.surfaceDim]
  final bool? useSurface;

  /// [EzText.style] passthrough
  final TextStyle? style;

  /// [EzText.textAlign] passthrough
  final TextAlign? textAlign;

  /// [EzText.semanticsLabel] passthrough
  final String? semanticsLabel;

  /// [EzText.backgroundColor] passthrough
  final Color? backgroundColor;

  /// Defaults to [ezIconRatio]
  final double? scale;

  /// Defaults to [EdgeInsets.all] with [EzConfig.marginVal] when [scale] > 1.1
  final EdgeInsetsGeometry? padding;

  /// [Checkbox.value] passthrough
  final bool? value;

  /// [Checkbox.onChanged] passthrough
  final ValueChanged<bool?>? onChanged;

  /// [Checkbox.isError] passthrough
  final bool isError;

  /// [Checkbox.semanticLabel] passthrough
  final String? semanticLabel;

  const EzCheckboxPair({
    super.key,
    // EzRow
    this.reverseHands = true,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,

    // EzText
    required this.text,
    this.useSurface = false,
    this.style,
    this.textAlign,
    this.semanticsLabel,
    this.backgroundColor,

    // EzCheckbox
    this.padding,
    this.value,
    this.onChanged,
    this.scale,
    this.isError = false,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) => EzRow(
        reverseHands: reverseHands,
        mainAxisSize: mainAxisSize,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: <Widget>[
          Flexible(
            child: EzText(
              text,
              useSurface: useSurface,
              style: style,
              textAlign: textAlign,
              semanticsLabel: semanticsLabel,
              backgroundColor: backgroundColor,
            ),
          ),
          EzCheckbox(
            scale: scale,
            padding: padding,
            value: value,
            onChanged: onChanged,
            isError: isError,
            semanticLabel: semanticLabel,
          ),
        ],
      );
}
