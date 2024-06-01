import '../widgets/export.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
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

  late final ThemeData theme = Theme.of(context);

  late final TextStyle? labelStyle = theme.textTheme.labelLarge;

  late final EFUILang l10n = EFUILang.of(context)!;

  // Define the shared build data //

  late final String themeProfile =
      isDark ? l10n.gDark.toLowerCase() : l10n.gLight.toLowerCase();

  static const String basicSettings = 'basic';
  static const String advancedSettings = 'advanced';

  String currentTab = basicSettings;

  late final String resetDialogTitle = l10n.csResetAll(themeProfile);

  late final Widget resetButton = EzResetButton(
    dialogTitle: resetDialogTitle,
    onConfirm: () {
      EzConfig.removeKeys(<String>{...fullList, userColorsKey});
      setState(() {
        currList = List<String>.from(defaultList);
      });
    },
  );

  // Basic controls  //

  /// Build from image button label
  late final String fromImageLabel = l10n.csSchemeBase;
  late final String fromImageHint = '${l10n.csOptional}: ${l10n.csFromImage}';

  /// Build from image button dialog title
  late final String fromImageTitle = '$themeProfile ${l10n.csColorScheme}';

  late final Widget fromImageButton = isDark
      ? Semantics(
          button: true,
          hint: fromImageHint,
          child: ExcludeSemantics(
            child: EzImageSetting(
              configKey: darkColorSchemeImageKey,
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
              configKey: lightColorSchemeImageKey,
              label: fromImageLabel,
              dialogTitle: fromImageTitle,
              allowClear: true,
              updateTheme: Brightness.light,
              hideThemeMessage: true,
            ),
          ),
        );

  // Advanced controls //

  late final List<String> defaultList = isDark
      ? <String>[
          darkPrimaryKey,
          darkSecondaryKey,
          darkTertiaryKey,
          darkSurfaceKey,
        ]
      : <String>[
          lightPrimaryKey,
          lightSecondaryKey,
          lightTertiaryKey,
          lightSurfaceKey,
        ];
  late final Set<String> defaultSet = defaultList.toSet();

  late final List<String> fullList = isDark ? darkColors : lightColors;

  late List<String> currList =
      EzConfig.get(userColorsKey) ?? List<String>.from(defaultList);

  /// Return the live [List] of [EzConfig.prefs] keys that the user is tracking
  List<Widget> dynamicColorSettings() {
    final List<Widget> toReturn = <Widget>[];

    for (final String key in currList) {
      if (defaultSet.contains(key)) {
        // Non-removable buttons
        toReturn.addAll(<Widget>[
          EzColorSetting(key: ValueKey<String>(key), configKey: key),
          spacer,
        ]);
      } else {
        toReturn.addAll(<Widget>[
          // Removable buttons
          EzColorSetting(
              key: ValueKey<String>(key),
              configKey: key,
              onRemove: () {
                setState(() {
                  currList.remove(key);
                });
                EzConfig.setStringList(userColorsKey, currList);
              }),
          spacer,
        ]);
      }
    }

    return toReturn;
  }

  /// Return the [List] of [EzConfig.prefs] keys that the user is not tracking
  List<Widget> getUntrackedColors(StateSetter setModalState) {
    final Set<String> currSet = currList.toSet();

    final List<Widget> trackers = fullList
        .where((String element) => !currSet.contains(element))
        .map<Widget>((String configKeyKey) {
      final Color liveColor = getLiveColor(context, configKeyKey);

      return Container(
        padding: EdgeInsets.symmetric(
          vertical: spacing / 2,
          horizontal: spacing,
        ),
        child: ElevatedButton.icon(
          key: ValueKey<String>(configKeyKey),
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.colorScheme.primaryContainer,
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
          label: Text(getColorName(context, configKeyKey)),
          style: theme.elevatedButtonTheme.style!.copyWith(
            padding: WidgetStateProperty.all(
              EdgeInsets.all(padding * 0.75),
            ),
            foregroundColor: WidgetStatePropertyAll<Color?>(
              theme.colorScheme.onSurface,
            ),
          ),
          onPressed: () {
            setState(() {
              currList.add(configKeyKey);
              currList.sort(
                (String a, String b) =>
                    fullList.indexOf(a) - fullList.indexOf(b),
              );
            });
            setModalState(() {});
          },
        ),
      );
    }).toList();

    return <Widget>[
      // Help
      EzLink(
        l10n.gHowThisWorks,
        style: labelStyle,
        textAlign: TextAlign.center,
        url: Uri.parse(materialColorRoles),
        semanticsLabel: l10n.gHowThisWorksHint,
        tooltip: materialColorRoles,
      ),
      ...trackers
    ];
  }

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(l10n.csPageTitle);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      body: EzScreen(
        decorationImageKey: isDark ? darkPageImageKey : lightPageImageKey,
        child: EzScrollView(
          children: <Widget>[
            // Current theme reminder
            Text(
              l10n.gEditingTheme(themeProfile),
              style: labelStyle,
              textAlign: TextAlign.center,
            ),
            spacer,

            SegmentedButton<String>(
              segments: <ButtonSegment<String>>[
                ButtonSegment<String>(
                  value: basicSettings,
                  label: Text(l10n.csBasic),
                ),
                ButtonSegment<String>(
                  value: advancedSettings,
                  label: Text(l10n.csAdvanced),
                ),
              ],
              selected: <String>{currentTab},
              showSelectedIcon: false,
              onSelectionChanged: (Set<String> selected) {
                setState(() => currentTab = selected.first);
              },
            ),
            separator,

            if (currentTab == basicSettings) ...<Widget>[
              // High contrast quick setting
              const EzHighContrastColorsSetting(),
              spacer,

              // Mono chrome quick setting
              const EzMonoChromeColorsSetting(),
              spacer,

              // From image button
              fromImageButton,
            ],

            if (currentTab == advancedSettings) ...<Widget>[
              // Dynamic configKeys
              ...dynamicColorSettings(),
              spacer, // dynamicColorSettings has a trailing spacer too

              // Add a color
              TextButton.icon(
                icon: Icon(PlatformIcons(context).addCircledOutline),
                label: Text(l10n.csAddColor),
                onPressed: () async {
                  // Show available color configKeys
                  await showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    builder: (BuildContext context) => StatefulBuilder(
                      builder: (
                        BuildContext context,
                        StateSetter setModalState,
                      ) {
                        return EzScrollView(
                          children: getUntrackedColors(setModalState),
                        );
                      },
                    ),
                  );

                  // Save the user's changes
                  if (currList != defaultList) {
                    EzConfig.setStringList(userColorsKey, currList);
                  }
                },
              ),
            ],
            separator,

            // Reset button
            resetButton,
            spacer,
          ],
        ),
      ),
    );
  }
}
