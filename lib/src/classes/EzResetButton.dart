/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzResetButton extends StatelessWidget {
  final BuildContext context;

  /// Functionality call-out for the user
  final String message;

  /// [message] style
  /// Recommended to use something underlined
  final TextStyle? style;

  /// [Semantics] message for screen readers
  final String hint;

  /// [EzAlertDialog.title] that shows on click
  final String dialogTitle;

  /// [EzAlertDialog.contents] that shows on click
  final String dialogContents;

  /// Standardized clickable text "button" for clearing all user settings
  const EzResetButton({
    required this.context,
    this.message = 'Reset all',
    this.style,
    this.hint = 'Reset all custom settings',
    this.dialogTitle = 'Reset all settings?',
    this.dialogContents = 'Cannot be undone',
  });

  @override
  Widget build(BuildContext context) {
    final void Function() onConfirm = () {
      EzConfig.instance.preferences.clear();
      popScreen(context: context, pass: true);
    };

    final void Function() onDeny = () => popScreen(context: context);

    return Semantics(
      button: true,
      hint: hint,
      child: ExcludeSemantics(
        child: EzSelectableText(
          message,
          style: style,
          onTap: () => showPlatformDialog(
            context: context,
            builder: (context) => EzAlertDialog(
              title: EzSelectableText(dialogTitle),
              contents: [EzSelectableText(dialogContents)],
              materialActions: ezMaterialActions(onConfirm: onConfirm, onDeny: onDeny),
              cupertinoActions: ezCupertinoActions(
                onConfirm: onConfirm,
                onDeny: onDeny,
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
