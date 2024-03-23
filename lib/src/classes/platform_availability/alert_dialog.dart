/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzAlertDialog extends PlatformAlertDialog {
  @override
  // ignore: overridden_fields
  final Widget? title;
  // vscode is convinced that title is a String? otherwise... the future giveth and the future taketh away

  /// Optional [content] override
  /// Wraps [contents] in an [EzScrollView]
  final List<Widget>? contents;

  /// [AlertDialog.actions]s to be displayed below the [contents]
  /// Pairs best with [ezMaterialActions]
  final List<Widget>? materialActions;

  /// [CupertinoAlertDialogData.actions]s to be displayed below the [contents]
  /// Pairs best with [ezCupertinoActions]
  final List<CupertinoDialogAction>? cupertinoActions;

  /// Cupertino alerts aren't dismissible by tapping outside the dialog
  /// Set [needsClose] to true if a default "Close" [CupertinoDialogAction] is needed
  final bool needsClose;

  /// [PlatformAlertDialog] wrapper with custom styling
  EzAlertDialog({
    super.key,
    super.widgetKey,
    this.title,
    super.content,
    this.contents,
    this.materialActions,
    this.cupertinoActions,
    this.needsClose = true,
  }) : assert(
          (content == null) != (contents == null),
          'Either content or contents should be provided, but not both.',
        );

  @override
  Widget build(BuildContext context) {
    final double margin = EzConfig.get(marginKey);
    final double padding = EzConfig.get(paddingKey);
    final double spacing = EzConfig.get(spacingKey);

    final CupertinoDialogAction closeAction = CupertinoDialogAction(
      onPressed: () => popScreen(context: context),
      child: Text(EFUILang.of(context)!.gClose),
    );

    return PlatformAlertDialog(
      key: key,
      widgetKey: widgetKey,
      material: (BuildContext context, PlatformTarget platform) =>
          MaterialAlertDialogData(
        // Title
        title: title,
        titlePadding: EdgeInsets.all(padding),

        // Content
        content: content ?? EzScrollView(children: contents),
        contentPadding: EdgeInsets.only(
          left: padding,
          right: padding,
          bottom: padding,
        ),

        // Actions
        actions: materialActions,

        // General
        iconPadding: EdgeInsets.only(right: spacing),
        buttonPadding: EdgeInsets.only(right: spacing),
        insetPadding: EdgeInsets.all(margin),
      ),
      cupertino: (BuildContext context, PlatformTarget platform) =>
          CupertinoAlertDialogData(
        title: Padding(
          // No titlePadding equivalent, have to do it manually
          padding: EdgeInsets.only(bottom: padding),
          child: title,
        ),
        content: content ?? EzScrollView(children: contents),
        actions: cupertinoActions == null
            ? <Widget>[closeAction]
            : (needsClose)
                ? <Widget>[...cupertinoActions!, closeAction]
                : cupertinoActions,
      ),
    );
  }
}

/// Pairs with [EzAlertDialog]
/// Quickly creates Material 'action' buttons for the dialog
/// All required parameters are identical to [ezCupertinoActions]
List<TextButton> ezMaterialActions({
  required BuildContext context,
  required void Function() onConfirm,
  String? confirmMsg,
  required void Function() onDeny,
  String? denyMsg,
}) {
  return <TextButton>[
    // Confirm
    TextButton(
      onPressed: onConfirm,
      child: Text(confirmMsg ?? EFUILang.of(context)!.gYes),
    ),

    // Deny
    TextButton(
      onPressed: onDeny,
      child: Text(denyMsg ?? EFUILang.of(context)!.gNo),
    ),
  ];
}

/// Pairs with [EzAlertDialog]
/// Quickly creates [CupertinoDialogAction]s
/// All required parameters are identical to [ezMaterialActions]
List<CupertinoDialogAction> ezCupertinoActions({
  required BuildContext context,
  required void Function() onConfirm,
  String? confirmMsg,
  bool confirmIsDefault = false,
  bool confirmIsDestructive = false,
  required void Function() onDeny,
  String? denyMsg,
  bool denyIsDefault = false,
  bool denyIsDestructive = false,
}) {
  return <CupertinoDialogAction>[
    // Confirm
    CupertinoDialogAction(
      onPressed: onConfirm,
      isDefaultAction: confirmIsDefault,
      isDestructiveAction: confirmIsDestructive,
      child: Text(confirmMsg ?? EFUILang.of(context)!.gYes),
    ),

    // Deny
    CupertinoDialogAction(
      onPressed: onDeny,
      isDefaultAction: denyIsDefault,
      isDestructiveAction: denyIsDestructive,
      child: Text(denyMsg ?? EFUILang.of(context)!.gNo),
    ),
  ];
}
