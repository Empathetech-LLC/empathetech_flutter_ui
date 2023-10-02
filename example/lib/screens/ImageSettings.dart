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
  void initState() {
    super.initState();
    setPageTitle(context: context, title: 'Image settings');
  }

  // Gather theme data //

  late bool isLight = !PlatformTheme.of(context)!.isDark;

  final double textSpacer = EzConfig.instance.prefs[textSpacingKey];
  final double buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];

  late final TextStyle? resetLinkStyle =
      bodyLarge(context)?.copyWith(decoration: TextDecoration.underline);

  // Build page //

  @override
  Widget build(BuildContext context) {
    final String themeProfile = isLight ? 'light' : 'dark';
    final String resetMessage = "Reset all $themeProfile theme images?";

    return ExampleScaffold(
      body: EzScreen(
        child: EzScrollView(
          children: [
            // Current theme mode reminder
            EzSelectableText(
              'Editing: $themeProfile theme',
              style: titleSmall(context),
            ),
            EzSpacer(textSpacer),

            // Settings //

            // Nested in a horizontal scroll view in case the screen doesn't have enough horizontal space
            EzScrollView(
              scrollDirection: Axis.horizontal,
              mainAxisSize: MainAxisSize.min,
              primary: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: isLight
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
                        EzSpacer(buttonSpacer),
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
                        EzSpacer(buttonSpacer),
                      ],
              ),
            ),

            // Local reset "all"
            EzResetButton(
              context: context,
              hint: resetMessage,
              style: resetLinkStyle,
              dialogTitle: resetMessage,
              onConfirm: () {
                if (isLight) {
                  EzConfig.instance.preferences.remove(lightPageImageKey);
                } else {
                  EzConfig.instance.preferences.remove(darkPageImageKey);
                }
              },
            ),
            EzSpacer(textSpacer),
          ],
        ),
      ),
    );
  }
}
