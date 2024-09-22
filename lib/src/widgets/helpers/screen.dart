/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzScreen extends StatelessWidget {
  /// Alignment of screen context
  final AlignmentGeometry? alignment;

  /// Margin around the screen content
  final EdgeInsetsGeometry? margin;

  /// Optional [Decoration] background for the screen
  /// If provided, must set [useImageDecoration] to false
  final Decoration? decoration;

  /// Whether the [darkDecorationImageKey] and [lightDecorationImageKey] should be used
  final bool useImageDecoration;

  /// [EzConfig] key that will be used to create a [DecorationImage] background for the screen (dark theme)
  final String darkDecorationImageKey;

  /// [EzConfig] key that will be used to create a [DecorationImage] background for the screen (light theme)
  final String lightDecorationImageKey;

  /// Screen width
  final double width;

  /// Screen height
  final double height;

  final BoxConstraints? constraints;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final Clip clipBehavior;
  final Widget child;

  /// [Container] wrapper that defaults to max size with a "margin" from [EzConfig]
  /// In this case, the screen's "margin" is the actually the Container's padding
  const EzScreen({
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
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry screenMargin = margin ?? EzMargin();

    Decoration? buildDecoration() {
      if (!useImageDecoration) return null;

      final bool isDark = PlatformTheme.of(context)?.isDark ??
          (MediaQuery.of(context).platformBrightness == Brightness.dark);

      final String? imagePath = EzConfig.get(
        isDark ? darkDecorationImageKey : lightDecorationImageKey,
      );

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
    this.useImageDecoration = true,
    this.darkDecorationImageKey = darkBackgroundImageKey,
    this.lightDecorationImageKey = lightBackgroundImageKey,
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
    this.useImageDecoration = true,
    this.darkDecorationImageKey = darkBackgroundImageKey,
    this.lightDecorationImageKey = lightBackgroundImageKey,
    this.width = double.infinity,
    this.height = double.infinity,
    this.constraints,
    this.transform,
    this.transformAlignment,
    this.clipBehavior = Clip.none,
    required Widget kid,
  }) : child = EzScrollView(child: kid);
}
