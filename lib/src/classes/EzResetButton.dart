/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzResetButton extends StatelessWidget {
  final BuildContext context;

  /// Functionality call-out for the user
  final String message;

  /// [Semantics] message for screen readers
  final String hint;

  /// [EzAlertDialog.title] that shows on click
  final String dialogTitle;

  /// [EzAlertDialog.contents] that shows on click
  final String dialogContents;

  /// What happens when the user choses to reset
  /// Defaults to clearing user [SharedPreferences]
  final void Function()? onConfirm;

  /// What happens when the user choses not to reset
  /// Defaults to [popScreen]
  final void Function()? onDeny;

  /// Standardized [ElevatedButton] for clearing user settings (aka resetting the apps')
  /// Colors are reversed to stand out
  const EzResetButton({
    required this.context,
    this.message = 'Reset all',
    this.hint = 'Reset all custom settings',
    this.dialogTitle = 'Reset all settings?',
    this.dialogContents = 'Cannot be undone',
    this.onConfirm,
    this.onDeny,
  });

  @override
  Widget build(BuildContext context) {
    // Gather theme data //

    final ElevatedButtonThemeData baseButtonTheme = Theme.of(context).elevatedButtonTheme;
    final TextStyle baseButtonTextStyle = baseButtonTheme.style!.textStyle!.resolve({})!;

    final ButtonStyle resetButtonTheme = baseButtonTheme.style!.copyWith(
      backgroundColor: MaterialStatePropertyAll(baseButtonTextStyle.color!),
      textStyle: MaterialStatePropertyAll(baseButtonTextStyle.copyWith(
        color: baseButtonTheme.style!.backgroundColor!.resolve({}),
      )),
    );

    // Define the button functions //

    final void Function() _onConfirm = (onConfirm == null)
        ? () {
            EzConfig.instance.preferences.clear();
            popScreen(context: context, pass: true);
          }
        : onConfirm!;

    final void Function() _onDeny = (onDeny == null) ? () => popScreen(context: context) : onDeny!;

    // Return the build //

    return Semantics(
      button: true,
      hint: hint,
      child: ExcludeSemantics(
        child: ElevatedButton.icon(
          icon: Icon(PlatformIcons(context).refresh),
          label: Text(message),
          style: resetButtonTheme,
          onPressed: () => showPlatformDialog(
            context: context,
            builder: (context) => EzAlertDialog(
              title: EzSelectableText(dialogTitle),
              contents: [EzSelectableText(dialogContents)],
              materialActions: ezMaterialActions(onConfirm: _onConfirm, onDeny: _onDeny),
              cupertinoActions: ezCupertinoActions(
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
