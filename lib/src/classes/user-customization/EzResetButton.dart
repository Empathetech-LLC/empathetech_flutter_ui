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

  /// Functionality call-out for the user
  final String? message;

  /// [Semantics] message for screen readers
  final String? hint;

  /// [EzAlertDialog.title] that shows on click
  final String? dialogTitle;

  /// [EzAlertDialog.contents] that shows on click
  final String? dialogContents;

  /// What happens when the user choses to reset
  /// Defaults to clearing user [SharedPreferences]
  final void Function()? onConfirm;

  /// What happens when the user choses not to reset
  /// Defaults to [popScreen]
  final void Function()? onDeny;

  /// Standardized [TextButton] for clearing user settings (aka resetting the apps')
  /// Colors are reversed to stand out
  const EzResetButton({
    required this.context,
    this.message,
    this.hint,
    this.dialogTitle,
    this.dialogContents,
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

    // Return the build //

    return Semantics(
      button: true,
      hint: hint ?? EFUILang.of(context)!.resetButtonHint,
      child: ExcludeSemantics(
        child: TextButton.icon(
          icon: Icon(PlatformIcons(context).refresh),
          label: Text(message ?? EFUILang.of(context)!.resetAll),
          onPressed: () => showPlatformDialog(
            context: context,
            builder: (context) => EzAlertDialog(
              title: EzText(
                dialogTitle ?? EFUILang.of(context)!.resetButtonDialogTitle,
              ),
              content: EzText(
                dialogContents ??
                    EFUILang.of(context)!.resetButtonDialogContents,
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
        ),
      ),
    );
  }
}
