/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

// Shared //

const String none = 'none';
const String system = 'system';

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

const String pill = 'pill';
const String rect = 'rect';
const String roundRect = 'roundRect';
const String leftGram = 'leftGram';
const String rightGram = 'rightGram';
const String gem = 'gem';
const String jewel = 'jewel';

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
        return pill;

      case EzButtonShape.rect:
        return rect;

      case EzButtonShape.roundRect:
        return roundRect;

      case EzButtonShape.leftGram:
        return leftGram;

      case EzButtonShape.rightGram:
        return rightGram;

      case EzButtonShape.gem:
        return gem;

      case EzButtonShape.jewel:
        return jewel;
    }
  }

  /// Defaults to [EzPageTransition.system]
  static EzButtonShape lookup(String? value) {
    switch (value) {
      case rect:
        return EzButtonShape.rect;

      case roundRect:
        return EzButtonShape.roundRect;

      case leftGram:
        return EzButtonShape.leftGram;

      case rightGram:
        return EzButtonShape.rightGram;

      case gem:
        return EzButtonShape.gem;

      case jewel:
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
  flipX,
  flipY,
  rotate,
  slideX,
  slideY,
  zoom,
}

const String flipX = 'flipX';
const String flipY = 'flipY';
const String rotate = 'rotate';
const String slideX = 'slideX';
const String slideY = 'slideY';
const String zoom = 'zoom';

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

      case EzPageTransition.flipX:
        return const Icon(Icons.flip);

      case EzPageTransition.flipY:
        return const Icon(Icons.u_turn_left);

      case EzPageTransition.rotate:
        return const Icon(Icons.rotate_90_degrees_cw);

      case EzPageTransition.slideX:
        return Icon(EzConfig.isLTR
            ? Icons.keyboard_double_arrow_right
            : Icons.keyboard_double_arrow_left);

      case EzPageTransition.slideY:
        return const Icon(Icons.keyboard_double_arrow_down);

      case EzPageTransition.zoom:
        return const Icon(Icons.zoom_in);
    }
  }

  String get value {
    switch (this) {
      case EzPageTransition.none:
        return none;

      case EzPageTransition.system:
        return system;

      case EzPageTransition.flipX:
        return flipX;

      case EzPageTransition.flipY:
        return flipY;

      case EzPageTransition.rotate:
        return rotate;

      case EzPageTransition.slideX:
        return slideX;

      case EzPageTransition.slideY:
        return slideY;

      case EzPageTransition.zoom:
        return zoom;
    }
  }

  /// Defaults to [EzPageTransition.system]
  static EzPageTransition lookup(String? value) {
    switch (value) {
      case none:
        return EzPageTransition.none;

      case flipX:
        return EzPageTransition.flipX;

      case flipY:
        return EzPageTransition.flipY;

      case rotate:
        return EzPageTransition.rotate;

      case slideX:
        return EzPageTransition.slideX;

      case slideY:
        return EzPageTransition.slideY;

      case zoom:
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

      case EzPageTransition.flipX:
        return EzConfig.l10n.dsFlipX;

      case EzPageTransition.flipY:
        return EzConfig.l10n.dsFlipY;

      case EzPageTransition.rotate:
        return EzConfig.l10n.dsRotate;

      case EzPageTransition.slideX:
        return EzConfig.l10n.dsSlideX;

      case EzPageTransition.slideY:
        return EzConfig.l10n.dsSlideY;

      case EzPageTransition.zoom:
        return EzConfig.l10n.dsZoom;
    }
  }
}
