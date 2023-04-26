library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzYesNo extends StatelessWidget {
  final void Function() onConfirm;
  final void Function() onDeny;
  final Axis axis;
  final double? spacer;
  final String confirmMsg;
  final String denyMsg;
  final Icon? customConfirm;
  final Icon? customDeny;

  EzYesNo({
    required this.onConfirm,
    required this.onDeny,
    this.axis = Axis.vertical,
    this.spacer,
    this.confirmMsg = 'Yes',
    this.denyMsg = 'No',
    this.customConfirm,
    this.customDeny,
  });

  @override
  Widget build(BuildContext context) {
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
}
