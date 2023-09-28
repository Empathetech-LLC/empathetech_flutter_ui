/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';

class LayoutSize extends InheritedWidget {
  /// true == small/mobile screen
  /// false == large/tablet/desktop screen
  final bool isLimited;

  /// [Scaffold] to be displayed
  final Widget child;

  /// [InheritedWidget] to wrap around your [Scaffold]s
  /// Enables real-time responses to screen space changes
  /// Currently uses the bool [isLimited] for switching between a small and large build
  /// Could be expanded limitlessly by replacing [isLimited] with a custom enum
  const LayoutSize({
    Key? key,
    required this.isLimited,
    required this.child,
  }) : super(key: key, child: child);

  static LayoutSize? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LayoutSize>();
  }

  @override
  bool updateShouldNotify(LayoutSize old) => isLimited != old.isLimited;
}
