/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

// Default constructors //

class EzMargin extends EzSpacer {
  /// [EzSpacer] with [EzConfig]s [marginKey] space
  EzMargin({
    super.key,
    super.vertical,
    super.horizontal,
  }) : super(space: EzConfig.margin);
}

class EzHeader extends EzSpacer {
  /// [EzSpacer.space] of [marginKey] - [spacingKey], unless margin is larger
  EzHeader({
    super.key,
    super.vertical,
    super.horizontal,
  }) : super(
            space: (EzConfig.spacing > EzConfig.margin)
                ? EzConfig.spacing - EzConfig.margin
                : 0.0);
}

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
    final double amount = space ?? EzConfig.spacing;

    return ExcludeSemantics(
      child: SizedBox(
        height: vertical ? amount : null,
        width: horizontal ? amount : null,
      ),
    );
  }
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
    final double amount = space ?? (EzConfig.spacing * 2);

    return ExcludeSemantics(
      child: SizedBox(
        height: vertical ? amount : null,
        width: horizontal ? amount : null,
      ),
    );
  }
}

class EzDivider extends StatelessWidget {
  /// Bounds for the [Divider]
  final BoxConstraints constraints;

  /// [Divider.height] passthrough
  final double? height;

  /// [Divider.thickness] passthrough
  final double? thickness;

  /// [Divider.indent] passthrough
  final double? indent;

  /// [Divider.color] passthrough
  final Color? color;

  /// [Divider.endIndent] passthrough
  final double? endIndent;

  /// [Divider.radius] passthrough
  final BorderRadius? radius;

  /// A [Divider] wrapped in a [ConstrainedBox]
  const EzDivider({
    super.key,

    // Constraints
    this.constraints = const BoxConstraints(maxWidth: 175),

    // Divider
    this.height,
    this.thickness,
    this.indent,
    this.color,
    this.endIndent,
    this.radius,
  });

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: constraints,
        child: Divider(
          height: height,
          thickness: thickness,
          indent: indent,
          endIndent: endIndent,
          color: color,
          radius: radius,
        ),
      );
}

// Swap constructors //

class EzSwapMargin extends EzSwapSpacer {
  /// [EzSwapSpacer] with [EzConfig]s [marginKey] space
  EzSwapMargin({super.key, super.breakpoint}) : super(space: EzConfig.margin);
}

class EzSwapSpacer extends StatelessWidget {
  /// Which [ScreenSize] the Widget should respond to
  final ScreenSize breakpoint;

  /// Optional [EzSpacer.space] passthrough
  final double? space;

  /// When the context's [ScreenSize] > [breakpoint]; [EzSpacer.vertical] => false
  /// When the context's [ScreenSize] <= [breakpoint]; [EzSpacer.horizontal] => false
  /// If [EzScreenSize] is not in the Widget tree; [EzSpacer.horizontal] => false
  const EzSwapSpacer({
    super.key,
    this.breakpoint = ScreenSize.small,
    this.space,
  });

  @override
  Widget build(BuildContext context) {
    final ScreenSize? size = EzScreenSize.of(context)?.screenSize;

    return (size == null || size.order <= breakpoint.order)
        ? EzSpacer(space: space, horizontal: false)
        : EzSpacer(space: space, vertical: false);
  }
}

class EzSwapSeparator extends StatelessWidget {
  /// Which [ScreenSize] the Widget should respond to
  final ScreenSize breakpoint;

  /// Optional [EzSeparator.space] passthrough
  final double? space;

  /// When the context's [ScreenSize] > [breakpoint]; [EzSeparator.vertical] => false
  /// When the context's [ScreenSize] <= [breakpoint]; [EzSeparator.horizontal] => false
  /// If [EzScreenSize] is not in the Widget tree; [EzSeparator.horizontal] => false
  const EzSwapSeparator({
    super.key,
    this.breakpoint = ScreenSize.small,
    this.space,
  });

  @override
  Widget build(BuildContext context) {
    final ScreenSize? size = EzScreenSize.of(context)?.screenSize;

    return (size == null || size.order <= breakpoint.order)
        ? EzSeparator(space: space, horizontal: false)
        : EzSeparator(space: space, vertical: false);
  }
}
