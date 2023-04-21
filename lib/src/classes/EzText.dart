library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

const String linkInsert = '_LINK_';

class EzText extends SelectableText {
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
  EzText(
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

  /// Builds a [SelectableText.rich] with styling from [EzConfig]
  /// A simple [TextSpan] will be created from [text]
  EzText.simple(
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
  }) : this(
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

  /// Builds a [SelectableText.rich] with styling from [EzConfig]
  /// A [TextSpan] will be made from [text] and given a [TapGestureRecognizer] to run [action]
  EzText.link({
    required String text,
    required void Function() action,
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
  }) : this(
          TextSpan(
            text: text,
            recognizer: TapGestureRecognizer()..onTap = action,
          ),
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

  /// Builds a [SelectableText.rich] with styling from [EzConfig]
  /// A [TextSpan] will be made from [text] and given a [TapGestureRecognizer] to [openLink] the provided [url]
  EzText.webLink({
    required String text,
    required Uri url,
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
  }) : this(
          TextSpan(
            text: text,
            recognizer: TapGestureRecognizer()..onTap = () => openLink(url),
          ),
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

  /// Provide text [base] that has [linkInsert]s everywhere a link should be inserted
  /// Provide a [String]->[Uri] list of [links] for each [linkInsert] replacement
  /// Changes will be made in order
  /// Returns the generated [TextSpan] with standard text using [style]
  /// And the links using [linkStyle]
  static TextSpan insertLinks({
    required String base,
    required List<Map<String, Uri>> links,
    TextAlign textAlign = TextAlign.center,
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
            text: base.substring(currentIndex, linkPosition),
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
          text: base.substring(currentIndex),
          style: style,
        ),
      );
    }

    return TextSpan(children: textSpans);
  }

  /// Builds a [SelectableText.rich] with styling from [EzConfig]
  /// Provide text [base] that has [linkInsert]s everywhere a link should be inserted
  /// Provide a [String]->[Uri] list of [links] for each [linkInsert] replacement
  /// Changes will be made in order
  /// Returns the generated [TextSpan] with standard text using [style]
  /// And the links using [linkStyle]
  EzText.webLinks({
    required String base,
    required List<Map<String, Uri>> links,
    TextAlign textAlign = TextAlign.center,
    required TextStyle style,
    required TextStyle linkStyle,
    Key? key,
    FocusNode? focusNode,
    StrutStyle? strutStyle,
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
  }) : this(
          insertLinks(
            base: base,
            links: links,
            textAlign: textAlign,
            style: style,
            linkStyle: linkStyle,
          ),
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
