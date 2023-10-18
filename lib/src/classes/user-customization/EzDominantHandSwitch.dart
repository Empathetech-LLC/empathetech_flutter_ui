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
  Hand currSide = EzConfig.instance.dominantHand;
  late final TextStyle? _style = Theme.of(context).dropdownMenuTheme.textStyle;

  @override
  Widget build(BuildContext context) {
    // Define the list items //

    final List<DropdownMenuItem<Hand>> items = [
      DropdownMenuItem<Hand>(
        child: Text(EFUILang.of(context)!.gRight),
        value: Hand.right,
      ),
      DropdownMenuItem<Hand>(
        child: Text(EFUILang.of(context)!.gLeft),
        value: Hand.left,
      ),
    ];

    // Return the build //

    // Define the build contents locally so it can be reversed in real-time alongside user selections
    List<Widget> _children = [
      // Label
      EzText(
        EFUILang.of(context)!.hsDominantHand,
        style: _style,
      ),
      EzSpacer.row(EzConfig.instance.prefs[buttonSpacingKey]),

      // Button
      Semantics(
        hint: EFUILang.of(context)!.hsHandSemantics,
        child: DropdownButton<Hand>(
          value: currSide,
          items: items,
          dropdownColor: Theme.of(context).scaffoldBackgroundColor,
          onChanged: (Hand? newDominantHand) {
            switch (newDominantHand) {
              case Hand.right:
                EzConfig.instance.preferences.remove(isRightKey);
                setState(() {
                  currSide = Hand.right;
                });
                break;

              case Hand.left:
                EzConfig.instance.preferences.setBool(isRightKey, false);
                setState(() {
                  currSide = Hand.left;
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
      children:
          (currSide == Hand.right) ? _children : _children.reversed.toList(),
    );
  }
}
