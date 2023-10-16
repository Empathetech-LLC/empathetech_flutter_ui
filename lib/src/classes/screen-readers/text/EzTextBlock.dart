/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class EzTextBlock extends StatelessWidget {
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
  final void Function()? onTap;
  final ScrollPhysics scrollPhysics;
  final TextHeightBehavior? textHeightBehavior;
  final TextWidthBasis? textWidthBasis;
  final void Function(TextSelection, SelectionChangedCause?)?
      onSelectionChanged;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// [SelectableText.rich] wrapper with customized defaults and preconfigured [Semantics]
  /// For ideal behavior, please provide [EzPlainText]s rather than [TextSpan]s
  const EzTextBlock(
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
    this.onTap,
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
          message.writeAll([(child as TextSpan).text, " "]);
          break;
        case EzPlainText:
          message.writeAll([(child as EzPlainText).text, " "]);
          break;
        case EzLink:
          message.writeAll([(child as EzLink).text, " "]);
          break;
        case EzWebLink:
          message.writeAll([(child as EzWebLink).text, " "]);
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
        onTap: onTap,
        scrollPhysics: scrollPhysics,
        semanticsLabel: null,
        textHeightBehavior: textHeightBehavior,
        textWidthBasis: textWidthBasis,
        onSelectionChanged: onSelectionChanged,
        magnifierConfiguration: magnifierConfiguration,
      ),
    );
  }
}
