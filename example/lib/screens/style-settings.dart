import '../utils/utils.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class StyleSettingsScreen extends StatefulWidget {
  const StyleSettingsScreen({Key? key}) : super(key: key);

  @override
  _StyleSettingsScreenState createState() => _StyleSettingsScreenState();
}

class _StyleSettingsScreenState extends State<StyleSettingsScreen> {
  // Set page/tab title //

  @override
  void initState() {
    super.initState();
    setPageTitle(context: context, title: 'Style settings');
  }

  // Gather theme data //

  final double textSpacer = EzConfig.instance.prefs[textSpacingKey];
  final double buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];
  final double diameter = EzConfig.instance.prefs[circleDiameterKey];

  // Build page //

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      body: EzScreen(
        child: EzScrollView(
          children: [
            // Font
            const EzFontSetting(),
            EzSpacer(buttonSpacer),

            // Margin
            const EzSliderSetting(
              prefsKey: marginKey,
              type: SettingType.margin,
              title: 'Margin',
              min: 5.0,
              max: 50.0,
              steps: 18,
            ),
            EzSpacer(buttonSpacer),

            // Padding
            const EzSliderSetting(
              prefsKey: paddingKey,
              type: SettingType.padding,
              title: 'Padding',
              min: 0.0,
              max: 50.0,
              steps: 20,
            ),
            EzSpacer(buttonSpacer),

            // Circle button size
            const EzSliderSetting(
              prefsKey: circleDiameterKey,
              type: SettingType.circleSize,
              title: 'Circle button size',
              min: 30,
              max: 100,
              steps: 14,
            ),
            EzSpacer(buttonSpacer),

            // Button spacing
            const EzSliderSetting(
              prefsKey: buttonSpacingKey,
              type: SettingType.buttonSpacing,
              title: 'Button spacing',
              min: 10.0,
              max: 100.0,
              steps: 18,
            ),
            EzSpacer(buttonSpacer),

            // Text spacing
            const EzSliderSetting(
              prefsKey: textSpacingKey,
              type: SettingType.textSpacing,
              title: 'Text spacing',
              min: 10.0,
              max: 100.0,
              steps: 18,
            ),
            EzSpacer(buttonSpacer),
          ],
        ),
      ),
      fab: null,
    );
  }
}
