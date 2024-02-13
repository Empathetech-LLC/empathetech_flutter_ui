import '../utils/utils.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class LayoutSettingsScreen extends StatefulWidget {
  const LayoutSettingsScreen({super.key});

  @override
  State<LayoutSettingsScreen> createState() => _LayoutSettingsScreenState();
}

class _LayoutSettingsScreenState extends State<LayoutSettingsScreen> {
  // Gather the theme data //

  late bool isDark = PlatformTheme.of(context)!.isDark;

  final double margin = EzConfig.get(marginKey);
  final double spacing = EzConfig.get(spacingKey);

  late final EzSpacer spacer = EzSpacer(spacing);
  late final EzSpacer separator = EzSpacer(2 * spacing);

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(EFUILang.of(context)!.lsPageTitle);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      title: efuiS,
      body: EzScreen(
        decorationImageKey: isDark ? darkPageImageKey : lightPageImageKey,
        child: EzScrollView(
          children: <Widget>[
            if (spacing > margin) EzSpacer(spacing - margin),
            // Margin
            const EzSliderSetting(
              prefsKey: marginKey,
              type: SliderSettingType.margin,
              min: 0.0,
              max: 50.0,
              steps: 10,
              decimals: 1,
            ),
            spacer,

            // Padding
            const EzSliderSetting(
              prefsKey: paddingKey,
              type: SliderSettingType.padding,
              min: 0.0,
              max: 50.0,
              steps: 10,
              decimals: 1,
            ),
            spacer,

            // Spacing
            const EzSliderSetting(
              prefsKey: spacingKey,
              type: SliderSettingType.spacing,
              min: 10.0,
              max: 100.0,
              steps: 18,
              decimals: 0,
            ),
            separator,

            // Local reset all
            EzResetButton(
              dialogTitle: EFUILang.of(context)!.lsResetAll,
              onConfirm: () {
                EzConfig.removeKeys(layoutKeys.keys.toSet());
                popScreen(context: context, result: true);
              },
            ),
            separator,

            // Help
            EzLink(
              EFUILang.of(context)!.gHowThisWorks,
              style: getLabel(context),
              textAlign: TextAlign.center,
              url: Uri.parse(understandingLayout),
              semanticsLabel: EFUILang.of(context)!.gHowThisWorksHint,
              tooltip: understandingLayout,
            ),
            spacer,
          ],
        ),
      ),
    );
  }
}
