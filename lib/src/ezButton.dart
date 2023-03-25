library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
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

  ButtonStyle _buildStyle() {
    ButtonStyle style = materialButton();

    switch (this.body.runtimeType) {
      case Icon:
        // Icon buttons should be circular
        style = materialButton(shape: CircleBorder());
        break;

      case Text:
        // Text styling works differently in Material and Cupertino
        // so a little redundancy goes a long way
        Text cast = this.body as Text;
        if (cast.style == null) {
          this.body = Text(
            cast.data ?? 'Lorem ipsum',
            style: getTextStyle(buttonStyleKey),
            textAlign: cast.textAlign,
          );
        }
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

  @override
  Widget build(BuildContext context) {
    ButtonStyle ezButtonStyle = _buildStyle();

    return GestureDetector(
      onLongPress: longAction,
      child: PlatformElevatedButton(
        onPressed: action,
        color: (ezButtonStyle.backgroundColor is Color)
            ? ezButtonStyle.backgroundColor as Color
            : Color(AppConfig.prefs[buttonColorKey]),
        child: body,
        material: (context, platform) => MaterialElevatedButtonData(style: ezButtonStyle),
        cupertino: (context, platform) => m2cButton(ezButtonStyle),
      ),
    );
  }
}
