/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzTextButton extends StatefulWidget {
  /// [TextButton.onPressed] passthrough
  final void Function()? onPressed;

  /// [TextButton.onLongPress] passthrough
  final void Function()? onLongPress;

  /// Defaults to add an [TextDecoration.underline] to the [text]
  /// Can override and/or set [underline] to false
  final void Function(bool)? onHover;

  /// Defaults to add an [TextDecoration.underline] to the [text]
  /// Can override and/or set [underline] to false
  final void Function(bool)? onFocusChange;

  /// Adds an [TextDecoration.underline] to the [text] via [onHover] and [onFocusChange]
  final bool underline;

  /// [TextDecoration.underline]'s color, defaults to [ColorScheme.primary]
  final Color? decorationColor;

  /// [TextButton.style] passthrough
  final ButtonStyle? style;

  /// [TextButton.focusNode] passthrough
  final FocusNode? focusNode;

  /// [TextButton.autofocus] passthrough
  final bool autofocus;

  /// [TextButton.clipBehavior] passthrough
  final Clip? clipBehavior;

  /// [TextButton.statesController] passthrough
  final WidgetStatesController? statesController;

  /// [TextButton.child] will be [Text] with [text], [textStyle], and [textAlign]
  final String text;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? textStyle;

  /// [Text.textAlign] passthrough
  final TextAlign? textAlign;

  /// [TextButton] with custom styling
  /// Crucially: automatically underlines its text [onHover] and [onFocusChange]
  const EzTextButton({
    super.key,
    this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.underline = true,
    this.decorationColor,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior,
    this.statesController,
    required this.text,
    this.textStyle,
    this.textAlign,
  });

  @override
  State<EzTextButton> createState() => _EzTextButtonState();
}

class _EzTextButtonState extends State<EzTextButton> {
  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    TextStyle? textStyle =
        (widget.textStyle ?? EzConfig.styles.bodyLarge)?.copyWith(
      decorationColor: widget.decorationColor ?? EzConfig.colors.primary,
    );

    void addUnderline(bool addIt) {
      textStyle = textStyle?.copyWith(
        decoration: addIt ? TextDecoration.underline : TextDecoration.none,
      );
      setState(() {});
    }

    // Return the build //

    return TextButton(
      onPressed: widget.onPressed,
      onLongPress: widget.onLongPress,
      onHover: widget.onHover ??
          (widget.underline
              ? (bool isHovering) => addUnderline(isHovering)
              : (_) {}),
      onFocusChange: widget.onFocusChange ??
          (widget.underline
              ? (bool isFocused) => addUnderline(isFocused)
              : (_) {}),
      style: widget.style,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      clipBehavior: widget.clipBehavior,
      statesController: widget.statesController,
      child: Text(widget.text, style: textStyle, textAlign: widget.textAlign),
    );
  }
}

class EzTextIconButton extends StatefulWidget {
  /// [TextButton.onPressed] passthrough
  final void Function()? onPressed;

  /// [TextButton.onLongPress] passthrough
  final void Function()? onLongPress;

  /// Defaults to add an [TextDecoration.underline] to the [label]
  /// Can override and/or set [underline] to false
  final void Function(bool)? onHover;

  /// Defaults to add an [TextDecoration.underline] to the [label]
  /// Can override and/or set [underline] to false
  final void Function(bool)? onFocusChange;

  /// Adds an [TextDecoration.underline] to the [label] via [onHover] and [onFocusChange]
  final bool underline;

  /// [TextDecoration.underline]'s color, defaults to [ColorScheme.primary]
  final Color? decorationColor;

  /// [TextButton.style] passthrough
  final ButtonStyle? style;

  /// [TextButton.focusNode] passthrough
  final FocusNode? focusNode;

  /// [TextButton.autofocus] passthrough
  final bool? autofocus;

  /// [TextButton.clipBehavior] passthrough
  final Clip? clipBehavior;

  /// [TextButton.statesController] passthrough
  final WidgetStatesController? statesController;

  /// [TextButton.icon] passthrough
  /// iconAlignment: [EzConfig.get] -> [isLeftyKey] ? [IconAlignment.start] : [IconAlignment.end]
  final Widget icon;

  /// [TextButton.icon] label will be [Text] with [label], [textStyle], and [textAlign]
  final String label;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? textStyle;

  /// [Text.textAlign] passthrough
  final TextAlign? textAlign;

  /// [TextButton.icon] with styling like an [EzTextButton] and the [icon] responds to [isLeftyKey]
  const EzTextIconButton({
    super.key,
    this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.underline = true,
    this.decorationColor,
    this.style,
    this.focusNode,
    this.autofocus,
    this.clipBehavior,
    this.statesController,
    required this.icon,
    required this.label,
    this.textStyle,
    this.textAlign,
  });

  @override
  State<EzTextIconButton> createState() => _EzTextIconButtonState();
}

class _EzTextIconButtonState extends State<EzTextIconButton> {
  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    TextStyle? textStyle =
        (widget.textStyle ?? EzConfig.styles.bodyLarge)?.copyWith(
      decorationColor: widget.decorationColor ?? EzConfig.colors.primary,
    );

    void addUnderline(bool addIt) {
      textStyle = textStyle?.copyWith(
        decoration: addIt ? TextDecoration.underline : TextDecoration.none,
      );
      setState(() {});
    }

    // Return the build //

    return TextButton.icon(
      onPressed: widget.onPressed,
      onLongPress: widget.onLongPress,
      onHover: widget.onHover ??
          (widget.underline
              ? (bool isHovering) => addUnderline(isHovering)
              : (_) {}),
      onFocusChange: widget.onFocusChange ??
          (widget.underline
              ? (bool isFocused) => addUnderline(isFocused)
              : (_) {}),
      style: widget.style,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      clipBehavior: widget.clipBehavior,
      statesController: widget.statesController,
      icon: widget.icon,
      iconAlignment: EzConfig.isLefty ? IconAlignment.start : IconAlignment.end,
      label: Text(widget.label, style: textStyle, textAlign: widget.textAlign),
    );
  }
}
