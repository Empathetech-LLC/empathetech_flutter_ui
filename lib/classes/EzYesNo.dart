library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

Widget EzYesNo({
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

  Icon confirmIcon = customConfirm ?? Icon(PlatformIcons(context).checkMark);
  Icon denyIcon = customDeny ?? Icon(PlatformIcons(context).clear);
  double spacing =
      (spacer is double) ? spacer : EzConfig.prefs[buttonSpacingKey];

  return axis == Axis.vertical
      ? Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: onConfirm,
              icon: confirmIcon,
              label: Text(confirmMsg),
            ),
            Container(height: spacing),
            ElevatedButton.icon(
              onPressed: onDeny,
              icon: denyIcon,
              label: Text(denyMsg),
            ),
          ],
        )
      : Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
                onPressed: onConfirm,
                icon: confirmIcon,
                label: Text(confirmMsg)),
            Container(width: spacing),
            ElevatedButton.icon(
                onPressed: onDeny, icon: denyIcon, label: Text(denyMsg)),
          ],
        );
}
