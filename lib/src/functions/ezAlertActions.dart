/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Pairs with [EzAlertDialog]
/// Quickly creates Material 'action' buttons for the dialog
/// All required parameters are identical to [ezCupertinoActions]
List<Widget>? ezMaterialActions({
  required BuildContext context,
  required void Function() onConfirm,
  required void Function() onDeny,
  String? confirmMsg,
  String? denyMsg,
  Icon? confirmIcon,
  Icon? denyIcon,
}) {
  return [
    // Confirm
    ElevatedButton.icon(
      onPressed: onConfirm,
      icon: confirmIcon ?? const Icon(Icons.check),
      label: Text(confirmMsg ?? EFUILocalizations.of(context)!.yes),
    ),
    EzSpacer(EzConfig.instance.prefs[buttonSpacingKey]),

    // Deny
    ElevatedButton.icon(
      onPressed: onDeny,
      icon: denyIcon ?? const Icon(Icons.clear),
      label: Text(denyMsg ?? EFUILocalizations.of(context)!.no),
    ),
  ];
}

/// Pairs with [EzAlertDialog]
/// Quickly creates [CupertinoDialogAction]s
/// All required parameters are identical to [ezMaterialActions]
List<CupertinoDialogAction>? ezCupertinoActions({
  required BuildContext context,
  required void Function() onConfirm,
  required void Function() onDeny,
  String? confirmMsg,
  String? denyMsg,
  bool confirmIsDefault = false,
  bool denyIsDefault = false,
  bool confirmIsDestructive = false,
  bool denyIsDestructive = false,
}) {
  return [
    // Confirm
    CupertinoDialogAction(
      onPressed: onConfirm,
      child: Text(confirmMsg ?? EFUILocalizations.of(context)!.yes),
      isDefaultAction: confirmIsDefault,
      isDestructiveAction: confirmIsDestructive,
    ),

    // Deny
    CupertinoDialogAction(
      onPressed: onDeny,
      child: Text(denyMsg ?? EFUILocalizations.of(context)!.no),
      isDefaultAction: denyIsDefault,
      isDestructiveAction: denyIsDestructive,
    ),
  ];
}
