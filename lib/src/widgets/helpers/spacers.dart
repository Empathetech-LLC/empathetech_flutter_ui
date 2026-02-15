/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

// Default constructors //

class EzMargin extends EzSpacer {
  /// [EzSpacer] paired with [darkMarginKey] and [lightMarginKey]
  EzMargin({
    super.key,
    super.isDark,
    super.vertical,
    super.horizontal,
  }) : super(
            space: (isDark == null)
                ? EzConfig.marginVal
                : isDark
                    ? EzConfig.get(darkMarginKey)
                    : EzConfig.get(lightMarginKey));
}

class EzHeader extends EzSpacer {
  /// [EzSpacer.space] of [EzConfig.spacing] - [EzConfig.marginVal], unless margin is larger
  /// Fails if [EzConfigProvider] is not in the context
  EzHeader({
    super.key,
    super.vertical,
    super.horizontal,
  }) : super(
            space: (EzConfig.spacing > EzConfig.marginVal)
                ? EzConfig.spacing - EzConfig.marginVal
                : 0.0);
}

class EzSpacer extends StatelessWidget {
  /// Default value is tied to [darkSpacingKey] and [lightSpacingKey] from [EzConfig]
  final double? space;

  /// Required IFF [EzConfigProvider] is not in the context
  final bool? isDark;

  /// Whether [space] should be provided to [SizedBox.height]
  final bool vertical;

  /// Whether [space] should be provided to [SizedBox.width]
  final bool horizontal;

  /// [SizedBox] with [space] dimensions for organizing your layout
  const EzSpacer({
    super.key,
    this.space,
    this.isDark,
    this.vertical = true,
    this.horizontal = true,
  });

  @override
  Widget build(BuildContext context) {
    final double amount = space ??
        ((isDark == null)
            ? EzConfig.spacing
            : isDark!
                ? EzConfig.get(darkSpacingKey)
                : EzConfig.get(lightSpacingKey));

    return ExcludeSemantics(
      child: SizedBox(
        height: vertical ? amount : null,
        width: horizontal ? amount : null,
      ),
    );
  }
}

class EzSeparator extends StatelessWidget {
  /// Defaults to double [EzSpacer]
  final double? space;

  /// Required IFF [EzConfigProvider] is not in the context
  final bool? isDark;

  /// Whether [space] should be provided to [SizedBox.height]
  final bool vertical;

  /// Whether [space] should be provided to [SizedBox.width]
  final bool horizontal;

  /// [SizedBox] with [space] dimensions for creating space in your layout
  const EzSeparator({
    super.key,
    this.space,
    this.isDark,
    this.vertical = true,
    this.horizontal = true,
  });

  @override
  Widget build(BuildContext context) {
    final double amount = space ??
        (((isDark == null)
                ? EzConfig.spacing
                : isDark!
                    ? EzConfig.get(darkSpacingKey)
                    : EzConfig.get(lightSpacingKey)) *
            2);

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
  /// [EzSwapSpacer] paired with [darkMarginKey] and [lightMarginKey]
  EzSwapMargin({
    super.key,
    super.isDark,
    super.breakpoint,
  }) : super(
            space: (isDark == null)
                ? EzConfig.marginVal
                : isDark
                    ? EzConfig.get(darkMarginKey)
                    : EzConfig.get(lightMarginKey));
}

class EzSwapSpacer extends StatelessWidget {
  /// Optional [EzSpacer.space] passthrough
  final double? space;

  /// Required IFF [EzConfigProvider] is not in the context
  final bool? isDark;

  /// Which [ScreenSize] the Widget should respond to
  final ScreenSize breakpoint;

  /// When the context's [ScreenSize] > [breakpoint]; [EzSpacer.vertical] => false
  /// When the context's [ScreenSize] <= [breakpoint]; [EzSpacer.horizontal] => false
  /// If [EzScreenSize] is not in the Widget tree; [EzSpacer.horizontal] => false
  const EzSwapSpacer({
    super.key,
    this.space,
    this.isDark,
    this.breakpoint = ScreenSize.small,
  });

  @override
  Widget build(BuildContext context) {
    final ScreenSize? size = EzScreenSize.of(context)?.screenSize;

    return (size == null || size.order <= breakpoint.order)
        ? EzSpacer(space: space, isDark: isDark, horizontal: false)
        : EzSpacer(space: space, isDark: isDark, vertical: false);
  }
}

class EzSwapSeparator extends StatelessWidget {
  /// Optional [EzSeparator.space] passthrough
  final double? space;

  /// Required IFF [EzConfigProvider] is not in the context
  final bool? isDark;

  /// Which [ScreenSize] the Widget should respond to
  final ScreenSize breakpoint;

  /// When the context's [ScreenSize] > [breakpoint]; [EzSeparator.vertical] => false
  /// When the context's [ScreenSize] <= [breakpoint]; [EzSeparator.horizontal] => false
  /// If [EzScreenSize] is not in the Widget tree; [EzSeparator.horizontal] => false
  const EzSwapSeparator({
    super.key,
    this.space,
    this.isDark,
    this.breakpoint = ScreenSize.small,
  });

  @override
  Widget build(BuildContext context) {
    final ScreenSize? size = EzScreenSize.of(context)?.screenSize;

    return (size == null || size.order <= breakpoint.order)
        ? EzSeparator(space: space, isDark: isDark, horizontal: false)
        : EzSeparator(space: space, isDark: isDark, vertical: false);
  }
}
