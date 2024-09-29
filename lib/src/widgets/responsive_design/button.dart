/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final void Function()? onLongPress;
  final void Function(bool)? onHover;
  final void Function(bool)? onFocusChange;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool? autofocus;
  final Clip? clipBehavior;
  final WidgetStatesController? statesController;
  final Widget icon;
  final String label;

  /// [ElevatedButton.icon] wrapper that responds to [isLeftyKey]
  const EzElevatedButton({
    super.key,
    this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.autofocus,
    this.clipBehavior,
    this.statesController,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLefty = EzConfig.get(isLeftyKey) ?? false;

    return ElevatedButton.icon(
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      statesController: statesController,
      icon: icon,
      iconAlignment: isLefty ? IconAlignment.start : IconAlignment.end,
      label: Text(isLefty ? '$label\t' : '\t$label'),
    );
  }
}

class EzTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final void Function()? onLongPress;
  final void Function(bool)? onHover;
  final void Function(bool)? onFocusChange;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool? autofocus;
  final Clip? clipBehavior;
  final WidgetStatesController? statesController;
  final Widget icon;
  final String label;
  final TextStyle? textStyle;
  final TextAlign? textAlign;

  /// [EzTextButton] wrapper that responds to [isLeftyKey]
  const EzTextButton({
    super.key,
    this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
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
  Widget build(BuildContext context) {
    final bool isLefty = EzConfig.get(isLeftyKey) ?? false;

    return TextButton.icon(
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      statesController: statesController,
      icon: icon,
      iconAlignment: isLefty ? IconAlignment.start : IconAlignment.end,
      label: Text(label, style: textStyle, textAlign: textAlign),
    );
  }
}
