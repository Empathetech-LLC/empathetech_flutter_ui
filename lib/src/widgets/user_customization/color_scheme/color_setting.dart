// ignore_for_file: deprecated_member_use
// Color.value was deprecated without replacement, .toARGB32() should be in next stable release

/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzColorSetting extends StatefulWidget {
  /// [EzConfig] key whose [Color.value] will be updated
  final String configKey;

  /// Optional callback for when the [configKey] is removed, if it is part of a dynamic set/list
  /// If null, the remove button will not be shown
  /// DO NOT include a pop() for the dialog, this is included automatically
  final void Function()? onRemove;

  /// Creates a tool for [configKey] ColorScheme values via [EzConfig]
  /// When [configKey] is a text ("on") color, the base color will be used to generate a recommendation via [getTextColor]
  /// [EzColorSetting] inherits styling from the [ElevatedButton] and [AlertDialog] values in your [ThemeData]
  const EzColorSetting({
    super.key,
    required this.configKey,
    this.onRemove,
  });

  @override
  State<EzColorSetting> createState() => _ColorSettingState();
}

class _ColorSettingState extends State<EzColorSetting> {
  // Gather the theme data //

  late final int? _prefsValue = EzConfig.get(widget.configKey);

  late Color currColor = (_prefsValue == null)
      ? getLiveColor(context, widget.configKey)
      : Color(_prefsValue);

  final double margin = EzConfig.get(marginKey);
  final double padding = EzConfig.get(paddingKey);

  static const EzSpacer spacer = EzSpacer();

  late final ThemeData theme = Theme.of(context);

  late final EFUILang l10n = EFUILang.of(context)!;

  // Define button functions //

  /// Opens an [ezColorPicker] for updating [currColor]
  /// Returns the [Color.value] of what was chosen (null otherwise)
  Future<dynamic> openColorPicker(BuildContext context) {
    final Color backup = currColor;

    return ezColorPicker(
      context,
      startColor: backup,
      onColorChange: (Color chosenColor) =>
          setState(() => currColor = chosenColor),
      onConfirm: () async {
        await EzConfig.setInt(widget.configKey, currColor.value);
      },
      onDeny: () => setState(() => currColor = backup),
    );
  }

