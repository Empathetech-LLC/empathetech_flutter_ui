import '../utils/utils.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class LayoutSettingsScreen extends StatefulWidget {
  const LayoutSettingsScreen({Key? key}) : super(key: key);

  @override
  _LayoutSettingsScreenState createState() => _LayoutSettingsScreenState();
}

class _LayoutSettingsScreenState extends State<LayoutSettingsScreen> {
  // Set page/tab title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(context, EFUILang.of(context)!.stsPageTitle);
  }

  // Gather theme data //

  late bool _isLight = !PlatformTheme.of(context)!.isDark;

  final double _margin = EzConfig.instance.prefs[marginKey];
  final double _buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      body: EzScreen(
        decorationImageKey: _isLight ? lightPageImageKey : darkPageImageKey,
        child: EzScrollView(
          children: [
            // Dominant hand
            EzSpacer(_buttonSpacer > _margin ? _buttonSpacer - _margin : 0),
            const EzDominantHandSwitch(),
            EzSpacer(_buttonSpacer),

            // Margin
            EzSliderSetting(
              prefsKey: marginKey,
              type: SliderSettingType.margin,
              title: EFUILang.of(context)!.lsMargin,
              min: 5.0,
              max: 50.0,
              steps: 18,
              decimals: 1,
            ),
            EzSpacer(_buttonSpacer),

            // Text spacing
            EzSliderSetting(
              prefsKey: textSpacingKey,
              type: SliderSettingType.textSpacing,
              title: EFUILang.of(context)!.lsTextSpacing,
              min: 10.0,
              max: 100.0,
              steps: 18,
              decimals: 0,
            ),
            EzSpacer(2 * _buttonSpacer),

            // Button spacing
            EzSliderSetting(
              prefsKey: buttonSpacingKey,
              type: SliderSettingType.buttonSpacing,
              title: EFUILang.of(context)!.lsButtonSpacing,
              min: 10.0,
              max: 100.0,
              steps: 18,
              decimals: 0,
            ),
            EzSpacer(_buttonSpacer),

            // Local reset all
            EzResetButton(
              context: context,
              dialogTitle: EFUILang.of(context)!.lsResetAll,
              onConfirm: () {
                removeKeys(layoutKeys);
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
