/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class EzRichText extends StatelessWidget {
  final List<InlineSpan> children;
  final Key? key;
  final FocusNode? focusNode;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final double? textScaleFactor;
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

  /// [TextSpan] wrapper with customized defaults and pre-configured [Semantics]
  /// Recommended to use [EzPlainText] rather than [TextSpan]
  /// Also see [EzInlineLink]
  EzRichText(
    this.children, {
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
  });

  String _buildSemantics() {
    StringBuffer message = StringBuffer("");

    for (InlineSpan child in children) {
      switch (child.runtimeType) {
        case TextSpan:
          TextSpan textChild = child as TextSpan;
          message.writeAll([textChild.semanticsLabel ?? textChild.text, " "]);
          break;
        case EzPlainText:
          EzPlainText textChild = child as EzPlainText;
          message.writeAll([textChild.semantics ?? textChild.text, " "]);
          break;
        case EzInlineLink:
          EzInlineLink linkChild = child as EzInlineLink;
          message.writeAll([linkChild.text, " "]);
          break;
        default:
          break;
      }
    }

    return message.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: _buildSemantics(),
      child: SelectableText.rich(
        TextSpan(children: children),
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
        selectionHeightStyle: selectionHeightStyle,
        dragStartBehavior: dragStartBehavior,
        enableInteractiveSelection: enableInteractiveSelection,
        selectionControls: selectionControls,
        scrollPhysics: scrollPhysics,
        textHeightBehavior: textHeightBehavior,
        textWidthBasis: textWidthBasis,
        onSelectionChanged: onSelectionChanged,
        magnifierConfiguration: magnifierConfiguration,
      ),
    );
  }
}
