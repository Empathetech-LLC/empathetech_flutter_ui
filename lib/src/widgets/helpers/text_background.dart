/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzTextBackground extends StatelessWidget {
  /// The [Text] that needs a background
  final Widget text;

  /// Defaults to [EdgeInsets.all] => [EzConfig.get] => [marginKey]
  final EdgeInsets? margin;

  /// Will use surface container if false
  final bool useSurface;

  /// Optional background color override
  /// Can ignore [useSurface] if this is set
  final Color? backgroundColor;

  /// Create a [Container] for your [text] with a su
  const EzTextBackground(
    this.text, {
    super.key,
    this.margin,
    this.useSurface = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final double percent = EzConfig.get(textBackgroundOKey) ??
        EzConfig.getDefault(textBackgroundOKey);

    final Color color = (backgroundColor == null)
        ? useSurface
            ? Theme.of(context).colorScheme.surface.withOpacity(percent)
            : Theme.of(context)
                .colorScheme
                .surfaceContainer
                .withOpacity(percent)
        : backgroundColor!;

    return Container(
      padding: margin ?? EzMargin.col(),
      decoration: BoxDecoration(
        color: color,
        borderRadius: ezRoundEdge,
      ),
      child: text,
    );
  }
}
