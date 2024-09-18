/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ColorSettings extends StatefulWidget {
  /// For [EzScreen.useImageDecoration]
  final bool useImageDecoration;

  /// Initial set of color configKeys to display in the advanced settings (light theme)
  final List<String> lightStarterSet;

  /// Initial set of color configKeys to display in the advanced settings (dark theme)
  final List<String> darkStarterSet;

  const ColorSettings({
    super.key,
    this.useImageDecoration = true,
    this.darkStarterSet = const <String>[
      darkPrimaryKey,
      darkSecondaryKey,
      darkTertiaryKey,
      darkSurfaceContainerKey,
      darkSurfaceKey,
      darkOnSurfaceKey,
    ],
    this.lightStarterSet = const <String>[
      lightPrimaryKey,
      lightSecondaryKey,
      lightTertiaryKey,
      lightSurfaceContainerKey,
      lightSurfaceKey,
      lightOnSurfaceKey,
    ],
  });

  @override
  State<ColorSettings> createState() => _ColorSettingsState();
}

class _ColorSettingsState extends State<ColorSettings> {
  // Gather the theme data //

  late bool isDark = PlatformTheme.of(context)?.isDark ??
      (MediaQuery.of(context).platformBrightness == Brightness.dark);

  static const EzSpacer spacer = EzSpacer();
  static const EzSeparator separator = EzSeparator();

  late final EFUILang l10n = EFUILang.of(context)!;
  late final ThemeData theme = Theme.of(context);

  // Define the build data //

  // Quick
  static const String quick = 'quick';

  // Advanced
  static const String advanced = 'advanced';

  late final List<String> defaultList =
      isDark ? widget.darkStarterSet : widget.lightStarterSet;

  late List<String> currList =
      EzConfig.get(userColorsKey) ?? List<String>.from(defaultList);

  late final List<String> fullList = isDark ? darkColors : lightColors;

  // Shared
  late final String themeProfile =
      isDark ? l10n.gDark.toLowerCase() : l10n.gLight.toLowerCase();

  String currentTab = quick;

  late final String resetDialogTitle = l10n.csResetAll(themeProfile);

  late final Widget resetButton = EzResetButton(
    dialogTitle: resetDialogTitle,
    onConfirm: () async {
      await EzConfig.removeKeys(<String>{
        ...fullList,
        userColorsKey,
        darkColorSchemeImageKey,
        lightColorSchemeImageKey,
      });

      setState(() => currList = List<String>.from(defaultList));
    },
  );

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(l10n.csPageTitle);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return EzScreen(
      useImageDecoration: widget.useImageDecoration,
      child: EzScrollView(
        children: <Widget>[
          // Current theme reminder
          Text(
            l10n.gEditingTheme(themeProfile),
            style: theme.textTheme.labelLarge,
            textAlign: TextAlign.center,
          ),
          spacer,

          // Mode switch
          SegmentedButton<String>(
            segments: <ButtonSegment<String>>[
              ButtonSegment<String>(
                value: quick,
                label: Text(l10n.gQuick),
              ),
              ButtonSegment<String>(
                value: advanced,
                label: Text(l10n.gAdvanced),
              ),
            ],
            selected: <String>{currentTab},
            showSelectedIcon: false,
            onSelectionChanged: (Set<String> selected) =>
                setState(() => currentTab = selected.first),
          ),
          separator,

          // Core settings
          if (currentTab == quick)
            _QuickColorSettings(
              l10n: l10n,
              isDark: isDark,
              themeProfile: themeProfile,
            )
          else
            _AdvancedColorSettings(
              key: UniqueKey(),
              defaultList: defaultList,
              currList: currList,
              fullList: fullList,
              theme: theme,
              l10n: l10n,
            ),
          separator,

          // Reset button
          resetButton,
          spacer,
        ],
      ),
    );
  }
}

class _QuickColorSettings extends StatefulWidget {
  final EFUILang l10n;
  final bool isDark;
  final String themeProfile;

  const _QuickColorSettings({
    required this.l10n,
    required this.isDark,
    required this.themeProfile,
  });

  @override
  State<_QuickColorSettings> createState() => _QuickColorSettingsState();
}

class _QuickColorSettingsState extends State<_QuickColorSettings> {
  // Make pointers //

  late final EFUILang l10n = widget.l10n;
  late bool isDark = widget.isDark;
  late final String themeProfile = widget.themeProfile;

  // Gather the theme data //

  static const EzSpacer spacer = EzSpacer();

  // Define custom widgets  //

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
              updateTheme: Brightness.light,
              updateThemeOption: false,
            ),
          ),
        );

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return EzScrollView(
      scrollDirection: Axis.horizontal,
      startCentered: true,
      mainAxisSize: MainAxisSize.min,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const EzMonoChromeColorsSetting(),
          spacer,
          fromImageButton
        ],
      ),
    );
  }
}

class _AdvancedColorSettings extends StatefulWidget {
  final List<String> defaultList;
  final List<String> currList;
  final List<String> fullList;
  final ThemeData theme;
  final EFUILang l10n;

  const _AdvancedColorSettings({
    super.key,
    required this.defaultList,
    required this.currList,
    required this.fullList,
    required this.theme,
    required this.l10n,
  });

  @override
  State<_AdvancedColorSettings> createState() => _AdvancedColorSettingsState();
}

class _AdvancedColorSettingsState extends State<_AdvancedColorSettings> {
  // Make pointers //

  late final List<String> defaultList = widget.defaultList;
  late final List<String> currList = widget.currList;
  late final List<String> fullList = widget.fullList;
  late final ThemeData theme = widget.theme;
  late final EFUILang l10n = widget.l10n;

  // Gather the theme data //

  final double padding = EzConfig.get(paddingKey);
  final double spacing = EzConfig.get(spacingKey);

  static const EzSpacer spacer = EzSpacer();

  // Define custom Widgets //

  late final Set<String> defaultSet = defaultList.toSet();

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
            onRemove: () async {
              currList.remove(key);
              await EzConfig.setStringList(userColorsKey, currList);
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

    final List<Widget> untrackedColors = fullList
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

    untrackedColors.insert(
      0,
      EzLink(
        l10n.gHowThisWorks,
        style: theme.textTheme.labelLarge,
        textAlign: TextAlign.center,
        url: Uri.parse(materialColorRoles),
        semanticsLabel: l10n.gHowThisWorksHint,
        tooltip: materialColorRoles,
      ),
    );

    return untrackedColors;
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Dynamic color settings
        EzSwapWidget(
          large: ConstrainedBox(
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
          small: EzScrollView(
            scrollDirection: Axis.horizontal,
            startCentered: true,
            mainAxisSize: MainAxisSize.min,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: dynamicColorSettings(),
            ),
          ),
        ),
        spacer,

        // Add a color button
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
                    scrollDirection: Axis.horizontal,
                    startCentered: true,
                    mainAxisSize: MainAxisSize.min,
                    child: EzScrollView(
                      mainAxisSize: MainAxisSize.min,
                      children: getUntrackedColors(setModalState),
                    ),
                  );
                },
              ),
            );

            // Save the user's changes
            if (currList != defaultList) {
              await EzConfig.setStringList(userColorsKey, currList);
            }
          },
        ),
      ],
    );
  }
}
