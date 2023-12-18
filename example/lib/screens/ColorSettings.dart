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
  late final EzSpacer _textSpacer = EzSpacer(EzConfig.get(textSpacingKey));

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

  /// Reset button dialog title
  late final String _resetTitle =
      EFUILang.of(context)!.csResetAll(_themeProfile);

  // Define the dynamic page content //

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

  late List<String> _currList =
      EzConfig.get(userColorsKey) ?? new List.from(_defaultList);
  late final List<String> _fullList = _isLight ? lightColors : darkColors;

  /// Return the live [Set] of [EzConfig.prefs] keys that the user is tracking as a [Stream]
  List<Widget> _dynamicColorSettings() {
    List<Widget> toReturn = [];
    Set<String> defaultSet = _defaultList.toSet();

    for (String key in _currList) {
      if (defaultSet.contains(key)) {
        toReturn.addAll([
          EzColorSetting(
            setting: key,
            allowTransparent: false,
          ),
          _buttonSpacer,
        ]);
      } else {
        toReturn.addAll([
          EzColorSetting(
              setting: key,
              onRemove: () {
                setState(() {
                  _currList.remove(key);
                });
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
    return _fullList
        .where((element) => !_currList.contains(element))
        .toList()
        .fold<List<Widget>>([], (accumulator, key) {
      accumulator.addAll([
        ElevatedButton.icon(
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
            child: CircleAvatar(
              backgroundColor: getLiveColor(context, key),
              radius: _padding * sqrt(2),
            ),
          ),
          label: Text(getColorName(context, key)),
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
              _currList.add(key);
            });
            modalSheetState(() {});
          },
        ),
        _buttonSpacer,
      ]);
      return accumulator;
    });
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
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (context) => StatefulBuilder(
                  builder: (BuildContext context, StateSetter modalSheetState) {
                    return EzScrollView(
                        children: _getUntrackedColors(modalSheetState));
                  },
                ),
              ),
              semanticsLabel: EFUILang.of(context)!.csAddColor,
            ),
            _buttonSeparator,

            // Build from image
            Semantics(
              button: true,
              hint: _fromImageHint,
              child: ExcludeSemantics(
                child: EzImageSetting(
                  prefsKey: _isLight
                      ? lightColorSchemeImageKey
                      : darkColorSchemeImageKey,
                  label: _fromImageLabel,
                  dialogTitle: _fromImageTitle,
                  allowClear: true,
                  updateTheme: _isLight ? Brightness.light : Brightness.dark,
                  hideThemeMessage: true,
                ),
              ),
            ),
            _buttonSeparator,

            // Local reset all
            EzResetButton(
              context: context,
              hint: _resetTitle,
              dialogTitle: _resetTitle,
              onConfirm: () {
                EzConfig.removeKeys(_isLight
                    ? {...lightColorKeys.keys.toSet(), userColorsKey}
                    : {...darkColorKeys.keys.toSet(), userColorsKey});
                setState(() {
                  _currList = new List.from(_defaultList);
                });
                popScreen(context: context, result: true);
              },
            ),
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

  @override
  void dispose() {
    if (_currList.isNotEmpty && _currList != _defaultList) {
      EzConfig.setStringList(userColorsKey, _currList);
    }
    super.dispose();
  }
}
