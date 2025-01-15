/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzResetButton extends StatelessWidget {
  /// Button label
  /// Defaults to [EFUILang.gResetAll]
  final String? label;

  /// [EzAlertDialog.title] that shows on click
  /// Defaults to [EFUILang.ssResetAll]
  final String? dialogTitle;

  /// [EzAlertDialog.content] that shows on click
  /// Defaults to [EFUILang.gUndoWarn]
  final String? dialogContent;

  /// What happens when the user choses to reset
  /// Defaults to clearing user [SharedPreferences]
  /// DO NOT include a pop() for the dialog, this is included automatically
  final void Function()? onConfirm;

  /// What happens when the user choses not to reset
  /// DO NOT include a pop() for the dialog, this is included automatically
  final void Function()? onDeny;

  /// Standardized [ElevatedButton] for clearing user settings (aka resetting the apps')
  /// Colors are reversed to stand out
  /// [EzResetButton] inherits [ElevatedButton] and [AlertDialog] styling from your [ThemeData]
  const EzResetButton({
    super.key,
    this.label,
    this.dialogTitle,
    this.dialogContent,
    this.onConfirm,
    this.onDeny,
  });

  @override
  Widget build(BuildContext context) {
    // Gather theme data //

    final EFUILang l10n = EFUILang.of(context)!;

    // Return the build //

    return EzElevatedIconButton(
      onPressed: () => showPlatformDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            late final List<Widget> materialActions;
            late final List<Widget> cupertinoActions;

            final void Function() confirm = onConfirm ?? () => EzConfig.reset();
            final void Function() deny = onDeny ?? doNothing;

            (materialActions, cupertinoActions) = ezActionPairs(
              context: context,
              onConfirm: () {
                confirm();
                Navigator.of(dialogContext).pop();
              },
              confirmIsDestructive: true,
              onDeny: () {
                deny();
                Navigator.of(dialogContext).pop();
              },
            );

            return EzAlertDialog(
              title: Text(
                dialogTitle ?? l10n.ssResetAll,
                textAlign: TextAlign.center,
              ),
              content: Text(
                dialogContent ?? l10n.gUndoWarn,
                textAlign: TextAlign.center,
              ),
              materialActions: materialActions,
              cupertinoActions: cupertinoActions,
              needsClose: false,
            );
          }),
      icon: EzIcon(PlatformIcons(context).refresh),
      label: label ?? l10n.gResetAll,
    );
  }
}
