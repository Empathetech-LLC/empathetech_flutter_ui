/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzAlertDialog extends AlertDialog {
  /// Dialog content becomes [contents] in an [EzScrollView]
  final List<Widget>? contents;

  /// Whether a "Close" [Action] should be included
  final bool needsClose;

  /// [AlertDialog] wrapper with custom styling
  const EzAlertDialog({
    super.key,
    super.title,
    super.content,
    this.contents,
    super.actions,
    this.needsClose = true,
  }) : assert(
          (content == null && contents == null) ||
              ((content == null) != (contents == null)),
          'Either content or contents should be provided, but not both.',
        );

  @override
  Widget build(BuildContext context) {
    // Define the content //

    final Widget? dialogContent = content ??
        ((contents == null) ? null : EzScrollView(children: contents!));

    late final Widget closeAction = EzTextButton(
      onPressed: () => Navigator.of(context).pop(),
      text: EzConfig.l10n.gClose,
    );

    late final List<Widget>? closedActions = needsClose
        ? (actions?.length ?? 0) > 1
            ? <Widget>[...actions!, closeAction]
            : <Widget>[
                closeAction,
                if (actions != null) ...actions!,
              ]
        : actions;

    // Return the build //

    return SelectionArea(
      child: AlertDialog(
        // Title
        title: title,
        titlePadding: title == null
            ? null
            : EdgeInsets.symmetric(
                horizontal: EzConfig.marginVal,
                vertical: EzConfig.spacing / 2,
              ),

        // Content
        content: dialogContent,
        contentPadding: dialogContent == null
            ? null
            : EdgeInsets.symmetric(
                horizontal: EzConfig.marginVal,
                vertical: EzConfig.spacing / 2,
              ),

        // Actions
        actions: (closedActions == null)
            ? null
            : closedActions.length <= 2
                ? EzConfig.isLefty
                    ? closedActions.reversed.toList()
                    : closedActions
                : <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: closedActions,
                    ),
                  ],
        actionsAlignment: (closedActions != null && closedActions.length > 2)
            ? MainAxisAlignment.center
            : EzConfig.isLefty
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,

        // General
        iconPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.all(EzConfig.marginVal),
        actionsPadding: EzInsets.wrap(EzConfig.spacing),
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

/// Pairs with [EzAlertDialog]
List<EzMaterialAction> ezActionPair({
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
}) =>
    <EzMaterialAction>[
      EzMaterialAction(
        text: denyMsg ?? EzConfig.l10n.gNo,
        onPressed: onDeny,
        isDefaultAction: denyIsDefault,
        isDestructiveAction: denyIsDestructive,
        style: style,
      ),
      EzMaterialAction(
        text: confirmMsg ?? EzConfig.l10n.gYes,
        onPressed: onConfirm,
        isDefaultAction: confirmIsDefault,
        isDestructiveAction: confirmIsDestructive,
        style: style,
      ),
    ];
