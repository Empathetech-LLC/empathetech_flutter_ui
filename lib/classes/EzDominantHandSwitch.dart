library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzLeftySwitch extends StatefulWidget {
  /// Standardized tool for updating [EzConfig.dominantSide]
  EzLeftySwitch({Key? key}) : super(key: key);

  @override
  _LeftySwitchState createState() => _LeftySwitchState();
}

class _LeftySwitchState extends State<EzLeftySwitch> {
  late TextStyle? style = headlineMedium(context);

  List<DropdownMenuItem<Hand>> _handOptions() {
    return [
      DropdownMenuItem<Hand>(
        child: Text('Right'),
        value: Hand.right,
      ),
      DropdownMenuItem<Hand>(
        child: Text('Left'),
        value: Hand.left,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return EzScrollView(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      scrollDirection: Axis.horizontal,
      children: [
        // Label
        ezText('Dominant hand', style: style),
        Container(width: EzConfig.prefs[buttonSpacingKey]),

        // Button
        DropdownButton<Hand>(
          value: EzConfig.dominantSide,
          items: _handOptions(),
          onChanged: (Hand? newDominantSide) {
            if (newDominantSide == Hand.right) {
              EzConfig.dominantSide = Hand.right;
              EzConfig.preferences.remove(isRightKey);
            } else if (newDominantSide == Hand.left) {
              EzConfig.dominantSide = Hand.left;
              EzConfig.preferences.setBool(isRightKey, false);
            }
          },
        ),
      ],
    );
  }
}
