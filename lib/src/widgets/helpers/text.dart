/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzTextBackground extends StatelessWidget {
  /// The [Widget] that needs a background
  /// Doesn't have to be [Text]
  final Widget text;

  /// Defaults to [EzInsets.wrap] with [EzConfig.marginVal]
  final EdgeInsets? padding;

  /// Defaults to [ezRoundEdge]
  /// moot if [buttonShape] is true
  final BorderRadiusGeometry? borderRadius;

  /// Match the current [EzConfig.buttonShape]
  /// Takes priority over [borderRadius]
  final bool buttonShape;

  /// true: [ColorScheme.surface]
  /// false (default): [ColorScheme.surfaceContainer]
  /// null: [ColorScheme.surfaceDim]
  /// Quantum supremacy achieved
  final bool? useSurface;

  /// Optional override
  /// Will ignore [useSurface] if this is set
  final Color? backgroundColor;

  /// Create a [Container] for your [text] with a background color that automatically responds to [lightTextBackgroundOpacityKey]/[darkTextBackgroundOpacityKey]
  const EzTextBackground(
    this.text, {
    super.key,
    this.padding,
    this.borderRadius,
    this.buttonShape = false,
    this.useSurface = false,
    this.backgroundColor,
  });

  Color _color(double percent) {
    if (backgroundColor != null) {
      return backgroundColor!;
    }

    late final Color baseColor;
    switch (useSurface) {
      case true:
        baseColor = EzConfig.colors.surface;
      case false:
        baseColor = EzConfig.colors.surfaceContainer;
      case null:
        baseColor = EzConfig.colors.surfaceDim;
    }

    return baseColor.withValues(alpha: percent);
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: padding ?? EzInsets.wrap(EzConfig.marginVal),
        decoration: buttonShape
            ? ShapeDecoration(
                color: _color(EzConfig.textBackgroundOpacity),
                shape: EzConfig.buttonShape.shape,
              )
            : BoxDecoration(
                color: _color(EzConfig.textBackgroundOpacity),
                borderRadius: borderRadius ?? ezRoundEdge,
              ),
        child: text,
      );
}

class EzText extends StatelessWidget {
  /// [Text.data] passthrough
  final String data;

  /// [Text.style] passthrough
  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? style;

  /// [Text.strutStyle] passthrough
  final StrutStyle? strutStyle;

  /// [Text.textAlign] passthrough
  final TextAlign? textAlign;

  /// [Text.textDirection] passthrough
  final TextDirection? textDirection;

  /// [Text.locale] passthrough
  final Locale? locale;

  /// [Text.softWrap] passthrough
  final bool? softWrap;

  /// [Text.overflow] passthrough
  final TextOverflow? overflow;

  /// [Text.textScaler] passthrough
  final TextScaler? textScaler;

  /// [Text.maxLines] passthrough
  final int? maxLines;

  /// [Text.semanticsLabel] passthrough
  final String? semanticsLabel;

  /// [Text.textWidthBasis] passthrough
  final TextWidthBasis? textWidthBasis;

  /// [Text.textHeightBehavior] passthrough
  final TextHeightBehavior? textHeightBehavior;

  /// [Text.selectionColor] passthrough
  final Color? selectionColor;

  /// [EzTextBackground.padding] passthrough
  final EdgeInsets? padding;

  /// [EzTextBackground.borderRadius] passthrough
  /// moot if [buttonShape] is true
  final BorderRadiusGeometry? borderRadius;

  /// [EzTextBackground.buttonShape] passthrough
  final bool buttonShape;

  /// [EzTextBackground.useSurface] passthrough
  /// true: [ColorScheme.surface]
  /// false: [ColorScheme.surfaceContainer]
  /// null: [ColorScheme.surfaceDim]
  final bool? useSurface;

  /// [EzTextBackground.backgroundColor] passthrough
  final Color? backgroundColor;

  /// Quick wrapper for creating [Text] with a default [EzTextBackground]
  /// [style] defaults to [TextTheme.bodyLarge]
  const EzText(
    this.data, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
    this.padding,
    this.borderRadius,
    this.buttonShape = false,
    this.useSurface = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) => EzTextBackground(
        Text(
          data,
          style: style ?? EzConfig.styles.bodyLarge,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
          textWidthBasis: textWidthBasis,
          textHeightBehavior: textHeightBehavior,
          selectionColor: selectionColor,
        ),
        padding: padding,
        borderRadius: borderRadius,
        buttonShape: buttonShape,
        useSurface: useSurface,
        backgroundColor: backgroundColor,
      );
}

class EzNewLine extends StatelessWidget {
  /// [Text.style] passthrough
  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? style;

  /// [Text.textAlign] passthrough
  /// Defaults to [TextAlign.start]
  final TextAlign? textAlign;

  /// Quick wrapper for creating a [TextStyle]d blank line
  const EzNewLine({super.key, this.style, this.textAlign});

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
        child: Text(
          '',
          style: style ?? EzConfig.styles.bodyLarge,
          textAlign: textAlign ?? TextAlign.start,
        ),
      );
}
