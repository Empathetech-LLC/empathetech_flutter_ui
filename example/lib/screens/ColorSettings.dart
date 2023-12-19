import '../utils/utils.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ColorSettingsScreen extends StatefulWidget {
  const ColorSettingsScreen({Key? key}) : super(key: key);

  @override
  _ColorSettingsScreenState createState() => _ColorSettingsScreenState();
}

class _ColorSettingsScreenState extends State<ColorSettingsScreen> {
  // Gather the theme data //

  late bool _isLight = !PlatformTheme.of(context)!.isDark;

  final double _padding = EzConfig.get(paddingKey);
  final double _buttonSpace = EzConfig.get(buttonSpacingKey);

  late final EzSpacer _buttonSpacer = EzSpacer(_buttonSpace);
  late final EzSpacer _buttonSeparator = EzSpacer(2 * _buttonSpace);
  final EzSpacer _textSpacer = EzSpacer(EzConfig.get(textSpacingKey));

  late final TextStyle? _descriptionStyle = titleSmall(context);

  // Define the static page content //

  late final String _themeProfile = _isLight
      ? EFUILang.of(context)!.gLight.toLowerCase()
      : EFUILang.of(context)!.gDark.toLowerCase();

  /// Build from image button label
  late final String _fromImageLabel = EFUILang.of(context)!.csSchemeBase;
  late final String _fromImageHint =
      "${EFUILang.of(context)!.csOptional}: ${EFUILang.of(context)!.csFromImage}";

  /// Build from image button dialog title
  late final String _fromImageTitle =
      "$_themeProfile ${EFUILang.of(context)!.csColorScheme}";

  late final String _resetDialogTitle =
      EFUILang.of(context)!.csResetAll(_themeProfile);

  late final List<String> _defaultList = _isLight
      ? [
          lightPrimaryKey,
          lightSecondaryKey,
          lightTertiaryKey,
          lightBackgroundKey,
          lightSurfaceKey,
        ]
      : [
          darkPrimaryKey,
          darkSecondaryKey,
          darkTertiaryKey,
          darkBackgroundKey,
          darkSurfaceKey,
        ];
  late final _defaultSet = _defaultList.toSet();
  late final List<String> _fullList = _isLight ? lightColors : darkColors;

  /// Return the [List] of [Widget]s that aren't [EzColorSetting]s
  late final List<Widget> _otherButtons = _isLight
      ? [
          Semantics(
            button: true,
            hint: _fromImageHint,
            child: ExcludeSemantics(
              child: EzImageSetting(
                prefsKey: lightColorSchemeImageKey,
                label: _fromImageLabel,
                dialogTitle: _fromImageTitle,
                allowClear: true,
                updateTheme: Brightness.light,
                hideThemeMessage: true,
              ),
            ),
          ),
          _buttonSeparator,

          // Local reset all
          EzResetButton(
            context: context,
            dialogTitle: _resetDialogTitle,
            onConfirm: () {
              EzConfig.removeKeys(
                {...lightColorKeys.keys.toSet(), userColorsKey},
              );
              setState(() {
                _currList = new List.from(_defaultList);
              });
              popScreen(context: context, result: true);
            },
          ),
        ]
      : [
          Semantics(
            button: true,
            hint: _fromImageHint,
            child: ExcludeSemantics(
              child: EzImageSetting(
                prefsKey: darkColorSchemeImageKey,
                label: _fromImageLabel,
                dialogTitle: _fromImageTitle,
                allowClear: true,
                updateTheme: Brightness.dark,
                hideThemeMessage: true,
              ),
            ),
          ),
          _buttonSeparator,

          // Local reset all
          EzResetButton(
            context: context,
            dialogTitle: _resetDialogTitle,
            onConfirm: () {
              EzConfig.removeKeys(
                {...darkColorKeys.keys.toSet(), userColorsKey},
              );
              setState(() {
                _currList = new List.from(_defaultList);
              });
              popScreen(context: context, result: true);
            },
          ),
        ];

