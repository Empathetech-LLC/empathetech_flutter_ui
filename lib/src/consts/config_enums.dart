/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

const String _none = 'none';

// Button shapes //

enum EzButtonShape {
  pill,
  box,
  leftZoid,
  rightZoid,
  gem,
  jewel,
  squiggle,
  burst,
}

const String _pill = 'pill';
const String _box = 'box';
const String _leftZoid = 'leftZoid';
const String _rightZoid = 'rightZoid';
const String _gem = 'gem';
const String _jewel = 'jewel';
const String _squiggle = 'squiggle';
const String _burst = 'burst';

/// EzButtonShape config
extension EBSConfig on EzButtonShape {
  String get value {
    switch (this) {
      case EzButtonShape.pill:
        return _pill;
      case EzButtonShape.box:
        return _box;
      case EzButtonShape.leftZoid:
        return _leftZoid;
      case EzButtonShape.rightZoid:
        return _rightZoid;
      case EzButtonShape.gem:
        return _gem;
      case EzButtonShape.jewel:
        return _jewel;
      case EzButtonShape.squiggle:
        return _squiggle;
      case EzButtonShape.burst:
        return _burst;
    }
  }

  /// Defaults to [EzPageTransition.system]
  static EzButtonShape lookup(String? value) {
    switch (value) {
      case _box:
        return EzButtonShape.box;
      case _leftZoid:
        return EzButtonShape.leftZoid;
      case _rightZoid:
        return EzButtonShape.rightZoid;
      case _gem:
        return EzButtonShape.gem;
      case _jewel:
        return EzButtonShape.jewel;
      case _squiggle:
        return EzButtonShape.squiggle;
      case _burst:
        return EzButtonShape.burst;
      default:
        return EzButtonShape.pill;
    }
  }

  String get name {
    switch (this) {
      case EzButtonShape.pill:
        return EzConfig.l10n.dsPill;
      case EzButtonShape.box:
        return EzConfig.l10n.dsBox;
      case EzButtonShape.leftZoid:
        return EzConfig.l10n.dsTrapezoid;
      case EzButtonShape.rightZoid:
        return EzConfig.l10n.dsTrapezoid;
      case EzButtonShape.gem:
        return EzConfig.l10n.dsGem;
      case EzButtonShape.jewel:
        return EzConfig.l10n.dsJewel;
      case EzButtonShape.squiggle:
        return EzConfig.l10n.dsSquiggle;
      case EzButtonShape.burst:
        return EzConfig.l10n.dsBurst;
    }
  }
}

// Page transitions //

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

const String _system = 'system';
const String _flip = 'flip';
const String _rotate = 'rotate';
const String _scale = 'scale';
const String _slideLeft = 'slideLeft';
const String _slideRight = 'slideRight';
const String _slideUp = 'slideUp';
const String _slideDown = 'slideDown';
const String _zoom = 'zoom';

/// EzPageTransition config
extension EPTConfig on EzPageTransition {
  String get value {
    switch (this) {
      case EzPageTransition.none:
        return _none;
      case EzPageTransition.system:
        return _system;
      case EzPageTransition.flip:
        return _flip;
      case EzPageTransition.rotate:
        return _rotate;
      case EzPageTransition.scale:
        return _scale;
      case EzPageTransition.slideLeft:
        return _slideLeft;
      case EzPageTransition.slideRight:
        return _slideRight;
      case EzPageTransition.slideUp:
        return _slideUp;
      case EzPageTransition.slideDown:
        return _slideDown;
      case EzPageTransition.zoom:
        return _zoom;
    }
  }

  /// Defaults to [EzPageTransition.system]
  static EzPageTransition lookup(String? value) {
    switch (value) {
      case _none:
        return EzPageTransition.none;
      case _flip:
        return EzPageTransition.flip;
      case _rotate:
        return EzPageTransition.rotate;
      case _scale:
        return EzPageTransition.scale;
      case _slideLeft:
        return EzPageTransition.slideLeft;
      case _slideRight:
        return EzPageTransition.slideRight;
      case _slideUp:
        return EzPageTransition.slideUp;
      case _slideDown:
        return EzPageTransition.slideDown;
      case _zoom:
        return EzPageTransition.zoom;
      default:
        return EzPageTransition.system;
    }
  }

  String get name {
    switch (this) {
      case EzPageTransition.none:
        return EzConfig.l10n.dsNone;
      case EzPageTransition.system:
        return EzConfig.l10n.dsSystem;
      case EzPageTransition.flip:
        return EzConfig.l10n.dsFlip;
      case EzPageTransition.rotate:
        return EzConfig.l10n.dsRotate;
      case EzPageTransition.scale:
        return EzConfig.l10n.dsScale;
      case EzPageTransition.slideLeft:
        return EzConfig.l10n.dsSlideLeft;
      case EzPageTransition.slideRight:
        return EzConfig.l10n.dsSlideRight;
      case EzPageTransition.slideUp:
        return EzConfig.l10n.dsSlideUp;
      case EzPageTransition.slideDown:
        return EzConfig.l10n.dsSlideDown;
      case EzPageTransition.zoom:
        return EzConfig.l10n.dsZoom;
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
