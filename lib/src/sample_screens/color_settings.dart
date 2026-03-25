/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzColorSettings extends StatefulWidget {
  /// Optional starting target
  final bool? advanced;

  /// [EzConfig.rebuildUI]/[EzConfig.redrawUI] passthrough
  final void Function() onUpdate;

  /// Spacer above the [EzResetButton], on both sub-screens
  final Widget resetSpacer;

  /// [EzResetButton.appName] passthrough
  final String appName;

  /// [EzResetButton.androidPackage] passthrough
  final String? androidPackage;

  /// Additional [EzConfig] keys for the local [EzResetButton]
  /// [darkColorKeys] are included by default
  final Set<String>? resetExtraDark;

  /// Additional [EzConfig] keys for the local [EzResetButton]
  /// [lightColorKeys] are included by default
  final Set<String>? resetExtraLight;

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
    this.advanced,
    required this.onUpdate,
    this.resetSpacer = const EzSeparator(),
    required this.appName,
    this.androidPackage,
    this.resetExtraDark,
    this.resetExtraLight,
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

  late EzCSType currentTab = (widget.advanced == null)
      ? (EzConfig.get(advancedColorsKey) == true
          ? EzCSType.advanced
          : EzCSType.quick)
      : (widget.advanced! ? EzCSType.advanced : EzCSType.quick);

  // Set the page title //

  @override
  void initState() {
    super.initState();
    ezWindowNamer(EzConfig.l10n.csPageTitle);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final String userColorsKey =
        EzConfig.isDark ? userDarkColorsKey : userLightColorsKey;
    final List<String> defaultList =
        EzConfig.isDark ? widget.darkStarterSet : widget.lightStarterSet;

    return EzScrollView(mainAxisSize: MainAxisSize.min, children: <Widget>[
      EzConfig.margin,

      // Mode selector(s)
      EzScrollView(
        scrollDirection: Axis.horizontal,
        mainAxisSize: MainAxisSize.min,
        reverseHands: true,
        showScrollHint: true,
        children: <Widget>[
          // Quick/Advanced selector
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

          // Update both toggle
          if (currentTab == EzCSType.quick) ...<Widget>[
            EzConfig.rowMargin,
            const EzThemeCoin(),
          ],
        ],
      ),
      EzDivider(height: EzConfig.spacing),
      EzConfig.spacer,

      // Core settings
      (currentTab == EzCSType.quick)
          ? _QuickColorSettings(
              onUpdate: widget.onUpdate,
              quickHeader: widget.quickHeader,
              quickFooter: widget.quickFooter,
              resetSpacer: widget.resetSpacer,
              appName: widget.appName,
              androidPackage: widget.androidPackage,
              resetExtraDark: widget.resetExtraDark,
              resetExtraLight: widget.resetExtraLight,
              resetSkip: widget.resetSkip,
              saveSkip: widget.saveSkip,
            )
          : _AdvancedColorSettings(
              onUpdate: widget.onUpdate,
              userColorsKey: userColorsKey,
              defaultList: defaultList,
              currList:
                  EzConfig.get(userColorsKey) ?? List<String>.from(defaultList),
              resetSpacer: widget.resetSpacer,
              appName: widget.appName,
              androidPackage: widget.androidPackage,
              resetExtraDark: widget.resetExtraDark,
              resetExtraLight: widget.resetExtraLight,
              resetSkip: widget.resetSkip,
              saveSkip: widget.saveSkip,
            ),
    ]);
  }
}

class _QuickColorSettings extends StatefulWidget {
  final void Function() onUpdate;
  final List<Widget>? quickHeader;
  final List<Widget>? quickFooter;
  final Widget resetSpacer;
  final String appName;
  final String? androidPackage;
  final Set<String>? resetExtraDark;
  final Set<String>? resetExtraLight;
  final Set<String>? resetSkip;
  final Set<String>? saveSkip;

  const _QuickColorSettings({
    required this.onUpdate,
    required this.quickHeader,
    required this.quickFooter,
    required this.resetSpacer,
    required this.appName,
    required this.androidPackage,
    required this.resetExtraDark,
    required this.resetExtraLight,
    required this.resetSkip,
    required this.saveSkip,
  });

  @override
  State<_QuickColorSettings> createState() => _QuickColorSettingsState();
}

