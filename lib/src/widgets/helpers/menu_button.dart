/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzMenuButton extends StatefulWidget {
  /// [MenuItemButton.onPressed] passthrough
  final void Function()? onPressed;

  /// [MenuItemButton.onPressed] passthrough
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

  /// [MenuItemButton.focusNode] passthrough
  final FocusNode? focusNode;

  /// [MenuItemButton.autofocus] passthrough
  final bool autofocus;

  /// [MenuItemButton.shortcut] passthrough
  final MenuSerializableShortcut? shortcut;

  /// [MenuItemButton.semanticsLabel] passthrough
  final String? semanticsLabel;

  /// [MenuItemButton.style] passthrough
  final ButtonStyle? style;

  /// [MenuItemButton.statesController] passthrough
  final WidgetStatesController? statesController;

  /// [MenuItemButton.clipBehavior] passthrough
  final Clip clipBehavior;

  /// iconAlignment: [EzConfig.get] -> [isLeftyKey] ? [IconAlignment.start] : [IconAlignment.end]
  final Widget? icon;

  /// [MenuItemButton.closeOnActivate] passthrough
  final bool closeOnActivate;

  /// [MenuItemButton.overflowAxis] passthrough
  final Axis overflowAxis;

  /// The text for the user
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
  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final Color primary = EzConfig.colors.primary;

    TextStyle? textStyle =
        (widget.textStyle ?? EzConfig.styles.bodyLarge)?.copyWith(
      decorationColor: widget.decorationColor ?? primary,
    );

    void addUnderline(bool addIt) {
      textStyle = textStyle?.copyWith(
        decoration: addIt ? TextDecoration.underline : TextDecoration.none,
      );
      setState(() {});
    }

    // Return the build //

    return MenuItemButton(
      onPressed: widget.onPressed,
      onHover: widget.onHover ??
          (widget.underline
              ? (bool isHovering) => addUnderline(isHovering)
              : (_) {}),
      requestFocusOnHover: widget.requestFocusOnHover,
      onFocusChange: widget.onFocusChange ??
          (widget.underline
              ? (bool isFocused) => addUnderline(isFocused)
              : (_) {}),
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      shortcut: widget.shortcut,
      semanticsLabel: widget.semanticsLabel,
      style: widget.style,
      statesController: widget.statesController,
      clipBehavior: widget.clipBehavior,
      leadingIcon: EzConfig.isLefty ? widget.icon : null,
      trailingIcon: EzConfig.isLefty ? null : widget.icon,
      closeOnActivate: widget.closeOnActivate,
      overflowAxis: widget.overflowAxis,
      child: Text(
        widget.label,
        style: textStyle,
        textAlign: widget.textAlign ??
            (EzConfig.isLefty ? TextAlign.start : TextAlign.end),
      ),
    );
  }
}
