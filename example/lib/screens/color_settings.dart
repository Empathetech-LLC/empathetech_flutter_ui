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

  late final TextStyle? labelStyle = theme.textTheme.labelLarge?.copyWith(
    color: theme.colorScheme.onSurface,
  );

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
      currList = List<String>.from(defaultList);
      setState(() {});
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
              updateThemeOption: false,
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
              updateThemeOption: false,
            ),
          ),
        );

  // Advanced controls //

  late final List<String> defaultList = isDark
      ? <String>[
          darkPrimaryKey,
          darkSecondaryKey,
          darkTertiaryKey,
          darkSurfaceContainerKey,
          darkSurfaceKey,
          darkOnSurfaceKey,
        ]
      : <String>[
          lightPrimaryKey,
          lightSecondaryKey,
          lightTertiaryKey,
          lightSurfaceContainerKey,
          lightSurfaceKey,
          lightOnSurfaceKey,
        ];
  late final Set<String> defaultSet = defaultList.toSet();

  late final List<String> fullList = isDark ? darkColors : lightColors;

  late List<String> currList =
      EzConfig.get(userColorsKey) ?? List<String>.from(defaultList);

  /// Return the live [List] of [EzConfig.prefs] keys that the user is tracking
  List<Widget> dynamicColorSettings() {
    final List<Widget> toReturn = <Widget>[];

    Widget personalSpace(Widget child) {
      return Padding(
        padding: EdgeInsets.only(
          left: spacing / 2,
          right: spacing / 2,
          bottom: spacing,
        ),
        child: child,
      );
    }

    for (final String key in currList) {
      if (defaultSet.contains(key)) {
        // Non-removable buttons
        toReturn.add(
          personalSpace(EzColorSetting(
            key: ValueKey<String>(key),
            configKey: key,
          )),
        );
      } else {
        toReturn.add(
          // Removable buttons
          personalSpace(EzColorSetting(
            key: ValueKey<String>(key),
            configKey: key,
            onRemove: () {
              currList.remove(key);
              EzConfig.setStringList(userColorsKey, currList);
              setState(() {});
            },
          )),
        );
      }
    }

    return toReturn;
  }

  /// Return the [List] of [EzConfig.prefs] keys that the user is not tracking
  List<Widget> getUntrackedColors(StateSetter setModalState) {
    final Set<String> currSet = currList.toSet();

    return fullList
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
            currList.add(configKeyKey);
            currList.sort(
              (String a, String b) => fullList.indexOf(a) - fullList.indexOf(b),
            );
            setState(() {});
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
                currentTab = selected.first;
                setState(() {});
              },
            ),
            separator,

            if (currentTab == basicSettings) ...<Widget>[
              // Mono chrome quick setting
              const EzMonoChromeColorsSetting(),
              spacer,

              // From image button
              fromImageButton,
            ],

            if (currentTab == advancedSettings) ...<Widget>[
              // Dynamic configKeys
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: widthOf(context) * (2 / 3),
                ),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: dynamicColorSettings(),
                ),
              ),
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

            if (currentTab == advancedSettings) ...<Widget>[
              separator,
              EzLink(
                l10n.gHowThisWorks,
                style: labelStyle,
                textAlign: TextAlign.center,
                url: Uri.parse(materialColorRoles),
                semanticsLabel: l10n.gHowThisWorksHint,
                tooltip: materialColorRoles,
              ),
            ],

            spacer,
          ],
        ),
      ),
    );
  }
}
