/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Enum declaration //

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

// BTS class //

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

// Parent Widget/Scaffold wrapper //

class EzAdaptiveParent extends StatelessWidget {
  /// Think phone thoughts
  /// HIGHLY recommended to wrap Scaffolds in a [Consumer] de [EzConfigProvider]
  /// Simply set the [Scaffold.key] to a [ValueKey] of the consumed [EzConfigProvider.seed]...
  /// ... and all [EzConfig] updates will be live!
  final Widget small;

  /// Think tablet thoughts
  /// HIGHLY recommended to wrap Scaffolds in a [Consumer] de [EzConfigProvider]
  /// Simply set the [Scaffold.key] to a [ValueKey] of the consumed [EzConfigProvider.seed]...
  /// ... and all [EzConfig] updates will be live!
  final Widget? medium;

  /// Think desktop thoughts
  /// HIGHLY recommended to wrap Scaffolds in a [Consumer] de [EzConfigProvider]
  /// Simply set the [Scaffold.key] to a [ValueKey] of the consumed [EzConfigProvider.seed]...
  /// ... and all [EzConfig] updates will be live!
  final Widget? large;

  /// Will be added to all [ScreenSize] calculations
  final double offset;

  /// Enables real-time responses to screen space changes
  /// If a [Widget] is not provided, the next smaller size will be used
  /// HIGHLY recommended to wrap Scaffolds in a [Consumer] de [EzConfigProvider]
  /// Simply set the [Scaffold.key] to a [ValueKey] of the consumed [EzConfigProvider.seed]...
  /// ... and all [EzConfig] updates will be live!
  const EzAdaptiveParent({
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

    if (width <= (ScreenSize.small.size + offset)) {
      size = ScreenSize.small;
      child = small;
    } else if (width <= (ScreenSize.medium.size + offset)) {
      size = ScreenSize.medium;
      child = medium ?? small;
    } else {
      size = ScreenSize.large;
      child = large ?? medium ?? small;
    }

    return EzScreenSize(screenSize: size, child: child);
  }
}

// Child Widgets && Values //

class EzAdaptiveWidget extends StatelessWidget {
  /// Displayed when the context's [ScreenSize] <= [ScreenSize.small]
  final Widget small;

  /// Displayed when the context's [ScreenSize] <= [ScreenSize.medium]
  final Widget? medium;

  /// Displayed when the context's [ScreenSize] > [ScreenSize.medium]
  final Widget? large;

  /// Display a different [Widget] for each [ScreenSize]
  /// Always [small] if [EzScreenSize] is not in the Widget tree
  const EzAdaptiveWidget({
    super.key,
    required this.small,
    required this.medium,
    required this.large,
  });

  @override
  Widget build(BuildContext context) {
    final int? order = EzScreenSize.of(context)?.screenSize.order;

    switch (order) {
      case 1:
        return medium ?? small;
      case 2:
        return large ?? medium ?? small;
      default:
        return small;
    }
  }
}
