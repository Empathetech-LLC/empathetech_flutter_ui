library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzLeftySwitch extends StatefulWidget {
  /// Standardized tool for updating [EzConfig.dominantSide]
  EzLeftySwitch({Key? key}) : super(key: key);

  @override
  _LeftySwitchState createState() => _LeftySwitchState();
}

class _LeftySwitchState extends State<EzLeftySwitch> {
  @override
  Widget build(BuildContext context) {
    double buttonSpacer = EzConfig.prefs[buttonSpacingKey];

    List<Widget> _buildButtons() {
      List<Widget> buttons = [];

      bool isRight = (EzConfig.dominantSide == Hand.right);
      String message = isRight ? 'Right handed' : 'Left handed';

      buttons.addAll([
        EzText(message),
        Container(width: buttonSpacer),
        PlatformSwitch(
          value: isRight,
          onChanged: (bool indeed) {
            EzConfig.preferences.setBool(isRightKey, indeed);

            setState(() {
              EzConfig.dominantSide = (indeed) ? Hand.right : Hand.left;
            });
          },
        )
      ]);

      return buttons;
    }

    return EzScrollView(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      scrollDirection: Axis.horizontal,
      reverseHands: true,
      children: _buildButtons(),
    );
  }
}
