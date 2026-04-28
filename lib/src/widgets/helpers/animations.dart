/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzAnimSwitch extends AnimatedSwitcher {
  /// [ezAnimDuration] passthrough
  final double mod;

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
    super.child,
  }) : super(
          duration: ezAnimDuration(mod: mod),
          transitionBuilder: (Widget w, Animation<double> a) => ezTransitionBuilder(
            a,
            w,
            forceType: forceType,
            forceFade: forceFade,
            reverse: reverse,
          ),
        );
}

class EzAnimVis extends EzAnimSwitch {
  /// When the [kid] should be visible
  final bool visible;

  /// Synonym for [child]
  final Widget kid;

  /// [EzAnimSwitch] + [Visibility]
  EzAnimVis({
    super.key,
    super.mod,
    super.reverseDuration,
    super.switchInCurve = Curves.easeInOut,
    super.switchOutCurve = Curves.easeInOut,
    super.layoutBuilder,
    super.forceType,
    super.forceFade,
    super.reverse = false,
    required this.visible,
    required this.kid,
  }) : super(
          child: visible ? kid : const SizedBox.shrink(key: ValueKey<String>('[-_-]~')),
        );
}

class EzAnimHide extends EzAnimSwitch {
  /// When the [kid] should be visible
  final bool visible;

  /// [BuildContext.findRenderObject] -> [Size]
  final Size size;

  /// Synonym for [child]
  final Widget kid;

  /// [EzAnimSwitch] + [Visibility] that maintains size
  /// && defaults to a static fade
  EzAnimHide({
    super.key,
    super.mod,
    super.reverseDuration,
    super.switchInCurve = Curves.easeInOut,
    super.switchOutCurve = Curves.easeInOut,
    super.layoutBuilder,
    super.forceType = EzTransitionType.none,
    super.forceFade = true,
    super.reverse = false,
    required this.visible,
    required this.size,
    required this.kid,
  }) : super(
          child: visible
              ? kid
              : SizedBox(
                  key: const ValueKey<String>('[-_-]~'),
                  height: size.height,
                  width: size.width,
                ),
        );
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
