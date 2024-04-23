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
  /// Defaults to [EFUILang.gResetWarn]
  final String? dialogContent;

  /// What happens when the user choses to reset
  /// Defaults to clearing user [SharedPreferences]
  /// DO NOT include a pop() for the dialog, this is included automatically
  final void Function()? onConfirm;

  /// What happens when the user choses not to reset
  /// DO NOT include a pop() for the dialog, this is included automatically
  final void Function()? onDeny;

  /// Standardized [OutlinedButton] for clearing user settings (aka resetting the apps')
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
    // Define the button functions //
    final void Function() confirm =
        onConfirm ?? () => EzConfig.removeKeys(allKeys.keys.toSet());

    final void Function() deny = onDeny ?? () {};

    // Define the dialog //

    void resetDialog() {
      showPlatformDialog(
        context: context,
        builder: (BuildContext dialogContext) => EzAlertDialog(
          title: Text(
            dialogTitle ?? EFUILang.of(context)!.ssResetAll,
            textAlign: TextAlign.center,
          ),
          contents: <Widget>[
            Text(
              dialogContent ?? EFUILang.of(context)!.gResetWarn,
              textAlign: TextAlign.center,
            ),
          ],
          materialActions: ezMaterialActions(
            context: context,
            onConfirm: () {
              confirm();
              Navigator.of(dialogContext).pop();
            },
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
            onDeny: () {
              deny();
              Navigator.of(dialogContext).pop();
            },
            confirmIsDestructive: true,
            denyIsDefault: true,
          ),
          needsClose: false,
        ),
      );
    }

    // Return the build //

    return OutlinedButton.icon(
      icon: Icon(PlatformIcons(context).refresh),
      label: Text(label ?? EFUILang.of(context)!.gResetAll),
      onPressed: resetDialog,
    );
  }
}
