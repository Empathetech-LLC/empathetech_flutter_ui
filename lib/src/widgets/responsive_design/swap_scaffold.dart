/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class ScreenSpace extends InheritedWidget {
  /// true == small/mobile screen
  /// false == large/tablet/desktop screen
  final bool isLimited;

  /// [InheritedWidget] to wrap around your [Scaffold]s
  /// Enables real-time responses to screen space changes
  /// Currently uses the bool [isLimited] for switching between a small and large build
  /// If further customization is desired, check out:
  /// https://pub.dev/packages/flutter_adaptive_scaffold
  const ScreenSpace({
    super.key,
    required this.isLimited,
    required super.child,
  });

  static ScreenSpace? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ScreenSpace>();

  @override
  bool updateShouldNotify(ScreenSpace oldWidget) =>
      isLimited != oldWidget.isLimited;
}

class EzSwapScaffold extends StatelessWidget {
  /// The [double] value where the swap should happen
  /// [smallBreakpoint] is recommended
  final double threshold;

  /// [small]er [Scaffold]
  /// Think mobile thoughts
  final Widget small;

  /// [large]r [Scaffold]
  /// Think desktop thoughts
  final Widget large;

  /// Enables real-time responses to screen space changes
  /// [small] when [widthOf] the [BuildContext] is less than or equal to [threshold]
  /// [large] when [widthOf] the [BuildContext] is greater than [threshold]
  const EzSwapScaffold({
    super.key,
    required this.threshold,
    required this.small,
    required this.large,
  });

  @override
  Widget build(BuildContext context) => (widthOf(context) <= threshold)
      ? ScreenSpace(isLimited: true, child: small)
      : ScreenSpace(isLimited: false, child: large);
}
