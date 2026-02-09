/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class EzDesignSettings extends StatefulWidget {
  /// When true, updates both dark and light theme settings simultaneously
  final bool updateBoth;

  /// If provided, the "Editing: X theme" text will be a link with this callback
  final void Function()? themeLink;

  /// Optional additional settings at the top of the page
  /// BYO tailing spacer, leading spacer is a custom [EzSpacer]
  final List<Widget>? beforeDesign;

  /// Whether to include animation duration control
  final bool includeAnimation;

  /// Whether to include the background image setting
  /// When true, pairs well with [EzScreen], specifically [EzScreen.useImageDecoration]
  final bool includeBackgroundImage;

  /// Optional credits for the dark background image
  /// Moot if [includeBackgroundImage] is false
  final String? darkBackgroundCredits;

  /// Optional credits for the light background image
  /// Moot if [includeBackgroundImage] is false
  final String? lightBackgroundCredits;

  /// Whether to include the scrollbar visibility toggle
  final bool includeScroll;

  /// Whether to include icon size controls
  final bool includeIconSize;

  /// Optional additional settings at the bottom of the page (above the (optional) reset button)
  /// BYO leading spacer, trailing is [resetSpacer]
  final List<Widget>? afterDesign;

  /// Spacer before the [EzResetButton]
  final Widget resetSpacer;

  /// Additional [EzConfig] keys for the local [EzResetButton]
  /// [darkDesignKeys], [darkHideScrollKey], [darkIconSizeKey] are included by default
  final Set<String>? resetExtraDark;

  /// Additional [EzConfig] keys for the local [EzResetButton]
  /// [lightDesignKeys], [lightHideScrollKey], [lightIconSizeKey] are included by default
  final Set<String>? resetExtraLight;

  /// [EzConfig.redrawUI]/[EzConfig.rebuildUI] passthrough
  final void Function() onRedraw;

  /// [EzResetButton.appName] passthrough
  final String appName;

  /// [EzResetButton.androidPackage] passthrough
  final String? androidPackage;

  /// [EzResetButton.resetSkip] passthrough
  final Set<String>? resetSkip;

  /// [EzResetButton.saveSkip] passthrough
  final Set<String>? saveSkip;

  /// Empathetech image settings
  /// Recommended to use as a [Scaffold.body]
  const EzDesignSettings({
    super.key,
    this.updateBoth = false,
    this.themeLink,
    this.beforeDesign,
    this.includeAnimation = true,
    this.includeBackgroundImage = true,
    this.darkBackgroundCredits,
    this.lightBackgroundCredits,
    this.includeScroll = true,
    this.includeIconSize = true,
    this.afterDesign,
    this.resetSpacer = const EzDivider(),
    this.resetExtraDark,
    this.resetExtraLight,
    required this.onRedraw,
    required this.appName,
    this.androidPackage,
    this.resetSkip,
    this.saveSkip,
  });

  @override
  State<EzDesignSettings> createState() => _EzDesignSettingsState();
}

