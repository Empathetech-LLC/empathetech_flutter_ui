/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzScreen extends StatelessWidget {
  /// Screen content
  final Widget child;

  /// [Container.alignment] passthrough
  final AlignmentGeometry? alignment;

  /// Margin around the screen content
  final EdgeInsetsGeometry? margin;

  /// Optional [Decoration] background for the screen
  /// If provided, must set [useImageDecoration] to false
  final Decoration? decoration;

  /// Whether the [darkDecorationImageKey]/[lightDecorationImageKey] should be used
  final bool useImageDecoration;

  /// [EzConfig] key that will be used to create a [DecorationImage] background for the screen (dark theme)
  final String darkDecorationImageKey;

  /// [EzConfig] key that will be used to create a [DecorationImage] background for the screen (light theme)
  final String lightDecorationImageKey;

  /// Screen width
  final double width;

  /// Screen height
  final double height;

  /// [Container.constraints] passthrough
  final BoxConstraints? constraints;

  /// [Container.transform] passthrough
  final Matrix4? transform;

  /// [Container.transformAlignment] passthrough
  final AlignmentGeometry? transformAlignment;

  /// [Container.clipBehavior] passthrough
  final Clip clipBehavior;

  /// [Container] wrapper that defaults to max size with a "margin" from [EzConfig]
  /// In this case, the screen's "margin" is the actually the [Container.padding]
  const EzScreen(
    this.child, {
    super.key,
    this.alignment,
    this.margin,
    this.decoration,
    this.useImageDecoration = true,
    this.darkDecorationImageKey = darkBackgroundImageKey,
    this.lightDecorationImageKey = lightBackgroundImageKey,
    this.width = double.infinity,
    this.height = double.infinity,
    this.constraints,
    this.transform,
    this.transformAlignment,
    this.clipBehavior = Clip.none,
  });

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry screenMargin =
        margin ?? EdgeInsets.all(EzConfig.margin);

    Decoration? buildDecoration() {
      if (!useImageDecoration) return null;

      final String decorationKey = isDarkTheme(context)
          ? darkDecorationImageKey
          : lightDecorationImageKey;
      final String? imagePath = EzConfig.get(decorationKey);

      if (imagePath == null || imagePath == noImageValue) {
        return null;
      } else {
        final int? isColor = int.tryParse(imagePath);
        if (isColor != null) return BoxDecoration(color: Color(isColor));

        final BoxFit? fit =
            ezFitFromName(EzConfig.get('$decorationKey$boxFitSuffix'));

        return BoxDecoration(
          image: DecorationImage(image: ezImageProvider(imagePath), fit: fit),
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
  /// For fancier solutions, see https://api.flutter.dev/flutter/widgets/TwoDimensionalScrollView-class.html
  EzScreen.hScroll(
    Widget kid, {
    super.key,
    this.alignment,
    this.margin,
    this.decoration,
    this.useImageDecoration = true,
    this.darkDecorationImageKey = darkBackgroundImageKey,
    this.lightDecorationImageKey = lightBackgroundImageKey,
    this.width = double.infinity,
    this.height = double.infinity,
    this.constraints,
    this.transform,
    this.transformAlignment,
    this.clipBehavior = Clip.none,
  }) : child = EzScrollView(
          scrollDirection: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          child: kid,
        );

  /// [EzScreen] with a [EzScrollView] as the top level child
  /// For fancier solutions, see https://api.flutter.dev/flutter/widgets/TwoDimensionalScrollView-class.html
  EzScreen.vScroll(
    Widget kid, {
    super.key,
    this.alignment,
    this.margin,
    this.decoration,
    this.useImageDecoration = true,
    this.darkDecorationImageKey = darkBackgroundImageKey,
    this.lightDecorationImageKey = lightBackgroundImageKey,
    this.width = double.infinity,
    this.height = double.infinity,
    this.constraints,
    this.transform,
    this.transformAlignment,
    this.clipBehavior = Clip.none,
  }) : child = EzScrollView(child: kid);
}
