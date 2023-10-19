/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzResetButton extends StatelessWidget {
  final BuildContext context;

  /// Button label
  /// Defaults to [EFUILang.dResetAll]
  final String? label;

  /// [Semantics] message for screen readers
  /// Defaults to [dialogTitle]
  final String? hint;

  /// [EzAlertDialog.title] that shows on click
  /// Defaults to [EFUILang.dResetDialogTitle]
  final String? dialogTitle;

  /// [EzAlertDialog.content] that shows on click
  /// Defaults to [EFUILang.dResetDialogContent]
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
    required this.context,
    this.label,
    this.hint,
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
          EzConfig.instance.preferences.clear();
          popScreen(context: context, pass: true);
        };

    final void Function() _onDeny = onDeny ?? () => popScreen(context: context);

    // Define the build //
    final String _dialogTitle =
        dialogTitle ?? EFUILang.of(context)!.dResetDialogTitle;

    final OutlinedButton resetButton = OutlinedButton.icon(
      icon: Icon(PlatformIcons(context).refresh),
      label: Text(label ?? EFUILang.of(context)!.dResetAll),
      onPressed: () => showPlatformDialog(
        context: context,
        builder: (context) => EzAlertDialog(
          title: EzText(_dialogTitle),
          content: EzText(
            dialogContent ?? EFUILang.of(context)!.dResetDialogContent,
          ),
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
      ),
    );

    // Return the build //

    return Semantics(
      button: true,
      hint: hint ?? _dialogTitle,
      child: ExcludeSemantics(child: resetButton),
    );
  }
}
