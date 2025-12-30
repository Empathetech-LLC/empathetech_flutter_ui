/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';

class EzCheckbox extends StatelessWidget {
  /// Defaults to [EdgeInsets.all] with [EzConfig.margin]s when [scale] > 1.1
  final EdgeInsetsGeometry? padding;

  /// [Checkbox.value] passthrough
  final bool? value;

  /// [Checkbox.tristate] passthrough
  final bool tristate;

  /// [Checkbox.onChanged] passthrough
  final ValueChanged<bool?>? onChanged;

  /// Defaults to max([EzConfig.iconSize] / [EzConfig.getDefault], 1.0)
  final double? scale;

  /// [Checkbox.mouseCursor] passthrough
  final MouseCursor? mouseCursor;

  /// [Checkbox.activeColor] passthrough
  final Color? activeColor;

  /// [Checkbox.checkColor] passthrough
  final Color? checkColor;

  /// [Checkbox.focusColor] passthrough
  final Color? focusColor;

  /// [Checkbox.hoverColor] passthrough
  final Color? hoverColor;

  /// [Checkbox.splashRadius] passthrough
  final double? splashRadius;

  /// [Checkbox.materialTapTargetSize] passthrough
  final MaterialTapTargetSize? materialTapTargetSize;

  /// [Checkbox.visualDensity] passthrough
  final VisualDensity? visualDensity;

  /// [Checkbox.focusNode] passthrough
  final FocusNode? focusNode;

  /// [Checkbox.autofocus] passthrough
  final bool autofocus;

  /// [Checkbox.shape] passthrough
  final OutlinedBorder? shape;

  /// [Checkbox.side] passthrough
  final BorderSide? side;

  /// [Checkbox.isError] passthrough
  final bool isError;

  /// [Checkbox.semanticLabel] passthrough
  final String? semanticLabel;

  /// [Checkbox] with custom styling and scaling
  const EzCheckbox({
    super.key,
    this.padding,
    this.value,
    this.tristate = false,
    this.onChanged,
    this.scale,
    this.mouseCursor,
    this.activeColor,
    this.checkColor,
    this.focusColor,
    this.hoverColor,
    this.splashRadius,
    this.materialTapTargetSize,
    this.visualDensity,
    this.focusNode,
    this.autofocus = false,
    this.shape,
    this.side,
    this.isError = false,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final double ratio = scale ?? ezIconRatio();

    return Padding(
      padding: ratio > 1.1
          ? padding ?? EzInsets.wrap(EzConfig.margin)
          : EdgeInsets.zero,
      child: Transform.scale(
        scale: max(1.0, ratio),
        child: Checkbox(
          value: value,
          tristate: tristate,
          onChanged: onChanged,
          mouseCursor: mouseCursor,
          activeColor: activeColor,
          checkColor: checkColor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          splashRadius: splashRadius,
          materialTapTargetSize: materialTapTargetSize,
          visualDensity: visualDensity,
          focusNode: focusNode,
          autofocus: autofocus,
          shape: shape,
          side: side,
          isError: isError,
          semanticLabel: semanticLabel,
        ),
      ),
    );
  }
}

class EzCheckboxPair extends StatelessWidget {
  /// [EzRow.reverseHands] passthrough
  final bool reverseHands;

  /// [EzRow.mainAxisSize] passthrough
  final MainAxisSize mainAxisSize;

  /// [EzRow.mainAxisAlignment] passthrough
  final MainAxisAlignment mainAxisAlignment;

  /// [EzRow.crossAxisAlignment] passthrough
  final CrossAxisAlignment crossAxisAlignment;

  /// [EzText.data] passthrough
  final String text;

  /// [EzText.useSurface] passthrough
  final bool useSurface;

  /// [EzText.style] passthrough
  final TextStyle? style;

  /// [EzText.strutStyle] passthrough
  final StrutStyle? strutStyle;

  /// [EzText.textAlign] passthrough
  final TextAlign? textAlign;

  /// [EzText.textDirection] passthrough
  final TextDirection? textDirection;

  /// [EzText.locale] passthrough
  final Locale? locale;

  /// [EzText.softWrap] passthrough
  final bool? softWrap;

