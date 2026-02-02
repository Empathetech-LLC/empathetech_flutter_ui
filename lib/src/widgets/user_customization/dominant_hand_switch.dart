/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzDominantHandSwitch extends StatefulWidget {
  /// [EzConfig.redrawUI] passthrough
  final void Function() onComplete;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? labelStyle;

  /// Defaults to [ColorScheme.surface]
  final Color? backgroundColor;

  /// Standardized tool for updating [EzConfig]s [isLeftyKey]
  const EzDominantHandSwitch(
    this.onComplete, {
    super.key,
    this.labelStyle,
    this.backgroundColor,
  });

  @override
  State<EzDominantHandSwitch> createState() => _HandSwitchState();
}

class _HandSwitchState extends State<EzDominantHandSwitch> {
  // Define the build data //

  late final List<DropdownMenuEntry<bool>> entries = <DropdownMenuEntry<bool>>[
    DropdownMenuEntry<bool>(value: false, label: EzConfig.l10n.gRight),
    DropdownMenuEntry<bool>(value: true, label: EzConfig.l10n.gLeft),
  ];

  // Return the build //

  @override
  Widget build(BuildContext context) => EzScrollView(
        scrollDirection: Axis.horizontal,
        reverseHands: true,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Label
          EzText(
            EzConfig.l10n.ssDominantHand,
            style: widget.labelStyle,
            textAlign: TextAlign.center,
          ),
          EzConfig.margin,

          // Button
          EzDropdownMenu<bool>(
            widthEntries: entries
                .map((DropdownMenuEntry<bool> entry) => entry.label)
                .toList(),
            dropdownMenuEntries: entries,
            enableSearch: false,
            initialSelection: EzConfig.isLefty,
            onSelected: (bool? makeLeft) async {
              if (makeLeft == null || makeLeft == EzConfig.isLefty) return;
              await EzConfig.setBool(isLeftyKey, makeLeft);
              await EzConfig.redrawUI(widget.onComplete);
            },
          ),
        ],
      );
}
