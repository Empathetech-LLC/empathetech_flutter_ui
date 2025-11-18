/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzResetButton extends StatelessWidget {
  /// [EzElevatedIconButton.label] passthrough
  /// Defaults to [EFUILang.gResetAll]
  final String? label;

  /// [EzElevatedIconButton.style] passthrough
  final ButtonStyle? style;

  /// [EzConfig.reset] passthrough
  /// Moot if [onConfirm] is provided
  final Set<String>? skip;

  /// [EzAlertDialog.title] that shows on click
  /// Defaults to [EFUILang.ssResetAll]
  final String? dialogTitle;

  /// [EzAlertDialog.content] that shows on click
  /// Defaults to [EFUILang.gUndoWarn]
  final String? dialogContent;

  /// [EzConfig.reset] passthrough
  /// Moot if [onConfirm] is provided
  final bool storageOnly;

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
    this.label,
    this.style,
    this.skip,
    this.dialogTitle,
    this.dialogContent,
    this.storageOnly = false,
    this.onConfirm,
    this.onDeny,
  });

  @override
  Widget build(BuildContext context) {
    // Gather the fixed theme data //

    final EFUILang l10n = ezL10n(context);

    // Gather the dynamic theme data //

    late final bool isDark = isDarkTheme(context);
    late final bool useCrucial =
        (EzConfig.get(isDark ? darkButtonOpacityKey : lightButtonOpacityKey)
                as double) <
            0.50;
    late final Color crucialSurface =
        Theme.of(context).colorScheme.surface.withValues(alpha: 0.50);

    // Return the build //

    return EzElevatedIconButton(
      // EzResetButton can at most be 50% transparent
      // If a user accidentally borks their UI, they should be able to see the reset button
      style: (style == null)
          ? useCrucial
              ? ElevatedButton.styleFrom(backgroundColor: crucialSurface)
              : null
          : style,
      onPressed: () => showPlatformDialog(
          context: context,
          builder: (BuildContext dContext) {
            late final List<Widget> materialActions;
            late final List<Widget> cupertinoActions;

            final void Function() confirm = onConfirm ??
                () => EzConfig.reset(
                      skip: skip,
                      storageOnly: storageOnly,
                    );
            final void Function() deny = onDeny ?? doNothing;

            (materialActions, cupertinoActions) = ezActionPairs(
              context: context,
              onConfirm: () {
                confirm();
                Navigator.of(dContext).pop();
              },
              confirmIsDestructive: true,
              onDeny: () {
                deny();
                Navigator.of(dContext).pop();
              },
            );

            return EzAlertDialog(
              title: Text(
                dialogTitle ?? l10n.ssResetAll,
                textAlign: TextAlign.center,
              ),
              content: Text(
                dialogContent ?? l10n.gUndoWarn,
                textAlign: TextAlign.center,
              ),
              materialActions: materialActions,
              cupertinoActions: cupertinoActions,
              needsClose: false,
            );
          }),
      icon: EzIcon(PlatformIcons(context).refresh),
      label: label ?? l10n.gResetAll,
    );
  }
}
