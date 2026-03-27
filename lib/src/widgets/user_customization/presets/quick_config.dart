/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class TryTip extends StatelessWidget {
  final Widget child;

  const TryTip({super.key, required this.child});

  @override
  Widget build(BuildContext context) => Tooltip(
        message: EzConfig.l10n.ssTryMe,
        excludeFromSemantics: true,
        child: child,
      );
}

class EzQuickConfig extends StatelessWidget {
  /// [EzConfigProvider.rebuildUI] passthrough
  final void Function() onComplete;

  /// When true, just includes...
  /// [EzBigButtonsConfig], [EzHighVisibilityConfig], [EzChalkboardConfig]
  final bool simple;

  /// Opens a [BottomSheet] with [EzElevatedIconButton]s for different [EzConfig] presets
  const EzQuickConfig(this.onComplete, {super.key, this.simple = false});

  // Define custom functions //

  Widget wrapIt(Widget child) =>
      Padding(padding: EzInsets.wrap(EzConfig.spacing), child: child);

  Future<void> cleanRebuild() => EzConfig.rebuildUI(onComplete);

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return EzElevatedIconButton(
      onPressed: () => ezModal(
        context: context,
        builder: (_) =>
            EzScrollView(mainAxisSize: MainAxisSize.min, children: <Widget>[
          // Choices
          Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              // Important
              wrapIt(EzBigButtonsConfig(cleanRebuild)),
              wrapIt(EzHighVisibilityConfig(cleanRebuild)),
              wrapIt(EzChalkboardConfig(cleanRebuild)), // segue

              // Fun
              if (!simple) ...<Widget>[
                wrapIt(EzNebulaConfig(cleanRebuild)),
                // wrapIt(EzWallHolesConfig(cleanRebuild)),
              ],
            ],
          ),
          EzConfig.spacer,
        ]),
      ),
      icon: const Icon(Icons.edit),
      label: EzConfig.l10n.ssLoadPreset,
    );
  }
}
