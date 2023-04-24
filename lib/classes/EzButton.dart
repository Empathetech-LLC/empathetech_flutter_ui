library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class EzButton extends StatelessWidget {
  final Key? key;
  final void Function() onPressed;
  final void Function()? onLongPress;
  final void Function(bool)? onHover;
  final void Function(bool)? onFocusChange;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;

  final MaterialStatesController? statesController;
  final Widget child;

  /// An [ElevatedButton] that can turn into a [CupertinoActionSheetAction]
  EzButton({
    this.key,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.statesController,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: key,
      onPressed: onPressed,
      onLongPress: onLongPress,
      onFocusChange: onFocusChange,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      statesController: statesController,
      child: child,
    );
  }

  /// Builds a [CupertinoActionSheetAction] from this button
  CupertinoActionSheetAction toAction() {
    return CupertinoActionSheetAction(
      onPressed: this.onPressed,
      child: GestureDetector(
        onLongPress: this.onLongPress,
        child: this.child,
      ),
    );
  }

  /// An [ElevatedButton] that can turn into a [CupertinoActionSheetAction]
  factory EzButton.icon({
    Key? key,
    required void Function() onPressed,
    void Function()? onLongPress,
    void Function(bool)? onHover,
    void Function(bool)? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus = false,
    Clip clipBehavior = Clip.none,
    MaterialStatesController? statesController,
    required Widget icon,
    required Widget label,
  }) {
    return EzButton(
      key: key,
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      statesController: statesController,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          icon,
          Container(width: EzConfig.prefs[paddingKey]),
          label,
        ],
      ),
    );
  }
}
