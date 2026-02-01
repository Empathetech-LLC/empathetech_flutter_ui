/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

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
  final String? appName;

  /// [ezRichUndoWarning] passthrough
  final String? androidPackage;

  /// [ezRichUndoWarning] passthrough
  final Set<String>? saveSkip;

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
    this.appName,
    this.androidPackage,
    this.saveSkip,
    this.onConfirm,
    this.onDeny,
  }) : assert((appName == null) != (dialogContent == null),
            'Must provide dialogContent or appName. androidPackage is optional, but only pairs/is useful with appName.');

  @override
  Widget build(BuildContext context) => EzElevatedIconButton(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext dContext) => EzAlertDialog(
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
                  appName: appName!,
                  androidPackage: androidPackage,
                  skip: saveSkip,
                ),
            actions: ezActionPair(
              context: context,
              onConfirm: () async {
                if (onConfirm == null) {
                  await EzConfig.randomize();
                } else {
                  onConfirm!.call();
                }
                if (dContext.mounted) Navigator.of(dContext).pop();
              },
              confirmIsDestructive: true,
              onDeny: () {
                if (onDeny == null) {
                  doNothing();
                } else {
                  onDeny!.call();
                }
                Navigator.of(dContext).pop();
              },
            ),
            needsClose: false,
          ),
        ),
        icon: const Icon(LineIcons.diceD6),
        label: label ?? EzConfig.l10n.ssRandom,
      );
}
