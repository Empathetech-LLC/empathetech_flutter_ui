/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';

class EzDesignSettings extends StatefulWidget {
  /// [EzConfig.redrawUI]/[EzConfig.rebuildUI] passthrough
  final void Function() onUpdate;

  /// When true, updates both dark and light theme settings simultaneously
  final bool updateBoth;

  /// If provided, the "Editing: X theme" text will be a link with this callback
  final void Function()? themeLink;

  /// Optional additional settings at the top of the page
  /// BYO tailing spacer, leading spacer is a custom [EzSpacer]
  final List<Widget>? beforeDesign;

  /// Whether to include the background image setting
  /// When true, pairs well with [EzScreen], specifically [EzScreen.useImageDecoration]
  final bool includeBackgroundImage;

  /// Optional credits for the dark background image
  /// Moot if [includeBackgroundImage] is false
  final String? darkBackgroundCredits;

  /// Optional credits for the light background image
  /// Moot if [includeBackgroundImage] is false
  final String? lightBackgroundCredits;

  /// Optional additional settings at the bottom of the page (above the (optional) reset button)
  /// BYO leading spacer, trailing is [resetSpacer]
  final List<Widget>? afterDesign;

  /// Spacer before the [EzResetButton]
  final Widget resetSpacer;

  /// Additional [EzConfig] keys for the local [EzResetButton]
  /// [darkDesignKeys] by default
  final Set<String>? resetExtraDark;

  /// Additional [EzConfig] keys for the local [EzResetButton]
  /// [lightDesignKeys] by default
  final Set<String>? resetExtraLight;

  /// [EzResetButton.appName] passthrough
  final String appName;

  /// [EzResetButton.androidPackage] passthrough
  final String? androidPackage;

  /// [EzResetButton.resetSkip] passthrough
  final Set<String>? resetSkip;

  /// [EzResetButton.saveSkip] passthrough
  final Set<String>? saveSkip;

  /// Defaults to [EzSeparator]
  final Widget trail;

  /// Empathetech image settings
  /// Recommended to use as a [Scaffold.body]
  const EzDesignSettings({
    super.key,
    required this.onUpdate,
    this.updateBoth = false,
    this.themeLink,
    this.beforeDesign,
    this.includeBackgroundImage = true,
    this.darkBackgroundCredits,
    this.lightBackgroundCredits,
    this.afterDesign,
    this.resetSpacer = const EzDivider(),
    this.resetExtraDark,
    this.resetExtraLight,
    required this.appName,
    this.androidPackage,
    this.resetSkip,
    this.saveSkip,
    this.trail = const EzSeparator(),
  });

  @override
  State<EzDesignSettings> createState() => _EzDesignSettingsState();
}

