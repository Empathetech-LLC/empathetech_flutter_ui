/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzColorSettings extends StatefulWidget {
  /// Optional starting [EzCSType] target
  final EzCSType? target;

  /// Spacer above the [EzResetButton], on both sub-screens
  final Widget resetSpacer;

  /// Additional [EzConfig] keys for the local [EzResetButton]
  /// [darkColorKeys]/[lightColorKeys] are included by default (and current mode aware)
  final Set<String>? resetKeys;

  /// Optional additional quick settings
  /// Will appear first, above the monochrome setting
  /// See [headerSpacer] for layout tuning
  final List<Widget>? quickHeader;

  /// Spacer between the [quickHeader] and the main settings
  /// Only drawn if [quickHeader] is no null
  final Widget headerSpacer;

  /// Spacer above the [quickFooter], if present
  final Widget footerSpacer;

  /// Optional additional quick settings
  /// Will appear last, below the main settings (above the [EzResetButton])
  /// See [footerSpacer] for layout tuning
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
    this.resetSpacer = const EzSeparator(),
    this.resetKeys,

    // Quick
    this.quickHeader,
    this.headerSpacer = const EzSeparator(),
    this.footerSpacer = const EzSeparator(),
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
  // Gather the fixed theme data //

  static const EzSeparator separator = EzSeparator();

  late final EFUILang l10n = ezL10n(context);

  // Define the build data //

  late EzCSType currentTab = widget.target ??
      (EzConfig.get(advancedColorsKey) == true
          ? EzCSType.advanced
          : EzCSType.quick);

  late final String darkString = l10n.gDark.toLowerCase();
  late final String lightString = l10n.gLight.toLowerCase();

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ezWindowNamer(context, l10n.csPageTitle);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    // Gather the dynamic theme data //

    final bool isDark = isDarkTheme(context);

    // Return the build //

    final List<String> defaultList =
        isDark ? widget.darkStarterSet : widget.lightStarterSet;

    final String userColorsKey =
        isDark ? userDarkColorsKey : userLightColorsKey;
    List<String> currList =
        EzConfig.get(userColorsKey) ?? List<String>.from(defaultList);

    return EzScrollView(
      children: <Widget>[
        // Current theme reminder
        EzText(
          l10n.gEditingTheme(isDark ? darkString : lightString),
          style: Theme.of(context).textTheme.labelLarge,
          textAlign: TextAlign.center,
        ),
        EzMargin(),

        // Mode switch
        SegmentedButton<EzCSType>(
          segments: <ButtonSegment<EzCSType>>[
            ButtonSegment<EzCSType>(
              value: EzCSType.quick,
              label: Text(l10n.gQuick),
            ),
            ButtonSegment<EzCSType>(
              value: EzCSType.advanced,
              label: Text(l10n.gAdvanced),
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
        separator,

        // Core settings
        if (currentTab == EzCSType.quick)
          _QuickColorSettings(
            l10n: l10n,
            quickHeader: widget.quickHeader,
            headerSpacer: widget.headerSpacer,
            footerSpacer: widget.footerSpacer,
            quickFooter: widget.quickFooter,
          )
        else
          _AdvancedColorSettings(
            key: UniqueKey(),
            l10n: l10n,
            defaultList: defaultList,
            currList: currList,
          ),

        // Reset button
        widget.resetSpacer,
        isDark
            ? EzResetButton(
                dialogTitle: l10n.csResetAll(darkString),
                onConfirm: () async {
                  await EzConfig.removeKeys(<String>{
                    ...darkColorKeys,
                    userDarkColorsKey,
                    darkColorSchemeImageKey,
                  });

                  if (widget.resetKeys != null) {
                    await EzConfig.removeKeys(widget.resetKeys!);
                  }

                  setState(() => currList = List<String>.from(defaultList));
                },
              )
            : EzResetButton(
                dialogTitle: l10n.csResetAll(lightString),
                onConfirm: () async {
                  await EzConfig.removeKeys(<String>{
                    ...lightColorKeys,
                    userLightColorsKey,
                    lightColorSchemeImageKey,
                  });

                  if (widget.resetKeys != null) {
                    await EzConfig.removeKeys(widget.resetKeys!);
                  }

                  setState(() => currList = List<String>.from(defaultList));
                },
              ),
        separator,
      ],
    );
  }
}

class _QuickColorSettings extends StatefulWidget {
  final EFUILang l10n;
  final List<Widget>? quickHeader;
  final Widget headerSpacer;
  final Widget footerSpacer;
  final List<Widget>? quickFooter;

  const _QuickColorSettings({
    required this.l10n,
    required this.quickHeader,
    required this.headerSpacer,
    required this.footerSpacer,
    required this.quickFooter,
  });

  @override
  State<_QuickColorSettings> createState() => _QuickColorSettingsState();
}

class _QuickColorSettingsState extends State<_QuickColorSettings> {
  // Gather the fixed theme data //

  static const EzSpacer spacer = EzSpacer();

  // Define custom widgets  //

  late final String fromImageLabel = widget.l10n.csSchemeBase;
  late final String fromImageHint = widget.l10n.csFromImage;

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final bool isDark = isDarkTheme(context);
    final Brightness brightness = isDark ? Brightness.dark : Brightness.light;

    final String fromImageKey =
        isDark ? darkColorSchemeImageKey : lightColorSchemeImageKey;

    return EzScrollView(
      scrollDirection: Axis.horizontal,
      startCentered: true,
      mainAxisSize: MainAxisSize.min,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (widget.quickHeader != null) ...<Widget>[
            ...widget.quickHeader!,
            widget.headerSpacer,
          ],

          // MonoChrome
          const EzMonoChromeColorsSetting(),
          spacer,

          // From image
          Semantics(
            label: fromImageLabel.replaceAll('\n', ' '),
            value: widget.l10n.gOptional,
            button: true,
            hint: fromImageHint,
            child: ExcludeSemantics(
              child: EzImageSetting(
                key: UniqueKey(),
                configKey: fromImageKey,
                label: fromImageLabel,
                updateTheme: brightness,
                updateThemeOption: false,
                showFitOption: false,
              ),
            ),
          ),

          // Additional settings
          if (widget.quickFooter != null) ...<Widget>[
            widget.footerSpacer,
            ...widget.quickFooter!,
          ],
        ],
      ),
    );
  }
}

