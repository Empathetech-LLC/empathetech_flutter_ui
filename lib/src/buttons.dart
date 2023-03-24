library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Styles a [PlatformSwitch] from [AppConfig.prefs]
PlatformSwitch ezSwitch({
  required bool value,
  required void Function(bool)? onChanged,
}) {
  return PlatformSwitch(
    value: value,
    onChanged: onChanged,
    activeColor: Color(AppConfig.prefs[buttonColorKey]),
  );
}

/// Styles an [Icon] from [AppConfig.prefs]
Icon ezIcon(
  IconData icon, {
  Color? color,
  double? size,
}) {
  return Icon(
    icon,
    color: color ?? Color(AppConfig.prefs[buttonTextColorKey]),
    size: size,
  );
}

/// Styles a [PlatformElevatedButton] from [AppConfig.prefs]
/// If provided, [customStyle] will be merged with [materialButton]
Widget ezButton({
  required void Function() action,
  void Function() longAction = doNothing,
  required Widget body,
  ButtonStyle? customStyle,
}) {
  // Preliminary styling based on the body Widget

  ButtonStyle ezButtonStyle = materialButton();

  switch (body.runtimeType) {
    case Icon:
      // Icon buttons should be circular
      ezButtonStyle = materialButton(shape: CircleBorder());
      break;

    case Text:
      // Text styling works differently in Material and Cupertino
      // so a little redundancy goes a long way
      Text cast = body as Text;
      if (cast.style == null) {
        body = Text(
          cast.data ?? 'Lorem ipsum',
          style: getTextStyle(buttonStyleKey),
          textAlign: cast.textAlign,
        );
      }
      break;
  }

  // Build the button style, using copyWith and merge to create a custom replaceAll()
  // style function if custom style is not null

  if (customStyle != null) {
    ezButtonStyle = ezButtonStyle.copyWith(
      backgroundColor: customStyle.backgroundColor ?? ezButtonStyle.backgroundColor,
      foregroundColor: customStyle.foregroundColor ?? ezButtonStyle.foregroundColor,
      textStyle: customStyle.textStyle ?? ezButtonStyle.textStyle,
      padding: customStyle.padding ?? ezButtonStyle.padding,
      side: customStyle.side ?? ezButtonStyle.side,
      shape: customStyle.shape ?? ezButtonStyle.shape,
    );
    ezButtonStyle = ezButtonStyle.merge(customStyle);
  }

  // Return the button
  return GestureDetector(
    onLongPress: longAction,
    child: PlatformElevatedButton(
      onPressed: action,

      color: (ezButtonStyle.backgroundColor is Color)
          ? ezButtonStyle.backgroundColor as Color
          : Color(AppConfig.prefs[buttonColorKey]),
      child: body,

      // Styling
      material: (context, platform) => MaterialElevatedButtonData(style: ezButtonStyle),
      cupertino: (context, platform) => m2cButton(ezButtonStyle),
    ),
  );
}

/// Style a [PlatformElevatedButton] from [AppConfig.prefs] that mimics the original
/// behavior of [ElevatedButton.icon]
/// If provided, [customStyle] will be merged with [materialButton]
Widget ezIconButton({
  required void Function() action,
  void Function() longAction = doNothing,
  required Icon icon,
  required String message,
  TextStyle? customTextStyle,
  ButtonStyle? customButonStyle,
}) {
  ButtonStyle ezButtonStyle = materialButton();
  TextStyle ezTextStyle =
      (customTextStyle == null) ? getTextStyle(buttonStyleKey) : customTextStyle;

  // Build the button style, using copyWith and merge to create a custom replaceAll()
  // style function if custom style is not null

  if (customButonStyle != null) {
    ezButtonStyle = ezButtonStyle.copyWith(
      backgroundColor: customButonStyle.backgroundColor ?? ezButtonStyle.backgroundColor,
      foregroundColor: customButonStyle.foregroundColor ?? ezButtonStyle.foregroundColor,
      textStyle: customButonStyle.textStyle ?? ezButtonStyle.textStyle,
      padding: customButonStyle.padding ?? ezButtonStyle.padding,
      side: customButonStyle.side ?? ezButtonStyle.side,
      shape: customButonStyle.shape ?? ezButtonStyle.shape,
    );
    ezButtonStyle = ezButtonStyle.merge(customButonStyle);
  }

  return GestureDetector(
    onLongPress: longAction,
    child: PlatformElevatedButton(
      onPressed: action,

      color: (ezButtonStyle.backgroundColor is Color)
          ? ezButtonStyle.backgroundColor as Color
          : Color(AppConfig.prefs[buttonColorKey]),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          icon,
          Container(width: AppConfig.prefs[paddingKey]),
          Text(message, style: ezTextStyle, textAlign: TextAlign.center),
        ],
      ),

      // Styling
      material: (context, platform) => MaterialElevatedButtonData(style: ezButtonStyle),
      cupertino: (context, platform) => m2cButton(ezButtonStyle),
    ),
  );
}

/// Builds a pair of customizable [ezIconButton]s for confirming and/or denying things
Widget ezYesNo({
  required BuildContext context,
  required void Function() onConfirm,
  required void Function() onDeny,
  required Axis axis,
  double? spacer,
  String confirmMsg = 'Yes',
  String denyMsg = 'No',
  Icon? customConfirm,
  Icon? customDeny,
}) {
  // Gather theme data

  Icon confirmIcon = customConfirm ?? ezIcon(PlatformIcons(context).checkMark);
  Icon denyIcon = customDeny ?? ezIcon(PlatformIcons(context).clear);
  double spacing = (spacer == null) ? AppConfig.prefs[buttonSpacingKey] : spacer;

  return axis == Axis.vertical
      ? Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ezIconButton(action: onConfirm, icon: confirmIcon, message: confirmMsg),
            Container(height: spacing),
            ezIconButton(action: onDeny, icon: denyIcon, message: denyMsg),
          ],
        )
      : Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ezIconButton(action: onConfirm, icon: confirmIcon, message: confirmMsg),
            Container(width: spacing),
            ezIconButton(action: onDeny, icon: denyIcon, message: denyMsg),
          ],
        );
}

/// Quickly build a customizable "Cancel" [ezIconButton]
Widget ezCancel({
  required BuildContext context,
  required void Function() onCancel,
  String cancelMsg = 'Cancel',
  Icon? customIcon,
}) {
  Icon icon = customIcon ?? ezIcon(PlatformIcons(context).clear);
  return ezIconButton(action: onCancel, icon: icon, message: cancelMsg);
}
