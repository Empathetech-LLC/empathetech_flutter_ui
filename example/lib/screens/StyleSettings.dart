import '../utils/utils.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

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

  final double _textSpacer = EzConfig.instance.prefs[textSpacingKey];
  final double _buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];

  final String resetTitle = "Reset all style settings?";
  final String resetMessage = kIsWeb
      ? "Cannot be undone\nChanges take effect on page reload"
      : "Cannot be undone\nChanges take effect on app restart";

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      body: EzScreen(
        child: EzScrollView(
          children: [
            // Font
            const EzFontSetting(),
            EzSpacer(_buttonSpacer),

            // Margin
            const EzSliderSetting(
              prefsKey: marginKey,
              type: SliderSettingType.margin,
              title: 'Margin',
              min: 5.0,
              max: 50.0,
              steps: 18,
              decimals: 1,
            ),
            EzSpacer(_buttonSpacer),

            // Padding
            const EzSliderSetting(
              prefsKey: paddingKey,
              type: SliderSettingType.padding,
              title: 'Padding',
              min: 0.0,
              max: 50.0,
              steps: 20,
              decimals: 1,
            ),
            EzSpacer(_buttonSpacer),

            // Circle button size
            const EzSliderSetting(
              prefsKey: circleDiameterKey,
              type: SliderSettingType.circleSize,
              title: 'Circle button size',
              min: 30,
              max: 100,
              steps: 14,
              decimals: 0,
            ),
            EzSpacer(_buttonSpacer),

            // Button spacing
            const EzSliderSetting(
              prefsKey: buttonSpacingKey,
              type: SliderSettingType.buttonSpacing,
              title: 'Button spacing',
              min: 10.0,
              max: 100.0,
              steps: 18,
              decimals: 0,
            ),
            EzSpacer(_buttonSpacer),

            // Text spacing
            const EzSliderSetting(
              prefsKey: textSpacingKey,
              type: SliderSettingType.textSpacing,
              title: 'Text spacing',
              min: 10.0,
              max: 100.0,
              steps: 18,
              decimals: 0,
            ),
            EzSpacer(_buttonSpacer),

            // Local reset "all"
            EzResetButton(
              context: context,
              hint: resetMessage,
              dialogTitle: resetTitle,
              dialogContents: resetMessage,
              onConfirm: () {
                EzConfig.instance.preferences.remove(fontFamilyKey);
                EzConfig.instance.preferences.remove(marginKey);
                EzConfig.instance.preferences.remove(paddingKey);
                EzConfig.instance.preferences.remove(circleDiameterKey);
                EzConfig.instance.preferences.remove(buttonSpacingKey);
                EzConfig.instance.preferences.remove(textSpacingKey);

                popScreen(context: context, pass: true);
              },
            ),
            EzSpacer(_textSpacer),
          ],
        ),
      ),
    );
  }
}
