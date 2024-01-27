/* empathetech_flutter_ui
 * Copyright (c) 2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzDominantHandSwitch extends StatefulWidget {
  /// Standardized tool for updating [EzConfig] dominantHand
  const EzDominantHandSwitch({Key? key}) : super(key: key);

  @override
  _HandSwitchState createState() => _HandSwitchState();
}

class _HandSwitchState extends State<EzDominantHandSwitch> {
  // Gather the theme data //

  final bool _isRighty = EzConfig.get(isRightHandKey) ?? true;
  late Hand currSide = _isRighty ? Hand.right : Hand.left;

  final double padding = EzConfig.get(paddingKey);

  @override
  Widget build(BuildContext context) {
    // Define the build //

    final String label = EFUILang.of(context)!.ssDominantHand;

    final List<DropdownMenuItem<Hand>> items = [
      DropdownMenuItem<Hand>(
        child: Text(handName(context, Hand.right)),
        value: Hand.right,
      ),
      DropdownMenuItem<Hand>(
        child: Text(handName(context, Hand.left)),
        value: Hand.left,
      ),
    ];

    // Define children separately to allow for live reversing
    List<Widget> children = [
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
              EzConfig.setBool(isRightHandKey, true);
              break;

            case Hand.left:
              setState(() {
                currSide = Hand.left;
              });
              EzConfig.setBool(isRightHandKey, false);
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
        children: (currSide == Hand.right) ? children : children.reversed.toList(),
      ),
    );
  }
}
