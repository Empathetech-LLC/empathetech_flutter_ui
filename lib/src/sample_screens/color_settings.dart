/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ColorSettings extends StatefulWidget {
  /// For [EzScreen.useImageDecoration]
  final bool useImageDecoration;

  /// Optional addition quick settings
  final List<Widget>? additionalQuickSettings;

  /// Initial set of color configKeys to display in the advanced settings (light theme)
  final List<String> lightStarterSet;

  /// Initial set of color configKeys to display in the advanced settings (dark theme)
  final List<String> darkStarterSet;

  const ColorSettings({
    super.key,
    this.useImageDecoration = true,
    this.additionalQuickSettings,
    this.darkStarterSet = const <String>[
      darkPrimaryKey,
      darkSecondaryKey,
      darkTertiaryKey,
      darkSurfaceKey,
      darkOnSurfaceKey,
      darkSurfaceContainerKey,
      darkSurfaceTintKey,
    ],
    this.lightStarterSet = const <String>[
      lightPrimaryKey,
      lightSecondaryKey,
      lightTertiaryKey,
      lightSurfaceKey,
      lightOnSurfaceKey,
      lightSurfaceContainerKey,
      lightSurfaceTintKey,
    ],
  });

  @override
  State<ColorSettings> createState() => _ColorSettingsState();
}

class _ColorSettingsState extends State<ColorSettings> {
  // Gather the theme data //

  static const EzSeparator separator = EzSeparator();

  late final ThemeData theme = Theme.of(context);
  late bool isDark = isDarkTheme(context);
  late final EFUILang l10n = EFUILang.of(context)!;

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
    setPageTitle(l10n.csPageTitle, theme.colorScheme.primary);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return EzScreen(
      useImageDecoration: widget.useImageDecoration,
      child: EzScrollView(
        children: <Widget>[
          // Current theme reminder
          EzTextBackground(
            Text(
              l10n.gEditingTheme(themeProfile),
              style: theme.textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
          ),
          EzSpacer(space: EzConfig.get(marginKey)),

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
              additionalSettings: widget.additionalQuickSettings,
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
          separator,
        ],
      ),
    );
  }
}

class _QuickColorSettings extends StatefulWidget {
  final EFUILang l10n;
  final bool isDark;
  final String themeProfile;
  final List<Widget>? additionalSettings;

  const _QuickColorSettings({
    required this.l10n,
    required this.isDark,
    required this.themeProfile,
    required this.additionalSettings,
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
  late final String titleLabel = '$themeProfile ${l10n.csColorScheme}';

  late final Widget fromImageButton = isDark
      ? Semantics(
          button: true,
          hint: fromImageHint,
          child: ExcludeSemantics(
            child: EzImageSetting(
              configKey: darkColorSchemeImageKey,
              label: fromImageLabel,
              dialogTitleLabel: titleLabel,
              updateTheme: Brightness.dark,
              updateThemeOption: false,
              showFitOption: false,
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
              dialogTitleLabel: titleLabel,
              updateTheme: Brightness.light,
              updateThemeOption: false,
              showFitOption: false,
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
          // MonoChrome
          const EzMonoChromeColorsSetting(),
          spacer,

          // From image
          fromImageButton,

          // Additional settings
          if (widget.additionalSettings != null) ...<Widget>[
            spacer,
            ...widget.additionalSettings!,
          ],
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

  final double margin = EzConfig.get(marginKey);
  final double padding = EzConfig.get(paddingKey);

  late final EdgeInsets wrapPadding = EzInsets.wrap(padding);

  // Define custom Widgets //

  late final Set<String> defaultSet = defaultList.toSet();

  /// Return the live [List] of [EzConfig.prefs] keys that the user is tracking
  List<Widget> dynamicColorSettings() {
    final List<Widget> toReturn = <Widget>[];

    for (final String key in currList) {
      if (defaultSet.contains(key)) {
        // Non-removable buttons
        toReturn.add(
          Padding(
            padding: wrapPadding,
            child: (EzColorSetting(
              key: ValueKey<String>(key),
              configKey: key,
            )),
          ),
        );
      } else {
        toReturn.add(
          // Removable buttons
          Padding(
            padding: wrapPadding,
            child: (EzColorSetting(
              key: ValueKey<String>(key),
              configKey: key,
              onRemove: () async {
                currList.remove(key);
                await EzConfig.setStringList(userColorsKey, currList);
                setState(() {});
              },
            )),
          ),
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
        .map<Widget>((String configKey) {
      final Color liveColor = getLiveColor(context, configKey);

      return Container(
        padding: EzInsets.col(padding),
        child: EzElevatedIconButton(
          key: ValueKey<String>(configKey),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(padding * 0.75),
          ),
          onPressed: () {
            currList.add(configKey);
            currList.sort(
              (String a, String b) => fullList.indexOf(a) - fullList.indexOf(b),
            );
            setState(() {});
            setModalState(() {});
          },
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: theme.colorScheme.primaryContainer),
            ),
            child: CircleAvatar(
              backgroundColor: liveColor,
              radius: padding + margin,
              child: liveColor == Colors.transparent
                  ? EzIcon(PlatformIcons(context).eyeSlash)
                  : null,
            ),
          ),
          label: getColorName(configKey),
        ),
      );
    }).toList();

    untrackedColors.insert(
      0,
      EzLink(
        l10n.gHowThisWorks,
        style: theme.textTheme.labelLarge!,
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
              maxWidth: widthOf(context) * 0.667,
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
        const EzSeparator(),

        // Add a color button
        EzTextIconButton(
          onPressed: () async {
            // Show available color configKeys
            await showModalBottomSheet(
              context: context,
              builder: (_) => StatefulBuilder(
                builder: (_, StateSetter setModalState) {
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
          icon: EzIcon(PlatformIcons(context).addCircledOutline),
          label: l10n.csAddColor,
        ),
      ],
    );
  }
}
