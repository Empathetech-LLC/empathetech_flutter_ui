/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzDominantHandSwitch extends StatefulWidget {
  /// Defaults to [DropdownMenuThemeData.textStyle]
  final TextStyle? labelStyle;

  /// Defaults to [ColorScheme.surface]
  final Color? backgroundColor;

  /// Standardized tool for updating [EzConfig] dominantHand
  const EzDominantHandSwitch({
    super.key,
    this.labelStyle,
    this.backgroundColor,
  });

  @override
  State<EzDominantHandSwitch> createState() => _HandSwitchState();
}

class _HandSwitchState extends State<EzDominantHandSwitch> {
  // Gather the theme data //

  late final EFUILang l10n = EFUILang.of(context)!;

  final EzSpacer margin = EzSpacer(space: EzConfig.get(marginKey));

  bool isLefty = EzConfig.get(isLeftyKey) ?? false;

  // Define the build data //

  late final List<DropdownMenuEntry<bool>> entries = <DropdownMenuEntry<bool>>[
    DropdownMenuEntry<bool>(
      value: false,
      label: l10n.gRight,
      style: TextButton.styleFrom(padding: EzPadding.menu()),
    ),
    DropdownMenuEntry<bool>(
      value: true,
      label: l10n.gLeft,
      style: TextButton.styleFrom(padding: EzPadding.menu()),
    ),
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
        margin,
        EzTextBackground(
          Text(
            l10n.ssDominantHand,
            style: widget.labelStyle ?? Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          useSurface: false,
        ),
        margin,

        // Button
        DropdownMenu<bool>(
          enableSearch: false,
          initialSelection: isLefty,
          dropdownMenuEntries: entries,
          onSelected: (bool? makeLeft) async {
            if (makeLeft == true) {
              if (!isLefty) {
                await EzConfig.setBool(isLeftyKey, true);
                setState(() => isLefty = true);
              }
            } else {
              if (isLefty) {
                await EzConfig.setBool(isLeftyKey, false);
                setState(() => isLefty = false);
              }
            }
          },
        ),
      ],
    );
  }
}
