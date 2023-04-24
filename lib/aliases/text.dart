library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

/// Quickly build a [TextSpan] with a [TapGestureRecognizer] to run [action]
TextSpan link({
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
TextSpan webLink({
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
