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

  /// Default: [widthOf] context
  final double? width;

  /// Default: [heightOf] context
  final double? height;

  final BoxConstraints? constraints;

  /// Default: [EdgeInsets.all] -> [EzConfig.prefs] -> [marginKey]
  final EdgeInsetsGeometry? margin;

  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final Widget child;

  /// Default: [Clip.none]
  final Clip clipBehavior;

  /// [Container] wrapper that defaults to max size with a margin from [EzConfig]
  EzView({
    this.key,
    this.alignment,
    this.padding,
    this.decoration,
    this.foregroundDecoration,
    this.width,
    this.height,
    this.constraints,
    this.margin,
    this.transform,
    this.transformAlignment,
    required this.child,
    this.clipBehavior = Clip.none,
  });

  @override
  Widget build(BuildContext context) {
    double ezMargin = EzConfig.prefs[marginKey];

    return Container(
      key: key,
      alignment: alignment,
      padding: padding,
      decoration: decoration,
      foregroundDecoration: foregroundDecoration,
      width: width ?? widthOf(context),
      height: height ?? heightOf(context),
      constraints: constraints,
      margin: margin ?? EdgeInsets.all(ezMargin),
      transform: transform,
      transformAlignment: transformAlignment,
      child: child,
      clipBehavior: clipBehavior,
    );
  }
}
