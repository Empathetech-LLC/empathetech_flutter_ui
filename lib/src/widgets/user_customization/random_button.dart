/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzConfigRandomizer extends StatelessWidget {
  /// Button label
  /// Defaults to [EFUILang.ssRandom]
  final String? label;

  /// [EzAlertDialog.title] that shows on click
  /// Defaults to [EFUILang.ssRandomize]
  final String? dialogTitle;

  /// [EzAlertDialog.content] that shows on click
  /// Defaults to [EFUILang.gUndoWarn]
  final String? dialogContent;

  /// What happens when the user choses to randomize
  /// Defaults to [EzConfig.randomize]
  /// DO NOT include a pop() for the dialog, this is included automatically
  final void Function()? onConfirm;

  /// What happens when the user choses not to reset
  /// DO NOT include a pop() for the dialog, this is included automatically
  final void Function()? onDeny;

  /// Standardized [EzElevatedIconButton] for randomizing EzConfig
  /// [EzConfigRandomizer] inherits [ElevatedButton] and [AlertDialog] styling from your [ThemeData]
  const EzConfigRandomizer({
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

    final String themeProfile = isDarkTheme(context)
        ? l10n.gDark.toLowerCase()
        : l10n.gLight.toLowerCase();

    // Define the button functions //

    final void Function() confirm =
        onConfirm ?? () => EzConfig.randomize(isDarkTheme(context));

    final void Function() deny = onDeny ?? doNothing;

    // Define the dialog //

    void randomizeDialog() {
      showPlatformDialog(
        context: context,
        builder: (BuildContext dialogContext) => EzAlertDialog(
          title: Text(
            dialogTitle ?? l10n.ssRandomize(themeProfile),
            textAlign: TextAlign.center,
          ),
          content: Text(
            dialogContent ?? l10n.gUndoWarn,
            textAlign: TextAlign.center,
          ),
          materialActions: ezMaterialActions(
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
          ),
          cupertinoActions: ezCupertinoActions(
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
            denyIsDefault: true,
          ),
          needsClose: false,
        ),
      );
    }

    // Return the build //

    return EzElevatedIconButton(
      onPressed: randomizeDialog,
      icon: const Icon(LineIcons.diceD6),
      label: label ?? l10n.ssRandom,
    );
  }
}