  /// [EzText.overflow] passthrough
  final TextOverflow? overflow;

  /// [EzText.textScaler] passthrough
  final TextScaler? textScaler;

  /// [EzText.maxLines] passthrough
  final int? maxLines;

  /// [EzText.semanticsLabel] passthrough
  final String? semanticsLabel;

  /// [EzText.textWidthBasis] passthrough
  final TextWidthBasis? textWidthBasis;

  /// [EzText.textHeightBehavior] passthrough
  final TextHeightBehavior? textHeightBehavior;

  /// [EzText.selectionColor] passthrough
  final Color? selectionColor;

  /// [EzText.backgroundColor] passthrough
  final Color? backgroundColor;

  /// Defaults to max([EzConfig]s [iconSizeKey] / [defaultIconSize], 1.0)
  final double? scale;

  /// Defaults to [EdgeInsets.all] with [EzConfig]s [marginKey] when [scale] > 1.1
  final EdgeInsetsGeometry? padding;

  /// [Checkbox.value] passthrough
  final bool? value;

  /// [Checkbox.tristate] passthrough
  final bool tristate;

  /// [Checkbox.onChanged] passthrough
  final ValueChanged<bool?>? onChanged;

  /// [Checkbox.mouseCursor] passthrough
  final MouseCursor? mouseCursor;

  /// [Checkbox.activeColor] passthrough
  final Color? activeColor;

  /// [Checkbox.checkColor] passthrough
  final Color? checkColor;

  /// [Checkbox.focusColor] passthrough
  final Color? focusColor;

  /// [Checkbox.hoverColor] passthrough
  final Color? hoverColor;

  /// [Checkbox.splashRadius] passthrough
  final double? splashRadius;

  /// [Checkbox.materialTapTargetSize] passthrough
  final MaterialTapTargetSize? materialTapTargetSize;

  /// [Checkbox.visualDensity] passthrough
  final VisualDensity? visualDensity;

  /// [Checkbox.focusNode] passthrough
  final FocusNode? focusNode;

  /// [Checkbox.autofocus] passthrough
  final bool autofocus;

  /// [Checkbox.shape] passthrough
  final OutlinedBorder? shape;

  /// [Checkbox.side] passthrough
  final BorderSide? side;

  /// [Checkbox.isError] passthrough
  final bool isError;

  /// [Checkbox.semanticLabel] passthrough
  final String? semanticLabel;

  const EzCheckboxPair({
    super.key,
    // EzRow
    this.reverseHands = true,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,

    // EzText
    required this.text,
    this.useSurface = false,
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

    // EzCheckbox
    this.scale,
    this.padding,
    this.value,
    this.tristate = false,
    this.onChanged,
    this.mouseCursor,
    this.activeColor,
    this.checkColor,
    this.focusColor,
    this.hoverColor,
    this.splashRadius,
    this.materialTapTargetSize,
    this.visualDensity,
    this.focusNode,
    this.autofocus = false,
    this.shape,
    this.side,
    this.isError = false,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return EzRow(
      reverseHands: reverseHands,
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: <Widget>[
        Flexible(
          child: EzText(
            text,
            useSurface: useSurface,
            style: style,
            strutStyle: strutStyle,
            textAlign: textAlign,
            textDirection: textDirection,
            locale: locale,
            softWrap: softWrap,
            overflow: overflow,
            textScaler: textScaler,
            maxLines: maxLines,
            semanticsLabel: semanticsLabel,
            textWidthBasis: textWidthBasis,
            textHeightBehavior: textHeightBehavior,
            selectionColor: selectionColor,
            backgroundColor: backgroundColor,
          ),
        ),
        EzCheckbox(
          scale: scale,
          padding: padding,
          value: value,
          tristate: tristate,
          onChanged: onChanged,
          mouseCursor: mouseCursor,
          activeColor: activeColor,
          checkColor: checkColor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          splashRadius: splashRadius,
          materialTapTargetSize: materialTapTargetSize,
          visualDensity: visualDensity,
          focusNode: focusNode,
          autofocus: autofocus,
          shape: shape,
          side: side,
          isError: isError,
          semanticLabel: semanticLabel,
        ),
      ],
    );
  }
}
