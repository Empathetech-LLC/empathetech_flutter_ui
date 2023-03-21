library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Style a [PlatformElevatedButton] from [AppConfig.prefs]
Widget ezButton(void Function() action, void Function() longAction, Widget body,
    [ButtonStyle? customStyle]) {
  // Build button style(s)
  ButtonStyle baseStyle =
      customStyle == null ? materialButton() : materialButton().merge(customStyle);

  return GestureDetector(
    onLongPress: longAction,
    child: PlatformElevatedButton(
      onPressed: action,
      child: body,

      // Android config
      material: (context, platform) => MaterialElevatedButtonData(style: baseStyle),
      cupertino: (context, platform) => m2cButton(baseStyle),
    ),
  );
}

/// Style a [PlatformElevatedButton] from [AppConfig.prefs] that mimics the original
/// behavior of [ElevatedButton.icon]

/// Style a [PlatformElevatedButton] from [AppConfig.prefs] that mimics the original
/// behavior of [ElevatedButton.icon]
Widget ezTextIconButton(
    void Function() action, void Function() longAction, String text, IconData icon,
    [TextStyle? textStyle, Color? buttonColor, Color? iconColor]) {
  Color color = Color(AppConfig.prefs[buttonColorKey]);
  double padding = AppConfig.prefs[paddingKey];
  double buttonTextSize = getTextStyle(buttonStyleKey).fontSize ?? 24.0;

  return GestureDetector(
    onLongPress: longAction,
    child: PlatformElevatedButton(
      onPressed: action,
      color: color,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Icon
          Icon(
            icon,
            color: iconColor ?? Color(AppConfig.prefs[buttonTextColorKey]),
            size: buttonTextSize,
          ),
          Container(width: padding),

          // Text
          Text(text, style: textStyle ?? getTextStyle(buttonStyleKey)),
        ],
      ),
      padding: EdgeInsets.all(AppConfig.prefs[paddingKey]),
    ),
  );
}
