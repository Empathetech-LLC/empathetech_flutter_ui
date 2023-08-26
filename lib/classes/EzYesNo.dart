/// empathetech_flutter_ui
/// Copyright (c) 2023 Empathetech LLC. All rights reserved.
/// See LICENSE for distribution and usage details.
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
  final Icon? confirmIcon;
  final Icon? denyIcon;

  const EzYesNo({
    required this.onConfirm,
    required this.onDeny,
    this.axis = Axis.vertical,
    this.spacer,
    this.confirmMsg = 'Yes',
    this.denyMsg = 'No',
    this.confirmIcon,
    this.denyIcon,
  });

  @override
  Widget build(BuildContext context) {
    final Icon confirm = confirmIcon ?? Icon(PlatformIcons(context).checkMark);
    final Icon deny = denyIcon ?? Icon(PlatformIcons(context).clear);

    final double space =
        (spacer is double) ? spacer : EzConfig.instance.prefs[buttonSpacingKey];

    return axis == Axis.vertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Yes
              ElevatedButton.icon(
                onPressed: onConfirm,
                icon: confirm,
                label: Text(confirmMsg),
              ),
              EzSpacer(space),

              // No
              ElevatedButton.icon(
                onPressed: onDeny,
                icon: deny,
                label: Text(denyMsg),
              ),
            ],
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Yes
              ElevatedButton.icon(
                onPressed: onConfirm,
                icon: confirm,
                label: Text(confirmMsg),
              ),
              EzSpacer.row(space),

              // No
              ElevatedButton.icon(
                onPressed: onDeny,
                icon: deny,
                label: Text(denyMsg),
              ),
            ],
          );
  }
}
