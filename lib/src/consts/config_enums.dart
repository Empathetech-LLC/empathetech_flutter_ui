/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

// Shared //

/// enum String 'none'
const String esNone = 'none';

/// enum String 'system'
const String esSystem = 'system';

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

/// enum String 'pill'
const String esPill = 'pill';

/// enum String 'rect'
const String esRect = 'rect';

/// enum String 'roundRect'
const String esRoundRect = 'roundRect';

/// enum String 'leftGram'
const String esLeftGram = 'leftGram';

/// enum String 'rightGram'
const String esRightGram = 'rightGram';

/// enum String 'gem'
const String esGem = 'gem';

/// enum String 'jewel'
const String esJewel = 'jewel';

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
        return esPill;

      case EzButtonShape.rect:
        return esRect;

      case EzButtonShape.roundRect:
        return esRoundRect;

      case EzButtonShape.leftGram:
        return esLeftGram;

      case EzButtonShape.rightGram:
        return esRightGram;

      case EzButtonShape.gem:
        return esGem;

      case EzButtonShape.jewel:
        return esJewel;
    }
  }

  /// Defaults to [EzPageTransition.system]
  static EzButtonShape lookup(String? value) {
    switch (value) {
      case esRect:
        return EzButtonShape.rect;

      case esRoundRect:
        return EzButtonShape.roundRect;

      case esLeftGram:
        return EzButtonShape.leftGram;

      case esRightGram:
        return EzButtonShape.rightGram;

      case esGem:
        return EzButtonShape.gem;

      case esJewel:
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
  turnX,
  turnY,
  rotate,
  slideX,
  slideY,
  zoom,
}

/// enum String 'turnX'
const String esTurnX = 'turnX';

/// enum String 'turnY'
const String esTurnY = 'turnY';

/// enum String 'rotate'
const String esRotate = 'rotate';

/// enum String 'slideX'
const String esSlideX = 'slideX';

/// enum String 'slideY'
const String esSlideY = 'slideY';

/// enum String 'zoom'
const String esZoom = 'zoom';

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

      case EzPageTransition.turnX:
        return const Icon(Icons.flip);

      case EzPageTransition.turnY:
        return const Icon(Icons.u_turn_left);

      case EzPageTransition.rotate:
        return const Icon(Icons.rotate_90_degrees_cw);

      case EzPageTransition.slideX:
        return Icon(EzConfig.isLTR
            ? Icons.keyboard_double_arrow_left
            : Icons.keyboard_double_arrow_right);

      case EzPageTransition.slideY:
        return const Icon(Icons.keyboard_double_arrow_up);

      case EzPageTransition.zoom:
        return const Icon(Icons.zoom_in);
    }
  }

  String get value {
    switch (this) {
      case EzPageTransition.none:
        return esNone;

      case EzPageTransition.system:
        return esSystem;

      case EzPageTransition.turnX:
        return esTurnX;

      case EzPageTransition.turnY:
        return esTurnY;

      case EzPageTransition.rotate:
        return esRotate;

      case EzPageTransition.slideX:
        return esSlideX;

      case EzPageTransition.slideY:
        return esSlideY;

      case EzPageTransition.zoom:
        return esZoom;
    }
  }

  /// Defaults to [EzPageTransition.system]
  static EzPageTransition lookup(String? value) {
    switch (value) {
      case esNone:
        return EzPageTransition.none;

      case esTurnX:
        return EzPageTransition.turnX;

      case esTurnY:
        return EzPageTransition.turnY;

      case esRotate:
        return EzPageTransition.rotate;

      case esSlideX:
        return EzPageTransition.slideX;

      case esSlideY:
        return EzPageTransition.slideY;

      case esZoom:
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

      case EzPageTransition.turnX:
        return EzConfig.l10n.dsTurnX;

      case EzPageTransition.turnY:
        return EzConfig.l10n.dsTurnY;

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
