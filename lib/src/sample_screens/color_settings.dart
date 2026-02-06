/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzColorSettings extends StatefulWidget {
  /// Optional starting [EzCSType] target
  final EzCSType? target;

  /// When true, updates both dark and light theme settings simultaneously
  final bool updateBoth;

  /// If provided, the "Editing: X theme" text will be a link with this callback
  final void Function()? themeLink;

  /// Spacer above the [EzResetButton], on both sub-screens
  final Widget resetSpacer;

  /// Additional [EzConfig] keys for the local [EzResetButton]
  /// [darkColorKeys] are included by default
  final Set<String>? resetExtraDark;

  /// Additional [EzConfig] keys for the local [EzResetButton]
  /// [lightColorKeys] are included by default
  final Set<String>? resetExtraLight;

  /// [EzResetButton.appName] passthrough
  final String appName;

  /// [EzResetButton.androidPackage] passthrough
  final String? androidPackage;

  /// [EzResetButton.resetSkip] passthrough
  /// Shared for both themes
  final Set<String>? resetSkip;

  /// [EzResetButton.saveSkip] passthrough
  /// Shared for both themes
  final Set<String>? saveSkip;

  /// Optional additional quick settings
  /// Will appear first, above the monochrome
  /// BYO spacers
  final List<Widget>? quickHeader;

  /// Optional additional quick settings
  /// Will appear last, just above above the [EzResetButton]
  /// BYO leading spacer, trailing is [resetSpacer]
  final List<Widget>? quickFooter;

  /// Initial set of [Brightness.dark] configKeys to display in the advanced settings
  final List<String> darkStarterSet;

  /// Initial set of [Brightness.light] configKeys to display in the advanced settings
  final List<String> lightStarterSet;

  /// Empathetech color settings
  /// Recommended to use as a [Scaffold.body]
  const EzColorSettings({
    // Shared
    super.key,
    this.target,
    required this.updateBoth,
    this.themeLink,
    this.resetSpacer = const EzSeparator(),
    this.resetExtraDark,
    this.resetExtraLight,
    required this.appName,
    this.androidPackage,
    this.resetSkip,
    this.saveSkip,

    // Quick
    this.quickHeader,
    this.quickFooter,

    // Advanced
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
  State<EzColorSettings> createState() => _EzColorSettingsState();
}

class _EzColorSettingsState extends State<EzColorSettings> {
  // Define the build data //

  late EzCSType currentTab = widget.target ??
      (EzConfig.get(advancedColorsKey) == true
          ? EzCSType.advanced
          : EzCSType.quick);

  // Set the page title //

  @override
  void initState() {
    super.initState();
    ezWindowNamer(EzConfig.l10n.csPageTitle);
  }

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final List<String> defaultList =
        EzConfig.isDark ? widget.darkStarterSet : widget.lightStarterSet;

    final String userColorsKey =
        EzConfig.isDark ? userDarkColorsKey : userLightColorsKey;
    List<String> currList =
        EzConfig.get(userColorsKey) ?? List<String>.from(defaultList);

    final String resetString = (widget.updateBoth
            ? EzConfig.l10n.gBoth
            : (EzConfig.isDark ? EzConfig.l10n.gDark : EzConfig.l10n.gLight))
        .toLowerCase();

    // Return the build //

    return EzScrollView(
      children: <Widget>[
        // Current theme reminder
        (widget.themeLink != null)
            ? EzLink(
                EzConfig.l10n.gEditingTheme(
                    resetString), // TODO: efficient plural and better fab dialog
                onTap: widget.themeLink,
                hint: EzConfig.l10n.gEditingThemeHint,
                style: EzConfig.styles.labelLarge,
                textAlign: TextAlign.center,
              )
            : EzText(
                EzConfig.l10n.gEditingTheme(resetString),
                style: EzConfig.styles.labelLarge,
                textAlign: TextAlign.center,
              ),
        EzConfig.margin,

        // Mode switch
        SegmentedButton<EzCSType>(
          segments: <ButtonSegment<EzCSType>>[
            ButtonSegment<EzCSType>(
              value: EzCSType.quick,
              label: Text(EzConfig.l10n.gQuick),
            ),
            ButtonSegment<EzCSType>(
              value: EzCSType.advanced,
              label: Text(EzConfig.l10n.gAdvanced),
            ),
          ],
          selected: <EzCSType>{currentTab},
          showSelectedIcon: false,
          onSelectionChanged: (Set<EzCSType> selected) async {
            switch (selected.first) {
              case EzCSType.quick:
                currentTab = EzCSType.quick;
                await EzConfig.setBool(advancedColorsKey, false);
                break;
              case EzCSType.advanced:
                currentTab = EzCSType.advanced;
                await EzConfig.setBool(advancedColorsKey, true);
                break;
            }
            setState(() {});
          },
        ),
        EzConfig.separator,

        // Core settings
        if (currentTab == EzCSType.quick)
          _QuickColorSettings(
            widget.updateBoth,
            quickHeader: widget.quickHeader,
            quickFooter: widget.quickFooter,
          )
        else
          _AdvancedColorSettings(
            defaultList: defaultList,
            currList: currList,
          ),

        // Reset button
        widget.resetSpacer,
        EzResetButton(
          () => setState(() {}),
          androidPackage: widget.androidPackage,
          appName: widget.appName,
          dialogTitle: EzConfig.l10n.csResetAll(resetString),
          resetBoth: widget.updateBoth,
          resetSkip: widget.resetSkip,
          onConfirm: () async {
            if (widget.updateBoth) {
              await EzConfig.removeKeys(allColorKeys.keys.toSet());
              if (widget.resetExtraDark != null) {
                await EzConfig.removeKeys(widget.resetExtraDark!);
              }
              if (widget.resetExtraLight != null) {
                await EzConfig.removeKeys(widget.resetExtraLight!);
              }
            } else {
              if (EzConfig.isDark) {
                await EzConfig.removeKeys(darkColorKeys.keys.toSet());
                if (widget.resetExtraDark != null) {
                  await EzConfig.removeKeys(widget.resetExtraDark!);
                }
              } else {
                await EzConfig.removeKeys(lightColorKeys.keys.toSet());
                if (widget.resetExtraLight != null) {
                  await EzConfig.removeKeys(widget.resetExtraLight!);
                }
              }
            }
            setState(() => currList = List<String>.from(defaultList));
          },
        ),
        EzConfig.separator,
      ],
    );
  }
}

class _QuickColorSettings extends StatefulWidget {
  final bool updateBoth;
  final List<Widget>? quickHeader;
  final List<Widget>? quickFooter;

  const _QuickColorSettings(
    this.updateBoth, {
    required this.quickHeader,
    required this.quickFooter,
  });

  @override
  State<_QuickColorSettings> createState() => _QuickColorSettingsState();
}

class _QuickColorSettingsState extends State<_QuickColorSettings> {
  void redraw() => setState(() {});

  @override
  Widget build(BuildContext context) => EzScrollView(
        scrollDirection: Axis.horizontal,
        startCentered: true,
        mainAxisSize: MainAxisSize.min,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (widget.quickHeader != null) ...widget.quickHeader!,

            // MonoChrome
            EzMonoChromeColorsSetting(redraw, both: widget.updateBoth),
            EzConfig.spacer,

            // From image
            Semantics(
              label: EzConfig.l10n.csSchemeBase.replaceAll('\n', ' '),
              value: EzConfig.l10n.gOptional,
              button: true,
              hint: EzConfig.l10n.csFromImage,
              child: ExcludeSemantics(
                child: EzImageSetting(
                  redraw,
                  configKey: EzConfig.isDark
                      ? darkColorSchemeImageKey
                      : lightColorSchemeImageKey,
                  label: EzConfig.l10n.csSchemeBase,
                  allowThemeUpdate: true,
                  updateBrightness: widget.updateBoth
                      ? null
                      : (EzConfig.isDark ? Brightness.dark : Brightness.light),
                  showEditor: false,
                  showFitOption: false,
                ),
              ),
            ),

            // Additional settings
            if (widget.quickFooter != null) ...widget.quickFooter!,
          ],
        ),
      );
}

