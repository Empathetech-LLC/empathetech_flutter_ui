library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

const String linkInsert = '_LINK_';

/// Get an appropriate [MainAxisAlignment] for a [Row] from the passed [TextAlign]
MainAxisAlignment matchTextAlign(TextAlign pair) {
  switch (pair) {
    case TextAlign.left:
      return MainAxisAlignment.start;
    case TextAlign.right:
      return MainAxisAlignment.end;
    case TextAlign.center:
      return MainAxisAlignment.center;
    case TextAlign.justify:
      return MainAxisAlignment.spaceEvenly;
    case TextAlign.start:
      return MainAxisAlignment.start;
    case TextAlign.end:
      return MainAxisAlignment.end;
  }
}

/// READ ME! Use case is very specific
/// Provide text [base] that has [linkInsert]s everywhere a link should be inserted
/// Provide a [String]->[Uri] list of [links] for each [linkInsert]
/// Changes will be made in order
/// A Row containing all of the [EzText] and [ezClickable] children will be returned
Row insertLinks({
  required String base,
  required List<Map<String, Uri>> links,
  required TextAlign textAlign,
  required TextStyle style,
  required TextStyle linkStyle,
}) {
  List<Widget> children = [];
  int currentIndex = 0;

  links.forEach((linkMap) {
    linkMap.forEach((text, url) {
      int linkPosition = base.indexOf(linkInsert, currentIndex);
      if (linkPosition == -1) return;

      // Add text before the link
      children.add(
        EzText(
          base.substring(currentIndex, linkPosition),
          style: style,
          textAlign: textAlign,
        ),
      );

      // Add the link
      children.add(
        ezClickable(
          onTap: () => openLink(url),
          child: EzText(text, style: linkStyle),
        ),
      );

      currentIndex = linkPosition + linkInsert.length;
    });
  });

  // Add the remaining text after the last link
  if (currentIndex < base.length) {
    children.add(
      EzText(
        base.substring(currentIndex),
        style: style,
        textAlign: textAlign,
      ),
    );
  }

  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: matchTextAlign(textAlign),
    children: children,
  );
}
