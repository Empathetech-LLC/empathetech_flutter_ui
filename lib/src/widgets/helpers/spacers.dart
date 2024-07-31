/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
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

  /// [SizedBox] with [space] dimensions for creating space in your layout
  /// Defaults to [EzConfig]s [spacingKey] value
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

class EzSwapSpacer extends StatelessWidget {
  /// Optional [EzSpacer.space] passthrough
  final double? space;

  /// Defaults to [EzSpacer.vertical] => false
  /// When [ScreenSpace.isLimited], it swaps to [EzSpacer.horizontal] => false
  const EzSwapSpacer(this.space, {super.key});

  @override
  Widget build(BuildContext context) {
    final bool limitedSpace = ScreenSpace.of(context)?.isLimited ?? false;

    return limitedSpace
        ? const EzSpacer(horizontal: false)
        : const EzSpacer(vertical: false);
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
  const EzSwapSeparator(this.space, {super.key});

  @override
  Widget build(BuildContext context) {
    final bool limitedSpace = ScreenSpace.of(context)?.isLimited ?? false;

    return limitedSpace
        ? const EzSeparator(horizontal: false)
        : const EzSeparator(vertical: false);
  }
}
