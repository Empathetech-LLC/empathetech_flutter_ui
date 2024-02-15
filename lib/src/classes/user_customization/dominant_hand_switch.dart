/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzDominantHandSwitch extends StatefulWidget {
  /// Standardized tool for updating [EzConfig] dominantHand
  const EzDominantHandSwitch({super.key});

  @override
  State<EzDominantHandSwitch> createState() => _HandSwitchState();
}

class _HandSwitchState extends State<EzDominantHandSwitch> {
  // Gather the theme data //

  final bool isLefty = EzConfig.get(isLeftyKey) ?? false;
  late Hand currSide = isLefty ? Hand.left : Hand.right;

  final double padding = EzConfig.get(paddingKey);

  @override
  Widget build(BuildContext context) {
    // Define the build //

    final String label = EFUILang.of(context)!.ssDominantHand;

    final List<DropdownMenuItem<Hand>> items = <DropdownMenuItem<Hand>>[
      DropdownMenuItem<Hand>(
        value: Hand.right,
        child: Text(handName(context, Hand.right)),
      ),
      DropdownMenuItem<Hand>(
        value: Hand.left,
        child: Text(handName(context, Hand.left)),
      ),
    ];

    // Define children separately to allow for live reversing
    final List<Widget> children = <Widget>[
      // Label
      Text(
        label,
        style: Theme.of(context).dropdownMenuTheme.textStyle,
        textAlign: TextAlign.center,
        semanticsLabel: EFUILang.of(context)!.gSettingX(label),
      ),
      EzSpacer.row(padding),

      // Button
      DropdownButton<Hand>(
        value: currSide,
        items: items,
        onChanged: (Hand? newDominantHand) {
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
        color: Theme.of(context).colorScheme.background,
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
