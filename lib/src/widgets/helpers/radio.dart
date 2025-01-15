/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter/material.dart';

class EzRadio<T> extends StatelessWidget {
  /// Optional override, defaults to...
  /// Current [EzConfig]s [iconSizeKey] / [defaultIconSize]
  final double? scale;

  /// Optional override, defaults to [EdgeInsets.all] with [EzConfig]s [marginKey]
  /// iff [scale] > 1.1
  final EdgeInsetsGeometry? padding;

  /// [Radio.value] passthrough
  final T value;

  /// [Radio.groupValue] passthrough
  final T? groupValue;

  /// [Radio.onChanged] passthrough
  final ValueChanged<T?>? onChanged;

  /// [Radio.mouseCursor] passthrough
  final MouseCursor? mouseCursor;

  /// [Radio.toggleable] passthrough
  final bool toggleable;

  /// [Radio.activeColor] passthrough
  final Color? activeColor;

  /// [Radio.focusColor] passthrough
  final Color? focusColor;

  /// [Radio.hoverColor] passthrough
  final Color? hoverColor;

  /// [Radio.splashRadius] passthrough
  final double? splashRadius;

  /// [Radio.materialTapTargetSize] passthrough
  final MaterialTapTargetSize? materialTapTargetSize;

  /// [Radio.visualDensity] passthrough
  final VisualDensity? visualDensity;

  /// [Radio.focusNode] passthrough
  final FocusNode? focusNode;

  /// [Radio.autofocus] passthrough
  final bool autofocus;

  const EzRadio({
    super.key,
    this.scale,
    this.padding,
    required this.value,
    this.groupValue,
    this.onChanged,
    this.mouseCursor,
    this.toggleable = false,
    this.activeColor,
    this.focusColor,
    this.hoverColor,
    this.splashRadius,
    this.materialTapTargetSize,
    this.visualDensity,
    this.focusNode,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    final double ratio = scale ??
        (EzConfig.get(iconSizeKey) ?? defaultIconSize) / defaultIconSize;

    return Padding(
      padding: ratio > 1.1
          ? padding ?? EzInsets.wrap(EzConfig.get(marginKey))
          : EdgeInsets.zero,
      child: Transform.scale(
        scale: ratio,
        child: Radio<T>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          mouseCursor: mouseCursor,
          toggleable: toggleable,
          activeColor: activeColor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          splashRadius: splashRadius,
          materialTapTargetSize: materialTapTargetSize,
          visualDensity: visualDensity,
          focusNode: focusNode,
          autofocus: autofocus,
        ),
      ),
    );
  }
}
