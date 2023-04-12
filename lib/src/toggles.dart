library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Styles a [PlatformSwitch] from [EzConfig.prefs]
PlatformSwitch ezSwitch({
  required bool value,
  required void Function(bool)? onChanged,
}) {
  return PlatformSwitch(
    value: value,
    onChanged: onChanged,
    activeColor: Color(EzConfig.prefs[buttonColorKey]),
  );
}

/// Styles a [Checkbox] from [EzConfig.prefs]
Widget ezCheckBox({
  required bool value,
  required void Function(bool?)? onChanged,
}) {
  return Checkbox(
    value: value,
    onChanged: onChanged,
    checkColor: Color(EzConfig.prefs[buttonTextColorKey]),
    fillColor: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return Color(EzConfig.prefs[buttonColorKey]);
        } else {
          return Color(EzConfig.prefs[themeTextColorKey]);
        }
      },
    ),
  );
}

/// Builds a pair of customizable [EzButton.icon]s for confirming and/or denying things
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

  Icon confirmIcon = customConfirm ?? EzIcon(PlatformIcons(context).checkMark);
  Icon denyIcon = customDeny ?? EzIcon(PlatformIcons(context).clear);
  double spacing = (spacer is double) ? spacer : EzConfig.prefs[buttonSpacingKey];

  return axis == Axis.vertical
      ? Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            EzButton.icon(action: onConfirm, icon: confirmIcon, message: confirmMsg),
            Container(height: spacing),
            EzButton.icon(action: onDeny, icon: denyIcon, message: denyMsg),
          ],
        )
      : Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            EzButton.icon(action: onConfirm, icon: confirmIcon, message: confirmMsg),
            Container(width: spacing),
            EzButton.icon(action: onDeny, icon: denyIcon, message: denyMsg),
          ],
        );
}

/// Quickly build a customizable "Cancel" [EzButton.icon]
Widget ezCancel({
  required BuildContext context,
  required void Function() onCancel,
  String cancelMsg = 'Cancel',
  Icon? customIcon,
}) {
  Icon icon = customIcon ?? EzIcon(PlatformIcons(context).clear);
  return EzButton.icon(action: onCancel, icon: icon, message: cancelMsg);
}

/// Styles an [ExpansionTile] with [EzConfig.prefs]
Widget ezDropList({
  required String title,
  required List<Widget> body,
  bool open = false,
}) {
  TextStyle titleStyle = buildTextStyle(style: titleStyleKey);
  Color themeColor = Color(EzConfig.prefs[themeColorKey]);
  Color themeTextColor = Color(EzConfig.prefs[themeTextColorKey]);

  double padding = EzConfig.prefs[paddingKey];

  return ExpansionTile(
    // Title
    title: Text(title, style: titleStyle),
    tilePadding: EdgeInsets.all(padding),

    // Body
    children: body,
    childrenPadding: EdgeInsets.only(left: padding, right: padding),
    initiallyExpanded: open,
    onExpansionChanged: (bool open) => EzConfig.focus.primaryFocus?.unfocus(),

    // Theme
    backgroundColor: themeColor,
    collapsedBackgroundColor: themeColor,
    textColor: themeTextColor,
    collapsedTextColor: themeTextColor,
    iconColor: themeTextColor,
    collapsedIconColor: themeTextColor,
  );
}
