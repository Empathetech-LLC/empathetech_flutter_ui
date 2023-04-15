library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

const String linkInsert = '_LINK_';

/// Get an appropriate [MainAxisAlignment] for a [Row] from the passed [TextAlign]
MainAxisAlignment matchMainAlign(TextAlign pair) {
  switch (pair) {
    case TextAlign.left:
    case TextAlign.start:
      return MainAxisAlignment.start;
    case TextAlign.right:
    case TextAlign.end:
      return MainAxisAlignment.end;
    case TextAlign.center:
      return MainAxisAlignment.center;
    case TextAlign.justify:
      return MainAxisAlignment.spaceEvenly;
  }
}

/// Get an appropriate [CrossAxisAlignment] for a [Row] from the passed [TextAlign]
CrossAxisAlignment matchCrossAlign(TextAlign pair) {
  switch (pair) {
    case TextAlign.left:
    case TextAlign.start:
      return CrossAxisAlignment.start;
    case TextAlign.right:
    case TextAlign.end:
      return CrossAxisAlignment.end;
    case TextAlign.center:
    default:
      return CrossAxisAlignment.center;
  }
}

/// READ ME! Use case is very specific
/// Provide text [base] that has [linkInsert]s everywhere a link should be inserted
/// Provide a [String]->[Uri] list of [links] for each [linkInsert]
/// Changes will be made in order
/// A Row containing all of the [EzText] and [ezClickable] children will be returned
Widget insertLinks({
  required String base,
  required List<Map<String, Uri>> links,
  required TextAlign textAlign,
  required TextStyle style,
  required TextStyle linkStyle,
}) {
  List<TextSpan> textSpans = [];
  int currentIndex = 0;

  links.forEach((linkMap) {
    linkMap.forEach((text, url) {
      int linkPosition = base.indexOf(linkInsert, currentIndex);
      if (linkPosition == -1) return;

      // Add text before the link
      textSpans.add(
        TextSpan(
          text: base.substring(currentIndex, linkPosition).trim(),
          style: style,
        ),
      );

      // Add the link
      textSpans.add(
        TextSpan(
          text: text,
          style: linkStyle,
          recognizer: TapGestureRecognizer()..onTap = () => openLink(url),
        ),
      );

      currentIndex = linkPosition + linkInsert.length;
    });
  });

  // Add the remaining text after the last link
  if (currentIndex < base.length) {
    textSpans.add(
      TextSpan(
        text: base.substring(currentIndex).trim(),
        style: style,
      ),
    );
  }

  return RichText(
    text: TextSpan(
      children: textSpans,
    ),
    textAlign: textAlign,
  );
}
