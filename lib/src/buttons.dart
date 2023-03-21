library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Style a [PlatformElevatedButton] from [AppConfig.prefs]
/// Intended for a widget child, see [ezTextButton] for text child
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
      cupertino: (context, platform) => CupertinoElevatedButtonData(m2cButton(baseStyle)),
    ),
  );
}

/// Style a [PlatformElevatedButton] from [AppConfig.prefs]
/// Intended for a text child, see [ezButton] for widget child
Widget ezTextButton(void Function() action, void Function() longAction, String text,
    [TextStyle? textStyle,
    ButtonStyle? androidStyle,
    CupertinoElevatedButtonData? iosStyle]) {
  // Gather theme data
  Color color = Color(AppConfig.prefs[buttonColorKey]);

  return GestureDetector(
    onLongPress: longAction,
    child: PlatformElevatedButton(
      onPressed: action,
      child: Text(text, style: textStyle, textAlign: TextAlign.center),

      // Platform specific overwrites
      material: (context, platform) => (androidStyle == null)
          ? MaterialElevatedButtonData(style: androidButton())
          : MaterialElevatedButtonData(style: androidButton().merge(androidStyle)),
      cupertino: (context, platform) => CupertinoElevatedButtonData(
        color: color,
        padding: EdgeInsets.all(AppConfig.prefs[paddingKey]),
      ),
    ),
  );
}

/// Style a [PlatformIconButton] from [AppConfig.prefs]
/// See [ezTextIconButton] for adding a message
Widget ezIconButton(void Function() action, void Function() longAction, IconData icon,
    [Color? buttonColor, Color? iconColor]) {
  double padding = AppConfig.prefs[paddingKey];
  double buttonTextSize = getTextStyle(buttonStyleKey).fontSize ?? 24.0;

  return GestureDetector(
    onLongPress: longAction,
    child: Container(
      width: buttonTextSize * 2 + padding,
      height: buttonTextSize * 2 + padding,
      decoration: BoxDecoration(
          color: buttonColor ?? Color(AppConfig.prefs[buttonColor]),
          shape: BoxShape.circle,
          border: Border.all(color: Color(AppConfig.prefs[buttonColorKey]))),
      child: PlatformIconButton(
        onPressed: action,
        icon: Icon(
          icon,
          color: iconColor ?? Color(AppConfig.prefs[buttonTextColorKey]),
          size: buttonTextSize,
        ),
      ),
    ),
  );
}

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
