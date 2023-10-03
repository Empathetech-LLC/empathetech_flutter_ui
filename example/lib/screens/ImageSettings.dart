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
  void initState() {
    super.initState();
    setPageTitle(context: context, title: 'Image settings');
  }

  // Gather theme data //

  late bool _isLight = !PlatformTheme.of(context)!.isDark;
  late final String _themeProfile = _isLight ? 'light' : 'dark';

  late final String _resetTitle = "Reset all $_themeProfile theme images?";
  final String _resetMessage = kIsWeb
      ? "Cannot be undone\nChanges take effect on page reload"
      : "Cannot be undone\nChanges take effect on app restart";

  final double _textSpacer = EzConfig.instance.prefs[textSpacingKey];
  final double _buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      body: EzScreen(
        child: EzScrollView(
          children: [
            // Current theme mode reminder
            EzSelectableText(
              'Editing: $_themeProfile theme',
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
                        const EzImageSetting(
                          prefsKey: lightPageImageKey,
                          title: 'Page',
                          allowClear: true,
                          fullscreen: true,
                          credits: 'Wherever you got it!',
                          semantics: 'Page background image',
                        ),
                        EzSpacer(_buttonSpacer),
                      ]
                    : // Editing dark theme //
                    [
                        // Page
                        const EzImageSetting(
                          prefsKey: darkPageImageKey,
                          title: 'Page',
                          allowClear: true,
                          fullscreen: true,
                          credits: 'Wherever you got it!',
                          semantics: 'Page background image',
                        ),
                        EzSpacer(_buttonSpacer),
                      ],
              ),
            ),

            // Local reset "all"
            EzResetButton(
              context: context,
              hint: _resetMessage,
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
            EzSpacer(_textSpacer),
          ],
        ),
      ),
    );
  }
}