class _EzDesignSettingsState extends State<EzDesignSettings>
    with WidgetsBindingObserver {
  // Init //

  @override
  void initState() {
    super.initState();
    ezWindowNamer(EzConfig.l10n.dsPageTitle);
    WidgetsBinding.instance.addObserver(this);
  }

  void redraw() {
    widget.onUpdate();
    setState(() {});
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

    return EzScrollView(children: <Widget>[
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
                      onChangeEnd: (double value) async {
                        if (widget.updateBoth || EzConfig.isDark) {
                          await EzConfig.setInt(
                            darkAnimationDurationKey,
                            value.toInt(),
                          );
                        }

                        if (widget.updateBoth || !EzConfig.isDark) {
                          await EzConfig.setInt(
                            lightAnimationDurationKey,
                            value.toInt(),
                          );
                        }
                      },
                    ),
                  ),
                  EzConfig.spacer,

                  // Reset button
                  EzElevatedIconButton(
                    onPressed: () async {
                      if (widget.updateBoth || EzConfig.isDark) {
                        await EzConfig.remove(darkAnimationDurationKey);
                        setModal(() => animDuration =
                            (EzConfig.getDefault(darkAnimationDurationKey)
                                    as int)
                                .toDouble());
                      }

                      if (widget.updateBoth || !EzConfig.isDark) {
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

          if (animDuration != backup) await EzConfig.rebuildUI(redraw);
        },
        label: EzConfig.l10n.dsAnimDuration,
        icon: const Icon(Icons.timer_outlined),
      ),
      EzConfig.spacer,

      // Page transition
      // TODO: semantics
      // TODO: research system defaults, make sure they're accurate
      EzElevatedIconButton(
        onPressed: () async {
          final EzPageTransition backupType = EzConfig.pageTransition;
          final bool backupFade = EzConfig.fadedTransition;

          EzPageTransition currType = backupType;
          bool currFade = backupFade;

          await ezModal(
            context: context,
            builder: (_) => StatefulBuilder(
              builder: (_, StateSetter setModal) => Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Type choices
                  RadioGroup<EzPageTransition>(
                    groupValue: currType,
                    onChanged: (EzPageTransition? choice) {
                      if (choice != null) setModal(() => currType = choice);
                    },
                    child: EzScrollView(
                      mainAxisSize: MainAxisSize.min,
                      scrollDirection: Axis.horizontal,
                      thumbVisibility: false,
                      showScrollHint: true,
                      children: EzPageTransition.values
                          .map(
                            (EzPageTransition type) => Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: EzConfig.spacing,
                                horizontal: EzConfig.spacing / 2,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  EzTextButton(
                                    text: type.name,
                                    textStyle: EzConfig.styles.labelLarge,
                                    textAlign: TextAlign.center,
                                    onPressed: () =>
                                        setModal(() => currType = type),
                                  ),
                                  EzIconButton(
                                    icon: type.icon,
                                    onPressed: () =>
                                        setModal(() => currType = type),
                                  ),
                                  ExcludeSemantics(
                                    child:
                                        EzRadio<EzPageTransition>(value: type),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  EzConfig.spacer,

                  // Fade switch
                  EzSwitchPair(
                    enabled: currType != EzPageTransition.none &&
                        currType != EzPageTransition.system,
                    valueKey: EzConfig.isDark
                        ? darkTransitionFadeKey
                        : lightTransitionFadeKey,
                    afterChanged: (bool? choice) {
                      if (choice != null) setModal(() => currFade = choice);
                    },
                    text: EzConfig.l10n.dsFadeTransition,
                  ),
                  EzSpacer(space: EzConfig.spargin),
                ],
              ),
            ),
          );

          if (currType != backupType || currFade != backupFade) {
            if (EzConfig.isDark || widget.updateBoth) {
              await EzConfig.setString(darkTransitionTypeKey, currType.value);
              await EzConfig.setBool(darkTransitionFadeKey, currFade);
            }

            if (!EzConfig.isDark || widget.updateBoth) {
              await EzConfig.setString(lightTransitionTypeKey, currType.value);
              await EzConfig.setBool(lightTransitionFadeKey, currFade);
            }

            await EzConfig.rebuildUI(redraw);
          }
        },
        icon: const Icon(Icons.slideshow),
        label: EzConfig.l10n.dsPageTransition,
      ),
      EzConfig.separator,

      // Background image
      if (widget.includeBackgroundImage) ...<Widget>[
        EzScrollView(
          scrollDirection: Axis.horizontal,
          startCentered: true,
          mainAxisSize: MainAxisSize.min,
          child: EzConfig.isDark
              ? EzImageSetting(
                  redraw,
                  configKey: darkBackgroundImageKey,
                  credits: widget.darkBackgroundCredits,
                  label: EzConfig.l10n.dsBackgroundImg.replaceAll(' ', '\n'),
                  updateBrightness: widget.updateBoth ? null : Brightness.dark,
                )
              : EzImageSetting(
                  redraw,
                  configKey: lightBackgroundImageKey,
                  credits: widget.lightBackgroundCredits,
                  label: EzConfig.l10n.dsBackgroundImg.replaceAll(' ', '\n'),
                  updateBrightness: widget.updateBoth ? null : Brightness.light,
                ),
        ),
        EzConfig.separator,
      ],

      // Button shape (&& border width)
      // TODO: l10n
      EzElevatedIconButton(
        onPressed: () async {
          final EzButtonShape shapeBackup = EzConfig.buttonShape;
          final double widthBackup = EzConfig.borderWidth;

          EzButtonShape currShape = shapeBackup;
          double currWidth = widthBackup;

          await ezModal(
            context: context,
            builder: (_) => StatefulBuilder(
              builder: (_, StateSetter setModal) => EzScrollView(
                children: <Widget>[
                  // Shape choices
                  RadioGroup<EzButtonShape>(
                    groupValue: currShape,
                    onChanged: (EzButtonShape? choice) {
                      if (choice != null) setModal(() => currShape = choice);
                    },
                    child: EzScrollView(
                      mainAxisSize: MainAxisSize.min,
                      scrollDirection: Axis.horizontal,
                      thumbVisibility: false,
                      showScrollHint: true,
                      children: EzButtonShape.values
                          .map(
                            (EzButtonShape shape) => Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: EzConfig.spacing,
                                horizontal: EzConfig.spacing / 2,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  EzElevatedButton(
                                    text: shape.name,
                                    style: ElevatedButton.styleFrom(
                                      side: BorderSide(
                                        color: EzConfig.colors.primaryContainer,
                                        width: currWidth,
                                      ),
                                      shape: shape.shape,
                                    ),
                                    onPressed: () =>
                                        setModal(() => currShape = shape),
                                  ),
                                  EzConfig.margin,
                                  ExcludeSemantics(
                                    child: EzRadio<EzButtonShape>(value: shape),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  EzConfig.spacer,

                  // Border width slider
                  Text(
                    'Border width',
                    style: EzConfig.styles.bodyLarge,
                  ),
                  ConstrainedBox(
                    constraints:
                        BoxConstraints(maxWidth: ScreenSize.small.size),
                    child: Slider(
                      // Slider values
                      value: currWidth,
                      min: minBorderWidth,
                      max: maxBorderWidth,
                      divisions: 30,
                      label: currWidth.toStringAsFixed(2),

                      // Slider functions
                      onChanged: (double value) =>
                          setModal(() => currWidth = value),
                      onChangeEnd: (double value) async {
                        if (widget.updateBoth || EzConfig.isDark) {
                          await EzConfig.setDouble(darkBorderWidthKey, value);
                        }

                        if (widget.updateBoth || !EzConfig.isDark) {
                          await EzConfig.setDouble(lightBorderWidthKey, value);
                        }
                      },
                    ),
                  ),
                  EzConfig.spacer,

                  // Reset button
                  EzElevatedIconButton(
                    onPressed: () async {
                      if (widget.updateBoth || EzConfig.isDark) {
                        await EzConfig.remove(darkButtonShapeKey);
                        await EzConfig.remove(darkBorderWidthKey);
                      }
                      if (widget.updateBoth || !EzConfig.isDark) {
                        await EzConfig.remove(lightButtonShapeKey);
                        await EzConfig.remove(lightBorderWidthKey);
                      }

                      setModal(() {
                        currShape = EBSConfig.lookup(EzConfig.getDefault(
                            EzConfig.isDark
                                ? darkButtonShapeKey
                                : lightButtonShapeKey));
                        currWidth = EzConfig.getDefault(EzConfig.isDark
                            ? darkBorderWidthKey
                            : lightBorderWidthKey);
                      });
                    },
                    icon: const Icon(Icons.refresh),
                    label: EzConfig.l10n.gReset,
                  ),
                  EzConfig.separator,
                ],
              ),
            ),
          );

          if (currShape != shapeBackup || currWidth != widthBackup) {
            if (widget.updateBoth || EzConfig.isDark) {
              await EzConfig.setString(darkButtonShapeKey, currShape.value);
            }

            if (widget.updateBoth || !EzConfig.isDark) {
              await EzConfig.setString(lightButtonShapeKey, currShape.value);
            }

            await EzConfig.rebuildUI(redraw);
          }
        },
        label: EzConfig.l10n.dsButtonStyle,
        icon: const Icon(Icons.edit),
      ),
      EzConfig.spacer,

      // Button opacity
      EzElevatedIconButton(
        onPressed: () async {
          final double buttonBackup = EzConfig.buttonOpacity;
          final double borderBackup = EzConfig.borderOpacity;

          double buttonOpacity = buttonBackup;
          double borderOpacity = borderBackup;

          await ezModal(
            context: context,
            builder: (_) {
              bool dummyBool = true;

              return StatefulBuilder(
                builder: (_, StateSetter setModal) {
                  Color buttonBackground =
                      EzConfig.colors.surface.withValues(alpha: buttonOpacity);
                  Color buttonShadow = EzConfig.colors.shadow
                      .withValues(alpha: buttonOpacity * shadowMod);
                  Color buttonOutline = EzConfig.colors.primaryContainer
                      .withValues(alpha: borderOpacity);

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
                                side: BorderSide(
                                  color: buttonOutline,
                                  width: EzConfig.borderWidth,
                                ),
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
                          onChangeEnd: (double value) async {
                            if (widget.updateBoth || EzConfig.isDark) {
                              await EzConfig.setDouble(
                                darkButtonOpacityKey,
                                value,
                              );
                            }
                            if (widget.updateBoth || !EzConfig.isDark) {
                              await EzConfig.setDouble(
                                lightButtonOpacityKey,
                                value,
                              );
                            }
                          },
                        ),
                      ),
                      EzConfig.spacer,

                      // Outline slider
                      Text(
                        EzConfig.l10n.dsOutline,
                        style: EzConfig.styles.bodyLarge,
                      ),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: ScreenSize.small.size),
                        child: Slider(
                          // Slider values
                          value: borderOpacity,
                          min: minOpacity,
                          max: maxOpacity,
                          divisions: 20,
                          label: borderOpacity.toStringAsFixed(2),

                          // Slider functions
                          onChanged: (double value) =>
                              setModal(() => borderOpacity = value),
                          onChangeEnd: (double value) async {
                            if (widget.updateBoth || EzConfig.isDark) {
                              await EzConfig.setDouble(
                                darkBorderOpacityKey,
                                value,
                              );
                            }

                            if (widget.updateBoth || !EzConfig.isDark) {
                              await EzConfig.setDouble(
                                lightBorderOpacityKey,
                                value,
                              );
                            }
                          },
                        ),
                      ),
                      EzConfig.spacer,

                      // Reset button
                      EzElevatedIconButton(
                        onPressed: () async {
                          if (widget.updateBoth || EzConfig.isDark) {
                            await EzConfig.remove(darkButtonOpacityKey);
                            await EzConfig.remove(darkBorderOpacityKey);
                          }
                          if (widget.updateBoth || !EzConfig.isDark) {
                            await EzConfig.remove(lightButtonOpacityKey);
                            await EzConfig.remove(lightBorderOpacityKey);
                          }

                          setModal(() {
                            buttonOpacity = EzConfig.getDefault(EzConfig.isDark
                                ? darkButtonOpacityKey
                                : lightButtonOpacityKey);
                            borderOpacity = EzConfig.getDefault(EzConfig.isDark
                                ? darkBorderOpacityKey
                                : lightBorderOpacityKey);

                            buttonBackground = EzConfig.colors.surface
                                .withValues(alpha: buttonOpacity);
                            buttonShadow = EzConfig.colors.shadow
                                .withValues(alpha: buttonOpacity * shadowMod);
                            buttonOutline = EzConfig.colors.primaryContainer
                                .withValues(alpha: borderOpacity);

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
          );

          if (buttonOpacity != buttonBackup || borderOpacity != borderBackup) {
            await EzConfig.rebuildUI(redraw);
          }
        },
        label: EzConfig.l10n.dsButtonOpacity,
        icon: const Icon(Icons.opacity),
      ),

      // After background
      if (widget.afterDesign != null) ...widget.afterDesign!,

      // Reset button
      widget.resetSpacer,
      EzResetButton(
        redraw,
        androidPackage: widget.androidPackage,
        appName: widget.appName,
        dialogTitle: EzConfig.l10n.dsReset(widget.updateBoth &&
                EzConfig.locale.languageCode == english.languageCode
            ? "$themeString'"
            : themeString),
        onConfirm: () async {
          if (widget.updateBoth || EzConfig.isDark) {
            await EzConfig.removeKeys(<String>{
              ...darkDesignKeys.keys.toSet(),
              darkColorSchemeImageKey,
            });

            if (widget.resetExtraDark != null) {
              await EzConfig.removeKeys(widget.resetExtraDark!);
            }
          }

          if (widget.updateBoth || !EzConfig.isDark) {
            await EzConfig.removeKeys(<String>{
              ...lightDesignKeys.keys.toSet(),
              lightColorSchemeImageKey,
            });

            if (widget.resetExtraLight != null) {
              await EzConfig.removeKeys(widget.resetExtraLight!);
            }
          }
        },
        resetBoth: widget.updateBoth,
        resetSkip: widget.resetSkip,
        saveSkip: widget.saveSkip,
      ),
      widget.trail,
    ]);
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
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (_, BoxConstraints constraints) => AnimatedBuilder(
          animation: _animation,
          builder: (_, Widget? child) {
            double xOffset;
            final double value = _animation.value;
            final double halfWidth = constraints.maxWidth / 2;

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
              offset: Offset(xOffset * (EzConfig.isLTR ? 1.0 : -1.0), 0),
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
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
