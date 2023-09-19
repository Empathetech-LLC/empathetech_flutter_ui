/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Pairs with [EzAlertDialog]
/// Quickly creates Material 'action' buttons for the dialog
/// All required parameters are identical to [ezCupertinoActions]
List<Widget>? ezMaterialActions({
  required void Function() onConfirm,
  required void Function() onDeny,
  String confirmMsg = 'Yes',
  String denyMsg = 'No',
  Icon? confirmIcon,
  Icon? denyIcon,
}) {
  final Icon confirm = confirmIcon ?? const Icon(Icons.check);
  final Icon deny = denyIcon ?? const Icon(Icons.clear);

  final double space = EzConfig.instance.prefs[buttonSpacingKey];

  return [
    // Confirm
    ElevatedButton.icon(
      onPressed: onConfirm,
      icon: confirm,
      label: Text(confirmMsg),
    ),
    EzSpacer(space),

    // Deny
    ElevatedButton.icon(
      onPressed: onDeny,
      icon: deny,
      label: Text(denyMsg),
    ),
  ];
}

/// Pairs with [EzAlertDialog]
/// Quickly creates [CupertinoDialogAction]s
/// All required parameters are identical to [ezMaterialActions]
List<CupertinoDialogAction>? ezCupertinoActions({
  required void Function() onConfirm,
  required void Function() onDeny,
  String confirmMsg = 'Yes',
  String denyMsg = 'No',
  bool confirmIsDefault = false,
  bool denyIsDefault = false,
  bool confirmIsDestructive = false,
  bool denyIsDestructive = false,
}) {
  return [
    // Confirm
    CupertinoDialogAction(
      onPressed: onConfirm,
      child: Text(confirmMsg),
      isDefaultAction: confirmIsDefault,
      isDestructiveAction: confirmIsDestructive,
    ),

    // Deny
    CupertinoDialogAction(
      onPressed: onDeny,
      child: Text(denyMsg),
      isDefaultAction: denyIsDefault,
      isDestructiveAction: denyIsDestructive,
    ),
  ];
}
