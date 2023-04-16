library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzIcon extends Icon {
  /// Styles an [Icon] from [EzConfig.prefs]
  EzIcon(
    IconData? icon, {
    Key? key,
    double? size,
    double? fill,
    double? weight,
    double? grade,
    double? opticalSize,
    Color? color,
    List<Shadow>? shadows,
    String? semanticLabel,
    TextDirection? textDirection,
  }) : super(
          icon,
          key: key,
          size: size ?? buildTextStyle(styleKey: buttonStyleKey).fontSize,
          fill: fill,
          weight: weight,
          grade: grade,
          opticalSize: opticalSize,
          color: color ?? Color(EzConfig.prefs[buttonTextColorKey]),
          shadows: shadows,
          semanticLabel: semanticLabel,
          textDirection: textDirection,
        );
}
