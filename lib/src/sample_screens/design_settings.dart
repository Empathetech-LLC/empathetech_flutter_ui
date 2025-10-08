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
  /// Optional additional global design settings, before the main group
  /// BYO tailing spacer, leading spacer is a custom [EzSpacer]
  final List<Widget>? globalSettingsPrepend;

  /// Whether to include animation duration control
  final bool includeAnimation;

  /// Whether to include icon size controls
  final bool includeIconSize;

  /// Whether to include the scrollbar visibility toggle
  final bool includeScroll;

  /// Optional additional global design settings, after the main group
  /// BYO leading spacer, trailing spacer is a custom [EzDivider]
  final List<Widget>? globalSettingsPostpend;

  /// Optional additional themed design settings, before the main group
  /// BYO trailing spacer, leading is a custom [EzDivider]
  final List<Widget>? themedSettingsPrepend;

  /// Whether to include the background image setting
  /// When true, pairs well with [EzScreen], specifically [EzScreen.useImageDecoration]
  final bool includeBackgroundImage;

  /// Optional credits for the dark background image
  /// Moot if [includeBackgroundImage] is false
  final String? darkBackgroundCredits;

  /// Optional credits for the light background image
  /// Moot if [includeBackgroundImage] is false
  final String? lightBackgroundCredits;

  /// Optional additional themed design settings, after the main group
  /// BYO leading spacer, trailing is [resetSpacer]
  final List<Widget>? themedSettingsPostpend;

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

  /// Optional callback for when a local reset is confirmed
  final void Function()? onReset;

  /// Empathetech image settings
  /// Recommended to use as a [Scaffold.body]
  const EzDesignSettings({
    super.key,
    this.globalSettingsPrepend,
    this.includeAnimation = true,
    this.includeIconSize = true,
    this.includeScroll = true,
    this.globalSettingsPostpend,
    this.themedSettingsPrepend,
    this.includeBackgroundImage = true,
    this.darkBackgroundCredits,
    this.lightBackgroundCredits,
    this.themedSettingsPostpend,
    this.resetSpacer = ezDivider,
    this.darkThemeResetKeys,
    this.lightThemeResetKeys,
    this.onReset,
  });

  @override
  State<EzDesignSettings> createState() => _EzDesignSettingsState();
}

