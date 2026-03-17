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
  final double slope;

  const ParallelogramBorder({
    super.side,
    required this.lefty,
    this.slope = zoidSlope,
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

/// For [EzButtonShape.squiggle]
class SquigglyBorder extends OutlinedBorder {
  final double amplitude;
  final double wavelength;

  const SquigglyBorder({
    super.side,
    this.amplitude = squiggleAmp,
    this.wavelength = squiggleWave,
  });

  @override
  OutlinedBorder copyWith({
    BorderSide? side,
    double? amplitude,
    double? wavelength,
  }) =>
      SquigglyBorder(
        side: side ?? this.side,
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

    // Down with the squiggles
    final Path path = Path();
    for (final PathMetric metric in basePath.computeMetrics()) {
      for (double d = 0.0; d < metric.length; d += 2.0) {
        final Tangent? tangent = metric.getTangentForOffset(d);

        if (tangent != null) {
          final Offset normal = Offset(-tangent.vector.dy, tangent.vector.dx);
          final double offsetAmount =
              sin(d / wavelength * pi * 2.0) * amplitude;

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
  ShapeBorder scale(double t) => SquigglyBorder(
        side: side.scale(t),
        amplitude: amplitude * t,
        wavelength: wavelength * t,
      );
}

/// For [EzButtonShape.burst]
class JaggedBorder extends OutlinedBorder {
  final double amplitude;
  final double wavelength;

  const JaggedBorder({
    super.side,
    this.amplitude = burstAmp,
    this.wavelength = burstWave,
  });

  @override
  OutlinedBorder copyWith({
    BorderSide? side,
    double? amplitude,
    double? wavelength,
  }) =>
      SquigglyBorder(
        side: side ?? this.side,
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

    // Down with the sickness
    final Path path = Path();
    for (final PathMetric metric in basePath.computeMetrics()) {
      for (double d = 0.0; d < metric.length; d += 2.0) {
        final Tangent? tangent = metric.getTangentForOffset(d);

        if (tangent != null) {
          final Offset normal = Offset(-tangent.vector.dy, tangent.vector.dx);
          final double offsetAmount =
              (d % wavelength - wavelength / 2.0).abs() /
                  (wavelength / 2.0) *
                  amplitude;

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
  ShapeBorder scale(double t) => SquigglyBorder(
        side: side.scale(t),
        amplitude: amplitude * t,
        wavelength: wavelength * t,
      );
}
