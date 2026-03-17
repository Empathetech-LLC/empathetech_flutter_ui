/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';

/// For [EzButtonShape.leftZoid] && [EzButtonShape.rightZoid]
class ParallelogramBorder extends OutlinedBorder {
  final bool lefty;
  final double slant;

  const ParallelogramBorder({
    super.side,
    required this.lefty,
    this.slant = 16.0,
  });

  @override
  OutlinedBorder copyWith({BorderSide? side, double? slant, bool? lefty}) =>
      ParallelogramBorder(
        side: side ?? this.side,
        lefty: lefty ?? this.lefty,
        slant: slant ?? this.slant,
      );

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();

    if (lefty) {
      path.moveTo(rect.left + slant, rect.top);
      path.lineTo(rect.right, rect.top);
      path.lineTo(rect.right - slant, rect.bottom);
      path.lineTo(rect.left, rect.bottom);
    } else {
      path.moveTo(rect.left, rect.top);
      path.lineTo(rect.right - slant, rect.top);
      path.lineTo(rect.right, rect.bottom);
      path.lineTo(rect.left + slant, rect.bottom);
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
        slant: slant * t,
      );
}

/// For [EzButtonShape.gem]
class GemBorder extends OutlinedBorder {
  final double pointWidth;

  const GemBorder({super.side, this.pointWidth = 16.0});

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

/// For [EzButtonShape.squiggle] && [EzButtonShape.virus]
class PerturbedPillBorder extends OutlinedBorder {
  final bool squiggly;
  final double amplitude;
  final double wavelength;

  const PerturbedPillBorder({
    super.side,
    this.squiggly = true,
    this.amplitude = 4.0,
    this.wavelength = 12.0,
  });

  @override
  OutlinedBorder copyWith({
    BorderSide? side,
    bool? squiggly,
    double? amplitude,
    double? wavelength,
  }) =>
      PerturbedPillBorder(
        side: side ?? this.side,
        squiggly: squiggly ?? this.squiggly,
        amplitude: amplitude ?? this.amplitude,
        wavelength: wavelength ?? this.wavelength,
      );

  Path _generatePerturbedPath(Rect rect) {
    // Base pill shape
    final Path basePath = Path()
      ..addRRect(RRect.fromRectAndRadius(
        rect,
        Radius.circular(rect.height / 2),
      ));

    // Final shape
    final Path path = Path();

    for (final PathMetric metric in basePath.computeMetrics()) {
      for (double d = 0.0; d < metric.length; d += 2.0) {
        final Tangent? tangent = metric.getTangentForOffset(d);

        if (tangent != null) {
          final Offset normal = Offset(-tangent.vector.dy, tangent.vector.dx);
          double offsetAmount;

          if (squiggly) {
            offsetAmount = sin(d / wavelength * pi * 2) * amplitude;
          } else {
            offsetAmount = (d % wavelength - wavelength / 2).abs() /
                (wavelength / 2) *
                amplitude;
          }

          final Offset pt = tangent.position + normal * offsetAmount;
          (d == 0.0) ? path.moveTo(pt.dx, pt.dy) : path.lineTo(pt.dx, pt.dy);
        }
      }

      path.close();
    }
    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      _generatePerturbedPath(rect);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      _generatePerturbedPath(rect.deflate(side.width));

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (side.style == BorderStyle.none) return;

    canvas.drawPath(
      getOuterPath(rect, textDirection: textDirection),
      side.toPaint(),
    );
  }

  @override
  ShapeBorder scale(double t) => PerturbedPillBorder(
        side: side.scale(t),
        squiggly: squiggly,
        amplitude: amplitude * t,
        wavelength: wavelength * t,
      );
}
