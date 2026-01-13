/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:math' as math;
import 'package:flutter/material.dart';

class EzCountdownTimer extends StatefulWidget {
  /// How long is the countdown
  final Duration duration;

  /// Defaults to a [SnackBar] appropriate value
  final double? radius;

  /// Defaults to [ColorScheme.secondary]
  final Color? color;

  /// An animated circle/pie countdown timer
  /// Default [radius] is for use in a [SnackBar]
  const EzCountdownTimer({
    super.key,
    required this.duration,
    this.radius,
    this.color,
  });

  @override
  State<EzCountdownTimer> createState() => _EzCountdownTimerState();
}

class _EzCountdownTimerState extends State<EzCountdownTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.radius ?? EzConfig.iconSize + EzConfig.padding;

    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) => CustomPaint(
        size: Size(size, size),
        painter: _CountdownTimerPainter(
          progress: _animation.value,
          color: widget.color ?? Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _CountdownTimerPainter extends CustomPainter {
  final double progress;
  final Color color;

  _CountdownTimerPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;

    final Paint foregroundPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * -math.pi * progress,
      true,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(_CountdownTimerPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
