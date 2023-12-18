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
  // Gather the theme data //

  final bool _isRighty = EzConfig.get(isRightHandKey) ?? true;
  late Hand currSide = _isRighty ? Hand.right : Hand.left;

  final double _padding = EzConfig.get(paddingKey);

  @override
  Widget build(BuildContext context) {
    // Define the list items //

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
        EFUILang.of(context)!.ssDominantHand,
        style: Theme.of(context).dropdownMenuTheme.textStyle,
        textAlign: TextAlign.center,
      ),
      EzSpacer.row(_padding),

      // Button
      Semantics(
        button: true,
        hint:
            "${EFUILang.of(context)!.ssHandSemantics} ${handName(context, currSide)}",
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

    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            (currSide == Hand.right) ? _children : _children.reversed.toList(),
      ),
    );
  }
}
