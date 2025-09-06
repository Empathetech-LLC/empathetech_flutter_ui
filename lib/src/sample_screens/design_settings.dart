/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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
  final EzSpacer pMSpacer = EzMargin(vertical: false);

  final double margin = EzConfig.get(marginKey);
  final double padding = EzConfig.get(paddingKey);
  final double spacing = EzConfig.get(spacingKey);

  late final EFUILang l10n = ezL10n(context);
  late final String darkString = l10n.gDark.toLowerCase();
  late final String lightString = l10n.gLight.toLowerCase();

  // Define the build data //

  final bool strictMobile = !kIsWeb && isMobile();

  double animDuration = EzConfig.get(animationDurationKey);
  double iconSize = EzConfig.get(iconSizeKey);
  final double defaultIconSize = EzConfig.getDefault(iconSizeKey);

  late bool isDark = isDarkTheme(context);
  late String themeProfile = isDark ? darkString : lightString;

  late double buttonOpacity = isDark
      ? EzConfig.get(darkButtonOpacityKey)
      : EzConfig.get(lightButtonOpacityKey);
  late double outlineOpacity = isDark
      ? EzConfig.get(darkButtonOutlineOpacityKey)
      : EzConfig.get(lightButtonOutlineOpacityKey);

  late ColorScheme colorScheme = Theme.of(context).colorScheme;

  late Color surface = colorScheme.surface;
  late Color shadow = colorScheme.shadow;
  late Color container = colorScheme.primaryContainer;
  late Color outline = colorScheme.outline;

  late Color buttonBackground = surface.withValues(alpha: buttonOpacity);
  late Color buttonShadow = shadow.withValues(alpha: buttonOpacity);
  late Color buttonContainer = container.withValues(alpha: outlineOpacity);
  late Color buttonOutline = outline.withValues(alpha: outlineOpacity);

  int redraw = 0;

  // Define custom functions //

  void setColors() {
    surface = colorScheme.surface;
    shadow = colorScheme.shadow;
    container = colorScheme.primaryContainer;
    outline = colorScheme.outline;

    buttonBackground = surface.withValues(alpha: buttonOpacity);
    buttonShadow = shadow.withValues(alpha: buttonOpacity);
    buttonContainer = container.withValues(alpha: outlineOpacity);
    buttonOutline = outline.withValues(alpha: outlineOpacity);
  }

  void drawState() => setState(() => redraw = Random().nextInt(rMax));

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

    colorScheme = Theme.of(context).colorScheme;
    setColors();
    drawState();
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return EzScrollView(
      children: <Widget>[
        if (spacing > margin) EzSpacer(space: spacing - margin),

        // Animation duration
        EzText(l10n.dsAnimDuration, style: textTheme.bodyLarge),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: ScreenSize.small.size),
          child: SliderTheme(
            data: SliderThemeData(
              thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: iconSize / 2,
                disabledThumbRadius: iconSize / 2,
              ),
            ),
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
        ),
        spacer,

        // Icon size
        EzText(l10n.tsIconSize, style: textTheme.bodyLarge),
        EzTextBackground(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Minus
              (iconSize > minIconSize)
                  ? EzIconButton(
                      onPressed: () async {
                        iconSize -= iconDelta;
                        await EzConfig.setDouble(iconSizeKey, iconSize);
                        drawState();
                      },
                      tooltip:
                          '${l10n.gDecrease} ${l10n.tsIconSize.toLowerCase()}',
                      iconSize: iconSize,
                      icon: Icon(PlatformIcons(context).remove),
                    )
                  : EzIconButton(
                      enabled: false,
                      tooltip: l10n.gMinimum,
                      iconSize: iconSize,
                      icon: Icon(
                        PlatformIcons(context).remove,
                        color: colorScheme.outline,
                      ),
                    ),
              pMSpacer,

              // Preview
              Icon(
                Icons.sync_alt,
                size: iconSize,
                color: colorScheme.onSurface,
              ),
              pMSpacer,

              // Plus
              (iconSize < maxIconSize)
                  ? EzIconButton(
                      onPressed: () async {
                        iconSize += iconDelta;
                        await EzConfig.setDouble(iconSizeKey, iconSize);
                        drawState();
                      },
                      tooltip:
                          '${l10n.gIncrease} ${l10n.tsIconSize.toLowerCase()}',
                      iconSize: iconSize,
                      icon: Icon(PlatformIcons(context).add),
                    )
                  : EzIconButton(
                      enabled: false,
                      tooltip: l10n.gMaximum,
                      iconSize: iconSize,
                      icon: Icon(
                        PlatformIcons(context).add,
                        color: colorScheme.outline,
                      ),
                    ),
            ],
          ),
          borderRadius: ezPillShape,
        ),
        spacer,

        // Hide scroll
        EzSwitchPair(
          key: ValueKey<String>('scroll_$redraw'),
          scale: iconSize / defaultIconSize,
          text: l10n.lsScroll,
          valueKey: hideScrollKey,
        ),

        // Global/themed divider, w/ theme reminder
        separator,
        EzDivider(height: margin * 2),
        EzText(
          l10n.gEditingTheme(themeProfile),
          style: textTheme.labelLarge,
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
                Text(l10n.dsButtonBackground, style: textTheme.bodyLarge),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: ScreenSize.small.size),
                  child: SliderTheme(
                    data: SliderThemeData(
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: iconSize / 2,
                        disabledThumbRadius: iconSize / 2,
                      ),
                    ),
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
                ),
                spacer,

                // Button outline
                Text(l10n.dsButtonOutline, style: textTheme.bodyLarge),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: ScreenSize.small.size),
                  child: SliderTheme(
                    data: SliderThemeData(
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: iconSize / 2,
                        disabledThumbRadius: iconSize / 2,
                      ),
                    ),
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
                        buttonOutline =
                            outline.withValues(alpha: outlineOpacity);
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
                ),
              ],
            ),
          ),
        ),

        // Background
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
                    label: l10n.dsBackgroundImg.replaceAll(' ', '\n'),
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
                    label: l10n.dsBackgroundImg.replaceAll(' ', '\n'),
                    updateTheme: Brightness.light,
                  ),
          ),
        ],

        // After background
        if (widget.additionalThemedSettings != null)
          ...widget.additionalThemedSettings!,

        // Reset button
        widget.resetSpacer,
        EzResetButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonBackground,
            shadowColor: buttonShadow,
            side: BorderSide(color: buttonContainer),
          ),
          dialogTitle: l10n.dsResetAll(themeProfile),
          onConfirm: () async {
            await EzConfig.removeKeys(globalDesignKeys.keys.toSet());
            await EzConfig.remove(iconSizeKey);
            await EzConfig.remove(hideScrollKey);

            if (isDark) {
              await EzConfig.removeKeys(darkDesignKeys.keys.toSet());
              await EzConfig.remove(darkColorSchemeImageKey);

              if (widget.darkThemeResetKeys != null) {
                await EzConfig.removeKeys(widget.darkThemeResetKeys!);
              }

              buttonOpacity = EzConfig.getDefault(darkButtonOpacityKey);
              outlineOpacity = EzConfig.getDefault(darkButtonOutlineOpacityKey);
            } else {
              await EzConfig.removeKeys(lightDesignKeys.keys.toSet());
              await EzConfig.remove(lightColorSchemeImageKey);

              if (widget.lightThemeResetKeys != null) {
                await EzConfig.removeKeys(widget.lightThemeResetKeys!);
              }

              buttonOpacity = EzConfig.getDefault(lightButtonOpacityKey);
              outlineOpacity =
                  EzConfig.getDefault(lightButtonOutlineOpacityKey);
            }

            animDuration = EzConfig.getDefault(animationDurationKey);
            iconSize = defaultIconSize;

            setColors();
            drawState();
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
