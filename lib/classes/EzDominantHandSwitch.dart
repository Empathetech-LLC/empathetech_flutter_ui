library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzDominantHandSwitch extends StatefulWidget {
  /// Standardized tool for updating [EzConfig] dominantSide
  const EzDominantHandSwitch({Key? key}) : super(key: key);

  @override
  _HandSwitchState createState() => _HandSwitchState();
}

class _HandSwitchState extends State<EzDominantHandSwitch> {
  Hand _currSide = EzConfig.instance.dominantSide;

  late TextStyle? style = Theme.of(context).dropdownMenuTheme.textStyle;

  final double space = EzConfig.instance.prefs[buttonSpacingKey];

  @override
  Widget build(BuildContext context) {
    const List<DropdownMenuItem<Hand>> items = [
      DropdownMenuItem<Hand>(
        child: Text('Right'),
        value: Hand.right,
      ),
      DropdownMenuItem<Hand>(
        child: Text('Left'),
        value: Hand.left,
      ),
    ];

    List<Widget> _children = [
      // Label
      EzSelectableText('Dominant hand', style: style),
      EzSpacer.row(space),

      // Button
      DropdownButton<Hand>(
        value: _currSide,
        items: items,
        onChanged: (Hand? newDominantSide) {
          switch (newDominantSide) {
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
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          (_currSide == Hand.right) ? _children : _children.reversed.toList(),
    );
  }
}
