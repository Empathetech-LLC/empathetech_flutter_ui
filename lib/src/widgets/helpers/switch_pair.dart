/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class EzSwitchPair extends StatefulWidget {
  /// [EzRow.reverseHands] passthrough
  final bool reverseHands;

  /// [EzRow.mainAxisSize] passthrough
  final MainAxisSize mainAxisSize;

  /// [EzRow.mainAxisAlignment] passthrough
  final MainAxisAlignment mainAxisAlignment;

  /// [EzRow.crossAxisAlignment] passthrough
  final CrossAxisAlignment crossAxisAlignment;

  /// [EzText.data] passthrough
  final String text;

  /// [EzText.useSurface] passthrough
  final bool useSurface;

  /// [EzText.style] passthrough
  final TextStyle? style;

  /// [EzText.strutStyle] passthrough
  final StrutStyle? strutStyle;

  /// [EzText.textAlign] passthrough
  final TextAlign? textAlign;

  /// [EzText.textDirection] passthrough
  final TextDirection? textDirection;

  /// [EzText.locale] passthrough
  final Locale? locale;

  /// [EzText.softWrap] passthrough
  final bool? softWrap;

  /// [EzText.overflow] passthrough
  final TextOverflow? overflow;

  /// [EzText.textScaler] passthrough
  final TextScaler? textScaler;

  /// [EzText.maxLines] passthrough
  final int? maxLines;

  /// [EzText.semanticsLabel] passthrough
  final String? semanticsLabel;

  /// [EzText.textWidthBasis] passthrough
  final TextWidthBasis? textWidthBasis;

  /// [EzText.textHeightBehavior] passthrough
  final TextHeightBehavior? textHeightBehavior;

  /// [EzText.selectionColor] passthrough
  final Color? selectionColor;

  /// [EzText.backgroundColor] passthrough
  final Color? backgroundColor;

  /// [EzConfig] key to provide to [Switch.value]
  /// And update in [Switch.onChanged]
  final String valueKey;

  /// If you want to do more than just update [valueKey] in [Switch.onChanged]
  final void Function(bool?)? onChangedCallback;

  /// [Switch.activeColor] passthrough
  final Color? activeColor;

  /// [Switch.activeTrackColor] passthrough
  final Color? activeTrackColor;

  /// [Switch.inactiveThumbColor] passthrough
  final Color? inactiveThumbColor;

  /// [Switch.inactiveTrackColor] passthrough
  final Color? inactiveTrackColor;

  /// [Switch.activeThumbImage] passthrough
  final ImageProvider<Object>? activeThumbImage;

  /// [Switch.onActiveThumbImageError] passthrough
  final ImageErrorListener? onActiveThumbImageError;

  /// [Switch.inactiveThumbImage] passthrough
  final ImageProvider<Object>? inactiveThumbImage;

  /// [Switch.onInactiveThumbImageError] passthrough
  final ImageErrorListener? onInactiveThumbImageError;

  /// [Switch.materialTapTargetSize] passthrough
  final MaterialTapTargetSize? materialTapTargetSize;

  /// [Switch.dragStartBehavior] passthrough
  final DragStartBehavior dragStartBehavior;

  /// [Switch.mouseCursor] passthrough
  final MouseCursor? mouseCursor;

  /// [Switch.focusColor] passthrough
  final Color? focusColor;

  /// [Switch.hoverColor] passthrough
  final Color? hoverColor;

  /// [Switch.splashRadius] passthrough
  final double? splashRadius;

  /// [Switch.focusNode] passthrough
  final FocusNode? focusNode;

  /// [Switch.onFocusChange] passthrough
  final ValueChanged<bool>? onFocusChange;

  /// [Switch.autofocus] passthrough
  final bool autofocus;

  /// [Switch.padding] passthrough
  final EdgeInsetsGeometry? padding;

  /// [EzRow] with [EzText] and a [Switch]
  /// The [text] is [Flexible]
  const EzSwitchPair({
    super.key,
    // Row
    this.reverseHands = true,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,

    // Text
    required this.text,
    this.useSurface = false,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
    this.backgroundColor,

    // Switch
    required this.valueKey,
    this.onChangedCallback,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeThumbImage,
    this.onActiveThumbImageError,
    this.inactiveThumbImage,
    this.onInactiveThumbImageError,
    this.materialTapTargetSize,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.focusColor,
    this.hoverColor,
    this.splashRadius,
    this.focusNode,
    this.onFocusChange,
    this.autofocus = false,
    this.padding,
  });

  @override
  State<EzSwitchPair> createState() => _EzSwitchPairState();
}

class _EzSwitchPairState extends State<EzSwitchPair> {
  late bool value =
      EzConfig.get(widget.valueKey) ?? EzConfig.getDefault(widget.valueKey);

  @override
  Widget build(BuildContext context) {
    return EzRow(
      reverseHands: widget.reverseHands,
      mainAxisSize: widget.mainAxisSize,
      mainAxisAlignment: widget.mainAxisAlignment,
      crossAxisAlignment: widget.crossAxisAlignment,
      children: <Widget>[
        Flexible(
          child: EzText(
            widget.text,
            useSurface: widget.useSurface,
            style: widget.style,
            strutStyle: widget.strutStyle,
            textAlign: widget.textAlign,
            textDirection: widget.textDirection,
            locale: widget.locale,
            softWrap: widget.softWrap,
            overflow: widget.overflow,
            textScaler: widget.textScaler,
            maxLines: widget.maxLines,
            semanticsLabel: widget.semanticsLabel,
            textWidthBasis: widget.textWidthBasis,
            textHeightBehavior: widget.textHeightBehavior,
            selectionColor: widget.selectionColor,
            backgroundColor: widget.backgroundColor,
          ),
        ),
        // Could be PlatformSwitch
        // Dev-option: Material switches are better
        Switch(
          value: value,
          onChanged: (bool? choice) async {
            if (choice == null) return;

            await EzConfig.setBool(widget.valueKey, choice);
            setState(() => value = choice);

            widget.onChangedCallback?.call(choice);
          },
          activeColor: widget.activeColor,
          activeTrackColor: widget.activeTrackColor,
          inactiveThumbColor: widget.inactiveThumbColor,
          inactiveTrackColor: widget.inactiveTrackColor,
          activeThumbImage: widget.activeThumbImage,
          onActiveThumbImageError: widget.onActiveThumbImageError,
          inactiveThumbImage: widget.inactiveThumbImage,
          onInactiveThumbImageError: widget.onInactiveThumbImageError,
          materialTapTargetSize: widget.materialTapTargetSize,
          dragStartBehavior: widget.dragStartBehavior,
          mouseCursor: widget.mouseCursor,
          focusColor: widget.focusColor,
          hoverColor: widget.hoverColor,
          splashRadius: widget.splashRadius,
          focusNode: widget.focusNode,
          onFocusChange: widget.onFocusChange,
          autofocus: widget.autofocus,
          padding: widget.padding,
        ),
      ],
    );
  }
}
