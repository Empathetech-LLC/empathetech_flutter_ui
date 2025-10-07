/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzTextBackground extends StatelessWidget {
  /// The [Widget] that needs a background
  /// Doesn't have to be [Text]
  final Widget text;

  /// Defaults to [EzInsets.wrap] with [marginKey]
  final EdgeInsets? margin;

  /// Defaults to [ezRoundEdge]
  final BorderRadiusGeometry? borderRadius;

  /// false (default): [ColorScheme.surfaceContainer]
  /// true: [ColorScheme.surface]
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
    this.margin,
    this.borderRadius,
    this.useSurface = false,
    this.backgroundColor,
  });

  Color _color(BuildContext context, double percent) {
    if (backgroundColor != null) {
      return backgroundColor!;
    }

    late final Color baseColor;
    if (useSurface == null) {
      baseColor = Theme.of(context).colorScheme.surfaceDim;
    } else if (useSurface!) {
      baseColor = Theme.of(context).colorScheme.surface;
    } else {
      baseColor = Theme.of(context).colorScheme.surfaceContainer;
    }

    return baseColor.withValues(alpha: percent);
  }

  @override
  Widget build(BuildContext context) {
    late final String oKey = isDarkTheme(context)
        ? darkTextBackgroundOpacityKey
        : lightTextBackgroundOpacityKey;

    return Container(
      padding: margin ?? EzInsets.wrap(EzConfig.get(marginKey)),
      decoration: BoxDecoration(
        color: _color(context, EzConfig.get(oKey)),
        borderRadius: borderRadius ?? ezRoundEdge,
      ),
      child: text,
    );
  }
}

class EzText extends StatelessWidget {
  /// [EzTextBackground.useSurface] passthrough
  final bool useSurface;

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

  /// [EzTextBackground.backgroundColor] passthrough
  final Color? backgroundColor;

  /// Quick wrapper for creating [Text] with a default [EzTextBackground]
  /// [style] defaults to [TextTheme.bodyLarge]
  const EzText(
    this.data, {
    this.useSurface = false,
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
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return EzTextBackground(
      Text(
        data,
        style: style ?? Theme.of(context).textTheme.bodyLarge,
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
      useSurface: useSurface,
      backgroundColor: backgroundColor,
    );
  }
}

class EzNewLine extends StatelessWidget {
  /// [Text.style] passthrough
  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? style;

  /// [Text.textAlign] passthrough
  /// Defaults to [TextAlign.start]
  final TextAlign? textAlign;

  /// Quick wrapper for creating a [TextStyle]d blank line
  const EzNewLine({
    super.key,
    this.style,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Text(
        '',
        style: style ?? Theme.of(context).textTheme.bodyLarge,
        textAlign: textAlign ?? TextAlign.start,
      ),
    );
  }
}

/// [TextTheme.bodyLarge] line with [TextAlign.start]
const Widget ezStartLine = EzNewLine();

/// [TextTheme.bodyLarge] line with [TextAlign.center]
const Widget ezCenterLine = EzNewLine(textAlign: TextAlign.center);

/// [TextTheme.bodyLarge] line with [TextAlign.end]
const Widget ezEndLine = EzNewLine(textAlign: TextAlign.end);
