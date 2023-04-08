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

/// Styles a [Checkbox] from [AppConfig.prefs]
Widget ezCheckBox({
  required bool value,
  required void Function(bool?)? onChanged,
}) {
  return Checkbox(
    value: value,
    onChanged: onChanged,
    activeColor: Color(AppConfig.prefs[buttonColorKey]),
  );
}

/// Builds a pair of customizable [EZButton.icon]s for confirming and/or denying things
Widget ezYesNo(
  BuildContext context, {
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
  double spacing = (spacer is double) ? spacer : AppConfig.prefs[buttonSpacingKey];

  return axis == Axis.vertical
      ? Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            EZButton.icon(action: onConfirm, icon: confirmIcon, message: confirmMsg),
            Container(height: spacing),
            EZButton.icon(action: onDeny, icon: denyIcon, message: denyMsg),
          ],
        )
      : Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            EZButton.icon(action: onConfirm, icon: confirmIcon, message: confirmMsg),
            Container(width: spacing),
            EZButton.icon(action: onDeny, icon: denyIcon, message: denyMsg),
          ],
        );
}

/// Quickly build a customizable "Cancel" [EZButton.icon]
Widget ezCancel(
  BuildContext context, {
  required void Function() onCancel,
  String cancelMsg = 'Cancel',
  Icon? customIcon,
}) {
  Icon icon = customIcon ?? ezIcon(PlatformIcons(context).clear);
  return EZButton.icon(action: onCancel, icon: icon, message: cancelMsg);
}
