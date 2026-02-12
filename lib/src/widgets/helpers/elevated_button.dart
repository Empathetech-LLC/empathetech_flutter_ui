/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzElevatedButton extends StatefulWidget {
  /// Easily disable the button
  /// Useful if the functionality is async
  final bool enabled;

  /// [ElevatedButton.onPressed] passthrough
  final void Function()? onPressed;

  /// [ElevatedButton.onLongPress] passthrough
  final void Function()? onLongPress;

  /// Defaults to add an [TextDecoration.underline] to the [text]
  /// Can override and/or set [underline] to false
  final void Function(bool)? onHover;

  /// Defaults to add an [TextDecoration.underline] to the [text]
  /// Can override and/or set [underline] to false
  final void Function(bool)? onFocusChange;

  /// Adds an [TextDecoration.underline] to the [text] via [onHover] and [onFocusChange]
  final bool underline;

  /// [TextDecoration.underline]'s color
  /// Defaults to [ColorScheme.primary]
  final Color? decorationColor;

  /// [ElevatedButton.style] passthrough
  final ButtonStyle? style;

  /// [ElevatedButton.focusNode] passthrough
  final FocusNode? focusNode;

  /// [ElevatedButton.autofocus] passthrough
  final bool autofocus;

  /// [ElevatedButton.clipBehavior] passthrough
  final Clip? clipBehavior;

  /// [ElevatedButton.statesController] passthrough
  final WidgetStatesController? statesController;

  /// [ElevatedButton.child] will be [Text] with [text], [textStyle], and [textAlign]
  final String text;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? textStyle;

  /// [Text.textAlign] passthrough
  final TextAlign? textAlign;

  /// [ElevatedButton] with custom styling and an off switch
  const EzElevatedButton({
    super.key,
    this.enabled = true,
    this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.underline = false,
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
  State<EzElevatedButton> createState() => _EzElevatedButtonState();
}

class _EzElevatedButtonState extends State<EzElevatedButton> {
  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final Color decorationColor = widget.decorationColor ??
        (widget.enabled ? EzConfig.colors.primary : EzConfig.colors.outline);

    TextStyle? textStyle = (widget.textStyle ?? EzConfig.styles.bodyLarge)
        ?.copyWith(decorationColor: decorationColor);

    // Define custom functions //

    void addUnderline(bool addIt) {
      textStyle = textStyle?.copyWith(
        decoration: addIt ? TextDecoration.underline : TextDecoration.none,
      );
      setState(() {});
    }

    // Return the build //

    return ElevatedButton(
      onPressed: widget.enabled ? widget.onPressed : doNothing,
      onLongPress: widget.enabled ? widget.onLongPress : doNothing,
      onHover: widget.onHover ??
          (widget.underline
              ? (bool isHovering) => addUnderline(isHovering)
              : (_) {}),
      onFocusChange: widget.onFocusChange ??
          (widget.underline
              ? (bool isFocused) => addUnderline(isFocused)
              : (_) {}),
      style: widget.enabled
          ? widget.style
          : (widget.style ?? Theme.of(context).elevatedButtonTheme.style)
              ?.copyWith(
              overlayColor: WidgetStateProperty.all(EzConfig.colors.outline),
              shadowColor: WidgetStateProperty.all(Colors.transparent),
            ),
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      clipBehavior: widget.clipBehavior,
      statesController: widget.statesController,
      child: Text(widget.text, style: textStyle, textAlign: widget.textAlign),
    );
  }
}

class EzElevatedIconButton extends StatefulWidget {
  /// Easily disable the button
  /// Useful if the functionality is async
  final bool enabled;

  /// [ElevatedButton.onPressed] passthrough
  final void Function()? onPressed;

  /// [ElevatedButton.onLongPress] passthrough
  final void Function()? onLongPress;

  /// Defaults to add an [TextDecoration.underline] to the [label]
  /// Can override and/or set [underline] to false
  final void Function(bool)? onHover;

  /// Defaults to add an [TextDecoration.underline] to the [label]
  /// Can override and/or set [underline] to false
  final void Function(bool)? onFocusChange;

  /// Default false
  /// Adds an [TextDecoration.underline] to the [label] via [onHover] and [onFocusChange]
  final bool underline;

  /// [TextDecoration.underline]'s color
  /// Defaults to [ColorScheme.primary]
  final Color? decorationColor;

  /// [ElevatedButton.style] passthrough
  final ButtonStyle? style;

  /// [ElevatedButton.focusNode] passthrough
  final FocusNode? focusNode;

  /// [ElevatedButton.autofocus] passthrough
  final bool autofocus;

  /// [ElevatedButton.clipBehavior] passthrough
  final Clip? clipBehavior;

  /// [ElevatedButton.statesController] passthrough
  final WidgetStatesController? statesController;

  /// [ElevatedButton.icon] passthrough
  final Widget icon;

  /// [ElevatedButton.icon]'s label will be [Text] with [label], [textStyle], and [textAlign]
  final String label;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? textStyle;

  /// [Text.textAlign] passthrough
  final TextAlign? textAlign;

  /// Adds a '\t' sized [EdgeInsets] as prefix (righty) or suffix (lefty) to the [label]
  final bool labelPadding;

  /// [ElevatedButton.icon] wrapper that responds to [isLeftyKey]
  const EzElevatedIconButton({
    super.key,
    this.enabled = true,
    this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.underline = false,
    this.decorationColor,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior,
    this.statesController,
    required this.icon,
    required this.label,
    this.textStyle,
    this.textAlign,
    this.labelPadding = true,
  });

  @override
  State<EzElevatedIconButton> createState() => _EzElevatedIconButtonState();
}

class _EzElevatedIconButtonState extends State<EzElevatedIconButton> {
  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final Color decorationColor = widget.decorationColor ??
        (widget.enabled ? EzConfig.colors.primary : EzConfig.colors.outline);

    TextStyle? textStyle = (widget.textStyle ?? EzConfig.styles.bodyLarge)
        ?.copyWith(decorationColor: decorationColor);

    // Define custom functions //

    void addUnderline(bool addIt) {
      textStyle = textStyle?.copyWith(
        decoration: addIt ? TextDecoration.underline : TextDecoration.none,
      );
      setState(() {});
    }

    // Return the build //

    return ElevatedButton.icon(
      onPressed: widget.enabled ? widget.onPressed : doNothing,
      onLongPress: widget.enabled ? widget.onLongPress : doNothing,
      onHover: widget.onHover ??
          (widget.underline
              ? (bool isHovering) => addUnderline(isHovering)
              : (_) {}),
      onFocusChange: widget.onFocusChange ??
          (widget.underline
              ? (bool isFocused) => addUnderline(isFocused)
              : (_) {}),
      style: widget.enabled
          ? widget.style
          : (widget.style ?? Theme.of(context).elevatedButtonTheme.style)
              ?.copyWith(
              overlayColor: WidgetStateProperty.all(EzConfig.colors.outline),
              shadowColor: WidgetStateProperty.all(Colors.transparent),
            ),
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      clipBehavior: widget.clipBehavior,
      statesController: widget.statesController,
      icon: widget.icon,
      iconAlignment: EzConfig.isLefty ? IconAlignment.start : IconAlignment.end,
      label: Text(
        widget.label,
        style: textStyle,
        textAlign: widget.textAlign,
      ),
    );
  }
}