class _EzDesignSettingsState extends State<EzDesignSettings>
    with WidgetsBindingObserver {
  // Gather the fixed theme data //

  final double margin = EzConfig.get(marginKey);
  final double spacing = EzConfig.get(spacingKey);

  late final EdgeInsets wrapPadding = EzInsets.wrap(spacing);

  late final EFUILang l10n = ezL10n(context);
  late final String darkString = l10n.gDark.toLowerCase();
  late final String lightString = l10n.gLight.toLowerCase();

  // Define the build data //

  final bool strictMobile = !kIsWeb && isMobile();
  int redraw = 0;

  double iconSize = EzConfig.get(iconSizeKey);

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
    drawState();
  }

  @override
  Widget build(BuildContext context) {
    // Gather the dynamic theme data //

    final bool isDark = isDarkTheme(context);
    final String themeProfile = isDark ? darkString : lightString;

    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    // Return the build //

    return EzScrollView(
      children: <Widget>[
        if (spacing > margin) EzSpacer(space: spacing - margin),

        if (widget.globalSettingsPrepend != null)
          ...widget.globalSettingsPrepend!,

        // Animation duration
        if (widget.includeAnimation)
          EzElevatedIconButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              useSafeArea: true,
              isScrollControlled: true,
              constraints: const BoxConstraints(minWidth: double.infinity),
              builder: (_) {
                double animDuration =
                    (EzConfig.get(animationDurationKey) as int).toDouble();

                return StatefulBuilder(
                  builder: (_, StateSetter setModal) => EzScrollView(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ezSpacer,
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: ScreenSize.small.size),
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
                                setModal(() => animDuration = value),
                            onChangeEnd: (double value) => EzConfig.setInt(
                                animationDurationKey, value.toInt()),
                          ),
                        ),
                      ),
                      EzSpacer(space: spacing * 1.5),
                    ],
                  ),
                );
              },
            ),
            label: l10n.dsAnimDuration,
            icon: Icon(PlatformIcons(context).time),
            style: ElevatedButton.styleFrom(iconSize: iconSize),
          ),

        // Icon size
        if (widget.includeIconSize) ...<Widget>[
          ezSpacer,
          Tooltip(
            message: l10n.gCenterReset,
            child: GestureDetector(
              onLongPress: () async {
                iconSize = defaultIconSize;
                await EzConfig.setDouble(iconSizeKey, defaultIconSize);
                drawState();
              },
              child: EzText(l10n.tsIconSize, style: textTheme.bodyLarge),
            ),
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
                        icon: Icon(PlatformIcons(context).remove),
                        iconSize: iconSize,
                      )
                    : EzIconButton(
                        enabled: false,
                        tooltip: l10n.gMinimum,
                        icon: Icon(
                          PlatformIcons(context).remove,
                          color: colorScheme.outline,
                        ),
                        iconSize: iconSize,
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
                        icon: Icon(PlatformIcons(context).add),
                        iconSize: iconSize,
                      )
                    : EzIconButton(
                        enabled: false,
                        tooltip: l10n.gMaximum,
                        icon: Icon(
                          PlatformIcons(context).add,
                          color: colorScheme.outline,
                        ),
                        iconSize: iconSize,
                      ),
              ],
            ),
            borderRadius: ezPillShape,
          ),
        ],

        // Scrollbar toggle
        if (widget.includeScroll) ...<Widget>[
          ezSpacer,
          EzSwitchPair(
            key: ValueKey<String>('scroll_$redraw'),
            valueKey: hideScrollKey,
            scale: iconSize / defaultIconSize,
            text: l10n.lsScroll,
          ),
        ],

        if (widget.globalSettingsPostpend != null)
          ...widget.globalSettingsPostpend!,

        // Global/themed divider, w/ theme reminder
        ezSeparator,
        EzDivider(height: margin),
        EzText(
          l10n.gEditingTheme(themeProfile),
          style: textTheme.labelLarge,
          textAlign: TextAlign.center,
        ),
        ezSeparator,

        if (widget.themedSettingsPrepend != null)
          ...widget.themedSettingsPrepend!,

        // Button opacity
        EzElevatedIconButton(
          onPressed: () => showModalBottomSheet(
            context: context,
            useSafeArea: true,
            isScrollControlled: true,
            constraints: const BoxConstraints(minWidth: double.infinity),
            builder: (_) {
              final String buttonOpacityKey =
                  isDark ? darkButtonOpacityKey : lightButtonOpacityKey;
              final String buttonOutlineOpacityKey = isDark
                  ? darkButtonOutlineOpacityKey
                  : lightButtonOutlineOpacityKey;

              double buttonOpacity = EzConfig.get(buttonOpacityKey);
              double outlineOpacity = EzConfig.get(buttonOutlineOpacityKey);

              bool dummyBool = true;

              return StatefulBuilder(
                builder: (_, StateSetter setModal) {
                  Color buttonBackground =
                      colorScheme.surface.withValues(alpha: buttonOpacity);
                  Color buttonShadow = colorScheme.shadow
                      .withValues(alpha: buttonOpacity * shadowMod);
                  Color buttonOutline = colorScheme.primaryContainer
                      .withValues(alpha: outlineOpacity);

                  Color trackColor = colorScheme.surface
                      .withValues(alpha: max(crucialOT, buttonOpacity));
                  WidgetStatePropertyAll<Color> trackOutline =
                      WidgetStatePropertyAll<Color>(buttonOutline);

                  return EzScrollView(
                    children: <Widget>[
                      Wrap(
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: wrapPadding,
                            child: EzElevatedButton(
                              text: 'Preview', // TODO: l10n
                              onPressed: doNothing,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: buttonBackground,
                                shadowColor: buttonShadow,
                                side: BorderSide(color: buttonOutline),
                              ),
                            ),
                          ),
                          Padding(
                            padding: wrapPadding,
                            child: Transform.scale(
                              scale: max(
                                  1.0,
                                  max(
                                      iconSize /
                                          EzConfig.getDefault(iconSizeKey),
                                      EzConfig.get(paddingKey) /
                                          EzConfig.getDefault(paddingKey))),
                              child: Switch(
                                value: dummyBool,
                                onChanged: (bool v) =>
                                    setModal(() => dummyBool = v),
                                activeTrackColor: trackColor,
                                inactiveTrackColor: trackColor,
                                trackOutlineColor: trackOutline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ezSpacer,

                      Text(l10n.dsButtonBackground, style: textTheme.bodyLarge),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: ScreenSize.small.size),
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
                                setModal(() => buttonOpacity = value),
                            onChangeEnd: (double value) => EzConfig.setDouble(
                              isDark
                                  ? darkButtonOpacityKey
                                  : lightButtonOpacityKey,
                              value,
                            ),
                          ),
                        ),
                      ),
                      ezSpacer,

                      // Button outline
                      Text(l10n.dsButtonOutline, style: textTheme.bodyLarge),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: ScreenSize.small.size),
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
                                setModal(() => outlineOpacity = value),
                            onChangeEnd: (double value) => EzConfig.setDouble(
                              isDark
                                  ? darkButtonOutlineOpacityKey
                                  : lightButtonOutlineOpacityKey,
                              value,
                            ),
                          ),
                        ),
                      ),
                      ezSpacer,

                      // Reset button
                      EzElevatedIconButton(
                        onPressed: () async {
                          await EzConfig.remove(buttonOpacityKey);
                          await EzConfig.remove(buttonOutlineOpacityKey);

                          setModal(() {
                            buttonOpacity =
                                EzConfig.getDefault(buttonOpacityKey);
                            outlineOpacity =
                                EzConfig.getDefault(buttonOutlineOpacityKey);

                            buttonBackground = colorScheme.surface
                                .withValues(alpha: buttonOpacity);
                            buttonShadow = colorScheme.shadow
                                .withValues(alpha: buttonOpacity * shadowMod);
                            buttonOutline = colorScheme.primaryContainer
                                .withValues(alpha: outlineOpacity);

                            trackColor = colorScheme.surface.withValues(
                                alpha: max(crucialOT, buttonOpacity));
                            trackOutline =
                                WidgetStatePropertyAll<Color>(buttonOutline);
                          });
                        },
                        icon: EzIcon(PlatformIcons(context).refresh),
                        label: l10n.gReset,
                      ),
                      EzSpacer(space: spacing * 1.5),
                    ],
                  );
                },
              );
            },
          ),
          label: 'Button opacity', // TODO: l10n
          icon: const Icon(Icons.opacity),
          style: ElevatedButton.styleFrom(iconSize: iconSize),
        ),

        // Background image
        if (widget.includeBackgroundImage) ...<Widget>[
          ezSpacer,
          EzScrollView(
            scrollDirection: Axis.horizontal,
            startCentered: true,
            mainAxisSize: MainAxisSize.min,
            child: isDark
                ? EzImageSetting(
                    key: UniqueKey(),
                    configKey: darkBackgroundImageKey,
                    credits: widget.darkBackgroundCredits,
                    label: l10n.dsBackgroundImg.replaceAll(' ', '\n'),
                    updateTheme: Brightness.dark,
                  )
                : EzImageSetting(
                    key: UniqueKey(),
                    configKey: lightBackgroundImageKey,
                    credits: widget.lightBackgroundCredits,
                    label: l10n.dsBackgroundImg.replaceAll(' ', '\n'),
                    updateTheme: Brightness.light,
                  ),
          ),
        ],

        // After background
        if (widget.themedSettingsPostpend != null)
          ...widget.themedSettingsPostpend!,

        // Reset button
        widget.resetSpacer,
        EzResetButton(
          key: ValueKey<String>('reset_$redraw'),
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
            } else {
              await EzConfig.removeKeys(lightDesignKeys.keys.toSet());
              await EzConfig.remove(lightColorSchemeImageKey);

              if (widget.lightThemeResetKeys != null) {
                await EzConfig.removeKeys(widget.lightThemeResetKeys!);
              }
            }

            iconSize = defaultIconSize;

            drawState();
            widget.onReset?.call();
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
