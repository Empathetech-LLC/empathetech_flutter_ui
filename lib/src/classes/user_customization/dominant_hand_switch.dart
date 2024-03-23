/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Enumerator for tracking which (horizontal) side of the screen touch points should be on
enum Hand {
  right,
  left,
}

/// Get the proper [String] name for [Hand]
String handName(BuildContext context, Hand hand) {
  switch (hand) {
    case Hand.left:
      return EFUILang.of(context)!.gLeft;
    case Hand.right:
      return EFUILang.of(context)!.gRight;
  }
}

class EzDominantHandSwitch extends StatefulWidget {
  /// Standardized tool for updating [EzConfig] dominantHand
  const EzDominantHandSwitch({super.key});

  @override
  State<EzDominantHandSwitch> createState() => _HandSwitchState();
}

class _HandSwitchState extends State<EzDominantHandSwitch> {
  // Gather the theme data //
  late final ThemeData theme = Theme.of(context);

  final bool isLefty = EzConfig.get(isLeftyKey) ?? false;
  late Hand currSide = isLefty ? Hand.left : Hand.right;

  final double padding = EzConfig.get(paddingKey);

  late final EFUILang l10n = EFUILang.of(context)!;

  @override
  Widget build(BuildContext context) {
    // Define the build //

    final String label = l10n.ssDominantHand;

    final List<DropdownMenuEntry<Hand>> entries = <DropdownMenuEntry<Hand>>[
      DropdownMenuEntry<Hand>(
        value: Hand.right,
        label: handName(context, Hand.right),
      ),
      DropdownMenuEntry<Hand>(
        value: Hand.left,
        label: handName(context, Hand.left),
      ),
    ];

    // Define children separately to allow for live reversing
    final List<Widget> children = <Widget>[
      // Label
      Text(
        label,
        style: theme.dropdownMenuTheme.textStyle,
        textAlign: TextAlign.center,
      ),
      EzSpacer.row(padding),

      // Button
      DropdownMenu<Hand>(
        initialSelection: currSide,
        dropdownMenuEntries: entries,
        onSelected: (Hand? newDominantHand) {
          switch (newDominantHand) {
            case Hand.right:
              setState(() {
                currSide = Hand.right;
              });
              EzConfig.remove(isLeftyKey);
              break;

            case Hand.left:
              setState(() {
                currSide = Hand.left;
              });
              EzConfig.setBool(isLeftyKey, true);
              break;

            default:
              break;
          }
        },
      ),
    ];

    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            (currSide == Hand.right) ? children : children.reversed.toList(),
      ),
    );
  }
}
