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
  /// When true, just includes...
  /// [EzBigButtonsConfig], [EzHighVisibilityConfig], [EzChalkboardConfig]
  final bool simple;

  /// Opens a [BottomSheet] with [EzElevatedIconButton]s for different [EzConfig] presets
  const EzQuickConfig({super.key, this.simple = false});

  Widget wrapIt(Widget child) => Padding(padding: EzInsets.wrap(EzConfig.spacing), child: child);

  @override
  Widget build(BuildContext context) => EzElevatedIconButton(
        onPressed: () => ezModal(
          context: context,
          builder: (_) => EzScrollView(children: <Widget>[
            // Choices
            EzWrap(children: <Widget>[
              // Important
              wrapIt(const EzBigButtonsConfig()),
              wrapIt(const EzHighVisibilityConfig()),
              wrapIt(const EzChalkboardConfig()), // segue

              // Fun
              if (!simple) ...<Widget>[
                wrapIt(const EzNebulaConfig()),
                wrapIt(const EzWallHolesConfig()),
              ],
            ]),
            EzConfig.spacer,
          ]),
        ),
        icon: const Icon(Icons.edit),
        label: EzConfig.l10n.ssLoadPreset,
      );
}
