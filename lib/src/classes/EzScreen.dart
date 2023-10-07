/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:io';
import 'package:flutter/material.dart';

class EzScreen extends StatelessWidget {
  final Key? key;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  /// See the custom parameter [decorationImageKey] before providing this
  final Decoration? decoration;

  /// Optional [EzConfig.instance] key that will be used to create a [DecorationImage] for a [BoxDecoration] that will cover the [EzScreen]
  /// Only provide this OR [decoration]
  final String? decorationImageKey;

  final Decoration? foregroundDecoration;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? margin;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final Widget child;
  final Clip clipBehavior;

  /// [Container] wrapper that defaults to max size with a margin from [EzConfig]
  const EzScreen({
    // Container
    this.key,
    this.alignment,
    this.padding,
    this.color,
    this.decoration,
    this.decorationImageKey,
    this.foregroundDecoration,
    this.width = double.infinity,
    this.height = double.infinity,
    this.constraints,
    this.margin,
    this.transform,
    this.transformAlignment,
    required this.child,
    this.clipBehavior = Clip.none,
  }) : assert(
          !(decoration != null && decorationImageKey != null),
          'Either decoration or decorationImageKey can be provided, but not both.',
        );

  DecorationImage? _buildDecoration(String? path) {
    return (path == null || path == noImageKey)
        ? null
        : isPathAsset(path)
            ? DecorationImage(
                image: AssetImage(path),
                fit: BoxFit.fill,
              )
            : DecorationImage(
                image: FileImage(File(path)),
                fit: BoxFit.fill,
              );
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry screenMargin =
        margin ?? EdgeInsets.all(EzConfig.instance.prefs[marginKey]);

    return Container(
      key: key,
      alignment: alignment,
      padding: padding,
      decoration: decorationImageKey == null
          ? decoration
          : BoxDecoration(
              image:
                  _buildDecoration(EzConfig.instance.prefs[decorationImageKey]),
            ),
      foregroundDecoration: foregroundDecoration,
      width: width,
      height: height,
      constraints: constraints,
      margin: screenMargin,
      transform: transform,
      transformAlignment: transformAlignment,
      child: child,
      clipBehavior: clipBehavior,
    );
  }
}
