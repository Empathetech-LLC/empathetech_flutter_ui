library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzText extends EzTextSpan {
  /// Builds a [SelectableText.rich] with styling from [EzConfig]
  /// A simple [TextSpan] will be created from [text]
  EzText(
    String text, {
    Key? key,
    FocusNode? focusNode,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign = TextAlign.center,
    TextDirection? textDirection,
    double? textScaleFactor,
    bool showCursor = false,
    bool autofocus = false,
    int? minLines,
    int? maxLines,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    bool enableInteractiveSelection = true,
    TextSelectionControls? selectionControls,
    void Function()? onTap,
    ScrollPhysics? scrollPhysics,
    String? semanticsLabel,
    TextHeightBehavior? textHeightBehavior,
    TextWidthBasis? textWidthBasis,
    void Function(TextSelection, SelectionChangedCause?)? onSelectionChanged,
    TextMagnifierConfiguration? magnifierConfiguration,
  }) : super(
          TextSpan(text: text),
          key: key,
          focusNode: focusNode,
          style: style,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          textScaleFactor: textScaleFactor,
          showCursor: showCursor,
          autofocus: autofocus,
          minLines: minLines,
          maxLines: maxLines,
          cursorWidth: cursorWidth,
          cursorHeight: cursorHeight,
          cursorRadius: cursorRadius,
          cursorColor: cursorColor,
          enableInteractiveSelection: enableInteractiveSelection,
          selectionControls: selectionControls,
          onTap: onTap,
          scrollPhysics: scrollPhysics,
          semanticsLabel: semanticsLabel,
          textHeightBehavior: textHeightBehavior,
          textWidthBasis: textWidthBasis,
          onSelectionChanged: onSelectionChanged,
          magnifierConfiguration: magnifierConfiguration,
        );
}
