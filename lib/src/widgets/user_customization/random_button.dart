/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzConfigRandomizer extends StatelessWidget {
  /// [EzElevatedIconButton.label] passthrough
  /// Defaults to [EFUILang.ssRandom]
  final String? label;

  /// [EzAlertDialog.title] that shows on click
  /// Defaults to [EFUILang.ssRandomize]
  final String? dialogTitle;

  /// Optional override for [EzAlertDialog.content] that shows on click
  /// Defaults to [ezRichUndoWarning]
  final Widget? dialogContent;

  /// [ezRichUndoWarning] passthrough
  final List<String>? extraKeys;

  /// [ezRichUndoWarning] passthrough
  final String? appName;

  /// [ezRichUndoWarning] passthrough
  final String? androidPackage;

  /// What happens when the user choses to randomize
  /// Defaults to [EzConfig.randomize]
  /// DO NOT include a pop() for the dialog, this is included automatically
  final void Function()? onConfirm;

  /// What happens when the user choses not to reset
  /// DO NOT include a pop() for the dialog, this is included automatically
  final void Function()? onDeny;

  /// [EzElevatedIconButton] for randomizing [EzConfig]
  const EzConfigRandomizer({
    super.key,
    this.label,
    this.dialogTitle,
    this.dialogContent,
    this.extraKeys,
    this.appName,
    this.androidPackage,
    this.onConfirm,
    this.onDeny,
  }) : assert((appName == null) != (dialogContent == null),
            'Must provide dialogContent or appName. androidPackage is optional, but only pairs/is useful with appName.');

  @override
  Widget build(BuildContext context) => EzElevatedIconButton(
        onPressed: () => showPlatformDialog(
            context: context,
            builder: (BuildContext dContext) {
              final void Function() confirm =
                  onConfirm ?? () => EzConfig.randomize();
              final void Function() deny = onDeny ?? doNothing;

              late final List<Widget> materialActions;
              late final List<Widget> cupertinoActions;

              (materialActions, cupertinoActions) = ezActionPairs(
                context: context,
                onConfirm: () {
                  confirm();
                  Navigator.of(dContext).pop();
                },
                confirmIsDestructive: true,
                onDeny: () {
                  deny();
                  Navigator.of(dContext).pop();
                },
              );

              return EzAlertDialog(
                title: Text(
                  dialogTitle ??
                      EzConfig.l10n.ssRandomize(EzConfig.isDark
                          ? EzConfig.l10n.gDark.toLowerCase()
                          : EzConfig.l10n.gLight.toLowerCase()),
                  textAlign: TextAlign.center,
                ),
                content: dialogContent ??
                    ezRichUndoWarning(
                      context,
                      extraKeys: extraKeys,
                      appName: appName!,
                      androidPackage: androidPackage,
                    ),
                materialActions: materialActions,
                cupertinoActions: cupertinoActions,
                needsClose: false,
              );
            }),
        icon: EzIcon(LineIcons.diceD6),
        label: label ?? EzConfig.l10n.ssRandom,
      );
}
