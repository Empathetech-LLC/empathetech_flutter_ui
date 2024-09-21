/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzTextBackground extends StatelessWidget {
  /// The [Text] that needs a background
  final Widget text;

  /// Will use surface container if false
  final bool useSurface;

  /// Create a [Container] for your [text] with a su
  const EzTextBackground(this.text, {this.useSurface = true, super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = useSurface
        ? Theme.of(context).colorScheme.surface.withOpacity(0.75)
        : Theme.of(context).colorScheme.surfaceContainer.withOpacity(0.75);

    return Container(
      padding: ezMargin(),
      decoration: BoxDecoration(
        color: color,
        borderRadius: ezRoundEdge,
      ),
      child: text,
    );
  }
}
