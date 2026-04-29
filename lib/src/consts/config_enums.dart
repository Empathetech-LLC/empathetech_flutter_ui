/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

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

//* Button shapes *//

enum EzButtonShape {
  pill,
  rect,
  roundRect,
  leftGram,
  rightGram,
  gem,
  jewel,
}

// EzConfig values //

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

// enum Config //

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

  /// Defaults to [EzTransitionType.system]
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

//* Page transitions *//

enum EzTransitionType {
  none,
  system,
  turnX,
  turnY,
  rotate,
  slideX,
  slideY,

  zoom,
}

// EzConfig values //

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

// enum Config //

/// EzTransitionType config
extension ETTConfig on EzTransitionType {
  Icon get icon {
    switch (this) {
      case EzTransitionType.none:
        return const Icon(Icons.cancel);

      case EzTransitionType.system:
        return Icon(EzConfig.onMobile
            ? EzConfig.platform == TargetPlatform.iOS
                ? Icons.phone_iphone
                : Icons.phone_android
            : Icons.computer);

      case EzTransitionType.turnX:
        return const Icon(Icons.flip);

      case EzTransitionType.turnY:
        return const Icon(Icons.u_turn_left);

      case EzTransitionType.rotate:
        return const Icon(Icons.rotate_90_degrees_cw);

      case EzTransitionType.slideX:
        return Icon(EzConfig.isLTR
            ? Icons.keyboard_double_arrow_left
            : Icons.keyboard_double_arrow_right);

      case EzTransitionType.slideY:
        return const Icon(Icons.keyboard_double_arrow_up);

      case EzTransitionType.zoom:
        return const Icon(Icons.zoom_in);
    }
  }

  String get value {
    switch (this) {
      case EzTransitionType.none:
        return esNone;

      case EzTransitionType.system:
        return esSystem;

      case EzTransitionType.turnX:
        return esTurnX;

      case EzTransitionType.turnY:
        return esTurnY;

      case EzTransitionType.rotate:
        return esRotate;

      case EzTransitionType.slideX:
        return esSlideX;

      case EzTransitionType.slideY:
        return esSlideY;

      case EzTransitionType.zoom:
        return esZoom;
    }
  }

  /// Defaults to [EzTransitionType.system]
  static EzTransitionType lookup(String? value) {
    switch (value) {
      case esNone:
        return EzTransitionType.none;

      case esTurnX:
        return EzTransitionType.turnX;

      case esTurnY:
        return EzTransitionType.turnY;

      case esRotate:
        return EzTransitionType.rotate;

      case esSlideX:
        return EzTransitionType.slideX;

      case esSlideY:
        return EzTransitionType.slideY;

      case esZoom:
        return EzTransitionType.zoom;

      default:
        return EzTransitionType.system;
    }
  }

  String get name {
    switch (this) {
      case EzTransitionType.none:
        return EzConfig.l10n.dsNone;

      case EzTransitionType.system:
        return EzConfig.l10n.dsSystem;

      case EzTransitionType.turnX:
        return EzConfig.l10n.dsTurnX;

      case EzTransitionType.turnY:
        return EzConfig.l10n.dsTurnY;

      case EzTransitionType.rotate:
        return EzConfig.l10n.dsRotate;

      case EzTransitionType.slideX:
        return EzConfig.l10n.dsSlideX;

      case EzTransitionType.slideY:
        return EzConfig.l10n.dsSlideY;

      case EzTransitionType.zoom:
        return EzConfig.l10n.dsZoom;
    }
  }
}

//* Shared *//

// EzConfig values //

/// enum String 'none'
const String esNone = 'none';

/// enum String 'system'
const String esSystem = 'system';

const Set<String> ezEnumVals = <String>{
  esNone,
  esSystem,
  esPill,
  esRect,
  esRoundRect,
  esLeftGram,
  esRightGram,
  esGem,
  esJewel,
  esTurnX,
  esTurnY,
  esRotate,
  esSlideX,
  esSlideY,
  esZoom,
};