  // Define the dynamic page content //

  late List<String> _currList =
      EzConfig.get(userColorsKey) ?? new List.from(_defaultList);

  /// Return the live [List] of [EzConfig.prefs] keys that the user is tracking
  List<Widget> _dynamicColorSettings() {
    List<Widget> toReturn = [];

    for (String key in _currList) {
      if (_defaultSet.contains(key)) {
        // Non-removable buttons
        toReturn.addAll([
          EzColorSetting(key: ValueKey(key), setting: key),
          _buttonSpacer,
        ]);
      } else {
        toReturn.addAll([
          // Removable buttons
          EzColorSetting(
              key: ValueKey(key),
              setting: key,
              onRemove: () {
                setState(() {
                  _currList.remove(key);
                });
                EzConfig.setStringList(userColorsKey, _currList);
                popScreen(context: context);
              }),
          _buttonSpacer,
        ]);
      }
    }

    return toReturn;
  }

  /// Return the [List] of [EzConfig.prefs] keys that the user is not tracking
  List<Widget> _getUntrackedColors(StateSetter modalSheetState) {
    final Set<String> _currSet = _currList.toSet();

    return _fullList
        .where((element) => !_currSet.contains(element))
        .map<Widget>(
          (String settingKey) => Container(
            padding: EdgeInsets.symmetric(
              vertical: _buttonSpace / 2,
              horizontal: _buttonSpace,
            ),
            child: ElevatedButton.icon(
              key: ValueKey(settingKey),
              icon: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: getLiveColor(context, settingKey),
                  radius: _padding * sqrt(2),
                ),
              ),
              label: Text(getColorName(context, settingKey)),
              style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.all(_padding * 0.75),
                    ),
                    foregroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
              onPressed: () {
                setState(() {
                  _currList.add(settingKey);
                });
                modalSheetState(() {});
              },
            ),
          ),
        )
        .toList();
  }

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(EFUILang.of(context)!.csPageTitle);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      body: EzScreen(
        decorationImageKey: _isLight ? lightPageImageKey : darkPageImageKey,
        child: EzScrollView(
          children: [
            // Current theme reminder
            Text(
              EFUILang.of(context)!.gEditingTheme(_themeProfile),
              style: _descriptionStyle,
              textAlign: TextAlign.center,
            ),
            _textSpacer,

            // Dynamic settings
            ..._dynamicColorSettings(),
            _buttonSpacer,

            // Add a color
            EzIconLink(
              icon: Icon(PlatformIcons(context).addCircledOutline),
              label: EFUILang.of(context)!.csAddColor,
              textAlign: TextAlign.center,
              onTap: () async {
                // Show available color settings
                await showModalBottomSheet(
                  context: context,
                  builder: (context) => StatefulBuilder(
                    builder:
                        (BuildContext context, StateSetter modalSheetState) {
                      return EzScrollView(
                          children: _getUntrackedColors(modalSheetState));
                    },
                  ),
                );

                // Save the user's changes (if any)
                if (_currList != _defaultList) {
                  final List<String> sortedList = new List.from(_currList);
                  sortedList.sort(
                    (a, b) => _fullList.indexOf(a) - _fullList.indexOf(b),
                  );
                  EzConfig.setStringList(userColorsKey, sortedList);
                }
              },
            ),
            _buttonSeparator,

            // Build from image
            ..._otherButtons,
            _buttonSeparator,

            // Help
            EzLink(
              EFUILang.of(context)!.gHowThisWorks,
              style: _descriptionStyle,
              textAlign: TextAlign.center,
              url: Uri.parse(materialColorRoles),
              semanticsLabel: EFUILang.of(context)!.gHowThisWorksHint,
            ),
            _buttonSpacer,
          ],
        ),
      ),
    );
  }
}
