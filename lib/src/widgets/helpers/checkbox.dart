/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter/material.dart';

class EzCheckbox extends StatelessWidget {
  /// Optional override, defaults to...
  /// Current [TextTheme.titleLarge] fontSize / [defaultTitleSize]
  final double? scale;

  /// Optional override, defaults to [EdgeInsets.all] with [EzConfig]s [marginKey]
  /// iff [scale] > 1.0
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
    late final double ratio = scale ??
        (Theme.of(context).textTheme.titleLarge?.fontSize ?? defaultTitleSize) /
            defaultTitleSize;

    return Transform.scale(
      scale: ratio,
      child: Padding(
        padding: ratio > 1.0
            ? padding ?? EdgeInsets.all(EzConfig.get(marginKey))
            : EdgeInsets.zero,
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
