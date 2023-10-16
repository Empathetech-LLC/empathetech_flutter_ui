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
    setPageTitle(context, Phrases.of(context)!.styleSettings);
  }

  // Gather theme data //

  final double _buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];

  late final String _resetTitle = Phrases.of(context)!.resetAllStyle;
  late final String _resetMessage = kIsWeb
      ? Phrases.of(context)!.resetAllWarningWeb
      : Phrases.of(context)!.resetAllWarning;

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
            EzSliderSetting(
              prefsKey: marginKey,
              type: SliderSettingType.margin,
              title: EFUIPhrases.of(context)!.margin,
              min: 5.0,
              max: 50.0,
              steps: 18,
              decimals: 1,
            ),
            EzSpacer(_buttonSpacer),

            // Padding
            EzSliderSetting(
              prefsKey: paddingKey,
              type: SliderSettingType.padding,
              title: EFUIPhrases.of(context)!.padding,
              min: 0.0,
              max: 50.0,
              steps: 20,
              decimals: 1,
            ),
            EzSpacer(_buttonSpacer),

            // Circle button size
            EzSliderSetting(
              prefsKey: circleDiameterKey,
              type: SliderSettingType.circleSize,
              title: EFUIPhrases.of(context)!.circleSize,
              min: 30,
              max: 100,
              steps: 14,
              decimals: 0,
            ),
            EzSpacer(_buttonSpacer),

            // Button spacing
            EzSliderSetting(
              prefsKey: buttonSpacingKey,
              type: SliderSettingType.buttonSpacing,
              title: EFUIPhrases.of(context)!.buttonSpacing,
              min: 10.0,
              max: 100.0,
              steps: 18,
              decimals: 0,
            ),
            EzSpacer(_buttonSpacer),

            // Text spacing
            EzSliderSetting(
              prefsKey: textSpacingKey,
              type: SliderSettingType.textSpacing,
              title: EFUIPhrases.of(context)!.textSpacing,
              min: 10.0,
              max: 100.0,
              steps: 18,
              decimals: 0,
            ),
            EzSpacer(_buttonSpacer),

            // Local reset "all"
            EzResetButton(
              context: context,
              hint: _resetTitle,
              dialogTitle: _resetTitle,
              dialogContents: _resetMessage,
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
            EzSpacer(_buttonSpacer),
          ],
        ),
      ),
    );
  }
}
