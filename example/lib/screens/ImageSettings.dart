import '../utils/utils.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
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
    setPageTitle(context, Phrases.of(context)!.imageSettings);
  }

  // Gather theme data //

  late bool _isLight = !PlatformTheme.of(context)!.isDark;
  late final String _themeProfile =
      _isLight ? EFUIPhrases.of(context)!.light : EFUIPhrases.of(context)!.dark;

  late final String _resetTitle =
      Phrases.of(context)!.resetAllImages(_themeProfile);

  late final String _resetMessage = kIsWeb
      ? Phrases.of(context)!.resetAllWarningWeb
      : Phrases.of(context)!.resetAllWarning;

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
              Phrases.of(context)!.editingTheme(_themeProfile),
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
                          title: Phrases.of(context)!.page,
                          allowClear: true,
                          fullscreen: true,
                          credits: Phrases.of(context)!.yourSourceCredit,
                        ),
                        EzSpacer(_buttonSpacer),
                      ]
                    : // Editing dark theme //
                    [
                        // Page
                        EzImageSetting(
                          prefsKey: darkPageImageKey,
                          title: Phrases.of(context)!.page,
                          allowClear: true,
                          fullscreen: true,
                          credits: Phrases.of(context)!.yourSourceCredit,
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
              dialogContents: _resetMessage,
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
