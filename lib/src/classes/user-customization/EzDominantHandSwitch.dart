/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
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
  // Gather theme data //

  Hand currSide =
      (EzConfig.get(isRightHandKey) == false) ? Hand.left : Hand.right;

  final double _buttonSpacer = EzConfig.get(buttonSpacingKey);

  @override
  Widget build(BuildContext context) {
    // Define the list items //

    final TextStyle? style = Theme.of(context).dropdownMenuTheme.textStyle;

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

    // Return the build //

    // Define the build contents locally so it can be reversed in real-time alongside user selections
    List<Widget> _children = [
      // Label
      Text(
        EFUILang.of(context)!.lsDominantHand,
        style: style,
        textAlign: TextAlign.center,
      ),
      EzSpacer.row(_buttonSpacer),

      // Button
      Semantics(
        button: true,
        hint:
            "${EFUILang.of(context)!.lsHandSemantics} ${handName(context, currSide)}",
        child: ExcludeSemantics(
          child: DropdownButton<Hand>(
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
        ),
      ),
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          (currSide == Hand.right) ? _children : _children.reversed.toList(),
    );
  }
}
