/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'dart:math' as math;
import 'package:flutter/material.dart';

class EzCountdownTimer extends StatefulWidget {
  final Duration duration;
  final double radius;

  /// Optional color override, defaults to [ColorScheme.secondary]
  final Color? color;

  /// An animated circle/pie countdown timer
  const EzCountdownTimer({
    super.key,
    required this.duration,
    required this.radius,
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
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) => CustomPaint(
        size: Size(widget.radius * 2, widget.radius * 2),
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
