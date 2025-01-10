/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
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
  // Gather theme data //

  late final ColorScheme colorScheme = Theme.of(context).colorScheme;
  late final Color decorationColor = widget.decorationColor ??
      (widget.enabled ? colorScheme.primary : colorScheme.outline);

  late TextStyle? textStyle =
      (widget.textStyle ?? Theme.of(context).textTheme.bodyLarge)
          ?.copyWith(decorationColor: decorationColor);

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
  Widget build(_) => ElevatedButton(
        onPressed: widget.enabled ? widget.onPressed : doNothing,
        onLongPress: widget.enabled ? widget.onLongPress : doNothing,
        onHover: onHover,
        onFocusChange: onFocusChange,
        style: widget.enabled
            ? widget.style
            : (widget.style ?? Theme.of(context).elevatedButtonTheme.style)
                ?.copyWith(
                overlayColor: WidgetStateProperty.all(colorScheme.outline),
                shadowColor: WidgetStateProperty.all(Colors.transparent),
              ),
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        clipBehavior: widget.clipBehavior,
        statesController: widget.statesController,
        child: Text(widget.text, style: textStyle, textAlign: widget.textAlign),
      );
}

class EzElevatedIconButton extends StatefulWidget {
  final void Function()? onPressed;
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

  /// [TextDecoration.underline]'s color, defaults to [ColorScheme.primary]
  final Color? decorationColor;

  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool? autofocus;
  final Clip? clipBehavior;
  final WidgetStatesController? statesController;

  /// iconAlignment: [EzConfig.get] -> [isLeftyKey] ? [IconAlignment.start] : [IconAlignment.end]
  final Widget icon;

  final String label;

  /// Default true
  /// Adds a '\t' sized [EdgeInsets] as prefix (righty) or suffix (lefty) to the [label]
  final bool labelPadding;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? textStyle;

  /// [Text] passthrough
  final TextAlign? textAlign;

  /// [ElevatedButton.icon] wrapper that responds to [isLeftyKey]
  const EzElevatedIconButton({
    super.key,
    this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.underline = false,
    this.decorationColor,
    this.style,
    this.focusNode,
    this.autofocus,
    this.clipBehavior,
    this.statesController,
    required this.icon,
    required this.label,
    this.labelPadding = true,
    this.textStyle,
    this.textAlign,
  });

  @override
  State<EzElevatedIconButton> createState() => _EzElevatedIconButtonState();
}

class _EzElevatedIconButtonState extends State<EzElevatedIconButton> {
  // Gather theme data //

  final bool isLefty = EzConfig.get(isLeftyKey) ?? false;

  late final String label = widget.label;

  late final Color primary = Theme.of(context).colorScheme.primary;

  late TextStyle? textStyle =
      (widget.textStyle ?? Theme.of(context).textTheme.bodyLarge)?.copyWith(
    decorationColor: widget.decorationColor ?? primary,
  );

  late final double margin =
      measureText('\t', context: context, style: textStyle).width;

  late final EdgeInsets labelPadding = widget.labelPadding
      ? (isLefty
          ? EdgeInsets.only(right: margin)
          : EdgeInsets.only(left: margin))
      : EdgeInsets.zero;

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
    return ElevatedButton.icon(
      onPressed: widget.onPressed,
      onLongPress: widget.onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      style: widget.style,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      clipBehavior: widget.clipBehavior,
      statesController: widget.statesController,
      icon: widget.icon,
      iconAlignment: isLefty ? IconAlignment.start : IconAlignment.end,
      label: Padding(
        padding: labelPadding,
        child: Text(label, style: textStyle, textAlign: widget.textAlign),
      ),
    );
  }
}
