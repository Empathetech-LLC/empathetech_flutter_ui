/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzTextBackground extends StatelessWidget {
  /// The [Text] that needs a background
  final Widget text;

  /// Defaults to [EzInsets.wrap]
  final EdgeInsets? margin;

  /// Defaults to [ezRoundEdge]
  final BorderRadiusGeometry? borderRadius;

  /// Will use surface container if false
  final bool useSurface;

  /// Optional background color override
  /// Can ignore [useSurface] if this is set
  final Color? backgroundColor;

  /// Create a [Container] for your [text] with a background color that automatically responds to [textBackgroundOKey]
  const EzTextBackground(
    this.text, {
    super.key,
    this.margin,
    this.borderRadius,
    this.useSurface = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    late final String oKey =
        isDarkTheme(context) ? darkTextBackgroundOKey : lightTextBackgroundOKey;

    late final double percent =
        EzConfig.get(oKey) ?? EzConfig.getDefault(oKey) ?? 0.0;

    final Color color = (backgroundColor == null)
        ? useSurface
            ? Theme.of(context).colorScheme.surface.withOpacity(percent)
            : Theme.of(context)
                .colorScheme
                .surfaceContainer
                .withOpacity(percent)
        : backgroundColor!;

    return Container(
      padding: margin ?? EzInsets.wrap(EzConfig.get(marginKey)),
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius ?? ezRoundEdge,
      ),
      child: text,
    );
  }
}
