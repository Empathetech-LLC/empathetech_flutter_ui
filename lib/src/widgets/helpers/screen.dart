/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzScreen extends StatelessWidget {
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
  final Clip clipBehavior;
  final Widget child;

  /// [Container] wrapper that defaults to max size with a "margin" from [EzConfig]
  /// In this case, the screen's "margin" is the actually the Container's padding
  /// See [decorationImageKey] for easily setting a background image
  const EzScreen({
    super.key,
    this.alignment,
    this.margin,
    this.decoration,
    this.decorationImageKey,
    this.width = double.infinity,
    this.height = double.infinity,
    this.constraints,
    this.transform,
    this.transformAlignment,
    this.clipBehavior = Clip.none,
    required this.child,
  }) : assert(
          (!(decoration != null && decorationImageKey != null)),
          'Either decoration or decorationImageKey can be provided, but not both.',
        );

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry screenMargin =
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
      alignment: alignment,
      padding: screenMargin,
      decoration: decoration ?? buildDecoration(),
      width: width,
      height: height,
      constraints: constraints,
      transform: transform,
      transformAlignment: transformAlignment,
      clipBehavior: clipBehavior,
      child: child,
    );
  }

  /// [EzScreen] with a horizontal [EzScrollView] as the top level child
  EzScreen.hScroll({
    super.key,
    this.alignment,
    this.margin,
    this.decoration,
    this.decorationImageKey,
    this.width = double.infinity,
    this.height = double.infinity,
    this.constraints,
    this.transform,
    this.transformAlignment,
    this.clipBehavior = Clip.none,
    required Widget kid,
  }) : child = EzScrollView(
          scrollDirection: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          child: kid,
        );

  /// [EzScreen] with a [EzScrollView] as the top level child
  EzScreen.vScroll({
    super.key,
    this.alignment,
    this.margin,
    this.decoration,
    this.decorationImageKey,
    this.width = double.infinity,
    this.height = double.infinity,
    this.constraints,
    this.transform,
    this.transformAlignment,
    this.clipBehavior = Clip.none,
    required Widget kid,
  }) : child = EzScrollView(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          child: kid,
        );
}
