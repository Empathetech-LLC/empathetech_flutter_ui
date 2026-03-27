/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

const String _none = 'none';

// Box Fit //

/// Library for getting a [BoxFit] from its name
/// '' && `null` both map to `null`
final Map<String?, BoxFit?> boxFitLookup = <String?, BoxFit?>{
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

// Button shapes //

enum EzButtonShape {
  pill,
  rect,
  roundRect,
  leftGram,
  rightGram,
  gem,
  jewel,
}

const String _pill = 'pill';
const String _rect = 'rect';
const String _roundRect = 'roundRect';
const String _leftGram = 'leftGram';
const String _rightGram = 'rightGram';
const String _gem = 'gem';
const String _jewel = 'jewel';

/// EzButtonShape config
extension EBSConfig on EzButtonShape {
  OutlinedBorder get shape {
    switch (this) {
      case EzButtonShape.pill:
        return const RoundedSuperellipseBorder(borderRadius: ezPillEdge);

      case EzButtonShape.rect:
        return const RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.zero,
        );

      case EzButtonShape.roundRect:
        return const RoundedRectangleBorder(borderRadius: ezRoundEdge);

      case EzButtonShape.leftGram:
        return const ParallelogramBorder(lefty: true);

      case EzButtonShape.rightGram:
        return const ParallelogramBorder(lefty: false);

      case EzButtonShape.gem:
        return const GemBorder();

      case EzButtonShape.jewel:
        return BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(gemSlope),
        );
    }
  }

  String get value {
    switch (this) {
      case EzButtonShape.pill:
        return _pill;
      case EzButtonShape.rect:
        return _rect;
      case EzButtonShape.roundRect:
        return _roundRect;
      case EzButtonShape.leftGram:
        return _leftGram;
      case EzButtonShape.rightGram:
        return _rightGram;
      case EzButtonShape.gem:
        return _gem;
      case EzButtonShape.jewel:
        return _jewel;
    }
  }

  /// Defaults to [EzPageTransition.system]
  static EzButtonShape lookup(String? value) {
    switch (value) {
      case _rect:
        return EzButtonShape.rect;
      case _roundRect:
        return EzButtonShape.roundRect;
      case _leftGram:
        return EzButtonShape.leftGram;
      case _rightGram:
        return EzButtonShape.rightGram;
      case _gem:
        return EzButtonShape.gem;
      case _jewel:
        return EzButtonShape.jewel;
      default:
        return EzButtonShape.pill;
    }
  }

  String get name {
    switch (this) {
      case EzButtonShape.pill:
        return EzConfig.l10n.dsPill;
      case EzButtonShape.rect:
        return EzConfig.l10n.dsRectangle;
      case EzButtonShape.roundRect:
        return EzConfig.l10n.dsRoundRectangle;
      case EzButtonShape.leftGram:
        return EzConfig.l10n.dsLeftGram;
      case EzButtonShape.rightGram:
        return EzConfig.l10n.dsRightGram;
      case EzButtonShape.gem:
        return EzConfig.l10n.dsGem;
      case EzButtonShape.jewel:
        return EzConfig.l10n.dsJewel;
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
  Icon get icon {
    switch (this) {
      case EzPageTransition.none:
        return const Icon(Icons.cancel);
      case EzPageTransition.system:
        return Icon(EzConfig.onMobile
            ? EzConfig.platform == TargetPlatform.iOS
                ? Icons.phone_iphone
                : Icons.phone_android
            : Icons.computer);
      case EzPageTransition.flip:
        return const Icon(Icons.flip);
      case EzPageTransition.rotate:
        return const Icon(Icons.rotate_right);
      case EzPageTransition.scale:
        return const Icon(Icons.scale);
      case EzPageTransition.slideLeft:
        return const Icon(Icons.keyboard_double_arrow_left);
      case EzPageTransition.slideRight:
        return const Icon(Icons.keyboard_double_arrow_right);
      case EzPageTransition.slideUp:
        return const Icon(Icons.keyboard_double_arrow_up);
      case EzPageTransition.slideDown:
        return const Icon(Icons.keyboard_double_arrow_down);
      case EzPageTransition.zoom:
        return const Icon(Icons.zoom_in);
    }
  }

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
