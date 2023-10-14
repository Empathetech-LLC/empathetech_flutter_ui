/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class ScreenSpace extends InheritedWidget {
  /// true == small/mobile screen
  /// false == large/tablet/desktop screen
  final bool isLimited;

  /// [Scaffold] to be displayed
  final Widget child;

  /// [InheritedWidget] to wrap around your [Scaffold]s
  /// Enables real-time responses to screen space changes
  /// Currently uses the bool [isLimited] for switching between a small and large build
  /// Could be expanded limitlessly by replacing [isLimited] with a custom enum
  const ScreenSpace({
    Key? key,
    required this.isLimited,
    required this.child,
  }) : super(key: key, child: child);

  static ScreenSpace? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ScreenSpace>();
  }

  @override
  bool updateShouldNotify(ScreenSpace old) => isLimited != old.isLimited;
}

class EzSwapScaffold extends StatelessWidget {
  final Key? key;

  /// Smaller [Scaffold]; think mobile thoughts
  final Widget small;

  /// Smaller [Scaffold]; think desktop thoughts
  final Widget large;

  /// The [double] pixel value where the swap should happen
  final double threshold;

  /// Enables real-time responses to screen space changes
  /// Swapping between a [small] and [large] build
  /// [small] when [widthOf] the [BuildContext] is less than [threshold]
  /// [large] when [widthOf] the [BuildContext] is more than [threshold]
  const EzSwapScaffold({
    this.key,
    required this.small,
    required this.large,
    required this.threshold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (widthOf(context) <= threshold)
        ? ScreenSpace(isLimited: true, child: small)
        : ScreenSpace(isLimited: false, child: large);
  }
}
