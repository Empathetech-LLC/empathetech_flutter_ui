/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzMenuButton extends StatefulWidget {
  final void Function()? onPressed;

  final bool requestFocusOnHover;

  /// Defaults to add an [TextDecoration.underline] to the [label]
  /// Can override and/or set [underline] to false
  final void Function(bool)? onHover;

  /// Defaults to add an [TextDecoration.underline] to the [label]
  /// Can override and/or set [underline] to false
  final void Function(bool)? onFocusChange;

  /// Default true
  /// Adds an [TextDecoration.underline] to the [label] via [onHover] and [onFocusChange]
  final bool underline;

  /// [TextDecoration.underline]'s color, defaults to [ColorScheme.primary]
  final Color? decorationColor;

  final FocusNode? focusNode;
  final bool autofocus;
  final MenuSerializableShortcut? shortcut;
  final String? semanticsLabel;
  final ButtonStyle? style;
  final WidgetStatesController? statesController;
  final Clip clipBehavior;

  /// iconAlignment: [EzConfig.get] -> [isLeftyKey] ? [IconAlignment.start] : [IconAlignment.end]
  final Widget? icon;

  final bool closeOnActivate;
  final Axis overflowAxis;

  final String label;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? textStyle;

  /// [Text] passthrough
  final TextAlign? textAlign;

  /// [ElevatedButton.icon] wrapper that responds to [isLeftyKey]
  const EzMenuButton({
    super.key,
    this.onPressed,
    this.requestFocusOnHover = true,
    this.onHover,
    this.onFocusChange,
    this.underline = false,
    this.decorationColor,
    this.focusNode,
    this.autofocus = false,
    this.shortcut,
    this.semanticsLabel,
    this.style,
    this.statesController,
    this.clipBehavior = Clip.none,
    this.icon,
    this.closeOnActivate = true,
    this.overflowAxis = Axis.horizontal,
    required this.label,
    this.textStyle,
    this.textAlign,
  });

  @override
  State<EzMenuButton> createState() => _EzMenuButtonState();
}

class _EzMenuButtonState extends State<EzMenuButton> {
  // Gather theme data //

  final bool isLefty = EzConfig.get(isLeftyKey) ?? false;

  late final Color primary = Theme.of(context).colorScheme.primary;

  late TextStyle? textStyle =
      (widget.textStyle ?? Theme.of(context).textTheme.bodyLarge)?.copyWith(
    decorationColor: widget.decorationColor ?? primary,
  );

  // Define custom functions //

  void addUnderline(bool addIt) {
    textStyle = textStyle?.copyWith(
      decoration: addIt ? TextDecoration.underline : TextDecoration.none,
    );
    setState(() {});
  }

  late final void Function(bool)? onHover = widget.onHover ??
      (widget.underline
          ? (bool isHovering) => addUnderline(isHovering)
          : (_) {});

  late final void Function(bool)? onFocusChange = widget.onFocusChange ??
      (widget.underline ? (bool isFocused) => addUnderline(isFocused) : (_) {});

  @override
  Widget build(BuildContext context) {
    return MenuItemButton(
      onPressed: widget.onPressed,
      onHover: onHover,
      requestFocusOnHover: widget.requestFocusOnHover,
      onFocusChange: onFocusChange,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      shortcut: widget.shortcut,
      semanticsLabel: widget.semanticsLabel,
      style: widget.style,
      statesController: widget.statesController,
      clipBehavior: widget.clipBehavior,
      leadingIcon: isLefty ? widget.icon : null,
      trailingIcon: isLefty ? null : widget.icon,
      closeOnActivate: widget.closeOnActivate,
      overflowAxis: widget.overflowAxis,
      child: Text(
        widget.label,
        style: textStyle,
        textAlign:
            widget.textAlign ?? (isLefty ? TextAlign.start : TextAlign.end),
      ),
    );
  }
}
