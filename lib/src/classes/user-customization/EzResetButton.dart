/* empathetech_flutter_ui
 * Copyright (c) 2024 Empathetech LLC. All rights reserved.
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
  final void Function()? onConfirm;

  /// What happens when the user choses not to reset
  /// Defaults to [popScreen]
  final void Function()? onDeny;

  /// Standardized [OutlinedButton] for clearing user settings (aka resetting the apps')
  /// Colors are reversed to stand out
  const EzResetButton({
    this.label,
    this.dialogTitle,
    this.dialogContent,
    this.onConfirm,
    this.onDeny,
  });

  @override
  Widget build(BuildContext context) {
    // Define the button functions //

    final void Function() _onConfirm = onConfirm ??
        () {
          EzConfig.removeKeys(allKeys.keys.toSet());
          popScreen(context: context, result: true);
        };

    final void Function() _onDeny = onDeny ?? () => popScreen(context: context);

    // Define the dialog //

    final String _dialogTitle = dialogTitle ?? EFUILang.of(context)!.ssResetAll;

    void resetDialog() {
      showPlatformDialog(
        context: context,
        builder: (context) => EzAlertDialog(
          title: Text(
            _dialogTitle,
            textAlign: TextAlign.center,
          ),
          contents: [
            Text(
              dialogContent ?? EFUILang.of(context)!.gResetWarn,
              textAlign: TextAlign.center,
            ),
          ],
          materialActions: ezMaterialActions(
            context: context,
            onConfirm: _onConfirm,
            onDeny: _onDeny,
          ),
          cupertinoActions: ezCupertinoActions(
            context: context,
            onConfirm: _onConfirm,
            onDeny: _onDeny,
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