class _QuickColorSettingsState extends State<_QuickColorSettings> {
  void redraw() {
    widget.onUpdate();
    setState(() {});
  }

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
            EzMonoChromeColorsSetting(redraw),
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
                  updateBrightness: EzConfig.updateBoth
                      ? null
                      : (EzConfig.isDark ? Brightness.dark : Brightness.light),
                  showEditor: false,
                  showFitOption: false,
                ),
              ),
            ),

            // Additional settings
            if (widget.quickFooter != null) ...widget.quickFooter!,

            // Local reset
            widget.resetSpacer,
            EzResetButton(
              all: false,
              widget.onUpdate,
              androidPackage: widget.androidPackage,
              appName: widget.appName,
              dynamicTitle: () => EzConfig.l10n.csReset(ezThemeString(true)),
              resetSkip: widget.resetSkip,
              onConfirm: () async {
                if (EzConfig.updateBoth) {
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
              },
            ),
            EzConfig.separator,
          ],
        ),
      );
}

class _AdvancedColorSettings extends StatefulWidget {
  final void Function() onUpdate;
  final String userColorsKey;
  final List<String> currList;
  final List<String> defaultList;
  final Widget resetSpacer;
  final String appName;
  final String? androidPackage;
  final Set<String>? resetExtraDark;
  final Set<String>? resetExtraLight;
  final Set<String>? resetSkip;
  final Set<String>? saveSkip;

  const _AdvancedColorSettings({
    required this.onUpdate,
    required this.userColorsKey,
    required this.currList,
    required this.defaultList,
    required this.resetSpacer,
    required this.appName,
    required this.androidPackage,
    required this.resetExtraDark,
    required this.resetExtraLight,
    required this.resetSkip,
    required this.saveSkip,
  });

  @override
  State<_AdvancedColorSettings> createState() => _AdvancedColorSettingsState();
}

class _AdvancedColorSettingsState extends State<_AdvancedColorSettings> {
  // Define custom functions //

  void redraw() {
    widget.onUpdate();
    setState(() {});
  }

  // Define custom Widgets //

  /// Returns the color keys the user is tracking
  List<Widget> dynamicColorSettings(String userColorsKey) {
    final EdgeInsets wrapPadding = EzInsets.wrap(EzConfig.spacing);
    final List<Widget> toReturn = <Widget>[];

    final Set<String> defaultSet = widget.defaultList.toSet();
    for (final String key in widget.currList) {
      if (defaultSet.contains(key)) {
        // Non-removable buttons
        toReturn.add(
          Padding(
            padding: wrapPadding,
            child: (EzColorSetting(
              key: ValueKey<String>(key),
              configKey: key,
              onUpdate: redraw,
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
              onUpdate: redraw,
              onRemove: () async {
                widget.currList.remove(key);
                await EzConfig.setStringList(userColorsKey, widget.currList);
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
    final Set<String> currSet = widget.currList.toSet();
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

            int insertAt = widget.currList.length;
            for (int i = 0; i < widget.currList.length; i++) {
              if (fullList.indexOf(widget.currList[i]) > newColorIndex) {
                insertAt = i;
                break;
              }
            }
            widget.currList.insert(insertAt, configKey);

            setState(() {});
            setModalState(() {});
          },
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: EzConfig.colors.primaryContainer,
                width: EzConfig.borderWidth,
              ),
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
              children: dynamicColorSettings(widget.userColorsKey),
            ),
          ),
          restricted: EzScrollView(
            scrollDirection: Axis.horizontal,
            startCentered: true,
            mainAxisSize: MainAxisSize.min,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: dynamicColorSettings(widget.userColorsKey),
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
            await EzConfig.setStringList(widget.userColorsKey, widget.currList);
          },
          style:
              TextButton.styleFrom(padding: EzInsets.wrap(EzConfig.marginVal)),
          icon: const Icon(Icons.add_circle_outline),
          label: EzConfig.l10n.csAddColor,
        ),

        // Local reset
        widget.resetSpacer,
        EzResetButton(
          all: false,
          widget.onUpdate,
          androidPackage: widget.androidPackage,
          appName: widget.appName,
          dynamicTitle: () => EzConfig.l10n.csReset(ezThemeString(false)),
          resetSkip: widget.resetSkip,
          onConfirm: () async {
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
          },
        ),
        EzConfig.separator,
      ],
    );
  }
}
