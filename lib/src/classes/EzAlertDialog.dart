/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzAlertDialog extends PlatformAlertDialog {
  final Key? key;
  final Key? widgetKey;

  /// Dialog's [title]
  final Widget? title;

  /// Dialog's main [content]
  final Widget? content;

  /// [AlertDialog.actions]s to be displayed below the [content]
  /// Pairs best with [ezMaterialActions]
  final List<Widget>? materialActions;

  /// [CupertinoAlertDialogData.actions]s to be displayed below the [content]
  /// Pairs best with [ezCupertinoActions]
  final List<CupertinoDialogAction>? cupertinoActions;

  /// Cupertino alerts aren't dismissable by tapping outside the renderbox
  /// Set [needsClose] to true if a default "Close" [CupertinoDialogAction] is needed
  final bool needsClose;

  /// [PlatformAlertDialog] wrapper with [EzConfig] styling
  EzAlertDialog({
    this.key,
    this.widgetKey,
    required this.title,
    required this.content,
    this.materialActions,
    this.cupertinoActions,
    this.needsClose = true,
  });

  @override
  Widget build(BuildContext context) {
    final double padding = EzConfig.instance.prefs[paddingKey];

    CupertinoDialogAction _closeAction = CupertinoDialogAction(
      onPressed: () => popScreen(context: context),
      child: Text(EFUILang.of(context)!.close),
    );

    return PlatformAlertDialog(
      key: key,
      widgetKey: widgetKey,
      material: (context, platform) => MaterialAlertDialogData(
        insetPadding: EdgeInsets.all(padding),

        title: title,
        // Bottom titlePadding comes from vertical contentPadding
        titlePadding:
            EdgeInsets.only(top: padding, left: padding, right: padding),

        content: content,
        contentPadding:
            EdgeInsets.symmetric(vertical: padding, horizontal: padding),
        actions: materialActions,
      ),
      cupertino: (context, platform) => CupertinoAlertDialogData(
        title: Padding(
          // No titlePadding equivalent, have to do it manually
          padding: EdgeInsets.only(bottom: padding),
          child: title,
        ),
        content: content,
        actions: cupertinoActions == null
            ? [_closeAction]
            : (needsClose)
                ? [...cupertinoActions!, _closeAction]
                : cupertinoActions,
      ),
    );
  }
}

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
      child: Text(confirmMsg ?? EFUILang.of(context)!.yes),
    ),
    EzSpacer(EzConfig.instance.prefs[buttonSpacingKey]),

    // Deny
    TextButton(
      onPressed: onDeny,
      child: Text(denyMsg ?? EFUILang.of(context)!.no),
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
      child: Text(confirmMsg ?? EFUILang.of(context)!.yes),
      isDefaultAction: confirmIsDefault,
      isDestructiveAction: confirmIsDestructive,
    ),

    // Deny
    CupertinoDialogAction(
      onPressed: onDeny,
      child: Text(denyMsg ?? EFUILang.of(context)!.no),
      isDefaultAction: denyIsDefault,
      isDestructiveAction: denyIsDestructive,
    ),
  ];
}