class _AdvancedColorSettings extends StatefulWidget {
  final List<String> defaultList;
  final List<String> currList;

  const _AdvancedColorSettings({
    required this.defaultList,
    required this.currList,
  });

  @override
  State<_AdvancedColorSettings> createState() => _AdvancedColorSettingsState();
}

class _AdvancedColorSettingsState extends State<_AdvancedColorSettings> {
  // Define the build data //

  late final List<String> currList = widget.currList;
  late final Set<String> defaultSet = widget.defaultList.toSet();

  // Define custom Widgets //

  /// Returns the color keys the user is tracking
  List<Widget> dynamicColorSettings(String userColorsKey) {
    final List<Widget> toReturn = <Widget>[];
    final EdgeInsets wrapPadding = EzInsets.wrap(EzConfig.spacing);

    for (final String key in currList) {
      if (defaultSet.contains(key)) {
        // Non-removable buttons
        toReturn.add(
          Padding(
            padding: wrapPadding,
            child: (EzColorSetting(key: ValueKey<String>(key), configKey: key)),
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

  /// Returns the color keys the user is NOT tracking
  List<Widget> getUntrackedColors(StateSetter setModalState) {
    final Set<String> currSet = currList.toSet();
    final List<String> fullList =
        EzConfig.isDark ? darkColorOrder : lightColorOrder;

    return fullList
        .where((String element) => !currSet.contains(element))
        .map<Widget>((String configKey) {
      final Color liveColor = getLiveColor(configKey);

      return Padding(
        padding: EzInsets.wrap(EzConfig.spacing),
        child: EzElevatedIconButton(
          key: ValueKey<String>(configKey),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(EzConfig.padding * 0.75),
          ),
          onPressed: () {
            final int newColorIndex = fullList.indexOf(configKey);

            int insertAt = currList.length;
            for (int i = 0; i < currList.length; i++) {
              if (fullList.indexOf(currList[i]) > newColorIndex) {
                insertAt = i;
                break;
              }
            }
            currList.insert(insertAt, configKey);

            setState(() {});
            setModalState(() {});
          },
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: EzConfig.colors.primaryContainer),
            ),
            child: CircleAvatar(
              backgroundColor: liveColor,
              radius: EzConfig.padding + EzConfig.marginVal,
              child: liveColor == Colors.transparent
                  ? EzIcon(Icons.visibility_off)
                  : null,
            ),
          ),
          label: getColorName(configKey),
        ),
      );
    }).toList();
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final String userColorsKey =
        EzConfig.isDark ? userDarkColorsKey : userLightColorsKey;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Dynamic color settings
        EzSwapWidget(
          expanded: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: widthOf(context) * 0.75),
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: dynamicColorSettings(userColorsKey),
            ),
          ),
          restricted: EzScrollView(
            scrollDirection: Axis.horizontal,
            startCentered: true,
            mainAxisSize: MainAxisSize.min,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: dynamicColorSettings(userColorsKey),
            ),
          ),
        ),
        EzConfig.separator,

        // Add a color button
        EzTextIconButton(
          onPressed: () async {
            // Show modal
            await ezModal(
              context: context,
              builder: (_) => StatefulBuilder(
                builder: (_, StateSetter setModalState) => EzScrollView(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Tutorial link
                    EzLink(
                      EzConfig.l10n.gHowThisWorks,
                      style: EzConfig.styles.labelLarge!,
                      textAlign: TextAlign.center,
                      url: Uri.parse(
                          'https://m3.material.io/styles/color/roles'),
                      hint: EzConfig.l10n.gHowThisWorksHint,
                      tooltip: 'https://m3.material.io/styles/color/roles',
                    ),

                    // Color options
                    Wrap(
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: getUntrackedColors(setModalState),
                    ),
                    EzConfig.spacer,
                  ],
                ),
              ),
            );

            // Save changes
            await EzConfig.setStringList(userColorsKey, currList);
          },
          style:
              TextButton.styleFrom(padding: EzInsets.wrap(EzConfig.marginVal)),
          icon: const Icon(Icons.add_circle_outline),
          label: EzConfig.l10n.csAddColor,
        ),
      ],
    );
  }
}
