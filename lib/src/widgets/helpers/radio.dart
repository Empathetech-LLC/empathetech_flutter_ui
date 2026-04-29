/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';

class EzRadio<T> extends StatelessWidget {
  /// Defaults to [EdgeInsets.all] with [EzConfig.marginVal] when [ezIconRatio] > 1.1
  final EdgeInsetsGeometry? padding;

  /// [Radio.value] passthrough
  final T value;

  /// [Radio.toggleable] passthrough
  final bool toggleable;

  final double _scale;

  /// [Radio] with custom styling and scaling
  EzRadio({
    super.key,
    this.padding,
    required this.value,
    this.toggleable = false,
  }) : _scale = ezIconRatio();

  @override
  Widget build(BuildContext context) => Container(
        padding: _scale > 1.1 ? padding ?? EzInsets.wrap(EzConfig.marginVal) : EdgeInsets.zero,
        decoration: BoxDecoration(
          color: EzConfig.colors.surface.withValues(alpha: EzConfig.textBackgroundOpacity),
          shape: BoxShape.circle,
        ),
        child: Transform.scale(
          scale: max(1.0, _scale),
          child: Radio<T>(value: value, toggleable: toggleable),
        ),
      );
}
