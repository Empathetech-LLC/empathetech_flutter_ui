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

  final double margin = EzConfig.get(marginKey);

  late final EzSpacer marginer = EzSpacer(space: margin);

  late final ButtonStyle menuButtonStyle = TextButton.styleFrom(
    padding: EzInsets.menu(width: margin, height: EzConfig.get(paddingKey)),
  );

  bool isLefty = EzConfig.get(isLeftyKey) ?? false;

  // Define the build data //

  late final List<DropdownMenuEntry<bool>> entries = <DropdownMenuEntry<bool>>[
    DropdownMenuEntry<bool>(
      value: false,
      label: l10n.gRight,
      style: menuButtonStyle,
    ),
    DropdownMenuEntry<bool>(
      value: true,
      label: l10n.gLeft,
      style: menuButtonStyle,
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
        marginer,
        EzTextBackground(
          Text(
            l10n.ssDominantHand,
            style: widget.labelStyle ?? Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          useSurface: false,
        ),
        marginer,

        // Button
        DropdownMenu<bool>(
          dropdownMenuEntries: entries,
          enableSearch: false,
          initialSelection: isLefty,
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