class _EzDesignSettingsState extends State<EzDesignSettings>
    with WidgetsBindingObserver {
  // Define the build data //

  final bool strictMobile = !kIsWeb && EzConfig.onMobile;

  // Init //

  @override
  void initState() {
    super.initState();
    ezWindowNamer(EzConfig.l10n.dsPageTitle);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final String themeString = (widget.updateBoth
            ? EzConfig.l10n.gBothThemes
            : EzConfig.isDark
                ? EzConfig.l10n.gDarkTheme
                : EzConfig.l10n.gLightTheme)
        .toLowerCase();

    // Return the build //

    return EzScrollView(
      children: <Widget>[
        (widget.themeLink != null)
            ? EzLink(
                EzConfig.l10n.gEditing + themeString,
                onTap: widget.themeLink,
                hint: EzConfig.l10n.gEditingThemeHint,
                style: EzConfig.styles.labelLarge,
                textAlign: TextAlign.center,
              )
            : EzText(
                EzConfig.l10n.gEditing + themeString,
                style: EzConfig.styles.labelLarge,
                textAlign: TextAlign.center,
              ),
        EzConfig.spacer,

        if (widget.beforeDesign != null) ...widget.beforeDesign!,

        // Animation duration
        if (widget.includeAnimation) ...<Widget>[
          EzElevatedIconButton(
            onPressed: () async {
              double animDuration = EzConfig.animDur.toDouble();
              final double backup = animDuration;

              await ezModal(
                context: context,
                builder: (_) => StatefulBuilder(
                  builder: (_, StateSetter setModal) => EzScrollView(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // Preview
                      SizedBox(
                        height: EzConfig.iconSize * 3,
                        child: _AnimationPreview(
                          duration: animDuration.toInt(),
                          iconSize: EzConfig.iconSize,
                        ),
                      ),
                      EzConfig.spacer,

                      // Slider
                      Text(
                        EzConfig.l10n.dsMilliseconds,
                        style: EzConfig.styles.bodyLarge,
                      ),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: ScreenSize.small.size),
                        child: Slider(
                          value: animDuration,
                          min: minAnimationDuration.toDouble(),
                          max: maxAnimationDuration.toDouble(),
                          divisions: 20,
                          label: animDuration.toStringAsFixed(0),
                          onChanged: (double value) =>
                              setModal(() => animDuration = value),
                          onChangeEnd: (double value) => EzConfig.isDark
                              ? EzConfig.setInt(
                                  darkAnimationDurationKey,
                                  value.toInt(),
                                )
                              : EzConfig.setInt(
                                  lightAnimationDurationKey,
                                  value.toInt(),
                                ),
                        ),
                      ),
                      EzConfig.spacer,

                      // Reset button
                      EzElevatedIconButton(
                        onPressed: () async {
                          if (EzConfig.isDark) {
                            await EzConfig.remove(darkAnimationDurationKey);
                            setModal(() => animDuration =
                                (EzConfig.getDefault(darkAnimationDurationKey)
                                        as int)
                                    .toDouble());
                          } else {
                            await EzConfig.remove(lightAnimationDurationKey);
                            setModal(() => animDuration =
                                (EzConfig.getDefault(lightAnimationDurationKey)
                                        as int)
                                    .toDouble());
                          }
                        },
                        icon: const Icon(Icons.refresh),
                        label: EzConfig.l10n.gReset,
                      ),
                      EzConfig.separator,
                    ],
                  ),
                ),
              );

              if (animDuration != backup) {
                await EzConfig.rebuildUI(widget.onRedraw);
              }
            },
            label: EzConfig.l10n.dsAnimDuration,
            icon: const Icon(Icons.timer_outlined),
          ),
          EzConfig.spacer,
        ],

        // Background image
        if (widget.includeBackgroundImage) ...<Widget>[
          EzScrollView(
            scrollDirection: Axis.horizontal,
            startCentered: true,
            mainAxisSize: MainAxisSize.min,
            child: EzConfig.isDark
                ? EzImageSetting(
                    widget.onRedraw,
                    configKey: darkBackgroundImageKey,
                    credits: widget.darkBackgroundCredits,
                    label: EzConfig.l10n.dsBackgroundImg.replaceAll(' ', '\n'),
                    updateBrightness: Brightness.dark,
                  )
                : EzImageSetting(
                    widget.onRedraw,
                    configKey: lightBackgroundImageKey,
                    credits: widget.lightBackgroundCredits,
                    label: EzConfig.l10n.dsBackgroundImg.replaceAll(' ', '\n'),
                    updateBrightness: Brightness.light,
                  ),
          ),
          EzConfig.spacer,
        ],

        // Button opacity
        EzElevatedIconButton(
          onPressed: () => ezModal(
            context: context,
            builder: (_) {
              final String buttonOpacityKey = EzConfig.isDark
                  ? darkButtonOpacityKey
                  : lightButtonOpacityKey;
              final String buttonOutlineOpacityKey = EzConfig.isDark
                  ? darkButtonOutlineOpacityKey
                  : lightButtonOutlineOpacityKey;

              double buttonOpacity = EzConfig.get(buttonOpacityKey);
              double outlineOpacity = EzConfig.get(buttonOutlineOpacityKey);

              bool dummyBool = true;

              return StatefulBuilder(
                builder: (_, StateSetter setModal) {
                  Color buttonBackground =
                      EzConfig.colors.surface.withValues(alpha: buttonOpacity);
                  Color buttonShadow = EzConfig.colors.shadow
                      .withValues(alpha: buttonOpacity * shadowMod);
                  Color buttonOutline = EzConfig.colors.primaryContainer
                      .withValues(alpha: outlineOpacity);

                  Color trackColor = EzConfig.colors.surface
                      .withValues(alpha: max(focusOpacity, buttonOpacity));
                  WidgetStatePropertyAll<Color> trackOutline =
                      WidgetStatePropertyAll<Color>(buttonOutline);

                  return EzScrollView(
                    children: <Widget>[
                      // Preview
                      Wrap(
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EzInsets.wrap(EzConfig.spacing),
                            child: EzElevatedButton(
                              text: EzConfig.l10n.dsPreview,
                              onPressed: doNothing,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: buttonBackground,
                                shadowColor: buttonShadow,
                                side: BorderSide(color: buttonOutline),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EzInsets.wrap(EzConfig.spacing),
                            child: Transform.scale(
                              scale: ezIconRatio(),
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
                      EzConfig.spacer,

                      // Background slider
                      Text(
                        EzConfig.l10n.dsBackground,
                        style: EzConfig.styles.bodyLarge,
                      ),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: ScreenSize.small.size),
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
                            EzConfig.isDark
                                ? darkButtonOpacityKey
                                : lightButtonOpacityKey,
                            value,
                          ),
                        ),
                      ),
                      EzConfig.spacer,

                      // Outline slider
                      Text(EzConfig.l10n.dsOutline,
                          style: EzConfig.styles.bodyLarge),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: ScreenSize.small.size),
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
                            EzConfig.isDark
                                ? darkButtonOutlineOpacityKey
                                : lightButtonOutlineOpacityKey,
                            value,
                          ),
                        ),
                      ),
                      EzConfig.spacer,

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

                            buttonBackground = EzConfig.colors.surface
                                .withValues(alpha: buttonOpacity);
                            buttonShadow = EzConfig.colors.shadow
                                .withValues(alpha: buttonOpacity * shadowMod);
                            buttonOutline = EzConfig.colors.primaryContainer
                                .withValues(alpha: outlineOpacity);

                            trackColor = EzConfig.colors.surface.withValues(
                                alpha: max(focusOpacity, buttonOpacity));
                            trackOutline =
                                WidgetStatePropertyAll<Color>(buttonOutline);
                          });
                        },
                        icon: const Icon(Icons.refresh),
                        label: EzConfig.l10n.gReset,
                      ),
                      EzConfig.separator,
                    ],
                  );
                },
              );
            },
          ),
          label: EzConfig.l10n.dsButtonOpacity,
          icon: const Icon(Icons.opacity),
        ),
        (widget.includeScroll || widget.includeIconSize)
            ? EzConfig.divider
            : EzConfig.spacer,

        // Scrollbar toggle
        if (widget.includeScroll) ...<Widget>[
          EzSwitchPair(
            valueKey: EzConfig.isDark ? darkHideScrollKey : lightHideScrollKey,
            text: EzConfig.l10n.lsScroll,
          ),
          EzConfig.spacer,
        ],

        // Icon size
        if (widget.includeIconSize) const EzIconSizeSetting(),

        // After background
        if (widget.afterDesign != null) ...widget.afterDesign!,

        // Reset button
        widget.resetSpacer,
        EzResetButton(
          widget.onRedraw,
          dialogTitle: EzConfig.l10n.dsReset(widget.updateBoth &&
                  EzConfig.locale.languageCode == english.languageCode
              ? "$themeString'"
              : themeString),
          onConfirm: () async {
            if (EzConfig.isDark) {
              await EzConfig.removeKeys(<String>{
                ...darkDesignKeys.keys.toSet(),
                darkColorSchemeImageKey,
                darkIconSizeKey,
                darkHideScrollKey,
              });

              if (widget.resetExtraDark != null) {
                await EzConfig.removeKeys(widget.resetExtraDark!);
              }
            } else {
              await EzConfig.removeKeys(<String>{
                ...lightDesignKeys.keys.toSet(),
                lightColorSchemeImageKey,
                lightIconSizeKey,
                lightHideScrollKey,
              });

              if (widget.resetExtraLight != null) {
                await EzConfig.removeKeys(widget.resetExtraLight!);
              }
            }
          },
          resetSkip: widget.resetSkip,
          saveSkip: widget.saveSkip,
          appName: widget.appName,
          androidPackage: widget.androidPackage,
        ),
        EzConfig.separator,
      ],
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