class _AdvancedColorSettings extends StatefulWidget {
  final EFUILang l10n;
  final List<String> defaultList;
  final List<String> currList;

  const _AdvancedColorSettings({
    super.key,
    required this.l10n,
    required this.defaultList,
    required this.currList,
  });

  @override
  State<_AdvancedColorSettings> createState() => _AdvancedColorSettingsState();
}

class _AdvancedColorSettingsState extends State<_AdvancedColorSettings> {
  // Gather the fixed theme data //

  final double margin = EzConfig.get(marginKey);
  final double padding = EzConfig.get(paddingKey);

  late final EdgeInsets wrapPadding = EzInsets.wrap(padding);

  late final EFUILang l10n = widget.l10n;

  // Define the build data //

  late final List<String> defaultList = widget.defaultList;
  late final Set<String> defaultSet = defaultList.toSet();

  late final List<String> currList = widget.currList;

  // Define custom Widgets //

  /// Return the live [List] of [EzConfig.prefs] keys that the user is tracking
  List<Widget> dynamicColorSettings(String userColorsKey) {
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
  List<Widget> getUntrackedColors(StateSetter setModalState, bool isDark) {
    final Set<String> currSet = currList.toSet();
    final List<String> fullList = isDark ? darkColorKeys : lightColorKeys;

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
              border: Border.all(
                  color: Theme.of(context).colorScheme.primaryContainer),
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
        style: Theme.of(context).textTheme.labelLarge!,
        textAlign: TextAlign.center,
        url: Uri.parse('https://m3.material.io/styles/color/roles'),
        hint: l10n.gHowThisWorksHint,
        tooltip: 'https://m3.material.io/styles/color/roles',
      ),
    );

    return untrackedColors;
  }

  @override
  Widget build(BuildContext context) {
    // Gather the dynamic theme data //

    final bool isDark = isDarkTheme(context);
    final String userColorsKey =
        isDark ? userDarkColorsKey : userLightColorsKey;

    // Return the build //

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Dynamic color settings
        EzSwapWidget(
          expanded: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: widthOf(context) * 0.667,
            ),
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
        const EzSeparator(),

        // Add a color button
        EzTextIconButton(
          onPressed: () async {
            // Show available color configKeys
            await showModalBottomSheet(
              context: context,
              constraints: const BoxConstraints(minWidth: double.infinity),
              builder: (_) => StatefulBuilder(
                builder: (_, StateSetter setModalState) {
                  return EzScrollView(
                    scrollDirection: Axis.horizontal,
                    startCentered: true,
                    mainAxisSize: MainAxisSize.min,
                    child: EzScrollView(
                      mainAxisSize: MainAxisSize.min,
                      children: getUntrackedColors(setModalState, isDark),
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
