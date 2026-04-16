/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EzSwitchPair extends StatefulWidget {
  /// Easily disable the button
  /// Useful if the functionality is async
  final bool enabled;

  /// Switches to disabled styling when true
  /// The switch is unchanged
  /// Overriding [style] makes [fauxDisabled] moot
  final bool fauxDisabled;

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
  /// true: [ColorScheme.surface]
  /// false: [ColorScheme.surfaceContainer]
  /// null: [ColorScheme.surfaceDim]
  final bool? useSurface;

  /// [EzText.style] passthrough
  final TextStyle? style;

  /// [EzText.textAlign] passthrough
  final TextAlign? textAlign;

  /// [EzText.textDirection] passthrough
  final TextDirection? textDirection;

  /// [EzText.maxLines] passthrough
  final int? maxLines;

  /// [EzText.semanticsLabel] passthrough
  final String? semanticsLabel;

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
  /// Optionally provide [afterChanged]
  final String? valueKey;

  /// Whether the key should use [FlutterSecureStorage]
  final bool secureKey;

  /// [Switch.onChanged] passthrough
  /// Provide [onChanged] OR [afterChanged]
  /// Pairs with [value]
  final void Function(bool?)? onChanged;

  /// If you want to do more than just update [valueKey] in [Switch.onChanged]
  /// Provide [afterChanged] OR [onChanged]
  /// Pairs with [valueKey]
  final void Function(bool?)? afterChanged;

  /// Defaults to [ezIconRatio]
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

  /// [Switch.mouseCursor] passthrough
  final MouseCursor? mouseCursor;

  /// [Switch.focusColor] passthrough
  final Color? focusColor;

  /// [Switch.hoverColor] passthrough
  final Color? hoverColor;

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
  /// Or and EzConfig optimized [valueKey] and optional [afterChanged]
  const EzSwitchPair({
    super.key,
    this.enabled = true,
    this.fauxDisabled = false,

    // Row
    this.reverseHands = true,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,

    // Text
    required this.text,
    this.useSurface = false,
    this.style,
    this.textAlign,
    this.textDirection,
    this.maxLines,
    this.semanticsLabel,
    this.selectionColor,
    this.backgroundColor,

    // Switch
    this.value,
    this.valueKey,
    this.secureKey = false,
    this.onChanged,
    this.canChange,
    this.afterChanged,
    this.scale,
    this.activeThumbColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.trackOutlineColor,
    this.trackOutlineWidth,
    this.mouseCursor,
    this.focusColor,
    this.hoverColor,
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
            ((afterChanged == null) && (value == null) ||
                ((afterChanged == null) != (value == null))),
            'Cannot use afterChanged with value');

  @override
  State<EzSwitchPair> createState() => _EzSwitchPairState();
}

class _EzSwitchPairState extends State<EzSwitchPair> {
  // Define the build data //

  late bool value = widget.value ?? EzConfig.get(widget.valueKey!);

  late final double ratio = widget.scale ?? ezIconRatio();

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
              textAlign: widget.textAlign,
              textDirection: widget.textDirection,
              maxLines: widget.maxLines,
              semanticsLabel: widget.semanticsLabel,
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
              onChanged: widget.enabled
                  ? widget.onChanged ??
                      (bool? choice) async {
                        if (choice == null) return;

                        if (widget.canChange != null) {
                          if (!await widget.canChange!(choice)) return;
                        }

                        if (widget.secureKey) {
                          await EzConfig.secSetString(
                              widget.valueKey!, choice.toString());
                        } else {
                          await EzConfig.setBool(widget.valueKey!, choice);
                        }
                        setState(() => value = choice);

                        widget.afterChanged?.call(choice);
                      }
                  : null,
              activeThumbColor: widget.fauxDisabled
                  ? widget.inactiveThumbColor ?? EzConfig.colors.outline
                  : widget.activeThumbColor,
              activeTrackColor: widget.fauxDisabled
                  ? widget.inactiveTrackColor
                  : widget.activeTrackColor,
              inactiveThumbColor:
                  widget.inactiveThumbColor ?? EzConfig.colors.outline,
              inactiveTrackColor: widget.inactiveTrackColor,
              trackOutlineColor: (widget.enabled && !widget.fauxDisabled)
                  ? widget.trackOutlineColor
                  : WidgetStatePropertyAll<Color>(
                      EzConfig.colors.outlineVariant),
              trackOutlineWidth: widget.trackOutlineWidth,
              mouseCursor: widget.mouseCursor,
              focusColor: widget.focusColor,
              hoverColor: widget.hoverColor,
              focusNode: widget.focusNode,
              onFocusChange: widget.onFocusChange,
              autofocus: widget.autofocus,
              padding: EzConfig.isLefty
                  ? EdgeInsets.only(right: EzConfig.marginVal)
                  : EdgeInsets.only(left: EzConfig.marginVal),
            ),
          ),
        ],
      );
}
