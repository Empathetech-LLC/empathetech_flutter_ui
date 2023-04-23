library empathetech_flutter_ui;

import 'dart:ui';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzTextStyle extends TextStyle {
  final bool inherit;
  final Color? color;
  final Color? backgroundColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? letterSpacing;

  /// Default: 1.25
  final double wordSpacing;

  final TextBaseline? textBaseline;

  /// Default: 1.5
  final double height;

  final TextLeadingDistribution? leadingDistribution;
  final Locale? locale;
  final Paint? foreground;
  final Paint? background;
  final List<Shadow>? shadows;
  final List<FontFeature>? fontFeatures;
  final List<FontVariation>? fontVariations;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;
  final String? debugLabel;

  /// Default: [googleStyles] -> [EzConfig.prefs] -> [fontFamilyKey].fontFamily
  final String? fontFamily;

  final List<String>? fontFamilyFallback;
  final String? package;
  final TextOverflow? overflow;

  /// Setup a [TextStyle] using the [fontFamilyKey] from [EzConfig.prefs]
  /// And some custom spacing defaults for readability
  EzTextStyle({
    this.inherit = true,
    this.color,
    this.backgroundColor,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing = 1.25,
    this.textBaseline,
    this.height = 1.5,
    this.leadingDistribution,
    this.locale,
    this.foreground,
    this.background,
    this.shadows,
    this.fontFeatures,
    this.fontVariations,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.debugLabel,
    this.fontFamily,
    this.fontFamilyFallback,
    this.package,
    this.overflow,
  }) : super(
          inherit: inherit,
          color: color,
          backgroundColor: backgroundColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing,
          textBaseline: textBaseline,
          height: height,
          leadingDistribution: leadingDistribution,
          locale: locale,
          foreground: foreground,
          background: background,
          shadows: shadows,
          fontFeatures: fontFeatures,
          fontVariations: fontVariations,
          decoration: decoration,
          decorationColor: decorationColor,
          decorationStyle: decorationStyle,
          decorationThickness: decorationThickness,
          debugLabel: debugLabel,
          fontFamily: fontFamily ??
              googleStyles[(EzConfig.prefs[fontFamilyKey])]?.fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          package: package,
          overflow: overflow,
        );
}
