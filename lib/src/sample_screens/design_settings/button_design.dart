/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';

class ButtonDesign extends StatelessWidget {
  final void Function() onUpdate;
  final List<Widget>? prepend;
  final List<Widget>? append;
  final Widget resetSpacer;
  final Set<String>? resetExtraDark;
  final Set<String>? resetExtraLight;
  final String appName;
  final String? androidPackage;
  final Set<String>? resetSkip;
  final Set<String>? saveSkip;

  const ButtonDesign({
    super.key,
    required this.onUpdate,
    required this.prepend,
    required this.append,
    this.resetSpacer = const EzSeparator(),
    required this.resetExtraDark,
    required this.resetExtraLight,
    required this.appName,
    required this.androidPackage,
    required this.resetSkip,
    required this.saveSkip,
  });

  // Return the build //
  @override
  Widget build(BuildContext context) {
    return EzScrollView(mainAxisSize: MainAxisSize.min, children: <Widget>[
      // Optional 'before' settings
      if (prepend != null) ...prepend!,

      // Padding
      EzPaddingSetting(
        onUpdate: onUpdate,
        min: minPadding,
        max: maxPadding,
        steps: 12,
        decimals: 1,
      ),
      EzConfig.spacer,

      // Button style
      _ButtonStyleSetting(onUpdate),
      EzConfig.spacer,

      // Button opacity
      _ButtonOpacitySetting(onUpdate),
      EzConfig.separator,

      // Underline links TODO: make 'links' a link (toggles switch too)
      EzSwitchPair(
        text: EzConfig.l10n.dsAlwaysUnderline,
        valueKey: EzConfig.isDark ? darkLineLinksKey : lightLineLinksKey,
        afterChanged: (bool? changed) async {
          if (changed == null) return;
          await EzConfig.redrawUI(onUpdate);
        },
      ),
      EzConfig.spacer,

      // Show back FAB
      EzSwitchPair(
        valueKey: EzConfig.isDark ? darkShowBackFABKey : lightShowBackFABKey,
        afterChanged: (bool? value) async {
          if (value == null) return;

          if (EzConfig.updateBoth) {
            await EzConfig.setBool(
                EzConfig.isDark ? lightShowBackFABKey : darkShowBackFABKey,
                value);
          }

          await EzConfig.rebuildUI(onUpdate);
        },
        text: EzConfig.l10n.dsShowBack,
      ),

      if (append != null) ...append!,

      // Local reset all
      resetSpacer,
      EzResetButton(
        all: false,
        onUpdate,
        androidPackage: androidPackage,
        appName: appName,
        dynamicTitle: () =>
            EzConfig.l10n.dsReset(ezThemeString(true)), // TODO: add button
        onConfirm: () async {
          if (EzConfig.updateBoth || EzConfig.isDark) {
            await EzConfig.removeKeys(darkButtonDesignKeys.keys.toSet());
            if (resetExtraDark != null) {
              await EzConfig.removeKeys(resetExtraDark!);
            }
          }

          if (EzConfig.updateBoth || !EzConfig.isDark) {
            await EzConfig.removeKeys(lightButtonDesignKeys.keys.toSet());
            if (resetExtraLight != null) {
              await EzConfig.removeKeys(resetExtraLight!);
            }
          }
        },
        resetSkip: resetSkip,
        saveSkip: saveSkip,
      ),
    ]);
  }
}

class _ButtonStyleSetting extends StatelessWidget {
  final void Function() onUpdate;

  const _ButtonStyleSetting(this.onUpdate);

  @override
  Widget build(BuildContext context) {
    return EzElevatedIconButton(
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
                                    side: currWidth == 0
                                        ? BorderSide.none
                                        : BorderSide(
                                            color: EzConfig
                                                .colors.primaryContainer,
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
                  EzConfig.l10n.dsBorderWidth,
                  style: EzConfig.styles.bodyLarge,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: ScreenSize.small.size),
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
                      if (EzConfig.updateBoth || EzConfig.isDark) {
                        await EzConfig.setDouble(darkBorderWidthKey, value);
                      }

                      if (EzConfig.updateBoth || !EzConfig.isDark) {
                        await EzConfig.setDouble(lightBorderWidthKey, value);
                      }
                    },
                  ),
                ),
                EzConfig.spacer,

                // Reset button
                EzElevatedIconButton(
                  onPressed: () async {
                    if (EzConfig.updateBoth || EzConfig.isDark) {
                      await EzConfig.remove(darkButtonShapeKey);
                      await EzConfig.remove(darkBorderWidthKey);
                    }
                    if (EzConfig.updateBoth || !EzConfig.isDark) {
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
          if (EzConfig.updateBoth || EzConfig.isDark) {
            await EzConfig.setString(darkButtonShapeKey, currShape.value);
          }

          if (EzConfig.updateBoth || !EzConfig.isDark) {
            await EzConfig.setString(lightButtonShapeKey, currShape.value);
          }

          await EzConfig.rebuildUI(onUpdate);
        }
      },
      label: 'Style', // TODO: l10n
      icon: const Icon(Icons.edit),
    );
  }
}

class _ButtonOpacitySetting extends StatelessWidget {
  final void Function() onUpdate;

  const _ButtonOpacitySetting(this.onUpdate);

  @override
  Widget build(BuildContext context) {
    return EzElevatedIconButton(
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
                              side: EzConfig.borderSide(buttonOutline),
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
                          if (EzConfig.updateBoth || EzConfig.isDark) {
                            await EzConfig.setDouble(
                              darkButtonOpacityKey,
                              value,
                            );
                          }
                          if (EzConfig.updateBoth || !EzConfig.isDark) {
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
                          if (EzConfig.updateBoth || EzConfig.isDark) {
                            await EzConfig.setDouble(
                              darkBorderOpacityKey,
                              value,
                            );
                          }

                          if (EzConfig.updateBoth || !EzConfig.isDark) {
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
                        if (EzConfig.updateBoth || EzConfig.isDark) {
                          await EzConfig.remove(darkButtonOpacityKey);
                          await EzConfig.remove(darkBorderOpacityKey);
                        }
                        if (EzConfig.updateBoth || !EzConfig.isDark) {
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
          await EzConfig.rebuildUI(onUpdate);
        }
      },
      label: 'Opacity', // TODO: l10n
      icon: const Icon(Icons.opacity),
    );
  }
}
