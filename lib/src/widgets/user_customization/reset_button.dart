/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzResetButton extends StatelessWidget {
  /// [ezRichUndoWarning] passthrough
  final String? androidPackage;

  /// [ezRichUndoWarning] passthrough
  final String? appName;

  /// Optionally override [EzAlertDialog.content] that shows on click
  /// Defaults to [ezRichUndoWarning]
  final Widget? dialogContent;

  /// [EzAlertDialog.title] that shows on click
  /// Defaults to [EFUILang.ssResetAll]
  final String? dialogTitle;

  /// [ezRichUndoWarning] passthrough
  final List<String>? extraKeys;

  /// [EzElevatedIconButton.label] passthrough
  /// Defaults to [EFUILang.gResetAll]
  final String? label;

  /// Whether to notify [EzConfigProvider] of changes
  final bool notifyTheme;

  /// [EzConfigProvider.rebuild] passthrough
  final void Function()? onNotify;

  /// What happens when the user choses to reset
  /// Defaults to [EzConfig.reset]
  /// DO NOT include a pop() for the dialog, this is included automatically
  final void Function()? onConfirm;

  /// What happens when the user choses not to reset
  /// DO NOT include a pop() for the dialog, this is included automatically
  final void Function()? onDeny;

  /// [EzConfig.reset] passthrough
  /// Moot if [onConfirm] is provided
  final Set<String>? skip;

  /// [EzConfig.reset] passthrough
  /// Moot if [onConfirm] is provided
  final bool storageOnly;

  /// [EzElevatedIconButton.style] passthrough
  final ButtonStyle? style;

  /// [EzElevatedIconButton] for clearing user settings
  const EzResetButton({
    super.key,
    this.androidPackage,
    this.appName,
    this.dialogContent,
    this.dialogTitle,
    this.extraKeys,
    this.label,
    this.notifyTheme = true,
    this.onConfirm,
    this.onDeny,
    this.onNotify,
    this.skip,
    this.storageOnly = false,
    this.style,
  }) : assert((appName == null) != (dialogContent == null),
            'Must provide dialogContent or appName. androidPackage is optional, but only pairs/is useful with appName.');

  @override
  Widget build(BuildContext context) {
    // Gather the fixed theme data //

    // Gather the contextual theme data //

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
                      notifyTheme: notifyTheme,
                      onNotify: onNotify,
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
                dialogTitle ?? EzConfig.l10n.ssResetAll,
                textAlign: TextAlign.center,
              ),
              content: dialogContent ??
                  ezRichUndoWarning(
                    context,
                    extraKeys: extraKeys,
                    appName: appName!,
                    androidPackage: androidPackage,
                  ),
              materialActions: materialActions,
              cupertinoActions: cupertinoActions,
              needsClose: false,
            );
          }),
      icon: EzIcon(PlatformIcons(context).refresh),
      label: label ?? EzConfig.l10n.gResetAll,
    );
  }
}
