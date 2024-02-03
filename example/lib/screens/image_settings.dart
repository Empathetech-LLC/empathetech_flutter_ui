import '../utils/utils.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ImageSettingsScreen extends StatefulWidget {
  const ImageSettingsScreen({super.key});

  @override
  State<ImageSettingsScreen> createState() => _ImageSettingsScreenState();
}

class _ImageSettingsScreenState extends State<ImageSettingsScreen> {
  // Gather the theme data //

  late bool isLight = !PlatformTheme.of(context)!.isDark;

  final double spacing = EzConfig.get(spacingKey);

  late final EzSpacer _buttonSpacer = EzSpacer(spacing);
  late final EzSpacer _buttonSeparator = EzSpacer(2 * spacing);

  // Define the page content //

  late final String themeProfile = isLight
      ? EFUILang.of(context)!.gLight.toLowerCase()
      : EFUILang.of(context)!.gDark.toLowerCase();

  late final String resetTitle = EFUILang.of(context)!.isResetAll(themeProfile);

  late final Set<String> resetAllKeys = imageKeys.keys
      .map((String key) => isLight ? '$light$key' : '$dark$key')
      .toSet();

  late final List<Widget> settingsButtons = <Widget>[
    isLight
        // Page
        ? EzImageSetting(
            prefsKey: '$light$pageImageKey',
            label: EFUILang.of(context)!.isBackground,
            allowClear: true,
            updateTheme: Brightness.light,
          )
        : EzImageSetting(
            prefsKey: '$dark$pageImageKey',
            label: EFUILang.of(context)!.isBackground,
            allowClear: true,
            updateTheme: Brightness.dark,
          ),
    _buttonSeparator,

    // Local reset all
    EzResetButton(
      dialogTitle: resetTitle,
      onConfirm: () {
        EzConfig.removeKeys(resetAllKeys);
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
        decorationImageKey:
            isLight ? '$light$pageImageKey' : '$dark$pageImageKey',
        child: EzScrollView(
          children: <Widget>[
            // Current theme reminder
            Text(
              EFUILang.of(context)!.gEditingTheme(themeProfile),
              style: getLabel(context),
              textAlign: TextAlign.center,
            ),
            _buttonSeparator,

            // Settings
            ...settingsButtons,
            _buttonSpacer,
          ],
        ),
      ),
    );
  }
}
