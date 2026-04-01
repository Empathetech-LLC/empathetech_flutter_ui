/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// For [EzButtonShape.leftGram] && [EzButtonShape.rightGram]
class ParallelogramBorder extends OutlinedBorder {
  final bool lefty;
  final double slope;

  const ParallelogramBorder({
    super.side,
    required this.lefty,
    this.slope = gramSlope,
  });

  @override
  OutlinedBorder copyWith({BorderSide? side, double? slope, bool? lefty}) =>
      ParallelogramBorder(
        side: side ?? this.side,
        lefty: lefty ?? this.lefty,
        slope: slope ?? this.slope,
      );

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();

    if (lefty) {
      path.moveTo(rect.left, rect.top);
      path.lineTo(rect.right - slope, rect.top);
      path.lineTo(rect.right, rect.bottom);
      path.lineTo(rect.left + slope, rect.bottom);
    } else {
      path.moveTo(rect.left + slope, rect.top);
      path.lineTo(rect.right, rect.top);
      path.lineTo(rect.right - slope, rect.bottom);
      path.lineTo(rect.left, rect.bottom);
    }

    path.close();
    return path;
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect.deflate(side.width), textDirection: textDirection);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (side.style == BorderStyle.none) return;

    canvas.drawPath(
      getOuterPath(rect, textDirection: textDirection),
      side.toPaint(),
    );
  }

  @override
  ShapeBorder scale(double t) => ParallelogramBorder(
        side: side.scale(t),
        lefty: lefty,
        slope: slope * t,
      );
}

/// For [EzButtonShape.gem]
class GemBorder extends OutlinedBorder {
  final double pointWidth;

  const GemBorder({
    super.side,
    this.pointWidth = gemSlope,
  });

  @override
  OutlinedBorder copyWith({BorderSide? side, double? pointWidth}) => GemBorder(
        side: side ?? this.side,
        pointWidth: pointWidth ?? this.pointWidth,
      );

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();

    path.moveTo(rect.left, rect.top + rect.height / 2);
    path.lineTo(rect.left + pointWidth, rect.top);
    path.lineTo(rect.right - pointWidth, rect.top);
    path.lineTo(rect.right, rect.top + rect.height / 2);
    path.lineTo(rect.right - pointWidth, rect.bottom);
    path.lineTo(rect.left + pointWidth, rect.bottom);

    path.close();
    return path;
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect.deflate(side.width), textDirection: textDirection);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (side.style == BorderStyle.none) return;

    canvas.drawPath(
      getOuterPath(rect, textDirection: textDirection),
      side.toPaint(),
    );
  }

  @override
  ShapeBorder scale(double t) => GemBorder(
        side: side.scale(t),
        pointWidth: pointWidth * t,
      );
}
