library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Styles a [PlatformElevatedButton] from [AppConfig.prefs]
/// If provided, [customStyle] will be merged with [materialButton]
class EZButton extends StatelessWidget {
  final VoidCallback action;
  final VoidCallback longAction;
  final Widget body;
  final ButtonStyle? customStyle;

  EZButton({
    required this.action,
    this.longAction = doNothing,
    required this.body,
    this.customStyle,
  });

  EZButton.icon({
    required this.action,
    this.longAction = doNothing,
    this.customStyle,
    required Icon icon,
    required String message,
    TextStyle? customTextStyle,
  }) : this.body = Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            icon,
            Container(width: AppConfig.prefs[paddingKey]),
            Text(
              message,
              style: customTextStyle ?? getTextStyle(buttonStyleKey),
              textAlign: TextAlign.center,
            ),
          ],
        );

  /// Text styling works differently in Material and Cupertino
  /// so a little redundancy goes a long way
  Widget _buildBody() {
    switch (this.body.runtimeType) {
      case Text:
        Text cast = this.body as Text;
        if (cast.style == null) {
          return Text(
            cast.data ?? 'Lorem ipsum',
            style: getTextStyle(buttonStyleKey),
            textAlign: cast.textAlign,
          );
        } else {
          return this.body;
        }

      default:
        return this.body;
    }
  }

  /// Mimics a [ButtonStyle] replaceAll() style function
  /// Replace and merge values in [materialButton] with values in [customStyle]
  ButtonStyle _buildStyle() {
    ButtonStyle style = materialButton();

    switch (this.body.runtimeType) {
      case Icon:
        style = materialButton(shape: CircleBorder());
        break;
    }

    if (customStyle != null) {
      style = style.copyWith(
        backgroundColor: customStyle!.backgroundColor ?? style.backgroundColor,
        foregroundColor: customStyle!.foregroundColor ?? style.foregroundColor,
        textStyle: customStyle!.textStyle ?? style.textStyle,
        padding: customStyle!.padding ?? style.padding,
        side: customStyle!.side ?? style.side,
        shape: customStyle!.shape ?? style.shape,
      );
      style = style.merge(customStyle!);
    }

    return style;
  }

  /// Builds a [CupertinoActionSheetAction] from this button's values
  Widget toAction() {
    return GestureDetector(
      onLongPress: this.longAction,
      child: CupertinoActionSheetAction(
        onPressed: this.action,
        child: DefaultTextStyle.merge(
          style: getTextStyle(dialogContentStyleKey),
          child: this.body,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget ezBody = _buildBody();
    ButtonStyle ezStyle = _buildStyle();

    return GestureDetector(
      onLongPress: longAction,
      child: PlatformElevatedButton(
        onPressed: action,
        color: (ezStyle.backgroundColor is Color)
            ? ezStyle.backgroundColor as Color
            : Color(AppConfig.prefs[buttonColorKey]),
        child: ezBody,
        material: (context, platform) => MaterialElevatedButtonData(style: ezStyle),
        cupertino: (context, platform) => m2cButton(ezStyle),
      ),
    );
  }
}
