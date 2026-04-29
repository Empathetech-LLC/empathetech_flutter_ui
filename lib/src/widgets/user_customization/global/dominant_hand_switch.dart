/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzDominantHandSwitch extends StatelessWidget {
  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? labelStyle;

  /// Defaults to [ColorScheme.surface]
  final Color? backgroundColor;

  /// Standardized tool for updating [EzConfig]s [isLeftyKey]
  const EzDominantHandSwitch({
    super.key,
    this.labelStyle,
    this.backgroundColor,
  });

  // Return the build //

  @override
  Widget build(BuildContext context) => EzScrollView(
        scrollDirection: Axis.horizontal,
        reverseHands: true,
        children: <Widget>[
          // Label
          EzText(
            EzConfig.l10n.ssDominantHand,
            style: labelStyle,
            textAlign: TextAlign.center,
          ),
          EzConfig.margin,

          // Button
          EzDropdownMenu<bool>(
            widthEntry: EzConfig.l10n.gRight,
            dropdownMenuEntries: <DropdownMenuEntry<bool>>[
              DropdownMenuEntry<bool>(value: false, label: EzConfig.l10n.gRight),
              DropdownMenuEntry<bool>(value: true, label: EzConfig.l10n.gLeft),
            ],
            enableSearch: false,
            initialSelection: EzConfig.isLefty,
            onSelected: (bool? makeLeft) async {
              if (makeLeft == null || makeLeft == EzConfig.isLefty) return;
              await EzConfig.setBool(isLeftyKey, makeLeft);
              await EzConfig.redrawUI();
            },
          ),
        ],
      );
}
