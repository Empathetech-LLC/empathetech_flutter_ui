/// Styles a [PlatformSwitch] from [EzConfig.prefs]
library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzCheckBox extends Checkbox {
  final Key? key;
  final bool? value;

  /// Default:
  /// false
  final bool tristate;

  final void Function(bool?)? onChanged;
  final MouseCursor? mouseCursor;
  final Color? activeColor;

  /// Default:
  /// MaterialStateProperty.resolveWith(
  //   (states) {
  //     if (states.contains(MaterialState.selected)) {
  //       return Color(EzConfig.prefs[buttonColorKey]);
  //     } else {
  //       return Color(EzConfig.prefs[themeTextColorKey]);
  //     }
  //   },
  // )
  final MaterialStateProperty<Color?>? fillColor;

  /// Default:
  /// [EzConfig.prefs] -> buttonTextColorKey
  final Color? checkColor;

  final Color? focusColor;
  final Color? hoverColor;
  final MaterialStateProperty<Color?>? overlayColor;
  final double? splashRadius;
  final MaterialTapTargetSize? materialTapTargetSize;
  final VisualDensity? visualDensity;
  final FocusNode? focusNode;

  /// Default:
  /// false
  final bool autofocus;

  final OutlinedBorder? shape;
  final BorderSide? side;

  /// Default:
  /// false
  final bool isError;

  /// Styles a [Checkbox] with [EzConfig.prefs]
  EzCheckBox({
    this.key,
    required this.value,
    this.tristate = false,
    required this.onChanged,
    this.mouseCursor,
    this.activeColor,
    this.fillColor,
    this.checkColor,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.materialTapTargetSize,
    this.visualDensity,
    this.focusNode,
    this.autofocus = false,
    this.shape,
    this.side,
    this.isError = false,
  }) : super(
          key: key,
          value: value,
          tristate: tristate,
          onChanged: onChanged,
          mouseCursor: mouseCursor,
          activeColor: activeColor,
          fillColor: fillColor ??
              MaterialStateProperty.resolveWith(
                (states) {
                  if (states.contains(MaterialState.selected)) {
                    return Color(EzConfig.prefs[buttonColorKey]);
                  } else {
                    return Color(EzConfig.prefs[themeTextColorKey]);
                  }
                },
              ),
          checkColor: checkColor ?? Color(EzConfig.prefs[buttonTextColorKey]),
          focusColor: focusColor,
          hoverColor: hoverColor,
          overlayColor: overlayColor,
          splashRadius: splashRadius,
          materialTapTargetSize: materialTapTargetSize,
          visualDensity: visualDensity,
          focusNode: focusNode,
          autofocus: autofocus,
          shape: shape,
          side: side,
          isError: isError,
        );
}