  /// Opens an [EzAlertDialog] for users to chose how they want to update the color
  /// Returns the [Color.value] of what was chosen (null if none)
  Future<dynamic> changeColor(BuildContext context) {
    if (!widget.configKey.contains(textColorPrefix)) {
      // Base color //

      // Just open a color picker
      return openColorPicker(context);
    } else {
      // 'on' (aka text) color //
      final String backgroundKey = widget.configKey.replaceAll(
        textColorPrefix,
        '',
      );

      // Find the recommended contrast color for the background
      final int? backgroundColorValue = EzConfig.get(backgroundKey);
      final Color backgroundColor = backgroundColorValue == null
          ? getLiveColor(context, widget.configKey)
          : Color(backgroundColorValue);

      final int recommended = getTextColor(backgroundColor).value;

      // Just open a color picker if the value is already what's recommended
      if (recommended == currColor.value) return openColorPicker(context);

      // Define action button parameters
      final String denyMsg = l10n.csUseCustom;

      return showPlatformDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          void onConfirm() async {
            // Update the user's configKey
            currColor = Color(recommended);
            await EzConfig.setInt(widget.configKey, recommended);
            setState(() {});

            if (dialogContext.mounted) {
              Navigator.of(dialogContext).pop(recommended);
            }
          }

          void onDeny() async {
            final dynamic chosen = await openColorPicker(context);

            if (dialogContext.mounted) {
              Navigator.of(dialogContext).pop(chosen);
            }
          }

          return EzAlertDialog(
            title: Text(
              l10n.csRecommended,
              textAlign: TextAlign.center,
            ),
            // Recommended color preview
            contents: <Widget>[
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: backgroundColor),
                ),
                child: recommended == transparentHex
                    ? CircleAvatar(
                        backgroundColor: theme.colorScheme.surface,
                        foregroundColor: theme.colorScheme.onSurface,
                        radius: padding + margin,
                        child: Icon(
                          PlatformIcons(context).eyeSlash,
                          size: theme.textTheme.titleLarge?.fontSize,
                        ),
                      )
                    : CircleAvatar(
                        backgroundColor: Color(recommended),
                        foregroundColor: getTextColor(Color(recommended)),
                        radius: padding + margin,
                      ),
              ),
            ],
            materialActions: ezMaterialActions(
              context: context,
              onConfirm: onConfirm,
              confirmIsDestructive: true,
              denyMsg: denyMsg,
              onDeny: onDeny,
              denyIsDestructive: true,
            ),
            cupertinoActions: ezCupertinoActions(
              context: context,
              onConfirm: onConfirm,
              confirmIsDestructive: true,
              denyMsg: denyMsg,
              onDeny: onDeny,
              denyIsDestructive: true,
            ),
          );
        },
      );
    }
  }

  /// Opens an [EzAlertDialog] for resetting the [widget.configKey] to default
  /// If there is no [EzConfig.defaults] value, the key will simply be removed from [EzConfig.prefs]
  /// If a value is found, a preview of the reset color is shown and the user can confirm/deny
  Future<dynamic> reset(BuildContext context) async {
    return showPlatformDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        final int? resetValue = EzConfig.getDefault(widget.configKey);
        final String currColorLabel =
            currColor.value.toRadixString(16).toUpperCase().substring(2);

        void onConfirm() async {
          // Remove the user's configKey and reset the current state
          await EzConfig.remove(widget.configKey);
          if (resetValue != null) currColor = Color(resetValue);
          setState(() {});

          if (dialogContext.mounted) Navigator.of(dialogContext).pop();
        }

        void onDeny() => Navigator.of(dialogContext).pop();

        return EzAlertDialog(
          title: Text(
            l10n.gResetValue(
              getColorName(widget.configKey).toLowerCase(),
            ),
            textAlign: TextAlign.center,
          ),
          contents: <Widget>[
            Text(l10n.csCurrVal, textAlign: TextAlign.center),
            EzMargin(),
            EzTextIconButton(
              onPressed: () => Clipboard.setData(
                ClipboardData(text: currColorLabel),
              ),
              icon: const Icon(Icons.copy),
              label: currColorLabel,
            ),
          ],
          materialActions: ezMaterialActions(
            context: context,
            onConfirm: onConfirm,
            confirmIsDestructive: true,
            onDeny: onDeny,
          ),
          cupertinoActions: ezCupertinoActions(
            context: context,
            onConfirm: onConfirm,
            confirmIsDestructive: true,
            onDeny: onDeny,
          ),
          needsClose: false,
        );
      },
    );
  }

  /// Opens an [EzAlertDialog] with the all optional actions
  /// Remove from list, reset to default, and set to transparent
  Future<dynamic> options(BuildContext context) {
    if (widget.onRemove == null) {
      return reset(context);
    } else {
      return showPlatformDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return EzAlertDialog(
              title: Text(
                l10n.gOptions,
                textAlign: TextAlign.center,
              ),
              contents: <Widget>[
                // Remove from list
                EzElevatedIconButton(
                  onPressed: () {
                    widget.onRemove!();
                    Navigator.of(dialogContext).pop();
                  },
                  icon: Icon(PlatformIcons(context).delete),
                  label: l10n.csRemove,
                ),
                spacer,

                // Reset to default
                EzElevatedIconButton(
                  onPressed: () async {
                    final dynamic resetResponse = await reset(context);

                    if (dialogContext.mounted) {
                      Navigator.of(dialogContext).pop(resetResponse);
                    }
                  },
                  icon: Icon(PlatformIcons(context).refresh),
                  label: l10n.csReset,
                ),
              ],
              needsClose: true,
            );
          });
    }
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final String label = getColorName(widget.configKey);

    return Semantics(
      button: true,
      hint: l10n.csPickerHint(label),
      child: ExcludeSemantics(
        child: EzElevatedIconButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(padding * 0.75),
          ),
          onPressed: () => changeColor(context),
          onLongPress: () => options(context),
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: theme.colorScheme.primaryContainer),
            ),
            child: currColor == Colors.transparent
                ? CircleAvatar(
                    backgroundColor: theme.colorScheme.surface,
                    foregroundColor: theme.colorScheme.onSurface,
                    radius: padding + margin,
                    child: Icon(
                      PlatformIcons(context).eyeSlash,
                      size: theme.textTheme.titleLarge?.fontSize,
                    ),
                  )
                : CircleAvatar(
                    backgroundColor: currColor,
                    foregroundColor: getTextColor(currColor),
                    radius: padding + margin,
                  ),
          ),
          label: label,
        ),
      ),
    );
  }
}
