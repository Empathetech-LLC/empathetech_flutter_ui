library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class EzView extends Container {
  final Key? key;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;
  final Decoration? foregroundDecoration;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry margin;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final Widget child;
  final Clip clipBehavior;

  /// [Container] wrapper that defaults to max size with a margin from [EzConfig]
  EzView({
    this.key,
    this.alignment,
    this.padding,
    this.decoration,
    this.foregroundDecoration,
    this.width = double.infinity,
    this.height = double.infinity,
    this.constraints,
    this.margin = const EdgeInsets.all(EzConfig.margin),
    this.transform,
    this.transformAlignment,
    required this.child,
    this.clipBehavior = Clip.none,
  }) : super(
          key: key,
          alignment: alignment,
          padding: padding,
          decoration: decoration,
          foregroundDecoration: foregroundDecoration,
          width: width,
          height: height,
          constraints: constraints,
          margin: margin,
          transform: transform,
          transformAlignment: transformAlignment,
          child: child,
          clipBehavior: clipBehavior,
        );
}
