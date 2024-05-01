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

  // Define the static page content //

  late final String themeProfile =
      isDark ? l10n.gDark.toLowerCase() : l10n.gLight.toLowerCase();

  /// Build from image button label
  late final String fromImageLabel = l10n.csSchemeBase;
  late final String fromImageHint = '${l10n.csOptional}: ${l10n.csFromImage}';

  /// Build from image button dialog title
  late final String fromImageTitle = '$themeProfile ${l10n.csColorScheme}';

  late final String resetDialogTitle = l10n.csResetAll(themeProfile);

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
  late final List<Widget> otherButtons = <Widget>[
    isDark
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
      },
    ),
  ];

  // Define the dynamic page content //

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
            padding: MaterialStateProperty.all(
              EdgeInsets.all(padding * 0.75),
            ),
            foregroundColor: MaterialStatePropertyAll<Color?>(
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
            separator,

            // Dynamic configKeys
            ...dynamicColorSettings(),
            spacer, // This makes two, dynamicColorSettings has a trailing spacer too

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
            separator,

            // Build from image
            ...otherButtons,
            spacer,
          ],
        ),
      ),
    );
  }
}
