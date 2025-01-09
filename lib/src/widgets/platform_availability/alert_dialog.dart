/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzAlertDialog extends PlatformAlertDialog {
  /// Dialog content becomes [contents] in an [EzScrollView]
  final List<Widget>? contents;

  /// [AlertDialog.actions]s to be displayed below the [contents]
  /// Pairs best with [ezActionPairs]
  final List<Widget>? materialActions;

  /// [CupertinoAlertDialogData.actions]s to be displayed below the [contents]
  /// Pairs best with [ezActionPairs]
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

          late final List<Widget>? actions = needsClose
              ? <Widget>[
                  if (materialActions != null) ...materialActions!,
                  closeAction
                ]
              : materialActions;

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
            actions: isLefty ? actions?.reversed.toList() : actions,
            actionsAlignment:
                isLefty ? MainAxisAlignment.start : MainAxisAlignment.end,

            // General
            actionsPadding: EdgeInsets.only(
              right: isLefty ? 0 : spacing,
              left: isLefty ? spacing : 0,
              top: spacing / 2,
              bottom: spacing,
            ),
            buttonPadding: EdgeInsets.only(
              right: isLefty ? 0 : spacing,
              left: isLefty ? spacing : 0,
            ),
            iconPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.all(margin),
          );
        },
        cupertino: (BuildContext dialogContext, _) {
          late final Widget closeAction = EzCupertinoAction(
            onPressed: () => Navigator.of(dialogContext).pop(),
            text: EFUILang.of(context)!.gClose,
          );

          late final List<Widget>? actions = needsClose
              ? <Widget>[
                  if (cupertinoActions != null) ...cupertinoActions!,
                  closeAction
                ]
              : cupertinoActions;

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
            actions: isLefty ? actions?.reversed.toList() : actions,
          );
        },
      ),
    );
  }
}

class EzMaterialAction extends StatelessWidget {
  /// [TextButton.child] will be [Text] with [text]
  final String text;

  /// [TextButton.onPressed] passthrough
  final void Function() onPressed;

  /// Will bold [style]
  final bool isDefaultAction;

  /// will add [ColorScheme.error] to [style]
  final bool isDestructiveAction;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? style;

  /// [EzTextButton] wrapper
  const EzMaterialAction({
    super.key,
    required this.text,
    required this.onPressed,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle? baseStyle = style ?? Theme.of(context).textTheme.bodyLarge;

    final TextStyle? textStyle = isDefaultAction
        ? baseStyle?.copyWith(fontWeight: FontWeight.bold)
        : isDestructiveAction
            ? baseStyle?.copyWith(color: Theme.of(context).colorScheme.error)
            : baseStyle;

    return EzTextButton(
      onPressed: onPressed,
      text: text,
      textStyle: textStyle,
    );
  }
}

class EzCupertinoAction extends StatelessWidget {
  /// [CupertinoDialogAction.child] will be [Text] with [text]
  final String text;

  /// [CupertinoDialogAction.onPressed] passthrough
  final void Function() onPressed;

  /// Will bold [style]
  final bool isDefaultAction;

  /// will add [ColorScheme.error] to [style]
  final bool isDestructiveAction;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? style;

  /// [CupertinoDialogAction] wrapper with custom styling
  /// Uses proper [MouseCursor]
  const EzCupertinoAction({
    super.key,
    required this.text,
    required this.onPressed,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle? baseStyle = style ?? Theme.of(context).textTheme.bodyLarge;

    final TextStyle? textStyle = isDefaultAction
        ? baseStyle?.copyWith(fontWeight: FontWeight.bold)
        : isDestructiveAction
            ? baseStyle?.copyWith(color: Theme.of(context).colorScheme.error)
            : baseStyle;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: EzTextButton(
        style: TextButton.styleFrom(shape: const LinearBorder()),
        onPressed: onPressed,
        text: text,
        textStyle: textStyle,
        underline: false,
      ),
    );
  }
}

/// Pairs with [EzAlertDialog]
/// Use when you want a variation of yes/no
/// Returns [EzAlertDialog.materialActions], [EzAlertDialog.cupertinoActions]
(List<EzMaterialAction>, List<EzCupertinoAction>) ezActionPairs({
  required BuildContext context,
  String? confirmMsg,
  required void Function() onConfirm,
  bool confirmIsDefault = false,
  bool confirmIsDestructive = false,
  String? denyMsg,
  required void Function() onDeny,
  bool denyIsDefault = false,
  bool denyIsDestructive = false,
  TextStyle? style,
}) {
  final List<EzMaterialAction> materialActions = <EzMaterialAction>[
    EzMaterialAction(
      text: denyMsg ?? EFUILang.of(context)!.gNo,
      onPressed: onDeny,
      isDefaultAction: denyIsDefault,
      isDestructiveAction: denyIsDestructive,
      style: style,
    ),
    EzMaterialAction(
      text: confirmMsg ?? EFUILang.of(context)!.gYes,
      onPressed: onConfirm,
      isDefaultAction: confirmIsDefault,
      isDestructiveAction: confirmIsDestructive,
      style: style,
    ),
  ];
  final List<EzCupertinoAction> cupertinoActions = <EzCupertinoAction>[
    EzCupertinoAction(
      text: denyMsg ?? EFUILang.of(context)!.gNo,
      onPressed: onDeny,
      isDefaultAction: denyIsDefault,
      isDestructiveAction: denyIsDestructive,
      style: style,
    ),
    EzCupertinoAction(
      text: confirmMsg ?? EFUILang.of(context)!.gYes,
      onPressed: onConfirm,
      isDefaultAction: confirmIsDefault,
      isDestructiveAction: confirmIsDestructive,
      style: style,
    ),
  ];

  return (materialActions, cupertinoActions);
}
