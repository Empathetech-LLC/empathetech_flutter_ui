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

  /// [Radio.toggleable] passthrough
  final bool toggleable;

  /// [Radio] with custom styling and scaling
  const EzRadio({
    super.key,
    this.scale,
    this.padding,
    required this.value,
    this.toggleable = false,
  });

  @override
  Widget build(BuildContext context) {
    final double ratio = scale ?? ezIconRatio();

    return Container(
      padding: ratio > 1.1 ? padding ?? EzInsets.wrap(EzConfig.marginVal) : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: EzConfig.colors.surface.withValues(alpha: EzConfig.textBackgroundOpacity),
        shape: BoxShape.circle,
      ),
      child: Transform.scale(
        scale: max(1.0, ratio),
        child: Radio<T>(value: value, toggleable: toggleable),
      ),
    );
  }
}
