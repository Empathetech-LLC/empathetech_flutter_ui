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
  late final String _themeProfile =
      _isLight ? EFUILang.of(context)!.gLight : EFUILang.of(context)!.gDark;

  late final String _resetTitle =
      EFUILang.of(context)!.isResetAll(_themeProfile);

  final double _buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];
  final double _textSpacer = EzConfig.instance.prefs[textSpacingKey];

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
                          title: EFUILang.of(context)!.gPage,
                          allowClear: true,
                          fullscreen: true,
                          credits: EFUILang.of(context)!.isSource,
                        ),
                      ]
                    : // Editing dark theme //
                    [
                        // Page
                        EzImageSetting(
                          prefsKey: darkPageImageKey,
                          title: EFUILang.of(context)!.gPage,
                          allowClear: true,
                          fullscreen: true,
                          credits: EFUILang.of(context)!.isSource,
                        ),
                      ],
              ),
            ),
            EzSpacer(2 * _buttonSpacer),

            // Local reset all
            EzResetButton(
              context: context,
              dialogTitle: _resetTitle,
              onConfirm: () {
                removeAllKeys(_isLight ? lightImageKeys : darkImageKeys);
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
