/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';

class EzCheckbox extends StatelessWidget {
  /// Optional override, defaults to...
  /// Current [EzConfig]s [iconSizeKey] / [defaultIconSize]
  final double? scale;

  /// Optional override, defaults to [EdgeInsets.all] with [EzConfig]s [marginKey]
  /// iff [scale] > 1.1
  final EdgeInsetsGeometry? padding;

  /// [Checkbox.value] passthrough
  final bool? value;

  /// [Checkbox.tristate] passthrough
  final bool tristate;

  /// [Checkbox.onChanged] passthrough
  final ValueChanged<bool?>? onChanged;

  /// [Checkbox.mouseCursor] passthrough
  final MouseCursor? mouseCursor;

  /// [Checkbox.activeColor] passthrough
  final Color? activeColor;

  /// [Checkbox.checkColor] passthrough
  final Color? checkColor;

  /// [Checkbox.focusColor] passthrough
  final Color? focusColor;

  /// [Checkbox.hoverColor] passthrough
  final Color? hoverColor;

  /// [Checkbox.splashRadius] passthrough
  final double? splashRadius;

  /// [Checkbox.materialTapTargetSize] passthrough
  final MaterialTapTargetSize? materialTapTargetSize;

  /// [Checkbox.visualDensity] passthrough
  final VisualDensity? visualDensity;

  /// [Checkbox.focusNode] passthrough
  final FocusNode? focusNode;

  /// [Checkbox.autofocus] passthrough
  final bool autofocus;

  /// [Checkbox.shape] passthrough
  final OutlinedBorder? shape;

  /// [Checkbox.side] passthrough
  final BorderSide? side;

  /// [Checkbox.isError] passthrough
  final bool isError;

  /// [Checkbox.semanticLabel] passthrough
  final String? semanticLabel;

  const EzCheckbox({
    super.key,
    this.scale,
    this.padding,
    this.value,
    this.tristate = false,
    this.onChanged,
    this.mouseCursor,
    this.activeColor,
    this.checkColor,
    this.focusColor,
    this.hoverColor,
    this.splashRadius,
    this.materialTapTargetSize,
    this.visualDensity,
    this.focusNode,
    this.autofocus = false,
    this.shape,
    this.side,
    this.isError = false,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final double ratio = scale ??
        (EzConfig.get(iconSizeKey) ?? defaultIconSize) / defaultIconSize;

    return Padding(
      padding: ratio > 1.1
          ? padding ?? EzInsets.col(EzConfig.get(marginKey))
          : EdgeInsets.zero,
      child: Transform.scale(
        scale: max(1.0, ratio),
        child: Checkbox(
          value: value,
          tristate: tristate,
          onChanged: onChanged,
          mouseCursor: mouseCursor,
          activeColor: activeColor,
          checkColor: checkColor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          splashRadius: splashRadius,
          materialTapTargetSize: materialTapTargetSize,
          visualDensity: visualDensity,
          focusNode: focusNode,
          autofocus: autofocus,
          shape: shape,
          side: side,
          isError: isError,
          semanticLabel: semanticLabel,
        ),
      ),
    );
  }
}
