import '../utils/utils.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class StyleSettingsScreen extends StatefulWidget {
  const StyleSettingsScreen({Key? key}) : super(key: key);

  @override
  _StyleSettingsScreenState createState() => _StyleSettingsScreenState();
}

class _StyleSettingsScreenState extends State<StyleSettingsScreen> {
  // Gather the theme data //

  late bool _isLight = !PlatformTheme.of(context)!.isDark;

  final double _margin = EzConfig.get(marginKey);
  final double _buttonSpacer = EzConfig.get(buttonSpacingKey);

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(context, EFUILang.of(context)!.stsPageTitle);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      body: EzScreen(
        decorationImageKey: _isLight ? lightPageImageKey : darkPageImageKey,
        child: EzScrollView(
          children: [
            // Font
            EzSpacer(_buttonSpacer > _margin ? _buttonSpacer - _margin : 0),
            const EzFontSetting(),
            EzSpacer(_buttonSpacer),

            // Margin
            EzSliderSetting(
              prefsKey: marginKey,
              type: SliderSettingType.margin,
              min: 0.0,
              max: 50.0,
              steps: 10,
              decimals: 1,
            ),
            EzSpacer(_buttonSpacer),

            // Padding
            EzSliderSetting(
              prefsKey: paddingKey,
              type: SliderSettingType.padding,
              min: 0.0,
              max: 50.0,
              steps: 10,
              decimals: 1,
            ),
            EzSpacer(_buttonSpacer),

            // Button spacing
            EzSliderSetting(
              prefsKey: buttonSpacingKey,
              type: SliderSettingType.buttonSpacing,
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
              min: 10.0,
              max: 100.0,
              steps: 18,
              decimals: 0,
            ),
            EzSpacer(_buttonSpacer),

            // Local reset all
            EzResetButton(
              context: context,
              dialogTitle: EFUILang.of(context)!.stsResetAll,
              onConfirm: () {
                EzConfig.removeKeys(styleKeys.keys.toSet());
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
