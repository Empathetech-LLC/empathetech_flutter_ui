/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzElevatedButton extends StatefulWidget {
  final void Function()? onPressed;
  final void Function()? onLongPress;

  /// Defaults to add an [TextDecoration.underline] to the [text]
  /// Can override and/or set [underline] to false
  final void Function(bool)? onHover;

  /// Defaults to add an [TextDecoration.underline] to the [text]
  /// Can override and/or set [underline] to false
  final void Function(bool)? onFocusChange;

  /// Default false
  /// Adds an [TextDecoration.underline] to the [text] via [onHover] and [onFocusChange]
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

  /// [ElevatedButton] wrapper that will optionally underline its text [onHover] and [onFocusChange]
  const EzElevatedButton({
    super.key,
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
    return ElevatedButton(
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
