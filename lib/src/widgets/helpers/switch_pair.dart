/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:math';
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

  /// [Switch.value] passthrough
  /// Provide [value] OR [valueKey]
  /// Must pair with [onChanged]
  final bool? value;

  /// Optional pre-requisite to [onChanged]
  /// Only for when using [valueKey]
  final Future<bool> Function(bool)? canChange;

  /// [EzConfig] key to provide to [Switch.value]
  /// And update in [Switch.onChanged]
  /// Provide [valueKey] OR [value]
  /// Optionally provide [onChangedCallback]
  final String? valueKey;

  /// [Switch.onChanged] passthrough
  /// Provide [onChanged] OR [onChangedCallback]
  /// Pairs with [value]
  final void Function(bool?)? onChanged;

  /// If you want to do more than just update [valueKey] in [Switch.onChanged]
  /// Provide [onChangedCallback] OR [onChanged]
  /// Pairs with [valueKey]
  final void Function(bool?)? onChangedCallback;

  /// Defaults to max([EzConfig]s [iconSizeKey] / [defaultIconSize], 1.0)
  final double? scale;

  /// [Switch.activeThumbColor] passthrough
  final Color? activeThumbColor;

  /// [Switch.activeTrackColor] passthrough
  final Color? activeTrackColor;

  /// [Switch.inactiveThumbColor] passthrough
  final Color? inactiveThumbColor;

  /// [Switch.inactiveTrackColor] passthrough
  final Color? inactiveTrackColor;

  /// [Switch.trackOutlineColor] passthrough
  final WidgetStateProperty<Color?>? trackOutlineColor;

  /// [Switch.trackOutlineWidth] passthrough
  final WidgetStateProperty<double?>? trackOutlineWidth;

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

  /// [EzRow] with flexible [EzText] and a [Switch]
  /// Provide the traditional [value] and [onChanged]
  /// Or and EzConfig optimized [valueKey] and optional [onChangedCallback]
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
    this.value,
    this.valueKey,
    this.onChanged,
    this.canChange,
    this.onChangedCallback,
    this.scale,
    this.activeThumbColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.trackOutlineColor,
    this.trackOutlineWidth,
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
  })  : assert((value == null) != (valueKey == null),
            'Provide value OR valueKey, but not both'),
        assert((value == null) == (onChanged == null),
            'Must pair value and onChanged'),
        assert((valueKey == null) != (onChanged == null),
            'Cannot use onChanged with valueKey'),
        assert(
            ((onChangedCallback == null) && (value == null) ||
                ((onChangedCallback == null) != (value == null))),
            'Cannot use onChangedCallback with value');

  @override
  State<EzSwitchPair> createState() => _EzSwitchPairState();
}

class _EzSwitchPairState extends State<EzSwitchPair> {
  // Define the build data //

  late bool value = widget.value ?? EzConfig.get(widget.valueKey!);

  late final double ratio = widget.scale ?? ezIconRatio();

  // Define custom functions //

  late final void Function(bool?) onChanged = widget.onChanged ??
      (bool? choice) async {
        if (choice == null) return;

        if (widget.canChange != null) {
          final bool canChange = await widget.canChange!(choice);
          if (!canChange) return;
        }

        await EzConfig.setBool(widget.valueKey!, choice);
        setState(() => value = choice);

        widget.onChangedCallback?.call(choice);
      };

  // Return the build //

  @override
  Widget build(BuildContext context) => EzRow(
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
          Transform.scale(
            scale: max(1.0, ratio),
            // Could be PlatformSwitch
            // Dev's opinion: Material switches are better
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: widget.activeThumbColor,
              activeTrackColor: widget.activeTrackColor,
              inactiveThumbColor: widget.inactiveThumbColor,
              inactiveTrackColor: widget.inactiveTrackColor,
              trackOutlineColor: widget.trackOutlineColor,
              trackOutlineWidth: widget.trackOutlineWidth,
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
              padding: widget.padding ??
                  (ratio > 1.1
                      ? EdgeInsets.all(EzConfig.margin * ratio)
                      : EdgeInsets.symmetric(horizontal: EzConfig.margin)),
            ),
          ),
        ],
      );
}
