/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
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

  /// Whether [EzConfig.backgroundImagePath] should be used to decorate the screen
  final bool useImageDecoration;

  /// Optional [Decoration] background for the screen
  /// If provided, must set [useImageDecoration] to false
  final Decoration? decoration;

  /// Screen width
  final double width;

  /// Screen height
  final double height;

  /// Custom [Container] that creates a standard screen for [EzConfig] powered apps
  const EzScreen(
    this.child, {
    super.key,
    this.alignment,
    this.margin,
    this.useImageDecoration = true,
    this.decoration,
    this.height = double.infinity,
    this.width = double.infinity,
  });

  Decoration? buildDecoration() {
    if (!useImageDecoration) return null;

    final String path = EzConfig.backgroundImagePath;
    if (path == noImageValue) return null;

    final int? isColor = int.tryParse(path);
    if (isColor != null) return BoxDecoration(color: Color(isColor));

    return BoxDecoration(image: EzConfig.backgroundImage);
  }

  @override
  Widget build(BuildContext context) => Container(
        alignment: alignment,
        padding: margin ?? EdgeInsets.all(EzConfig.marginVal),
        decoration: decoration ?? buildDecoration(),
        height: height,
        width: width,
        child: child,
      );
}
