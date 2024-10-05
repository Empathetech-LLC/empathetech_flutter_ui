/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzTextButton extends StatefulWidget {
  final void Function()? onPressed;
  final void Function()? onLongPress;

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

  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip? clipBehavior;
  final WidgetStatesController? statesController;

  final String text;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? textStyle;

  /// [Text] passthrough
  final TextAlign? textAlign;

  /// [TextButton] wrapper that responds to [isLeftyKey]
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
  // Gather theme data //

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
    return TextButton(
      onPressed: widget.onPressed,
      onLongPress: widget.onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
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
  final void Function()? onPressed;
  final void Function()? onLongPress;

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

  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool? autofocus;
  final Clip? clipBehavior;
  final WidgetStatesController? statesController;

  /// iconAlignment: [EzConfig.get] -> [isLeftyKey] ? [IconAlignment.start] : [IconAlignment.end]
  final Widget icon;

  final String label;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? textStyle;

  /// [Text] passthrough
  final TextAlign? textAlign;

  /// [TextButton.icon] wrapper that responds to [isLeftyKey]
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
    return TextButton.icon(
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
      label: Text(widget.label, style: textStyle, textAlign: widget.textAlign),
    );
  }
}
