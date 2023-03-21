library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Styles a [PlatformSwitch] from [AppConfig.prefs]
Widget ezSwitch(BuildContext context, bool value, void Function(bool)? onChanged) {
  return PlatformSwitch(
    value: value,
    onChanged: onChanged,
    activeColor: Color(AppConfig.prefs[buttonColorKey]),
  );
}

/// Style a [PlatformElevatedButton] from [AppConfig.prefs]
/// If provided, [customStyle] will be merged with [materialButton]
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

      // Styling
      material: (context, platform) => MaterialElevatedButtonData(style: baseStyle),
      cupertino: (context, platform) => m2cButton(baseStyle),
    ),
  );
}

/// Style a [PlatformElevatedButton] from [AppConfig.prefs] that mimics the original
/// behavior of [ElevatedButton.icon]
/// If provided, [customStyle] will be merged with [materialButton]
Widget ezIconButton(
    void Function() action, void Function() longAction, Icon icon, Widget body,
    [ButtonStyle? customStyle]) {
  ButtonStyle baseStyle =
      customStyle == null ? materialButton() : materialButton().merge(customStyle);

  return GestureDetector(
    onLongPress: longAction,
    child: PlatformElevatedButton(
      onPressed: action,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          icon,
          Container(width: AppConfig.prefs[paddingKey]),
          body,
        ],
      ),

      // Styling
      padding: EdgeInsets.all(AppConfig.prefs[paddingKey]),
      material: (context, platform) => MaterialElevatedButtonData(style: baseStyle),
      cupertino: (context, platform) => m2cButton(baseStyle),
    ),
  );
}

/// Builds a pair of customizable [ezTextIconButton]s for confirming and/or denying things
Widget ezYesNo(
    BuildContext context, void Function() onConfirm, void Function() onDeny, Axis axis,
    [String confirmMsg = 'Yes',
    String denyMsg = 'No',
    Icon? customConfirm,
    Icon? customDeny]) {
  // Gather theme data
  Icon confirmIcon = customConfirm ?? Icon(PlatformIcons(context).checkMark);
  Icon denyIcon = customConfirm ?? Icon(PlatformIcons(context).clear);

  return axis == Axis.vertical
      ? Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Confirm
            ezIconButton(onConfirm, () {}, confirmIcon, Text(confirmMsg)),

            // Spacer
            Container(height: AppConfig.prefs[buttonSpacingKey]),

            // Deny
            ezIconButton(onDeny, () {}, denyIcon, Text(denyMsg)),
          ],
        )
      : Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Confirm
            ezIconButton(onConfirm, () {}, confirmIcon, Text(confirmMsg)),

            // Spacer
            Container(width: AppConfig.prefs[paddingKey]),

            // Deny
            ezIconButton(onDeny, () {}, denyIcon, Text(denyMsg)),
          ],
        );
}
