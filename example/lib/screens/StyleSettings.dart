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

  late bool isLight = !PlatformTheme.of(context)!.isDark;

  final double margin = EzConfig.get(marginKey);
  final double buttonSpace = EzConfig.get(buttonSpacingKey);

  late final EzSpacer _buttonSpacer = EzSpacer(buttonSpace);
  late final EzSpacer _buttonSeparator = EzSpacer(2 * buttonSpace);

  late final TextStyle? descriptionStyle = titleSmall(context);

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(EFUILang.of(context)!.stsPageTitle);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      body: EzScreen(
        decorationImageKey: isLight ? lightPageImageKey : darkPageImageKey,
        child: EzScrollView(
          children: [
            // Font
            if (buttonSpace > margin) EzSpacer(buttonSpace - margin),
            const EzFontSetting(),
            _buttonSpacer,

            // Margin
            const EzSliderSetting(
              prefsKey: marginKey,
              type: SliderSettingType.margin,
              min: 0.0,
              max: 50.0,
              steps: 10,
              decimals: 1,
            ),
            _buttonSpacer,

            // Padding
            const EzSliderSetting(
              prefsKey: paddingKey,
              type: SliderSettingType.padding,
              min: 0.0,
              max: 50.0,
              steps: 10,
              decimals: 1,
            ),
            _buttonSpacer,

            // Button spacing
            const EzSliderSetting(
              prefsKey: buttonSpacingKey,
              type: SliderSettingType.buttonSpacing,
              min: 10.0,
              max: 100.0,
              steps: 18,
              decimals: 0,
            ),
            _buttonSpacer,

            // Text spacing
            const EzSliderSetting(
              prefsKey: textSpacingKey,
              type: SliderSettingType.textSpacing,
              min: 10.0,
              max: 100.0,
              steps: 18,
              decimals: 0,
            ),
            _buttonSeparator,

            // Local reset all
            EzResetButton(
              context: context,
              dialogTitle: EFUILang.of(context)!.stsResetAll,
              onConfirm: () {
                EzConfig.removeKeys(styleKeys.keys.toSet());
                popScreen(context: context, result: true);
              },
            ),
            _buttonSeparator,

            // Help
            EzLink(
              EFUILang.of(context)!.gHowThisWorks,
              style: descriptionStyle,
              textAlign: TextAlign.center,
              url: Uri.parse(understandingLayout),
              semanticsLabel: EFUILang.of(context)!.gHowThisWorksHint,
              tooltip: understandingLayout,
            ),
            _buttonSpacer,
          ],
        ),
      ),
    );
  }
}
