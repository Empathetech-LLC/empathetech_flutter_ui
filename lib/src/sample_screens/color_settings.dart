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

  /// If provided, the "Editing: X theme" text will be a link with this callback
  final void Function()? themeLink;

  /// Spacer above the [EzResetButton], on both sub-screens
  final Widget resetSpacer;

  /// Additional [EzConfig] keys for the shared [EzResetButton]
  /// [darkColorKeys] are included by default
  final Set<String>? darkThemeResetKeys;

  /// Additional [EzConfig] keys for the shared [EzResetButton]
  /// [lightColorKeys] are included by default
  final Set<String>? lightThemeResetKeys;

  /// [EzResetButton.extraKeys] passthrough
  final List<String>? extraSaveKeys;

  /// [EzResetButton.appName] passthrough
  final String appName;

  /// [EzResetButton.androidPackage] passthrough
  final String? androidPackage;

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
    this.themeLink,
    this.resetSpacer = ezSeparator,
    this.darkThemeResetKeys,
    this.lightThemeResetKeys,
    this.extraSaveKeys,
    required this.appName,
    this.androidPackage,

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

  late final EFUILang l10n = ezL10n(context);

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

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final bool isDark = isDarkTheme(context);

    final List<String> defaultList =
        isDark ? widget.darkStarterSet : widget.lightStarterSet;

    final String userColorsKey =
        isDark ? userDarkColorsKey : userLightColorsKey;
    List<String> currList =
        EzConfig.get(userColorsKey) ?? List<String>.from(defaultList);

    // Return the build //

    return EzScrollView(
      children: <Widget>[
        // Current theme reminder
        (widget.themeLink != null)
            ? EzLink(
                l10n.gEditingTheme(isDark ? darkString : lightString),
                onTap: widget.themeLink,
                hint: l10n.gEditingThemeHint,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              )
            : EzText(
                l10n.gEditingTheme(isDark ? darkString : lightString),
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
        ezMargin,

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
        ezSeparator,

        // Core settings
        if (currentTab == EzCSType.quick)
          _QuickColorSettings(
            l10n: l10n,
            quickHeader: widget.quickHeader,
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
                  await EzConfig.removeKeys(darkColorKeys.keys.toSet());

                  if (widget.darkThemeResetKeys != null) {
                    await EzConfig.removeKeys(widget.darkThemeResetKeys!);
                  }

                  setState(() => currList = List<String>.from(defaultList));
                },
                extraKeys: widget.extraSaveKeys,
                appName: widget.appName,
                androidPackage: widget.androidPackage,
              )
            : EzResetButton(
                dialogTitle: l10n.csResetAll(lightString),
                onConfirm: () async {
                  await EzConfig.removeKeys(lightColorKeys.keys.toSet());

                  if (widget.lightThemeResetKeys != null) {
                    await EzConfig.removeKeys(widget.lightThemeResetKeys!);
                  }

                  setState(() => currList = List<String>.from(defaultList));
                },
                extraKeys: widget.extraSaveKeys,
                appName: widget.appName,
                androidPackage: widget.androidPackage,
              ),
        ezSeparator,
      ],
    );
  }
}

class _QuickColorSettings extends StatefulWidget {
  final EFUILang l10n;
  final List<Widget>? quickHeader;
  final List<Widget>? quickFooter;

  const _QuickColorSettings({
    required this.l10n,
    required this.quickHeader,
    required this.quickFooter,
  });

  @override
  State<_QuickColorSettings> createState() => _QuickColorSettingsState();
}

class _QuickColorSettingsState extends State<_QuickColorSettings> {
  late final String fromImageLabel = widget.l10n.csSchemeBase;
  late final String fromImageHint = widget.l10n.csFromImage;

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
          if (widget.quickHeader != null) ...widget.quickHeader!,

          // MonoChrome
          const EzMonoChromeColorsSetting(),
          ezSpacer,

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

class _AdvancedColorSettingsState extends State<_AdvancedColorSettings>
    with WidgetsBindingObserver {
  // Gather the fixed theme data //

  late final EFUILang l10n = widget.l10n;

  // Define the build data //

  late final List<String> defaultList = widget.defaultList;
  late final Set<String> defaultSet = defaultList.toSet();

  late final List<String> currList = widget.currList;
  bool modalOpen = false;

  // Define custom Widgets //

  /// Return the live [List] of [EzConfig.prefs] keys that the user is tracking
  List<Widget> dynamicColorSettings(String userColorsKey) {
    final List<Widget> toReturn = <Widget>[];
    final EdgeInsets wrapPadding = EzInsets.wrap(EzConfig.spacing);

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
    final List<String> fullList = isDark ? darkColorOrder : lightColorOrder;

    return fullList
        .where((String element) => !currSet.contains(element))
        .map<Widget>((String configKey) {
      final Color liveColor = getLiveColor(context, configKey);

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
              border: Border.all(
                  color: Theme.of(context).colorScheme.primaryContainer),
            ),
            child: CircleAvatar(
              backgroundColor: liveColor,
              radius: EzConfig.padding + EzConfig.margin,
              child: liveColor == Colors.transparent
                  ? EzIcon(PlatformIcons(context).eyeSlash)
                  : null,
            ),
          ),
          label: getColorName(configKey),
        ),
      );
    }).toList();
  }

  // Init //

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    if (modalOpen) {
      Navigator.of(context).pop();
      modalOpen = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

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
              maxWidth: widthOf(context) * 0.75,
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
        ezSeparator,

        // Add a color button
        EzTextIconButton(
          onPressed: () async {
            // Show modal
            modalOpen = true;
            await ezModal(
              context: context,
              builder: (_) => StatefulBuilder(
                builder: (_, StateSetter setModalState) => EzScrollView(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Tutorial link
                    EzLink(
                      l10n.gHowThisWorks,
                      style: Theme.of(context).textTheme.labelLarge!,
                      textAlign: TextAlign.center,
                      url: Uri.parse(
                          'https://m3.material.io/styles/color/roles'),
                      hint: l10n.gHowThisWorksHint,
                      tooltip: 'https://m3.material.io/styles/color/roles',
                    ),

                    // Color options
                    Wrap(
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: getUntrackedColors(setModalState, isDark),
                    ),
                    ezSpacer,
                  ],
                ),
              ),
            );
            modalOpen = false;

            // Save changes
            await EzConfig.setStringList(userColorsKey, currList);
          },
          style: TextButton.styleFrom(padding: EzInsets.wrap(EzConfig.margin)),
          icon: EzIcon(PlatformIcons(context).addCircledOutline),
          label: l10n.csAddColor,
        ),
      ],
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
