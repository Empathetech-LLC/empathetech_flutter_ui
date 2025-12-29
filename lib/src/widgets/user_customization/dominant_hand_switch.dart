/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzDominantHandSwitch extends StatefulWidget {
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

  @override
  State<EzDominantHandSwitch> createState() => _HandSwitchState();
}

class _HandSwitchState extends State<EzDominantHandSwitch> {
  // Define the build data //

  bool isLefty = EzConfig.isLefty;

  late final List<DropdownMenuEntry<bool>> entries = <DropdownMenuEntry<bool>>[
    DropdownMenuEntry<bool>(value: false, label: EzConfig.l10n.gRight),
    DropdownMenuEntry<bool>(value: true, label: EzConfig.l10n.gLeft),
  ];

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return EzScrollView(
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
        EzConfig.layout.margin,

        // Button
        EzDropdownMenu<bool>(
          widthEntries: entries
              .map((DropdownMenuEntry<bool> entry) => entry.label)
              .toList(),
          dropdownMenuEntries: entries,
          enableSearch: false,
          initialSelection: isLefty,
          onSelected: (bool? makeLeft) async {
            if (makeLeft == null || makeLeft == isLefty) return;

            await EzConfig.setBool(isLeftyKey, makeLeft);
            EzConfig.provider
                .redraw(onComplete: () => setState(() => isLefty = makeLeft));
          },
        ),
      ],
    );
  }
}
