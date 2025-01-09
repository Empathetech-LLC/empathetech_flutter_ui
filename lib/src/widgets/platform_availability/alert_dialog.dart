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
  final List<Widget>? cupertinoActions;

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
          late final Widget closeAction = EzTextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            text: EFUILang.of(context)!.gClose,
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
List<Widget> ezMaterialActions({
  required BuildContext context,
  String? confirmMsg,
  required void Function() onConfirm,
  bool confirmIsDestructive = false,
  String? denyMsg,
  required void Function() onDeny,
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

  final List<Widget> actions = <Widget>[
    // Deny
    EzTextButton(
      onPressed: onDeny,
      text: denyMsg ?? EFUILang.of(context)!.gNo,
      textStyle: denyIsDestructive ? destructiveText : defaultText,
    ),

    // Confirm
    EzTextButton(
      onPressed: onConfirm,
      text: confirmMsg ?? EFUILang.of(context)!.gYes,
      textStyle: confirmIsDestructive ? destructiveText : defaultText,
    ),
  ];

  return isLefty ? actions.reversed.toList() : actions;
}

class EzCupertinoAction extends StatelessWidget {
  /// [CupertinoDialogAction.child] will be [Text] with [text]
  final String text;

  /// [CupertinoDialogAction.onPressed] passthrough
  final void Function() onPressed;

  /// Will use [defaultStyle]
  final bool isDefaultAction;

  /// Will use [destructiveStyle]
  final bool isDestructiveAction;

  /// Optional override defaults to [TextTheme.bodyLarge]
  final TextStyle? defaultStyle;

  /// Optional override defaults to [TextTheme.bodyLarge] with [ColorScheme.primary]
  final TextStyle? destructiveStyle;

  /// [CupertinoDialogAction] wrapper with custom styling
  /// Uses proper [MouseCursor]
  const EzCupertinoAction({
    super.key,
    required this.text,
    required this.onPressed,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    this.defaultStyle,
    this.destructiveStyle,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final TextStyle? defaultText = defaultStyle ?? theme.textTheme.bodyLarge;
    final TextStyle? destructiveText = destructiveStyle ??
        theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.primary);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: CupertinoDialogAction(
        onPressed: onPressed,
        isDefaultAction: isDefaultAction,
        isDestructiveAction: isDestructiveAction,
        textStyle: isDestructiveAction ? destructiveText : defaultText,
        child: Text(text),
      ),
    );
  }
}

/// Pairs with [EzAlertDialog]
/// Quickly creates [CupertinoDialogAction]s
/// All required parameters are identical to [ezMaterialActions]
List<Widget> ezCupertinoActions({
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

  final List<Widget> actions = <Widget>[
    // Deny
    EzCupertinoAction(
      onPressed: onDeny,
      isDefaultAction: denyIsDefault,
      isDestructiveAction: denyIsDestructive,
      defaultStyle: defaultStyle,
      destructiveStyle: destructiveStyle,
      text: denyMsg ?? EFUILang.of(context)!.gNo,
    ),

    // Confirm
    EzCupertinoAction(
      onPressed: onConfirm,
      isDefaultAction: confirmIsDefault,
      isDestructiveAction: confirmIsDestructive,
      defaultStyle: defaultStyle,
      destructiveStyle: destructiveStyle,
      text: confirmMsg ?? EFUILang.of(context)!.gYes,
    ),
  ];

  return isLefty ? actions.reversed.toList() : actions;
}
