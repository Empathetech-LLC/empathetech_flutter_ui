library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Maintains some prebuilt [TextStyle]s styled from [EzConfig]
/// Optionally overwrite any values
TextStyle buildTextStyle({
  bool inherit = true,
  required String style,
  Color? color,
  Color? backgroundColor,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  double? letterSpacing,
  double? wordSpacing,
  TextBaseline? textBaseline,
  double? height,
  TextLeadingDistribution? leadingDistribution,
  Locale? locale,
  Paint? foreground,
  Paint? background,
  List<Shadow>? shadows,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
  String? debugLabel,
  String? fontFamily,
  List<String>? fontFamilyFallback,
  String? package,
  TextOverflow? overflow,
}) {
  late String currFontFamily = gStyle(EzConfig.prefs[fontFamilyKey]).fontFamily!;

  late double currSize = EzConfig.prefs[fontSizeKey];

  late Color themeTextColor = Color(EzConfig.prefs[themeTextColorKey]);
  late Color buttonTextColor = Color(EzConfig.prefs[buttonTextColorKey]);

  switch (style) {
    case headerStyleKey:
      return TextStyle(
        inherit: inherit,
        fontFamily: fontFamily ?? currFontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        fontSize: fontSize ?? currSize * 2.0,
        color: color ?? themeTextColor,
        backgroundColor: backgroundColor,
        fontWeight: fontWeight ?? FontWeight.bold,
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
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        overflow: overflow,
      );

    case titleStyleKey:
      return TextStyle(
        inherit: inherit,
        fontFamily: fontFamily ?? currFontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        fontSize: fontSize ?? currSize * 1.5,
        color: color ?? themeTextColor,
        backgroundColor: backgroundColor,
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
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        overflow: overflow,
      );

    case subTitleStyleKey:
    case dialogTitleStyleKey:
      return TextStyle(
        inherit: inherit,
        fontFamily: fontFamily ?? currFontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        fontSize: fontSize ?? currSize * 1.25,
        color: color ?? themeTextColor,
        backgroundColor: backgroundColor,
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
        decoration: decoration ?? TextDecoration.underline,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        overflow: overflow,
      );

    case defaultStyleKey:
    case dialogContentStyleKey:
      return TextStyle(
        inherit: inherit,
        fontFamily: fontFamily ?? currFontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        fontSize: fontSize ?? currSize,
        color: color ?? themeTextColor,
        backgroundColor: backgroundColor,
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
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        overflow: overflow,
      );

    case buttonStyleKey:
    case colorSettingStyleKey:
    case fontSettingStyleKey:
    case imageSettingStyleKey:
    case sliderSettingStyleKey:
      return TextStyle(
        inherit: inherit,
        fontFamily: fontFamily ?? currFontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        fontSize: fontSize ?? currSize,
        color: color ?? buttonTextColor,
        backgroundColor: backgroundColor,
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
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        overflow: overflow,
      );

    case errorStyleKey:
    default:
      return TextStyle(
        fontSize: 48,
        color: Colors.red,
        fontWeight: FontWeight.bold,
      );
  }
}

const String defaultStyleKey = 'defaultStyle';
const String headerStyleKey = 'headerStyle';
const String titleStyleKey = 'titleStyle';
const String subTitleStyleKey = 'subTitleStyle';
const String dialogTitleStyleKey = 'dialogTitleStyle';
const String buttonStyleKey = 'buttonStyle';
const String dialogContentStyleKey = 'dialogContentStyle';
const String colorSettingStyleKey = 'colorSettingStyle';
const String imageSettingStyleKey = 'imageSettingStyle';
const String fontSettingStyleKey = 'fontSettingStyle';
const String sliderSettingStyleKey = 'sliderSettingStyle';
const String errorStyleKey = 'errorStyle';
