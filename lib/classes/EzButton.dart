library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzButton extends ElevatedButton {
  final Key? key;
  final void Function()? onPressed;
  final void Function()? onLongPress;
  final void Function(bool)? onHover;
  final void Function(bool)? onFocusChange;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final MaterialStatesController? statesController;
  final Widget child;

  /// [ElevatedButton] wrapper that adds [EzConfig] padding around the child widget
  EzButton({
    this.key,
    this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.statesController,
    required this.child,
  }) : super(
          key: key,
          onPressed: onPressed ?? () {},
          onLongPress: onLongPress,
          onHover: onHover,
          onFocusChange: onFocusChange,
          style: style,
          focusNode: focusNode,
          autofocus: autofocus,
          clipBehavior: clipBehavior,
          statesController: statesController,
          child: Padding(
            padding: EdgeInsets.all(EzConfig.prefs[paddingKey]),
            child: child,
          ),
        );

  /// [ElevatedButton.icon] wrapper that adds [EzConfig] padding around the icon and label widgets
  EzButton.icon({
    Key? key,
    required Icon icon,
    required Text label,
    void Function()? onPressed,
    void Function()? onLongPress,
    void Function(bool)? onHover,
    void Function(bool)? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus = false,
    Clip clipBehavior = Clip.none,
    MaterialStatesController? statesController,
  }) : this(
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: EzConfig.prefs[paddingKey],
                  bottom: EzConfig.prefs[paddingKey],
                  left: EzConfig.prefs[paddingKey],
                ),
                child: icon,
              ),
              Padding(
                padding: EdgeInsets.all(EzConfig.prefs[paddingKey]),
                child: label,
              ),
            ],
          ),
        );
}
