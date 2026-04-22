/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

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
