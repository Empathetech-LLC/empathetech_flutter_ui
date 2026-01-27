/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';

enum EzPageTransition {
  none,
  system,
  flip,
  rotate,
  scale,
  slideLeft,
  slideRight,
  slideUp,
  slideDown,
  zoom,
}

extension EzPageTransitionConfig on EzPageTransition {
  String get value {
    switch (this) {
      case EzPageTransition.none:
        return 'none';
      case EzPageTransition.system:
        return 'system';
      case EzPageTransition.flip:
        return 'flip';
      case EzPageTransition.rotate:
        return 'rotate';
      case EzPageTransition.scale:
        return 'scale';
      case EzPageTransition.slideLeft:
        return 'slideLeft';
      case EzPageTransition.slideRight:
        return 'slideRight';
      case EzPageTransition.slideUp:
        return 'slideUp';
      case EzPageTransition.slideDown:
        return 'slideDown';
      case EzPageTransition.zoom:
        return 'zoom';
    }
  }

  static EzPageTransition lookup(String? value) {
    switch (value) {
      case 'system':
        return EzPageTransition.system;
      case 'flip':
        return EzPageTransition.flip;
      case 'rotate':
        return EzPageTransition.rotate;
      case 'scale':
        return EzPageTransition.scale;
      case 'slideLeft':
        return EzPageTransition.slideLeft;
      case 'slideRight':
        return EzPageTransition.slideRight;
      case 'slideUp':
        return EzPageTransition.slideUp;
      case 'slideDown':
        return EzPageTransition.slideDown;
      case 'zoom':
        return EzPageTransition.zoom;
      default:
        return EzPageTransition.none;
    }
  }
}

/// Library for getting a [BoxFit] from its name
/// '' && [null] both map to [null]
final Map<String?, BoxFit?> boxFitLib = <String?, BoxFit?>{
  BoxFit.contain.name: BoxFit.contain,
  BoxFit.cover.name: BoxFit.cover,
  BoxFit.fill.name: BoxFit.fill,
  BoxFit.fitHeight.name: BoxFit.fitHeight,
  BoxFit.fitWidth.name: BoxFit.fitWidth,
  BoxFit.none.name: BoxFit.none,
  BoxFit.scaleDown.name: BoxFit.scaleDown,
  '': null,
  null: null,
};
