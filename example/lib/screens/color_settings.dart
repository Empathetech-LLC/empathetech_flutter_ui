import '../utils/utils.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ColorSettingsScreen extends StatefulWidget {
  const ColorSettingsScreen({super.key});

  @override
  State<ColorSettingsScreen> createState() => _ColorSettingsScreenState();
}

class _ColorSettingsScreenState extends State<ColorSettingsScreen> {
  // Gather the theme data //

  late bool isDark = PlatformTheme.of(context)!.isDark;

  final double padding = EzConfig.get(paddingKey);
  final double spacing = EzConfig.get(spacingKey);

  late final EzSpacer spacer = EzSpacer(spacing);
  late final EzSpacer separator = EzSpacer(2 * spacing);

  late final TextStyle? labelStyle = getLabel(context);

  // Define the static page content //

  late final String themeProfile = isDark
      ? EFUILang.of(context)!.gDark.toLowerCase()
      : EFUILang.of(context)!.gLight.toLowerCase();

  /// Build from image button label
  late final String fromImageLabel = EFUILang.of(context)!.csSchemeBase;
  late final String fromImageHint =
      '${EFUILang.of(context)!.csOptional}: ${EFUILang.of(context)!.csFromImage}';

  /// Build from image button dialog title
  late final String fromImageTitle =
      '$themeProfile ${EFUILang.of(context)!.csColorScheme}';

  late final String resetDialogTitle =
      EFUILang.of(context)!.csResetAll(themeProfile);

  late final List<String> defaultList = isDark
      ? <String>[
          darkPrimaryKey,
          darkSecondaryKey,
          darkTertiaryKey,
          darkBackgroundKey,
          darkSurfaceKey,
        ]
      : <String>[
          lightPrimaryKey,
          lightSecondaryKey,
          lightTertiaryKey,
          lightBackgroundKey,
          lightSurfaceKey,
        ];
  late final Set<String> defaultSet = defaultList.toSet();

  late final List<String> fullList = isDark ? darkColors : lightColors;

  /// Return the [List] of [Widget]s that aren't [EzColorSetting]s
  late final List<Widget> _otherButtons = <Widget>[
    isDark
        ? Semantics(
            button: true,
            hint: fromImageHint,
            child: ExcludeSemantics(
              child: EzImageSetting(
                prefsKey: darkColorSchemeImageKey,
                label: fromImageLabel,
                dialogTitle: fromImageTitle,
                allowClear: true,
                updateTheme: Brightness.dark,
                hideThemeMessage: true,
              ),
            ),
          )
        : Semantics(
            button: true,
            hint: fromImageHint,
            child: ExcludeSemantics(
              child: EzImageSetting(
                prefsKey: lightColorSchemeImageKey,
                label: fromImageLabel,
                dialogTitle: fromImageTitle,
                allowClear: true,
                updateTheme: Brightness.light,
                hideThemeMessage: true,
              ),
            ),
          ),
    separator,

    // Local reset all
    EzResetButton(
      dialogTitle: resetDialogTitle,
      onConfirm: () {
        EzConfig.removeKeys(<String>{...fullList, userColorsKey});
        setState(() {
          currList = List<String>.from(defaultList);
        });
        popScreen(context: context, result: true);
      },
    ),
  ];

  // Define the dynamic page content //

  late List<String> currList =
      EzConfig.get(userColorsKey) ?? List<String>.from(defaultList);

  /// Return the live [List] of [EzConfig.prefs] keys that the user is tracking
  List<Widget> _dynamicColorSettings() {
    final List<Widget> toReturn = <Widget>[];

    for (final String key in currList) {
      if (defaultSet.contains(key)) {
        // Non-removable buttons
        toReturn.addAll(<Widget>[
          EzColorSetting(key: ValueKey<String>(key), setting: key),
          spacer,
        ]);
      } else {
        toReturn.addAll(<Widget>[
          // Removable buttons
          EzColorSetting(
              key: ValueKey<String>(key),
              setting: key,
              onRemove: () {
                setState(() {
                  currList.remove(key);
                });
                EzConfig.setStringList(userColorsKey, currList);
                popScreen(context: context);
              }),
          spacer,
        ]);
      }
    }

    return toReturn;
  }

  /// Return the [List] of [EzConfig.prefs] keys that the user is not tracking
  List<Widget> _getUntrackedColors(StateSetter setModalState) {
    final Set<String> currSet = currList.toSet();

    return fullList
        .where((String element) => !currSet.contains(element))
        .map<Widget>((String settingKey) {
      final Color liveColor = getLiveColor(context, settingKey);

      return Container(
        padding: EdgeInsets.symmetric(
          vertical: spacing / 2,
          horizontal: spacing,
        ),
        child: ElevatedButton.icon(
          key: ValueKey<String>(settingKey),
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
            child: CircleAvatar(
              backgroundColor: liveColor,
              radius: padding * sqrt(2),
              child: liveColor == Colors.transparent
                  ? Icon(PlatformIcons(context).eyeSlash)
                  : null,
            ),
          ),
          label: Text(getColorName(context, settingKey)),
          style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                padding: MaterialStateProperty.all(
                  EdgeInsets.all(padding * 0.75),
                ),
                foregroundColor: MaterialStatePropertyAll<Color?>(
                  Theme.of(context).colorScheme.onSurface,
                ),
              ),
          onPressed: () {
            setState(() {
              currList.add(settingKey);
            });
            setModalState(() {});
          },
        ),
      );
    }).toList();
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
      title: efuiS,
      body: EzScreen(
        decorationImageKey: isDark ? darkPageImageKey : lightPageImageKey,
        child: EzScrollView(
          children: <Widget>[
            // Current theme reminder
            Text(
              EFUILang.of(context)!.gEditingTheme(themeProfile),
              style: labelStyle,
              textAlign: TextAlign.center,
            ),
            separator,

            // Dynamic settings
            ..._dynamicColorSettings(),
            spacer, // This makes two, dynamicColorSettings has a trailing spacer too

            // Add a color
            TextButton.icon(
              icon: Icon(PlatformIcons(context).addCircledOutline),
              label: Text(EFUILang.of(context)!.csAddColor),
              onPressed: () async {
                // Show available color settings
                await showModalBottomSheet(
                  context: context,
                  showDragHandle: true,
                  builder: (BuildContext context) => StatefulBuilder(
                    builder: (
                      BuildContext context,
                      StateSetter setModalState,
                    ) {
                      return EzScrollView(
                        children: _getUntrackedColors(setModalState),
                      );
                    },
                  ),
                );

                // Save the user's changes (if any)
                if (currList != defaultList) {
                  final List<String> sortedList = List<String>.from(currList);
                  // Sort based on the original material order
                  sortedList.sort(
                    (String a, String b) =>
                        fullList.indexOf(a) - fullList.indexOf(b),
                  );
                  EzConfig.setStringList(userColorsKey, sortedList);
                }
              },
            ),
            separator,

            // Build from image
            ..._otherButtons,
            separator,

            // Help
            EzLink(
              EFUILang.of(context)!.gHowThisWorks,
              style: labelStyle,
              textAlign: TextAlign.center,
              url: Uri.parse(materialColorRoles),
              semanticsLabel: EFUILang.of(context)!.gHowThisWorksHint,
              tooltip: materialColorRoles,
            ),
            spacer,
          ],
        ),
      ),
    );
  }
}
