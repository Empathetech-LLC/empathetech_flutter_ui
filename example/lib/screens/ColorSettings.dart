import '../utils/utils.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ColorSettingsScreen extends StatefulWidget {
  const ColorSettingsScreen({Key? key}) : super(key: key);

  @override
  _ColorSettingsScreenState createState() => _ColorSettingsScreenState();
}

class _ColorSettingsScreenState extends State<ColorSettingsScreen> {
  // Set page/tab title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(context, EFUILang.of(context)!.csPageTitle);
  }

  // Gather theme data //

  late bool _isLight = !PlatformTheme.of(context)!.isDark;
  late final String _themeProfile =
      _isLight ? EFUILang.of(context)!.gLight : EFUILang.of(context)!.gDark;

  // Define local reset button's messages
  late final String _resetTitle =
      EFUILang.of(context)!.csResetAll(_themeProfile);

  final double _buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      body: EzScreen(
        decorationImageKey: _isLight ? lightPageImageKey : darkPageImageKey,
        child: EzScrollView(
          children: [
            // Editing reminders
            Text(
              EFUILang.of(context)!.csEditingTheme(_themeProfile),
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
                    ? [
                        // Background
                        EzColorSetting(
                          updating: [lightBackgroundKey],
                          label: EFUILang.of(context)!.csBackground,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [lightOnBackgroundKey],
                          label: EFUILang.of(context)!.csOnBackground,
                          textBackgroundKey: lightBackgroundKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Surface
                        EzColorSetting(
                          updating: [lightSurfaceKey],
                          label: EFUILang.of(context)!.csSurface,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [lightOnSurfaceKey],
                          label: EFUILang.of(context)!.csOnSurface,
                          textBackgroundKey: lightSurfaceKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Primary
                        EzColorSetting(
                          updating: [lightPrimaryKey],
                          label: EFUILang.of(context)!.csPrimary,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [lightOnPrimaryKey],
                          label: EFUILang.of(context)!.csOnPrimary,
                          textBackgroundKey: lightPrimaryKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Secondary
                        EzColorSetting(
                          updating: [lightSecondaryKey],
                          label: EFUILang.of(context)!.csSecondary,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [lightOnSecondaryKey],
                          label: EFUILang.of(context)!.csOnSecondary,
                          textBackgroundKey: lightSecondaryKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Tertiary
                        EzColorSetting(
                          updating: [lightTertiaryKey],
                          label: EFUILang.of(context)!.csTertiary,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [lightOnTertiaryKey],
                          label: EFUILang.of(context)!.csOnTertiary,
                          textBackgroundKey: lightTertiaryKey,
                        ),
                        EzSpacer(_buttonSpacer),
                      ]
                    : [
                        // Background
                        EzColorSetting(
                          updating: [darkBackgroundKey],
                          label: EFUILang.of(context)!.csBackground,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [darkOnBackgroundKey],
                          label: EFUILang.of(context)!.csOnBackground,
                          textBackgroundKey: darkBackgroundKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Surface
                        EzColorSetting(
                          updating: [darkSurfaceKey],
                          label: EFUILang.of(context)!.csSurface,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [darkOnSurfaceKey],
                          label: EFUILang.of(context)!.csOnSurface,
                          textBackgroundKey: darkSurfaceKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Primary
                        EzColorSetting(
                          updating: [darkPrimaryKey],
                          label: EFUILang.of(context)!.csPrimary,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [darkOnPrimaryKey],
                          label: EFUILang.of(context)!.csOnPrimary,
                          textBackgroundKey: darkPrimaryKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Secondary
                        EzColorSetting(
                          updating: [darkSecondaryKey],
                          label: EFUILang.of(context)!.csSecondary,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [darkOnSecondaryKey],
                          label: EFUILang.of(context)!.csOnSecondary,
                          textBackgroundKey: darkSecondaryKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Tertiary
                        EzColorSetting(
                          updating: [darkTertiaryKey],
                          label: EFUILang.of(context)!.csTertiary,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [darkOnTertiaryKey],
                          label: EFUILang.of(context)!.csOnTertiary,
                          textBackgroundKey: darkTertiaryKey,
                        ),
                        EzSpacer(_buttonSpacer),
                      ],
              ),
            ),

            EzSpacer(_buttonSpacer),

            // Local reset all
            EzResetButton(
              context: context,
              hint: _resetTitle,
              dialogTitle: _resetTitle,
              onConfirm: () {
                removeKeys(_isLight ? lightColorKeys : darkColorKeys);
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
