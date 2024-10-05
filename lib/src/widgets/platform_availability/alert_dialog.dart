/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzAlertDialog extends PlatformAlertDialog {
  /// Optional [content] override
  /// Wraps [contents] in an [EzScrollView]
  final List<Widget>? contents;

  /// [AlertDialog.actions]s to be displayed below the [contents]
  /// Pairs best with [ezMaterialActions]
  final List<Widget>? materialActions;

  /// [CupertinoAlertDialogData.actions]s to be displayed below the [contents]
  /// Pairs best with [ezCupertinoActions]
  final List<CupertinoDialogAction>? cupertinoActions;

  /// Whether a "Close" action should be included
  final bool needsClose;

  /// [PlatformAlertDialog] wrapper with custom styling
  EzAlertDialog({
    super.key,
    super.widgetKey,
    super.title,
    super.content,
    this.contents,
    this.materialActions,
    this.cupertinoActions,
    this.needsClose = true,
  }) : assert(
          (content == null && contents == null) ||
              ((content == null) != (contents == null)),
          'Either content or contents should be provided, but not both.',
        );

  @override
  Widget build(BuildContext context) {
    // Gather theme data //

    final double margin = EzConfig.get(marginKey);
    final double padding = EzConfig.get(paddingKey);
    final double spacing = EzConfig.get(spacingKey);

    final bool isLefty = EzConfig.get(isLeftyKey) ?? false;

    // Return the build //

    final Widget? dialogContent = content ??
        ((contents == null) ? null : EzScrollView(children: contents!));

    return SelectionArea(
      child: PlatformAlertDialog(
        material: (BuildContext dialogContext, _) {
          late final TextButton closeAction = TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(EFUILang.of(context)!.gClose),
          );

          return MaterialAlertDialogData(
            // Title
            title: title,
            titlePadding: EdgeInsets.only(
              left: padding,
              right: padding,
              top: padding,
              bottom: spacing / 2,
            ),

            // Content
            content: dialogContent,
            contentPadding: EdgeInsets.symmetric(
              horizontal: margin,
              vertical: spacing / 2,
            ),

            // Actions
            actions: materialActions == null
                ? <Widget>[closeAction]
                : needsClose
                    ? <Widget>[...materialActions!, closeAction]
                    : materialActions,
            actionsAlignment:
                isLefty ? MainAxisAlignment.start : MainAxisAlignment.end,

            // General
            actionsPadding: EdgeInsets.only(
              right: spacing,
              top: spacing / 2,
              bottom: spacing,
            ),
            buttonPadding: EdgeInsets.only(right: spacing),
            iconPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.all(margin),
          );
        },
        cupertino: (BuildContext dialogContext, _) {
          late final CupertinoDialogAction closeAction = CupertinoDialogAction(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              EFUILang.of(context)!.gClose,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );

          return CupertinoAlertDialogData(
            title: Padding(
              padding: dialogContent == null
                  ? EdgeInsets.zero
                  : EdgeInsets.only(bottom: spacing / 2),
              child: title,
            ),
            content: dialogContent == null
                ? null
                : Padding(
                    padding: EdgeInsets.symmetric(vertical: spacing / 2),
                    child: dialogContent,
                  ),
            actions: cupertinoActions == null
                ? <Widget>[closeAction]
                : needsClose
                    ? <Widget>[...cupertinoActions!, closeAction]
                    : cupertinoActions,
          );
        },
      ),
    );
  }
}

/// Pairs with [EzAlertDialog]
/// Quickly creates Material 'action' buttons for the dialog
/// All required parameters are identical to [ezCupertinoActions]
List<TextButton> ezMaterialActions({
  required BuildContext context,
  String? confirmMsg,
  required void Function() onConfirm,
  bool confirmIsDestructive = false,
  String? denyMsg,
  required void Function() onDeny,
  bool denyIsDestructive = false,
  bool reverseHands = true,
}) {
  final bool isLefty = reverseHands && (EzConfig.get(isLeftyKey) ?? false);
  final Color primary = Theme.of(context).colorScheme.primary;

  final List<TextButton> actions = <TextButton>[
    // Deny
    TextButton(
      onPressed: onDeny,
      style: denyIsDestructive
          ? TextButton.styleFrom(foregroundColor: primary)
          : null,
      child: Text(denyMsg ?? EFUILang.of(context)!.gNo),
    ),

    // Confirm
    TextButton(
      onPressed: onConfirm,
      style: confirmIsDestructive
          ? TextButton.styleFrom(foregroundColor: primary)
          : null,
      child: Text(confirmMsg ?? EFUILang.of(context)!.gYes),
    ),
  ];

  return isLefty ? actions.reversed.toList() : actions;
}

/// Pairs with [EzAlertDialog]
/// Quickly creates [CupertinoDialogAction]s
/// All required parameters are identical to [ezMaterialActions]
List<CupertinoDialogAction> ezCupertinoActions({
  required BuildContext context,
  String? confirmMsg,
  required void Function() onConfirm,
  bool confirmIsDefault = false,
  bool confirmIsDestructive = false,
  String? denyMsg,
  required void Function() onDeny,
  bool denyIsDefault = false,
  bool denyIsDestructive = false,
  bool reverseHands = true,
  TextStyle? defaultStyle,
  TextStyle? destructiveStyle,
}) {
  final bool isLefty = reverseHands && (EzConfig.get(isLeftyKey) ?? false);

  late final ThemeData theme = Theme.of(context);

  final TextStyle? defaultText = defaultStyle ?? theme.textTheme.bodyLarge;

  final TextStyle? destructiveText = destructiveStyle ??
      theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.primary);

  final List<CupertinoDialogAction> actions = <CupertinoDialogAction>[
    // Deny
    CupertinoDialogAction(
      onPressed: onDeny,
      isDefaultAction: denyIsDefault,
      isDestructiveAction: denyIsDestructive,
      textStyle: denyIsDestructive ? destructiveText : defaultText,
      child: Text(denyMsg ?? EFUILang.of(context)!.gNo),
    ),

    // Confirm
    CupertinoDialogAction(
      onPressed: onConfirm,
      isDefaultAction: confirmIsDefault,
      isDestructiveAction: confirmIsDestructive,
      textStyle: confirmIsDestructive ? destructiveText : defaultText,
      child: Text(confirmMsg ?? EFUILang.of(context)!.gYes),
    ),
  ];

  return isLefty ? actions.reversed.toList() : actions;
}