class _AnimationPreview extends StatefulWidget {
  final int duration;
  final double iconSize;

  const _AnimationPreview({required this.duration, required this.iconSize});

  @override
  State<_AnimationPreview> createState() => _AnimationPreviewState();
}

class _AnimationPreviewState extends State<_AnimationPreview>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  // Init //

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void didUpdateWidget(covariant _AnimationPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      _controller.duration = Duration(milliseconds: widget.duration);
    }
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        final double width = constraints.maxWidth;
        final double direction = EzConfig.isLTR ? 1.0 : -1.0;

        return AnimatedBuilder(
          animation: _animation,
          builder: (_, Widget? child) {
            double xOffset;
            final double value = _animation.value;
            final double halfWidth = width / 2;

            if (value < 0.5) {
              // Center to edge
              final double progress = value * 2;
              xOffset = progress * halfWidth;
            } else {
              // Opposite edge to center
              final double progress = (value - 0.5) * 2;
              xOffset = -halfWidth + (progress * halfWidth);
            }

            return Transform.translate(
              offset: Offset(xOffset * direction, 0),
              child: child,
            );
          },
          child: Center(
            child: EzIconButton(
              onPressed: () => _controller.isAnimating
                  ? _controller.stop()
                  : _controller.forward(from: 0.0),
              icon: const Icon(Icons.play_arrow),
              iconSize: widget.iconSize,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
