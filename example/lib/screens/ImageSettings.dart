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
    setPageTitle(context, EFUILang.of(context)!.is_PageTitle);
  }

  // Gather theme data //

  late bool _isLight = !PlatformTheme.of(context)!.isDark;
  late final String _themeProfile =
      _isLight ? EFUILang.of(context)!.g_Light : EFUILang.of(context)!.g_Dark;

  late final String _resetTitle =
      EFUILang.of(context)!.is_ResetAll(_themeProfile);

  final double _buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];
  final double _textSpacer = EzConfig.instance.prefs[textSpacingKey];

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      body: EzScreen(
        child: EzScrollView(
          children: [
            // Current theme mode reminder
            EzText(
              EFUILang.of(context)!.d_EditingTheme(_themeProfile),
              style: titleSmall(context),
            ),
            EzSpacer(_textSpacer),

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
                          title: EFUILang.of(context)!.g_Page,
                          allowClear: true,
                          fullscreen: true,
                          credits: EFUILang.of(context)!.is_Source,
                        ),
                        EzSpacer(_buttonSpacer),
                      ]
                    : // Editing dark theme //
                    [
                        // Page
                        EzImageSetting(
                          prefsKey: darkPageImageKey,
                          title: EFUILang.of(context)!.g_Page,
                          allowClear: true,
                          fullscreen: true,
                          credits: EFUILang.of(context)!.is_Source,
                        ),
                        EzSpacer(_buttonSpacer),
                      ],
              ),
            ),

            // Local reset "all"
            EzResetButton(
              context: context,
              hint: _resetTitle,
              dialogTitle: _resetTitle,
              onConfirm: () {
                if (_isLight) {
                  EzConfig.instance.preferences.remove(lightPageImageKey);
                } else {
                  EzConfig.instance.preferences.remove(darkPageImageKey);
                }

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
