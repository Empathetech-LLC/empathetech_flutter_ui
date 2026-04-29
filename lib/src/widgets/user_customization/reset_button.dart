/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';

class EzResetButton extends StatelessWidget {
  /// Set to false for a 'Reset' [ElevatedButton.icon] label rather than 'Reset all'
  /// Also, when true there will be a local 'Reset all' switch
  /// When false, the current [EzConfig.updateBoth] value is used
  final bool all;

  /// [EzAlertDialog.title] that shows on click
  final String Function()? dynamicTitle;

  /// Optionally override [EzAlertDialog.content] that shows on click
  /// Defaults to [ezRichUndoWarning]
  final Widget? dialogContent;

  /// [EzConfig.reset] skip passthrough
  /// Moot if [onConfirm] is provided
  final Set<String>? resetSkip;

  /// [ezRichUndoWarning] passthrough
  final Set<String>? saveSkip;

  /// Override what happens when the user choses to reset
  /// Defaults to [EzConfig.reset]
  /// DO NOT include an [EzConfig.rebuildUI] or [Navigator.pop], these are included automatically
  final Future<void> Function()? onConfirm;

  /// Override what happens when the user choses not to reset
  /// DO NOT include a [Navigator.pop], it is included automatically
  final void Function()? onDeny;

  /// [EzElevatedIconButton] for clearing user settings
  const EzResetButton({
    super.key,
    this.all = true,
    this.saveSkip,
    this.dialogContent,
    this.dynamicTitle,
    this.resetSkip,
    this.onConfirm,
    this.onDeny,
  });

  @override
  Widget build(BuildContext context) => EzElevatedIconButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              EzConfig.colors.surface.withValues(alpha: max(EzConfig.buttonOpacity, focusOpacity)),
        ),
        onPressed: () => showDialog(
          context: context,
          builder: (_) {
            bool updateBoth = true;

            return StatefulBuilder(
              builder: (BuildContext dCon, StateSetter setDialog) => EzAlertDialog(
                title: Text(
                  dynamicTitle?.call() ?? EzConfig.l10n.ssResetAll,
                  textAlign: TextAlign.center,
                ),
                content: (dialogContent == null)
                    ? (all ? null : ezRichUndoWarning(context, standalone: false))
                    : dialogContent,
                contents: (dialogContent == null)
                    ? (all
                        ? <Widget>[
                            ezRichUndoWarning(context, standalone: false),
                            EzConfig.margin,
                            EzSwitchPair(
                              key: ValueKey<bool>(updateBoth),
                              text: EzConfig.l10n.ssResetBoth,
                              value: updateBoth,
                              onChanged: (bool? choice) {
                                if (choice == null) return;
                                setDialog(() => updateBoth = choice);
                              },
                            ),
                          ]
                        : null)
                    : null,
                actions: ezActionPair(
                  context: context,
                  onConfirm: () async {
                    if (onConfirm == null) {
                      await EzConfig.reset(
                        skip: resetSkip,
                        forceOne: !updateBoth,
                        forceBoth: updateBoth,
                      );
                    } else {
                      await onConfirm!.call();
                    }

                    await EzConfig.rebuildUI();
                  },
                  confirmIsDestructive: true,
                  onDeny: () {
                    if (onDeny == null) {
                      doNothing();
                    } else {
                      onDeny!.call();
                    }
                    if (dCon.mounted) Navigator.of(dCon).pop();
                  },
                ),
                needsClose: false,
              ),
            );
          },
        ),
        icon: const Icon(Icons.refresh),
        label: all ? EzConfig.l10n.gResetAll : EzConfig.l10n.gReset,
      );
}
