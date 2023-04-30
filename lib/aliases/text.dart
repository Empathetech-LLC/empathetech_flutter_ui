library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

/// Simplified alias for [SelectableText.rich]
/// Defaults to [enableInteractiveSelection] && [TextAlign.center]
SelectableText ezRichText(
  TextSpan span, {
  TextStyle? style,
  TextAlign? textAlign = TextAlign.center,
  TextDirection? textDirection,
  double? textScaleFactor,
  int? minLines,
  int? maxLines,
  bool enableInteractiveSelection = true,
  TextSelectionControls? selectionControls,
  void Function()? onTap,
}) {
  return SelectableText.rich(
    span,
    style: style,
    textAlign: textAlign,
    textDirection: textDirection,
    textScaleFactor: textScaleFactor,
    minLines: minLines,
    maxLines: maxLines,
    enableInteractiveSelection: enableInteractiveSelection,
    selectionControls: selectionControls,
    onTap: onTap,
  );
}

/// Simplified alias for [TextSpan]
TextSpan ezTextSpan({
  String? text,
  List<InlineSpan>? children,
  TextStyle? style,
  GestureRecognizer? recognizer,
  MouseCursor? mouseCursor,
  void Function(PointerEnterEvent)? onEnter,
  void Function(PointerExitEvent)? onExit,
}) {
  return TextSpan(
    text: text,
    children: children,
    style: style,
    recognizer: recognizer,
    mouseCursor: mouseCursor,
    onEnter: onEnter,
    onExit: onExit,
  );
}

/// Quickly build a [TextSpan] with a [TapGestureRecognizer] to run [action]
TextSpan ezLink({
  required String text,
  required void Function() action,
  TextStyle? style,
  MouseCursor? mouseCursor,
  void Function(PointerEnterEvent)? onEnter,
  void Function(PointerExitEvent)? onExit,
}) {
  return ezTextSpan(
    text: text,
    recognizer: TapGestureRecognizer()..onTap = action,
    style: style,
    mouseCursor: mouseCursor,
    onEnter: onEnter,
    onExit: onExit,
  );
}

/// Quickly build a [TextSpan] with a [TapGestureRecognizer] to [openLink] the [url]
TextSpan ezWebLink({
  required String text,
  required Uri url,
  TextStyle? style,
  MouseCursor? mouseCursor,
  void Function(PointerEnterEvent)? onEnter,
  void Function(PointerExitEvent)? onExit,
}) {
  return ezTextSpan(
    text: text,
    recognizer: TapGestureRecognizer()..onTap = () => openLink(url),
    style: style,
    mouseCursor: mouseCursor,
    onEnter: onEnter,
    onExit: onExit,
  );
}
