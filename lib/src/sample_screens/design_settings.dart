/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

// TODO: l10n, semantics, tooltips

import '../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class EzDesignSettings extends StatefulWidget {
  /// Optional additional global design settings
  /// Will appear after the default global design settings
  /// BYO leading spacer, trailing will be a custom [EzDivider]
  final List<Widget>? additionalGlobalSettings;

  /// Whether to include the background image setting
  /// When true, pairs well with [EzScreen], specifically [EzScreen.useImageDecoration]
  final bool includeBackgroundImage;

  /// Optional credits for the dark background image
  /// Moot if [includeBackgroundImage] is false
  final String? darkBackgroundCredits;

  /// Optional credits for the light background image
  /// Moot if [includeBackgroundImage] is false
  final String? lightBackgroundCredits;

  /// Whether to include the "Liquid Glass" setting
  /// Only applicable for mobile
  final bool includeGlass;

  /// Optional additional theme design settings
  /// Will appear after the default themed design settings
  /// BYO leading spacer, trailing will be [resetSpacer]
  final List<Widget>? additionalThemedSettings;

  /// Spacer before the [EzResetButton]
  final Widget resetSpacer;

  /// Additional [EzConfig] keys for the local [EzResetButton]
  /// [globalDesignKeys], [darkDesignKeys], && [darkColorSchemeImageKey] are included by default
  /// Intentionally just resets the image, not the color scheme itself
  /// Include [darkColorKeys] if desired
  final Set<String>? darkThemeResetKeys;

  /// Additional [EzConfig] keys for the local [EzResetButton]
  /// [globalDesignKeys], [lightDesignKeys], && [lightColorSchemeImageKey] are included by default
  /// /// Intentionally just resets the image, not the color scheme itself
  /// Include [lightColorKeys] if desired
  final Set<String>? lightThemeResetKeys;

  /// Empathetech image settings
  /// Recommended to use as a [Scaffold.body]
  const EzDesignSettings({
    super.key,
    this.additionalGlobalSettings,
    this.includeBackgroundImage = true,
    this.darkBackgroundCredits,
    this.lightBackgroundCredits,
    this.includeGlass = true,
    this.additionalThemedSettings,
    this.resetSpacer = const EzDivider(),
    this.darkThemeResetKeys,
    this.lightThemeResetKeys,
  });

  @override
  State<EzDesignSettings> createState() => _EzDesignSettingsState();
}

