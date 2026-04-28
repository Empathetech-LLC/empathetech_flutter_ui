/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzAnimSwitch extends AnimatedSwitcher {
  /// [ezAnimDuration] passthrough
  final double mod;

  /// Traditional [transitionBuilder]
  final Widget Function(Widget, Animation<double>)? override;

  /// [ezTransitionBuilder] passthrough
  final EzTransitionType? forceType;

  /// [ezTransitionBuilder] passthrough
  final bool? forceFade;

  /// [[ezTransitionBuilder] passthrough
  final bool reverse;

  /// An [EzConfig] controlled [AnimatedSwitcher]
  EzAnimSwitch({
    super.key,
    this.mod = 1.0,
    super.reverseDuration,
    super.switchInCurve = Curves.easeInOut,
    super.switchOutCurve = Curves.easeInOut,
    super.layoutBuilder,
    this.forceType,
    this.forceFade,
    this.reverse = false,
    this.override,
    super.child,
  }) : super(
          duration: ezAnimDuration(mod: mod),
          transitionBuilder: override ??
              (Widget w, Animation<double> a) => ezTransitionBuilder(
                    a,
                    w,
                    forceType: forceType,
                    forceFade: forceFade,
                    reverse: reverse,
                  ),
        );
}

class EzAnimVis extends EzAnimSwitch {
  /// When the [child] should be visible
  final bool visible;

  /// [EzAnimSwitch] where the second child is always [SizedBox.shrink]
  EzAnimVis({
    super.key,
    required this.visible,
    super.mod,
    super.reverseDuration,
    super.switchInCurve = Curves.easeInOut,
    super.switchOutCurve = Curves.easeInOut,
    super.layoutBuilder,
    super.forceType,
    super.forceFade,
    super.reverse = false,
    super.child,
  }) : super(
            override: (Widget w, Animation<double> a) => ezTransitionBuilder(
                  a,
                  visible ? w : const SizedBox.shrink(),
                  forceType: forceType,
                  forceFade: forceFade,
                  reverse: reverse,
                ));
}

class EzAnimHide extends EzAnimSwitch {
  ///[BuildContext.findRenderObject] -> [Size]
  final Size size;

  /// When the [child] should be visible
  final bool visible;

  /// Think [EzAnimVis] but it maintains the size of the widget
  /// Always a static fade
  EzAnimHide({
    super.key,
    required this.visible,
    required this.size,
    super.mod,
    super.reverseDuration,
    super.switchInCurve = Curves.easeInOut,
    super.switchOutCurve = Curves.easeInOut,
    super.layoutBuilder,
    super.child,
  }) : super(
            override: (Widget w, Animation<double> a) => ezTransitionBuilder(
                  a,
                  visible ? w : SizedBox(height: size.height, width: size.width),
                  forceType: EzTransitionType.none,
                  forceFade: true,
                  reverse: false,
                ));
}

class EzFauxCarousel extends StatelessWidget {
  final int position;
  final int delta;
  final Widget child;
  final double animMod;

  const EzFauxCarousel({
    super.key,
    required this.position,
    required this.delta,
    required this.child,
    this.animMod = 0.75,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: ezAnimDuration(mod: animMod),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (Widget w, Animation<double> a) {
        final double sign = (w.key == ValueKey<int>(position)) ? 1.0 : -1.0;
        final double direction = (EzConfig.isLTR ? 1.0 : -1.0) * delta.sign;

        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(direction * sign, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: a,
            curve: Curves.easeInOut,
          )),
          child: FadeTransition(opacity: a, child: w),
        );
      },
      child: KeyedSubtree(
        key: ValueKey<int>(position),
        child: child,
      ),
    );
  }
}
