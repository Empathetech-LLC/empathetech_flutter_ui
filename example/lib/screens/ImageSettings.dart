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
  // Set page/tab title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(context, EFUILang.of(context)!.isPageTitle);
  }

  // Gather theme data //

  late bool _isLight = !PlatformTheme.of(context)!.isDark;
  late final String _themeProfile = _isLight
      ? EFUILang.of(context)!.gLight.toLowerCase()
      : EFUILang.of(context)!.gDark.toLowerCase();

  late final String _resetTitle =
      EFUILang.of(context)!.isResetAll(_themeProfile);

  final double _buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      body: EzScreen(
        decorationImageKey: _isLight ? lightPageImageKey : darkPageImageKey,
        child: EzScrollView(
          children: [
            // Current theme mode reminder
            Text(
              EFUILang.of(context)!.gEditingTheme(_themeProfile),
              style: titleSmall(context),
              textAlign: TextAlign.center,
            ),
            EzSpacer(_buttonSpacer),

            // Settings //

            // Nested in a horizontal scroll view in case the screen doesn't have enough horizontal space
            EzScrollView(
              scrollDirection: Axis.horizontal,
              mainAxisSize: MainAxisSize.min,
              primary: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _isLight
                    ? // Editing light theme //
                    [
                        // Page
                        EzImageSetting(
                          prefsKey: lightPageImageKey,
                          label: EFUILang.of(context)!.isBackground,
                          allowClear: true,
                          fullscreen: true,
                          updateTheme: Brightness.light,
                        ),
                      ]
                    : // Editing dark theme //
                    [
                        // Page
                        EzImageSetting(
                          prefsKey: darkPageImageKey,
                          label: EFUILang.of(context)!.isBackground,
                          allowClear: true,
                          fullscreen: true,
                          updateTheme: Brightness.dark,
                        ),
                      ],
              ),
            ),
            EzSpacer(_buttonSpacer),

            // Local reset all
            EzResetButton(
              context: context,
              dialogTitle: _resetTitle,
              onConfirm: () {
                removeKeys(_isLight ? lightImageKeys : darkImageKeys);
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
