import '../utils/utils.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ImageSettingsScreen extends StatefulWidget {
  const ImageSettingsScreen({Key? key}) : super(key: key);

  @override
  _ImageSettingsScreenState createState() => _ImageSettingsScreenState();
}

class _ImageSettingsScreenState extends State<ImageSettingsScreen> {
  // Gather the theme data //

  late bool isLight = !PlatformTheme.of(context)!.isDark;

  final double buttonSpace = EzConfig.get(buttonSpacingKey);

  late final EzSpacer _buttonSpacer = EzSpacer(buttonSpace);
  late final EzSpacer _buttonSeparator = EzSpacer(2 * buttonSpace);
  final EzSpacer _textSpacer = EzSpacer(EzConfig.get(textSpacingKey));

  // Define the page content //

  late final String themeProfile = isLight
      ? EFUILang.of(context)!.gLight.toLowerCase()
      : EFUILang.of(context)!.gDark.toLowerCase();

  late final String resetTitle = EFUILang.of(context)!.isResetAll(themeProfile);

  late final List<Widget> _lightButtons = [
    // Page
    EzImageSetting(
      prefsKey: lightPageImageKey,
      label: EFUILang.of(context)!.isBackground,
      allowClear: true,
      updateTheme: Brightness.light,
    ),
    _buttonSeparator,

    // Local reset all
    EzResetButton(
      dialogTitle: resetTitle,
      onConfirm: () {
        EzConfig.removeKeys(lightImageKeys.keys.toSet());
        popScreen(context: context, result: true);
      },
    ),
  ];

  late final List<Widget> _darkButtons = [
    // Page
    EzImageSetting(
      prefsKey: darkPageImageKey,
      label: EFUILang.of(context)!.isBackground,
      allowClear: true,
      updateTheme: Brightness.dark,
    ),
    _buttonSeparator,

    // Local reset all
    EzResetButton(
      dialogTitle: resetTitle,
      onConfirm: () {
        EzConfig.removeKeys(darkImageKeys.keys.toSet());
        popScreen(context: context, result: true);
      },
    ),
  ];

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(EFUILang.of(context)!.isPageTitle);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      title: efuiS,
      body: EzScreen(
        decorationImageKey: isLight ? lightPageImageKey : darkPageImageKey,
        child: EzScrollView(
          children: [
            // Current theme reminder
            Text(
              EFUILang.of(context)!.gEditingTheme(themeProfile),
              style: getLabel(context),
              textAlign: TextAlign.center,
            ),
            _textSpacer,

            // Settings
            ...(isLight ? _lightButtons : _darkButtons),
            _buttonSpacer,
          ],
        ),
      ),
    );
  }
}
