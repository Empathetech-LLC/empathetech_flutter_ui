/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// small: 700.0
/// medium: 1000.0
/// large: 1200.0
/// extraLarge: 1600.0
enum ScreenSize { small, medium, large, extraLarge }

extension ScreenSizeConfig on ScreenSize {
  double get size {
    switch (this) {
      case ScreenSize.small:
        return 700.0;
      case ScreenSize.medium:
        return 1000.0;
      case ScreenSize.large:
        return 1200.0;
      case ScreenSize.extraLarge:
        return 1600.0;
    }
  }
}

class EzScreenSize extends InheritedWidget {
  final ScreenSize screenSize;

  /// [InheritedWidget] to wrap around your [Scaffold]s
  /// Enables real-time responses to screen space changes
  const EzScreenSize({
    super.key,
    required this.screenSize,
    required super.child,
  });

  static EzScreenSize? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<EzScreenSize>();

  @override
  bool updateShouldNotify(EzScreenSize oldWidget) =>
      screenSize != oldWidget.screenSize;
}

class EzAdaptiveScaffold extends StatelessWidget {
  /// Think phone thoughts
  final Widget small;

  /// Think tablet thoughts
  final Widget? medium;

  /// Think desktop thoughts
  final Widget? large;

  /// Think gamer thoughts
  final Widget? extraLarge;

  /// Enables real-time responses to screen space changes
  /// If a Widget is not provided, the next smaller size will be used
  const EzAdaptiveScaffold({
    super.key,
    required this.small,
    this.medium,
    this.large,
    this.extraLarge,
  });

  @override
  Widget build(BuildContext context) {
    final double width = widthOf(context);
    late final ScreenSize size;
    late final Widget child;

    if (width >= ScreenSize.extraLarge.size) {
      size = ScreenSize.extraLarge;
      child = extraLarge ?? large ?? medium ?? small;
    } else if (width >= ScreenSize.large.size) {
      size = ScreenSize.large;
      child = large ?? medium ?? small;
    } else if (width >= ScreenSize.medium.size) {
      size = ScreenSize.medium;
      child = medium ?? small;
    } else {
      size = ScreenSize.small;
      child = small;
    }

    return EzScreenSize(screenSize: size, child: child);
  }
}
