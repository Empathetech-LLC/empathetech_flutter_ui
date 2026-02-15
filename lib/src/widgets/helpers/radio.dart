/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';

class EzRadio<T> extends StatelessWidget {
  /// Defaults to max([EzConfig.iconSize] / [EzConfig.getDefault], 1.0)
  final double? scale;

  /// Defaults to [EdgeInsets.all] with [EzConfig.marginVal] when [scale] > 1.1
  final EdgeInsetsGeometry? padding;

  /// [Radio.value] passthrough
  final T value;

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

  /// [Radio] with custom styling and scaling
  const EzRadio({
    super.key,
    this.scale,
    this.padding,
    required this.value,
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
    final double ratio = scale ?? ezIconRatio();

    return Container(
      padding: ratio > 1.1
          ? padding ?? EzInsets.wrap(EzConfig.marginVal)
          : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Theme.of(context)
            .textButtonTheme
            .style
            ?.backgroundColor
            ?.resolve(<WidgetState>{}),
        shape: BoxShape.circle,
      ),
      child: Transform.scale(
        scale: max(1.0, ratio),
        child: Radio<T>(
          value: value,
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
