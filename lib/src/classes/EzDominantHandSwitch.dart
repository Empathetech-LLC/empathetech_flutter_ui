/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  @override
  Widget build(BuildContext context) {
    // Define the list items //

    final List<DropdownMenuItem<Hand>> items = [
      DropdownMenuItem<Hand>(
        child: Semantics(
          hint: AppLocalizations.of(context)!.rightHandHint,
          child: ExcludeSemantics(child: Text(AppLocalizations.of(context)!.right)),
        ),
        value: Hand.right,
      ),
      DropdownMenuItem<Hand>(
        child: Semantics(
          hint: AppLocalizations.of(context)!.leftHandHint,
          child: ExcludeSemantics(child: Text(AppLocalizations.of(context)!.left)),
        ),
        value: Hand.left,
      ),
    ];

    // Return the build //

    // Define the build contents locally so it can be reversed in real-time alongside user selections
    List<Widget> _children = [
      // Label
      EzSelectableText(
        AppLocalizations.of(context)!.dominantHand,
        style: _style,
        semanticsLabel: AppLocalizations.of(context)!.handSettingLabelSemantics,
      ),
      EzSpacer.row(_buttonSpacer),

      // Button
      Semantics(
        hint: AppLocalizations.of(context)!.handSettingButtonSemantics,
        child: DropdownButton<Hand>(
          value: _currSide,
          items: items,
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
