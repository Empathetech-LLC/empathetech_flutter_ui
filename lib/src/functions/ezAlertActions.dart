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
}) {
  return [
    // Confirm
    TextButton(
      onPressed: onConfirm,
      child: Text(confirmMsg ?? EFUIPhrases.of(context)!.yes),
    ),
    EzSpacer(EzConfig.instance.prefs[buttonSpacingKey]),

    // Deny
    TextButton(
      onPressed: onDeny,
      child: Text(denyMsg ?? EFUIPhrases.of(context)!.no),
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
      child: Text(confirmMsg ?? EFUIPhrases.of(context)!.yes),
      isDefaultAction: confirmIsDefault,
      isDestructiveAction: confirmIsDestructive,
    ),

    // Deny
    CupertinoDialogAction(
      onPressed: onDeny,
      child: Text(denyMsg ?? EFUIPhrases.of(context)!.no),
      isDefaultAction: denyIsDefault,
      isDestructiveAction: denyIsDestructive,
    ),
  ];
}
