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

  final double _buttonSpacer = EzConfig.get(buttonSpacingKey);
  final double _padding = EzConfig.get(paddingKey);

  late final TextStyle? _descriptionStyle = titleSmall(context);

  late final String _themeProfile = _isLight
      ? EFUILang.of(context)!.gLight.toLowerCase()
      : EFUILang.of(context)!.gDark.toLowerCase();
  late final String _resetTitle =
      EFUILang.of(context)!.csResetAll(_themeProfile);

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
              style: _descriptionStyle,
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
                          setting: lightBackgroundKey,
                          label: EFUILang.of(context)!.csBackground,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          setting: lightOnBackgroundKey,
                          label: EFUILang.of(context)!.csOnBackground,
                          textBackgroundKey: lightBackgroundKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Surface
                        EzColorSetting(
                          setting: lightSurfaceKey,
                          label: EFUILang.of(context)!.csSurface,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          setting: lightOnSurfaceKey,
                          label: EFUILang.of(context)!.csOnSurface,
                          textBackgroundKey: lightSurfaceKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Primary
                        EzColorSetting(
                          setting: lightPrimaryKey,
                          label: EFUILang.of(context)!.csPrimary,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          setting: lightOnPrimaryKey,
                          label: EFUILang.of(context)!.csOnPrimary,
                          textBackgroundKey: lightPrimaryKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Secondary
                        EzColorSetting(
                          setting: lightSecondaryKey,
                          label: EFUILang.of(context)!.csSecondary,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          setting: lightOnSecondaryKey,
                          label: EFUILang.of(context)!.csOnSecondary,
                          textBackgroundKey: lightSecondaryKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Tertiary
                        EzColorSetting(
                          setting: lightTertiaryKey,
                          label: EFUILang.of(context)!.csTertiary,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          setting: lightOnTertiaryKey,
                          label: EFUILang.of(context)!.csOnTertiary,
                          textBackgroundKey: lightTertiaryKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // ColorScheme source
                        Text(
                          EFUILang.of(context)!.csOptional,
                          style: _descriptionStyle,
                          textAlign: TextAlign.center,
                        ),
                        EzSpacer(_padding),
                        EzImageSetting(
                          prefsKey: lightColorSchemeImageKey,
                          label:
                              "${EFUILang.of(context)!.csSchemeBase}\n\n(${EFUILang.of(context)!.csOptional})",
                          dialogTitle:
                              "$_themeProfile ${EFUILang.of(context)!.csColorScheme}",
                          allowClear: true,
                          fullscreen: true,
                          updateTheme: Brightness.light,
                          hideThemeMessage: true,
                        ),
                        EzSpacer(_buttonSpacer),
                      ]
                    : [
                        // Background
                        EzColorSetting(
                          setting: darkBackgroundKey,
                          label: EFUILang.of(context)!.csBackground,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          setting: darkOnBackgroundKey,
                          label: EFUILang.of(context)!.csOnBackground,
                          textBackgroundKey: darkBackgroundKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Surface
                        EzColorSetting(
                          setting: darkSurfaceKey,
                          label: EFUILang.of(context)!.csSurface,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          setting: darkOnSurfaceKey,
                          label: EFUILang.of(context)!.csOnSurface,
                          textBackgroundKey: darkSurfaceKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Primary
                        EzColorSetting(
                          setting: darkPrimaryKey,
                          label: EFUILang.of(context)!.csPrimary,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          setting: darkOnPrimaryKey,
                          label: EFUILang.of(context)!.csOnPrimary,
                          textBackgroundKey: darkPrimaryKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Secondary
                        EzColorSetting(
                          setting: darkSecondaryKey,
                          label: EFUILang.of(context)!.csSecondary,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          setting: darkOnSecondaryKey,
                          label: EFUILang.of(context)!.csOnSecondary,
                          textBackgroundKey: darkSecondaryKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Tertiary
                        EzColorSetting(
                          setting: darkTertiaryKey,
                          label: EFUILang.of(context)!.csTertiary,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          setting: darkOnTertiaryKey,
                          label: EFUILang.of(context)!.csOnTertiary,
                          textBackgroundKey: darkTertiaryKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // ColorScheme source

                        EzImageSetting(
                          prefsKey: darkColorSchemeImageKey,
                          label:
                              "${EFUILang.of(context)!.csSchemeBase}\n\n(${EFUILang.of(context)!.csOptional})",
                          dialogTitle:
                              "$_themeProfile ${EFUILang.of(context)!.csColorScheme}",
                          allowClear: true,
                          fullscreen: true,
                          updateTheme: Brightness.dark,
                          hideThemeMessage: true,
                        ),
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
                EzConfig.removeKeys(_isLight
                    ? lightColorKeys.keys.toSet()
                    : darkColorKeys.keys.toSet());
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
