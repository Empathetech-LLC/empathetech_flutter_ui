/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class EzLink extends SelectableText {
  /// Link message
  final String text;

  final TextStyle? style;

  /// Message for screen readers
  final String semanticsLabel;

  /// Destination function
  final void Function()? onTap;

  /// Destination URL
  final Uri? url;

  final Key? key;
  final FocusNode? focusNode;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextScaler? textScaler;
  final bool showCursor;
  final bool autofocus;
  final int? minLines;
  final int? maxLines;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final BoxHeightStyle selectionHeightStyle;
  final BoxWidthStyle selectionWidthStyle;
  final DragStartBehavior dragStartBehavior;
  final bool enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final ScrollPhysics scrollPhysics;
  final TextHeightBehavior? textHeightBehavior;
  final TextWidthBasis? textWidthBasis;
  final void Function(TextSelection, SelectionChangedCause?)?
      onSelectionChanged;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// [SelectableText.rich] wrapper that either opens an internal link via [onTap]
  /// Or an external link to [url]
  /// Requires [semanticsLabel] for screen readers
  EzLink(
    this.text, {
    this.style,
    required this.semanticsLabel,
    this.onTap,
    this.url,
    this.key,
    this.focusNode,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.textScaler,
    this.showCursor = false,
    this.autofocus = false,
    this.minLines,
    this.maxLines,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.selectionHeightStyle = BoxHeightStyle.tight,
    this.selectionWidthStyle = BoxWidthStyle.tight,
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.scrollPhysics = const NeverScrollableScrollPhysics(),
    this.textHeightBehavior,
    this.textWidthBasis,
    this.onSelectionChanged,
    this.contextMenuBuilder,
    this.magnifierConfiguration,
  })  : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.'),
        super.rich(
          TextSpan(
            text: text,
            style: style,
            mouseCursor: SystemMouseCursors.click,
          ),
          key: key,
          focusNode: focusNode,
          style: style,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          textScaler: textScaler,
          showCursor: showCursor,
          autofocus: autofocus,
          minLines: minLines,
          maxLines: maxLines,
          cursorWidth: cursorWidth,
          cursorHeight: cursorHeight,
          cursorRadius: cursorRadius,
          cursorColor: cursorColor,
          selectionHeightStyle: selectionHeightStyle,
          dragStartBehavior: dragStartBehavior,
          enableInteractiveSelection: enableInteractiveSelection,
          selectionControls: selectionControls,
          onTap: onTap ?? () => launchUrl(url!),
          scrollPhysics: scrollPhysics,
          semanticsLabel: semanticsLabel,
          textHeightBehavior: textHeightBehavior,
          textWidthBasis: textWidthBasis,
          onSelectionChanged: onSelectionChanged,
          magnifierConfiguration: magnifierConfiguration,
        );
}
