/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzSpacer extends StatelessWidget {
  /// Defaults to [EzConfig]s [spacingKey] value
  final double? space;

  /// Whether [space] should be provided to [SizedBox.height]
  final bool vertical;

  /// Whether [space] should be provided to [SizedBox.width]
  final bool horizontal;

  /// [SizedBox] with [space] dimensions for organizing your layout
  const EzSpacer({
    super.key,
    this.space,
    this.vertical = true,
    this.horizontal = true,
  });

  @override
  Widget build(BuildContext context) {
    final double amount = space ?? EzConfig.get(spacingKey);

    return ExcludeSemantics(
      child: SizedBox(
        height: vertical ? amount : null,
        width: horizontal ? amount : null,
      ),
    );
  }
}

class EzMargin extends EzSpacer {
  /// [EzSpacer] with [EzConfig]s [marginKey] space
  EzMargin({
    super.key,
    super.vertical,
    super.horizontal,
  }) : super(space: EzConfig.get(marginKey));
}

class EzSwapSpacer extends StatelessWidget {
  /// Optional [EzSpacer.space] passthrough
  final double? space;

  /// Defaults to [EzSpacer.vertical] => false
  /// When [ScreenSpace.isLimited], it swaps to [EzSpacer.horizontal] => false
  const EzSwapSpacer({super.key, this.space});

  @override
  Widget build(BuildContext context) {
    final bool limitedSpace = ScreenSpace.of(context)?.isLimited ?? true;

    return limitedSpace
        ? EzSpacer(space: space, horizontal: false)
        : EzSpacer(space: space, vertical: false);
  }
}

class EzSwapMargin extends EzSwapSpacer {
  /// [EzSwapSpacer] with [EzConfig]s [marginKey] space
  EzSwapMargin({super.key}) : super(space: EzConfig.get(marginKey));
}

class EzSeparator extends StatelessWidget {
  /// Defaults to double [EzConfig]s [spacingKey] value
  final double? space;

  /// Whether [space] should be provided to [SizedBox.height]
  final bool vertical;

  /// Whether [space] should be provided to [SizedBox.width]
  final bool horizontal;

  /// [SizedBox] with [space] dimensions for creating space in your layout
  /// Defaults to [EzConfig]s [spacingKey] value
  const EzSeparator({
    super.key,
    this.space,
    this.vertical = true,
    this.horizontal = true,
  });

  @override
  Widget build(BuildContext context) {
    final double amount = space ?? (EzConfig.get(spacingKey) * 2);

    return ExcludeSemantics(
      child: SizedBox(
        height: vertical ? amount : null,
        width: horizontal ? amount : null,
      ),
    );
  }
}

class EzSwapSeparator extends StatelessWidget {
  /// Optional [EzSeparator.space] passthrough
  final double? space;

  /// Defaults to [EzSeparator.vertical] => false
  /// When [ScreenSpace.isLimited], it swaps to [EzSeparator.horizontal] => false
  const EzSwapSeparator({super.key, this.space});

  @override
  Widget build(BuildContext context) {
    final bool limitedSpace = ScreenSpace.of(context)?.isLimited ?? true;

    return limitedSpace
        ? EzSeparator(space: space, horizontal: false)
        : EzSeparator(space: space, vertical: false);
  }
}

class EzDivider extends StatelessWidget {
  /// [widthOf] multiplier override
  /// Defaults to 0.667
  final double widthM;

  /// A [Divider] bounded by [BoxConstraints.maxWidth] => [widthOf] * [widthM]
  const EzDivider({super.key, this.widthM = 0.667});

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: BoxConstraints(maxWidth: widthOf(context) * widthM),
        child: const Divider(),
      );
}
