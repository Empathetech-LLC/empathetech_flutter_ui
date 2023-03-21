library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Styles a [PlatformSwitch] from [AppConfig.prefs]
Widget ezSwitch({
  required bool value,
  required void Function(bool)? onChanged,
}) {
  return PlatformSwitch(
    value: value,
    onChanged: onChanged,
    activeColor: Color(AppConfig.prefs[buttonColorKey]),
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
  // Build button style
  ButtonStyle baseStyle;

  (body is Icon)
      ? baseStyle = materialButton(shape: CircleBorder())
      : baseStyle = materialButton();

  // Overwrite any fields from base style found in custom style
  // Then merge any fields unique to custom style
  if (customStyle != null) {
    baseStyle = baseStyle.copyWith(
      backgroundColor: customStyle.backgroundColor ?? baseStyle.backgroundColor,
      foregroundColor: customStyle.foregroundColor ?? baseStyle.foregroundColor,
      textStyle: customStyle.textStyle ?? baseStyle.textStyle,
      padding: customStyle.padding ?? baseStyle.padding,
      side: customStyle.side ?? baseStyle.side,
      shape: customStyle.shape ?? baseStyle.shape,
    );
    baseStyle = baseStyle.merge(customStyle);
  }

  // Return the button
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
Widget ezIconButton({
  required void Function() action,
  void Function() longAction = doNothing,
  required Icon icon,
  required Widget body,
  ButtonStyle? customStyle,
}) {
  ButtonStyle baseStyle = materialButton();

  // Overwrite any fields from base style found in custom style
  // Then merge any fields unique to custom style
  if (customStyle != null) {
    baseStyle = baseStyle.copyWith(
      backgroundColor: customStyle.backgroundColor ?? baseStyle.backgroundColor,
      foregroundColor: customStyle.foregroundColor ?? baseStyle.foregroundColor,
      textStyle: customStyle.textStyle ?? baseStyle.textStyle,
      padding: customStyle.padding ?? baseStyle.padding,
      side: customStyle.side ?? baseStyle.side,
      shape: customStyle.shape ?? baseStyle.shape,
    );
    baseStyle = baseStyle.merge(customStyle);
  }

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
      material: (context, platform) => MaterialElevatedButtonData(style: baseStyle),
      cupertino: (context, platform) => m2cButton(baseStyle),
    ),
  );
}

/// Builds a pair of customizable [ezIconButton]s for confirming and/or denying things
Widget ezYesNo({
  required BuildContext context,
  required void Function() onConfirm,
  required void Function() onDeny,
  required Axis axis,
  String confirmMsg = 'Yes',
  String denyMsg = 'No',
  Icon? customConfirm,
  Icon? customDeny,
}) {
  // Gather theme data
  Icon confirmIcon = customConfirm ?? Icon(PlatformIcons(context).checkMark);
  Icon denyIcon = customDeny ?? Icon(PlatformIcons(context).clear);

  return axis == Axis.vertical
      ? Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Confirm
            ezIconButton(
              action: onConfirm,
              icon: confirmIcon,
              body: Text(confirmMsg),
            ),

            Container(height: AppConfig.prefs[buttonSpacingKey]),

            // Deny
            ezIconButton(
              action: onDeny,
              icon: denyIcon,
              body: Text(denyMsg),
            ),
          ],
        )
      : Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Confirm
            ezIconButton(
              action: onConfirm,
              icon: confirmIcon,
              body: Text(confirmMsg),
            ),

            Container(width: AppConfig.prefs[paddingKey]),

            // Deny
            ezIconButton(
              action: onDeny,
              icon: denyIcon,
              body: Text(denyMsg),
            ),
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
  Icon icon = customIcon ?? Icon(PlatformIcons(context).clear);

  return ezIconButton(
    action: onCancel,
    icon: icon,
    body: Text(cancelMsg),
  );
}
