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
  /// Whether to disable animation control
  final bool noAnimation;

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
    this.noAnimation = false,
    this.additionalGlobalSettings,
    this.includeBackgroundImage = true,
    this.darkBackgroundCredits,
    this.lightBackgroundCredits,
    this.additionalThemedSettings,
    this.resetSpacer = ezDivider,
    this.darkThemeResetKeys,
    this.lightThemeResetKeys,
  });

  @override
  State<EzDesignSettings> createState() => _EzDesignSettingsState();
}

class _EzDesignSettingsState extends State<EzDesignSettings>
    with WidgetsBindingObserver {
  // Gather the fixed theme data //

  final double margin = EzConfig.get(marginKey);
  final double padding = EzConfig.get(paddingKey);
  final double spacing = EzConfig.get(spacingKey);

  late final EFUILang l10n = ezL10n(context);
  late final String darkString = l10n.gDark.toLowerCase();
  late final String lightString = l10n.gLight.toLowerCase();

  // Define the build data //

  final bool strictMobile = !kIsWeb && isMobile();

  double animDuration = (EzConfig.get(animationDurationKey) as int).toDouble();
  double iconSize = EzConfig.get(iconSizeKey);

  late double buttonOpacity = isDarkTheme(context)
      ? EzConfig.get(darkButtonOpacityKey)
      : EzConfig.get(lightButtonOpacityKey);
  late double outlineOpacity = isDarkTheme(context)
      ? EzConfig.get(darkButtonOutlineOpacityKey)
      : EzConfig.get(lightButtonOutlineOpacityKey);

  int redraw = 0;

  // Define custom functions //

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
    final bool dark = isDarkTheme(context);

    buttonOpacity = dark
        ? EzConfig.get(darkButtonOpacityKey)
        : EzConfig.get(lightButtonOpacityKey);
    outlineOpacity = dark
        ? EzConfig.get(darkButtonOutlineOpacityKey)
        : EzConfig.get(lightButtonOutlineOpacityKey);

    drawState();
  }

  @override
  Widget build(BuildContext context) {
    // Gather the dynamic theme data //

    final bool isDark = isDarkTheme(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final String themeProfile = isDark ? darkString : lightString;

    // Return the build //

    return EzScrollView(
      children: <Widget>[
        if (spacing > margin) EzSpacer(space: spacing - margin),

        // Animation duration
        if (!widget.noAnimation) ...<Widget>[
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
                min: minAnimationDuration.toDouble(),
                max: maxAnimationDuration.toDouble(),
                divisions: 20,
                label: animDuration.toStringAsFixed(0),
                onChanged: (double value) =>
                    setState(() => animDuration = value),
                onChangeEnd: (double value) =>
                    EzConfig.setInt(animationDurationKey, value.toInt()),
              ),
            ),
          ),
          ezSpacer,
        ],

        // Icon size
        Tooltip(
          message: l10n.gCenterReset,
          child: EzText(l10n.tsIconSize, style: textTheme.bodyLarge),
        ),
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
              ezRowMargin,

              // Preview
              GestureDetector(
                onLongPress: () async {
                  iconSize = defaultIconSize;
                  await EzConfig.setDouble(iconSizeKey, defaultIconSize);
                  drawState();
                },
                child: Icon(
                  Icons.sync_alt,
                  size: iconSize,
                  color: colorScheme.onSurface,
                ),
              ),
              ezRowMargin,

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
        ezSpacer,

        // Hide scroll
        EzSwitchPair(
          key: ValueKey<String>('scroll_$redraw'),
          scale: iconSize / defaultIconSize,
          text: l10n.lsScroll,
          valueKey: hideScrollKey,
        ),

        // Global/themed divider, w/ theme reminder
        ezSeparator,
        EzDivider(height: margin),
        EzText(
          l10n.gEditingTheme(themeProfile),
          style: textTheme.labelLarge,
          textAlign: TextAlign.center,
        ),
        ezSeparator,

        // Button opacity
        Card(
          key: ValueKey<String>('opacity_$redraw'),
          color: colorScheme.surface.withValues(alpha: buttonOpacity),
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: colorScheme.outline.withValues(alpha: outlineOpacity)),
            borderRadius: ezRoundEdge,
          ),
          shadowColor: colorScheme.shadow.withValues(alpha: buttonOpacity),
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
                      onChanged: (double value) =>
                          setState(() => buttonOpacity = value),
                      onChangeEnd: (double value) async {
                        await EzConfig.setDouble(
                          isDark ? darkButtonOpacityKey : lightButtonOpacityKey,
                          value,
                        );
                      },
                    ),
                  ),
                ),
                ezSpacer,

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
                      onChanged: (double value) =>
                          setState(() => outlineOpacity = value),
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
          ezSpacer,
          EzScrollView(
            scrollDirection: Axis.horizontal,
            startCentered: true,
            mainAxisSize: MainAxisSize.min,
            child: isDark
                ? EzImageSetting(
                    key: UniqueKey(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          colorScheme.surface.withValues(alpha: buttonOpacity),
                      shadowColor:
                          colorScheme.shadow.withValues(alpha: buttonOpacity),
                      side: BorderSide(
                          color: colorScheme.primaryContainer
                              .withValues(alpha: outlineOpacity)),
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
                      backgroundColor:
                          colorScheme.surface.withValues(alpha: buttonOpacity),
                      shadowColor:
                          colorScheme.shadow.withValues(alpha: buttonOpacity),
                      side: BorderSide(
                          color: colorScheme.primaryContainer
                              .withValues(alpha: outlineOpacity)),
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
          key: ValueKey<String>('reset_$redraw'),
          style: ElevatedButton.styleFrom(
            backgroundColor:
                colorScheme.surface.withValues(alpha: buttonOpacity),
            shadowColor: colorScheme.shadow.withValues(alpha: buttonOpacity),
            side: BorderSide(
                color: colorScheme.primaryContainer
                    .withValues(alpha: outlineOpacity)),
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

            animDuration =
                (EzConfig.getDefault(animationDurationKey) as int).toDouble();
            iconSize = defaultIconSize;

            drawState();
          },
        ),
        ezSeparator,
      ],
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
