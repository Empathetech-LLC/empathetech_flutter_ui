/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzResetButton extends StatelessWidget {
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

  /// [EzConfigProvider.rebuild] passthrough
  /// Moot if [onConfirm] is provided
  final void Function()? onNotify;

  /// What happens when the user choses to reset
  /// Defaults to [EzConfig.reset]
  /// DO NOT include a pop() for the dialog, this is included automatically
  final void Function()? onConfirm;

  /// What happens when the user choses not to reset
  /// DO NOT include a pop() for the dialog, this is included automatically
  final void Function()? onDeny;

  /// [EzElevatedIconButton] for clearing user settings
  const EzResetButton({
    super.key,
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
    this.onNotify,
    this.onConfirm,
    this.onDeny,
  });

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    late final bool useCrucial = (EzConfig.get(
                EzConfig.isDark ? darkButtonOpacityKey : lightButtonOpacityKey)
            as double) <
        0.50;
    late final Color crucialSurface =
        EzConfig.colors.surface.withValues(alpha: 0.50);

    // Return the build //

    return EzElevatedIconButton(
      // EzResetButton can at most be 50% transparent
      // If a user accidentally borks their UI, they should be able to see the reset button
      style: (style == null)
          ? useCrucial
              ? ElevatedButton.styleFrom(backgroundColor: crucialSurface)
              : null
          : style,
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
                  notifyTheme: notifyTheme,
                  onNotify: onNotify,
                );
              } else {
                onConfirm!.call();
              }
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
      ),
      icon: const Icon(Icons.refresh),
      label: label ?? EzConfig.l10n.gResetAll,
    );
  }
}
