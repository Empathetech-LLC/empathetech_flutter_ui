library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class EzRichText extends SelectableText {
  final TextSpan textSpan;
  final Key? key;
  final FocusNode? focusNode;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final double? textScaleFactor;

  /// Default: false
  final bool showCursor;

  /// Default: false
  final bool autofocus;

  final int? minLines;
  final int? maxLines;

  /// Default: 2.0
  final double cursorWidth;

  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;

  /// Default: true
  final bool enableInteractiveSelection;

  final TextSelectionControls? selectionControls;
  final void Function()? onTap;
  final ScrollPhysics? scrollPhysics;
  final String? semanticsLabel;
  final TextHeightBehavior? textHeightBehavior;
  final TextWidthBasis? textWidthBasis;
  final void Function(TextSelection, SelectionChangedCause?)?
      onSelectionChanged;
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// Builds a [SelectableText.rich] with styling from [EzConfig]
  EzRichText(
    this.textSpan, {
    this.key,
    this.focusNode,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.center,
    this.textDirection,
    this.textScaleFactor,
    this.showCursor = false,
    this.autofocus = false,
    this.minLines,
    this.maxLines,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.onTap,
    this.scrollPhysics,
    this.semanticsLabel,
    this.textHeightBehavior,
    this.textWidthBasis,
    this.onSelectionChanged,
    this.magnifierConfiguration,
  }) : super.rich(
          textSpan,
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

  /// Quickly build a [TextSpan] with a [TapGestureRecognizer] to run [action]
  static TextSpan link({
    required String text,
    required void Function() action,
    TextStyle? style,
    MouseCursor? mouseCursor,
    void Function(PointerEnterEvent)? onEnter,
    void Function(PointerExitEvent)? onExit,
    String? semanticsLabel,
    Locale? locale,
    bool? spellOut,
  }) {
    return TextSpan(
      text: text,
      recognizer: TapGestureRecognizer()..onTap = action,
      style: style,
      mouseCursor: mouseCursor,
      onEnter: onEnter,
      onExit: onExit,
      semanticsLabel: semanticsLabel,
      locale: locale,
      spellOut: spellOut,
    );
  }

  /// Quickly build a [TextSpan] with a [TapGestureRecognizer] to [openLink] the [url]
  static TextSpan webLink({
    required String text,
    required Uri url,
    TextStyle? style,
    MouseCursor? mouseCursor,
    void Function(PointerEnterEvent)? onEnter,
    void Function(PointerExitEvent)? onExit,
    String? semanticsLabel,
    Locale? locale,
    bool? spellOut,
  }) {
    return TextSpan(
      text: text,
      recognizer: TapGestureRecognizer()..onTap = () => openLink(url),
      style: style,
      mouseCursor: mouseCursor,
      onEnter: onEnter,
      onExit: onExit,
      semanticsLabel: semanticsLabel,
      locale: locale,
      spellOut: spellOut,
    );
  }
}
