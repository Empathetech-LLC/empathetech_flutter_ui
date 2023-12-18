/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzScreen extends StatelessWidget {
  final Key? key;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? margin;

  /// Optional [Decoration] background for the screen
  /// Provide [decoration] OR [decorationImageKey]
  final Decoration? decoration;

  /// Optional [EzConfig] key that will be used to create a [DecorationImage] background for the screen
  /// Provide [decorationImageKey] OR [decoration]
  final String? decorationImageKey;

  final double width;
  final double height;
  final BoxConstraints? constraints;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final Widget child;
  final Clip clipBehavior;

  /// [Container] wrapper that defaults to max size with a margin from [EzConfig]
  /// See [decorationImageKey] for easily setting a background image
  const EzScreen({
    // Container
    this.key,
    this.alignment,
    this.margin,
    this.decoration,
    this.decorationImageKey,
    this.width = double.infinity,
    this.height = double.infinity,
    this.constraints,
    this.transform,
    this.transformAlignment,
    required this.child,
    this.clipBehavior = Clip.none,
  }) : assert(
          (!(decoration != null && decorationImageKey != null)),
          'Either decoration or decorationImageKey can be provided, but not both.',
        );

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry _margin =
        margin ?? EdgeInsets.all(EzConfig.get(marginKey));

    Decoration? buildDecoration() {
      if (decorationImageKey == null) {
        return null;
      }

      final String? imagePath = EzConfig.get(decorationImageKey!);

      if (imagePath == null || imagePath == noImageValue) {
        return null;
      } else {
        return BoxDecoration(
          image: DecorationImage(
            image: provideImage(imagePath),
            fit: BoxFit.fill,
          ),
        );
      }
    }

    return Container(
      key: key,
      alignment: alignment,
      padding: _margin,
      decoration: decoration ?? buildDecoration(),
      width: width,
      height: height,
      constraints: constraints,
      transform: transform,
      transformAlignment: transformAlignment,
      child: child,
      clipBehavior: clipBehavior,
    );
  }
}
