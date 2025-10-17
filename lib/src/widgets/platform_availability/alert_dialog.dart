/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
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
  const EzAlertDialog({
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
    // Gather the fixed theme data //

    final double margin = EzConfig.get(marginKey);
    final double spacing = EzConfig.get(spacingKey);

    final bool isLefty = EzConfig.get(isLeftyKey);

    // Define custom functions //

    List<Widget>? buildMActions(List<Widget>? actions) {
      if (actions == null) return null;

      return actions.length <= 2
          ? isLefty
              ? actions.reversed.toList()
              : actions
          : <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: actions,
              )
            ];
    }

    // Return the build //

    final Widget? dialogContent = content ??
        ((contents == null) ? null : EzScrollView(children: contents!));

    return SelectionArea(
      child: PlatformAlertDialog(
        material: (BuildContext dialogContext, _) {
          late final Widget closeAction = EzTextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            text: ezL10n(context).gClose,
          );

          late final List<Widget>? mActions = needsClose
              ? (materialActions?.length ?? 0) > 1
                  ? <Widget>[...materialActions!, closeAction]
                  : <Widget>[
                      closeAction,
                      if (materialActions != null) ...materialActions!,
                    ]
              : materialActions;

          return MaterialAlertDialogData(
            // Title
            title: title,
            titlePadding: title == null
                ? null
                : EdgeInsets.symmetric(
                    horizontal: margin,
                    vertical: spacing / 2,
                  ),

            // Content
            content: dialogContent,
            contentPadding: dialogContent == null
                ? null
                : EdgeInsets.symmetric(
                    horizontal: margin,
                    vertical: spacing / 2,
                  ),

            // Actions
            actions: buildMActions(mActions),
            actionsAlignment: (mActions != null && mActions.length > 2)
                ? MainAxisAlignment.center
                : isLefty
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,

            // General
            iconPadding: EdgeInsets.zero,
            buttonPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.all(margin),
            actionsPadding: EzInsets.wrap(spacing),
          );
        },
        cupertino: (BuildContext dialogContext, _) {
          late final Widget closeAction = EzCupertinoAction(
            onPressed: () => Navigator.of(dialogContext).pop(),
            text: ezL10n(context).gClose,
          );

          late final List<Widget>? cActions = needsClose
              ? <Widget>[
                  if (cupertinoActions != null) ...cupertinoActions!,
                  closeAction
                ]
              : cupertinoActions;

          return CupertinoAlertDialogData(
            // Title
            title: title == null
                ? null
                : Padding(
                    padding: dialogContent == null
                        ? EdgeInsets.zero
                        : EdgeInsets.only(bottom: spacing / 2),
                    child: title,
                  ),

            // Content
            content: dialogContent == null
                ? null
                : Padding(
                    padding: title == null
                        ? EdgeInsets.zero
                        : EdgeInsets.symmetric(vertical: spacing / 2),
                    child: dialogContent,
                  ),

            // Actions
            actions: (cActions != null && cActions.length <= 2 && isLefty)
                ? cActions.reversed.toList()
                : cActions,
          );
        },
      ),
    );
  }
}

class EzMaterialAction extends StatelessWidget {
  /// [EzTextButton.text] passthrough
  final String text;

  /// [EzTextButton.onPressed] passthrough
  final void Function() onPressed;

  /// Will add [FontWeight.bold] to [style]
  final bool isDefaultAction;

  /// Will add [ColorScheme.error] to [style]
  final bool isDestructiveAction;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? style;

  /// [EzTextButton] wrapper with custom styling for an [AlertDialog]
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
      style: TextButton.styleFrom(backgroundColor: Colors.transparent),
      text: text,
      textStyle: textStyle,
    );
  }
}

class EzCupertinoAction extends StatelessWidget {
  /// [EzTextButton.text] passthrough
  final String text;

  /// [EzTextButton.onPressed] passthrough
  final void Function() onPressed;

  /// Will add [FontWeight.bold] to [style]
  final bool isDefaultAction;

  /// Will add [ColorScheme.error] to [style]
  final bool isDestructiveAction;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? style;

  /// [EzTextButton] wrapper with custom styling for a [CupertinoAlertDialog]
  /// Includes a [MouseCursor] layer for macOS
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
        style: TextButton.styleFrom(
          shape: const LinearBorder(),
          backgroundColor: Colors.transparent,
        ),
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
      text: denyMsg ?? ezL10n(context).gNo,
      onPressed: onDeny,
      isDefaultAction: denyIsDefault,
      isDestructiveAction: denyIsDestructive,
      style: style,
    ),
    EzMaterialAction(
      text: confirmMsg ?? ezL10n(context).gYes,
      onPressed: onConfirm,
      isDefaultAction: confirmIsDefault,
      isDestructiveAction: confirmIsDestructive,
      style: style,
    ),
  ];
  final List<EzCupertinoAction> cupertinoActions = <EzCupertinoAction>[
    EzCupertinoAction(
      text: denyMsg ?? ezL10n(context).gNo,
      onPressed: onDeny,
      isDefaultAction: denyIsDefault,
      isDestructiveAction: denyIsDestructive,
      style: style,
    ),
    EzCupertinoAction(
      text: confirmMsg ?? ezL10n(context).gYes,
      onPressed: onConfirm,
      isDefaultAction: confirmIsDefault,
      isDestructiveAction: confirmIsDestructive,
      style: style,
    ),
  ];

  return (materialActions, cupertinoActions);
}
