/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// small: 700.0
/// medium: 1000.0
/// large: 1300.0
enum ScreenSize { small, medium, large }

extension ScreenSizeConfig on ScreenSize {
  double get size {
    switch (this) {
      case ScreenSize.small:
        return 700.0;
      case ScreenSize.medium:
        return 1000.0;
      case ScreenSize.large:
        return 1300.0;
    }
  }

  int get order {
    switch (this) {
      case ScreenSize.small:
        return 0;
      case ScreenSize.medium:
        return 1;
      case ScreenSize.large:
        return 2;
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

  /// Will be added to all [ScreenSize] calculations
  final double offset;

  /// Enables real-time responses to screen space changes
  /// If a Widget is not provided, the next smaller size will be used
  const EzAdaptiveScaffold({
    super.key,
    required this.small,
    this.medium,
    this.large,
    this.offset = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final double width = widthOf(context);
    late final ScreenSize size;
    late final Widget child;

    if (width > (ScreenSize.large.size + offset)) {
      size = ScreenSize.large;
      child = large ?? medium ?? small;
    } else if (width > (ScreenSize.medium.size + offset)) {
      size = ScreenSize.medium;
      child = medium ?? small;
    } else {
      size = ScreenSize.small;
      child = small;
    }

    return EzScreenSize(screenSize: size, child: child);
  }
}
