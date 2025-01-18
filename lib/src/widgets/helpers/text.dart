/* empathetech_flutter_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzTextBackground extends StatelessWidget {
  /// The [Text] that needs a background
  final Widget text;

  /// Defaults to [EzInsets.wrap]
  final EdgeInsets? margin;

  /// Defaults to [ezRoundEdge]
  final BorderRadiusGeometry? borderRadius;

  /// Will use surface container if false
  final bool useSurface;

  /// Optional background color override
  /// Can ignore [useSurface] if this is set
  final Color? backgroundColor;

  /// Create a [Container] for your [text] with a background color that automatically responds to [textBackgroundOpacityKey]
  const EzTextBackground(
    this.text, {
    super.key,
    this.margin,
    this.borderRadius,
    this.useSurface = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    late final String oKey = isDarkTheme(context)
        ? darkTextBackgroundOpacityKey
        : lightTextBackgroundOpacityKey;

    late final double percent =
        EzConfig.get(oKey) ?? EzConfig.getDefault(oKey) ?? 0.0;

    final Color color = (backgroundColor == null)
        ? useSurface
            ? Theme.of(context).colorScheme.surface.withValues(alpha: percent)
            : Theme.of(context)
                .colorScheme
                .surfaceContainer
                .withValues(alpha: percent)
        : backgroundColor!;

    return Container(
      padding: margin ?? EzInsets.wrap(EzConfig.get(marginKey)),
      decoration: BoxDecoration(
        color: color,
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
  /// Default to [TextTheme.bodyLarge]
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

  /// Quick wrapper for creating [Text] with a default [EzTextBackground]
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
    );
  }
}
