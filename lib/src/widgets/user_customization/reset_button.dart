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

  /// What happens when the user choses to reset
  /// Defaults to [EzConfig.reset]
  /// DO NOT include an [EzConfig.rebuildUI] or [Navigator.pop], these are included automatically
  final Future<void> Function()? onConfirm;

  /// What happens when the user choses not to reset
  /// DO NOT include a [Navigator.pop], it is included automatically
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
    this.onConfirm,
    this.onDeny,
  });

  @override
  Widget build(BuildContext context) => EzElevatedIconButton(
        style: style ??
            ElevatedButton.styleFrom(
              backgroundColor: EzConfig.colors.surface
                  .withValues(alpha: max(EzConfig.buttonOpacity, focusOpacity)),
            ),
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext dContext) => EzAlertDialog(
            title: Text(
              dialogTitle ?? EzConfig.l10n.ssResetAll,
              textAlign: TextAlign.center,
            ),
            content: dialogContent ??
                ezRichUndoWarning(
                  context,
                  standalone: false,
                  appName: appName,
                  androidPackage: androidPackage,
                ),
            actions: ezActionPair(
              context: context,
              onConfirm: () async {
                if (onConfirm == null) {
                  await EzConfig.reset(
                    skip: resetSkip,
                    storageOnly: storageOnly,
                  );
                } else {
                  await onConfirm!.call();
                }
                justDraw
                    ? await EzConfig.redrawUI(onComplete)
                    : await EzConfig.rebuildUI(onComplete);
              },
              confirmIsDestructive: true,
              onDeny: () {
                if (onDeny == null) {
                  doNothing();
                } else {
                  onDeny!.call();
                }
                if (dContext.mounted) Navigator.of(dContext).pop();
              },
            ),
            needsClose: false,
          ),
        ),
        icon: const Icon(Icons.refresh),
        label: label ?? EzConfig.l10n.gResetAll,
      );
}