class _EzDesignSettingsState extends State<EzDesignSettings>
    with WidgetsBindingObserver {
  // Gather the fixed theme data //

  static const EzSpacer spacer = EzSpacer();
  static const EzSeparator separator = EzSeparator();
  final EzSpacer marginer = EzMargin();

  final double margin = EzConfig.get(marginKey);
  final double padding = EzConfig.get(paddingKey);
  final double spacing = EzConfig.get(spacingKey);

  late final EFUILang l10n = ezL10n(context);
  late final String darkString = l10n.gDark.toLowerCase();
  late final String lightString = l10n.gLight.toLowerCase();

  // Define the build data //

  final bool strictMobile = !kIsWeb && isMobile();
  double animDuration = EzConfig.get(animationDurationKey);

  late bool isDark = isDarkTheme(context);
  late String themeProfile = isDark ? darkString : lightString;

  late double buttonOpacity = isDark
      ? EzConfig.get(darkButtonOpacityKey)
      : EzConfig.get(lightButtonOpacityKey);
  late double outlineOpacity = isDark
      ? EzConfig.get(darkButtonOutlineOpacityKey)
      : EzConfig.get(lightButtonOutlineOpacityKey);

  late Color surface = Theme.of(context).colorScheme.surface;
  late Color shadow = Theme.of(context).colorScheme.shadow;
  late Color container = Theme.of(context).colorScheme.primaryContainer;
  late Color outline = Theme.of(context).colorScheme.outline;

  late Color buttonBackground = surface.withValues(alpha: buttonOpacity);
  late Color buttonShadow = shadow.withValues(alpha: buttonOpacity);
  late Color buttonContainer = container.withValues(alpha: outlineOpacity);
  late Color buttonOutline = outline.withValues(alpha: outlineOpacity);

  int redraw = 0;

  // Define custom functions //

  void setColors() {
    surface = Theme.of(context).colorScheme.surface;
    shadow = Theme.of(context).colorScheme.shadow;
    container = Theme.of(context).colorScheme.primaryContainer;
    outline = Theme.of(context).colorScheme.outline;

    buttonBackground = surface.withValues(alpha: buttonOpacity);
    buttonShadow = shadow.withValues(alpha: buttonOpacity);
    buttonContainer = container.withValues(alpha: outlineOpacity);
    buttonOutline = outline.withValues(alpha: outlineOpacity);
  }

  // Init //

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ezWindowNamer(context, l10n.dsPageTitle);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();

    isDark = isDarkTheme(context);
    themeProfile = isDark ? darkString : lightString;

    buttonOpacity = isDark
        ? EzConfig.get(darkButtonOpacityKey)
        : EzConfig.get(lightButtonOpacityKey);
    outlineOpacity = isDark
        ? EzConfig.get(darkButtonOutlineOpacityKey)
        : EzConfig.get(lightButtonOutlineOpacityKey);

    setColors();
    setState(() => redraw = Random().nextInt(rMax));
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return EzScrollView(
      children: <Widget>[
        if (spacing > margin) EzSpacer(space: spacing - margin),

        // Animation duration
        const Text('Animation duration (ms)'),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: ScreenSize.small.size),
          child: Slider(
            value: animDuration,
            min: minAnimationDuration,
            max: maxAnimationDuration,
            divisions: 20,
            label: animDuration.toStringAsFixed(0),
            onChanged: (double value) => setState(() => animDuration = value),
            onChangeEnd: (double value) =>
                EzConfig.setDouble(animationDurationKey, value),
          ),
        ),
        spacer,

        // Hide scroll
        EzSwitchPair(
          key: ValueKey<String>('scroll_$redraw'),
          text: l10n.lsScroll,
          valueKey: hideScrollKey,
        ),

        // Global/themed divider, w/ theme reminder
        separator,
        EzDivider(height: margin * 2),
        EzText(
          l10n.gEditingTheme(themeProfile),
          style: Theme.of(context).textTheme.labelLarge,
          textAlign: TextAlign.center,
        ),
        separator,

        // Button background
        Card(
          color: buttonBackground,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: buttonOutline),
            borderRadius: ezRoundEdge,
          ),
          shadowColor: buttonShadow,
          child: Padding(
            padding: EdgeInsets.all(margin),
            child: Column(
              children: <Widget>[
                const Text('Button background opacity'),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: ScreenSize.small.size),
                  child: Slider(
                    // Slider values
                    value: buttonOpacity,
                    min: minOpacity,
                    max: maxOpacity,
                    divisions: 20,
                    label: buttonOpacity.toStringAsFixed(2),

                    // Slider functions
                    onChanged: (double value) {
                      buttonOpacity = value;
                      buttonBackground =
                          surface.withValues(alpha: buttonOpacity);
                      buttonShadow = shadow.withValues(alpha: buttonOpacity);
                      setState(() {});
                    },
                    onChangeEnd: (double value) async {
                      await EzConfig.setDouble(
                        isDark ? darkButtonOpacityKey : lightButtonOpacityKey,
                        value,
                      );
                    },
                  ),
                ),
                spacer,

                // Button outline
                const Text('Button outline opacity'),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: ScreenSize.small.size),
                  child: Slider(
                    // Slider values
                    value: outlineOpacity,
                    min: minOpacity,
                    max: maxOpacity,
                    divisions: 20,
                    label: outlineOpacity.toStringAsFixed(2),

                    // Slider functions
                    onChanged: (double value) {
                      outlineOpacity = value;
                      buttonContainer =
                          container.withValues(alpha: outlineOpacity);
                      buttonOutline = outline.withValues(alpha: outlineOpacity);
                      setState(() {});
                    },
                    onChangeEnd: (double value) async {
                      await EzConfig.setDouble(
                        isDark
                            ? darkButtonOutlineOpacityKey
                            : lightButtonOutlineOpacityKey,
                        value,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        // Background TODO: Add 'image' to button label
        if (widget.includeBackgroundImage) ...<Widget>[
          spacer,
          EzScrollView(
            scrollDirection: Axis.horizontal,
            startCentered: true,
            mainAxisSize: MainAxisSize.min,
            child: isDark
                ? EzImageSetting(
                    key: UniqueKey(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonBackground,
                      shadowColor: buttonShadow,
                      side: BorderSide(color: buttonContainer),
                      padding: EdgeInsets.all(padding * 0.75),
                    ),
                    configKey: darkBackgroundImageKey,
                    credits: widget.darkBackgroundCredits,
                    label: l10n.dsBackground,
                    updateTheme: Brightness.dark,
                  )
                : EzImageSetting(
                    key: UniqueKey(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonBackground,
                      shadowColor: buttonShadow,
                      side: BorderSide(color: buttonContainer),
                      padding: EdgeInsets.all(padding * 0.75),
                    ),
                    configKey: lightBackgroundImageKey,
                    credits: widget.lightBackgroundCredits,
                    label: l10n.dsBackground,
                    updateTheme: Brightness.light,
                  ),
          ),
        ],

        if (widget.includeGlass && strictMobile) ...<Widget>[
          spacer,
          EzSwitchPair(
            text: 'Glass buttons',
            valueKey: isDark ? darkGlassKey : lightGlassKey,
          ), // TODO: enabling this greys out above (not remove, just disable)
        ],

        // After background
        if (widget.additionalThemedSettings != null)
          ...widget.additionalThemedSettings!,

        // Reset button
        widget.resetSpacer,
        isDark
            ? EzResetButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonBackground,
                  shadowColor: buttonShadow,
                  side: BorderSide(color: buttonContainer),
                ),
                dialogTitle: l10n.dsResetAll(darkString), // TODO: update entry
                onConfirm: () async {
                  await EzConfig.removeKeys(globalDesignKeys.keys.toSet());
                  await EzConfig.removeKeys(darkDesignKeys.keys.toSet());
                  await EzConfig.remove(darkColorSchemeImageKey);

                  if (widget.darkThemeResetKeys != null) {
                    await EzConfig.removeKeys(widget.darkThemeResetKeys!);
                  }

                  animDuration = EzConfig.getDefault(animationDurationKey);
                  buttonOpacity = EzConfig.getDefault(darkButtonOpacityKey);
                  outlineOpacity =
                      EzConfig.getDefault(darkButtonOutlineOpacityKey);
                  setColors();

                  setState(() => redraw = Random().nextInt(rMax));
                },
              )
            : EzResetButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonBackground,
                  shadowColor: buttonShadow,
                  side: BorderSide(color: buttonContainer),
                ),
                dialogTitle: l10n.dsResetAll(lightString),
                onConfirm: () async {
                  await EzConfig.removeKeys(globalDesignKeys.keys.toSet());
                  await EzConfig.removeKeys(lightDesignKeys.keys.toSet());
                  await EzConfig.remove(lightColorSchemeImageKey);

                  if (widget.lightThemeResetKeys != null) {
                    await EzConfig.removeKeys(widget.lightThemeResetKeys!);
                  }

                  animDuration = EzConfig.getDefault(animationDurationKey);
                  buttonOpacity = EzConfig.getDefault(lightButtonOpacityKey);
                  outlineOpacity =
                      EzConfig.getDefault(lightButtonOutlineOpacityKey);
                  setColors();

                  setState(() => redraw = Random().nextInt(rMax));
                },
              ),
        separator,
      ],
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
