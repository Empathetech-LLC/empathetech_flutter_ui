/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';

class EzResetButton extends StatelessWidget {
  /// [EzConfig.rebuildUI]/[EzConfig.redrawUI] passthrough
  final void Function() onComplete;

  /// When true, [EzConfig.redrawUI] will be called instead of [EzConfig.rebuildUI]
  final bool justDraw;

  /// [EzElevatedIconButton.style] passthrough
  final ButtonStyle? style;

  /// [EzElevatedIconButton.label] passthrough
  /// Defaults to [EFUILang.gResetAll]
  final String? label;

  /// [ezRichUndoWarning] passthrough
  final String appName;

  /// [ezRichUndoWarning] passthrough
  final String? androidPackage;

  /// [ezRichUndoWarning] passthrough
  final Set<String>? saveSkip;

  /// Optionally override [EzAlertDialog.content] that shows on click
  /// Defaults to [ezRichUndoWarning]
  final Widget? dialogContent;

  /// [EzAlertDialog.title] that shows on click
  /// Defaults to [EFUILang.ssResetAll]
  final String? dialogTitle;

  /// [EzConfig.reset] skip passthrough
  /// Moot if [onConfirm] is provided
  final Set<String>? resetSkip;

  /// [EzConfig.reset] passthrough
  /// Moot if [onConfirm] is provided
  final bool storageOnly;

  /// Whether to notify [EzConfigProvider] of changes
  /// Moot if [onConfirm] is provided
  final bool notifyTheme;

  /// What happens when the user choses to reset
  /// Defaults to [EzConfig.reset]
  /// DO NOT include a pop() for the dialog, this is included automatically
  final void Function()? onConfirm;

  /// What happens when the user choses not to reset
  /// DO NOT include a pop() for the dialog, this is included automatically
  final void Function()? onDeny;

  /// [EzElevatedIconButton] for clearing user settings
  const EzResetButton(
    this.onComplete, {
    super.key,
    this.justDraw = false,
    this.style,
    this.label,
    required this.appName,
    this.androidPackage,
    this.saveSkip,
    this.dialogContent,
    this.dialogTitle,
    this.resetSkip,
    this.storageOnly = false,
    this.notifyTheme = true,
    this.onConfirm,
    this.onDeny,
  });

  @override
  Widget build(BuildContext context) => EzElevatedIconButton(
        style: style ??
            ElevatedButton.styleFrom(
              backgroundColor: EzConfig.colors.surface.withValues(
                  alpha: max(
                      EzConfig.get(EzConfig.isDark
                          ? darkButtonOpacityKey
                          : lightButtonOpacityKey),
                      focusOpacity)),
            ),
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext dContext) {
            bool resetBoth = true;

            return StatefulBuilder(
              builder: (_, StateSetter setDialog) => EzAlertDialog(
                title: Text(
                  dialogTitle ?? EzConfig.l10n.ssResetAll,
                  textAlign: TextAlign.center,
                ),
                content: dialogContent,
                contents: (dialogContent == null)
                    ? <Widget>[
                        // Reset both themes option
                        EzSwitchPair(
                          key: ValueKey<bool>(resetBoth),
                          text: EzConfig.l10n.ssUpdateBoth,
                          value: resetBoth,
                          onChanged: (bool? choice) {
                            if (choice == null) return;
                            setDialog(() => resetBoth = choice);
                          },
                        ),
                        EzConfig.spacer,

                        // Undo warning/save option
                        ezRichUndoWarning(
                          context,
                          standalone: false,
                          appName: appName,
                          androidPackage: androidPackage,
                        )
                      ]
                    : null,
                actions: ezActionPair(
                  context: context,
                  onConfirm: () async {
                    if (onConfirm == null) {
                      await EzConfig.reset(
                        resetBoth,
                        skip: resetSkip,
                        storageOnly: storageOnly,
                      );
                    } else {
                      onConfirm!.call();
                    }
                    justDraw
                        ? await EzConfig.redrawUI(onComplete)
                        : await EzConfig.rebuildUI(onComplete);
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
            );
          },
        ),
        icon: const Icon(Icons.refresh),
        label: label ?? EzConfig.l10n.gResetAll,
      );
}
