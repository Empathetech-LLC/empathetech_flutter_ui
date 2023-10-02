/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzDominantHandSwitch extends StatefulWidget {
  /// Standardized tool for updating [EzConfig] dominantHand
  const EzDominantHandSwitch({Key? key}) : super(key: key);

  @override
  _HandSwitchState createState() => _HandSwitchState();
}

class _HandSwitchState extends State<EzDominantHandSwitch> {
  // Gather theme data //
  Hand _currSide = EzConfig.instance.dominantHand;

  final double _buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];
  late final TextStyle? _style = Theme.of(context).dropdownMenuTheme.textStyle;

  // Define the list items //

  final List<DropdownMenuItem<Hand>> _items = [
    DropdownMenuItem<Hand>(
      child: Semantics(
        hint: 'Touch points will favor the right side of the screen',
        child: ExcludeSemantics(child: const Text('Right')),
      ),
      value: Hand.right,
    ),
    DropdownMenuItem<Hand>(
      child: Semantics(
        hint: 'Touch points will favor the left side of the screen',
        child: ExcludeSemantics(child: const Text('Left')),
      ),
      value: Hand.left,
    ),
  ];

  // Return the build

  @override
  Widget build(BuildContext context) {
    // Define the build contents locally so it can be reversed in real-time alongside user selections
    List<Widget> _children = [
      // Label
      EzSelectableText(
        'Dominant hand',
        style: _style,
        semanticsLabel: 'Set your dominant hand',
      ),
      EzSpacer.row(_buttonSpacer),

      // Button
      Semantics(
        hint: 'Open to choose left or right. Currently set to:',
        child: DropdownButton<Hand>(
          value: _currSide,
          items: _items,
          dropdownColor: Theme.of(context).scaffoldBackgroundColor,
          onChanged: (Hand? newDominantHand) {
            switch (newDominantHand) {
              case Hand.right:
                EzConfig.instance.preferences.remove(isRightKey);
                setState(() {
                  _currSide = Hand.right;
                });
                break;

              case Hand.left:
                EzConfig.instance.preferences.setBool(isRightKey, false);
                setState(() {
                  _currSide = Hand.left;
                });
                break;

              default:
                break;
            }
          },
        ),
      ),
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: (_currSide == Hand.right) ? _children : _children.reversed.toList(),
    );
  }
}
