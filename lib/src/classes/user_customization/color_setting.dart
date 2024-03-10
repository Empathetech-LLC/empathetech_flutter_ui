/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzColorSetting extends StatefulWidget {
  /// [EzConfig] key whose [Color.value] will be updated
  final String configKey;

  /// Optional callback for when the configKey is removed, if it is part of a dynamic set/list
  /// If null, the remove button will not be shown
  final void Function()? onRemove;

  /// Creates a tool for [configKey] ColorScheme values via [EzConfig]
  /// When [configKey] text ("on") colors, the base color will be used to generate a recommendation via [getTextColor]
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

  final double padding = EzConfig.get(paddingKey);

  late final EzSpacer spacer = EzSpacer(EzConfig.get(spacingKey));

  late final EFUILang l10n = EFUILang.of(context)!;

  // Define button functions //

  /// Opens an [ezColorPicker] for updating [currColor]
  /// Returns the [Color.value] of what was chosen (null otherwise)
  Future<dynamic> openColorPicker(BuildContext context) {
    return ezColorPicker(
      context: context,
      startColor: currColor,
      onColorChange: (Color chosenColor) {
        // Update currColor
        setState(() {
          currColor = chosenColor;
        });
      },
      onConfirm: () {
        // Update the user's configKey
        EzConfig.setInt(widget.configKey, currColor.value);

        popScreen(context: context, result: currColor.value);
      },
      onDeny: () => popScreen(context: context),
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

      // Define action button parameters
      final String denyMsg = l10n.csUseCustom;

      void onConfirm() {
        // Update the user's configKey
        EzConfig.setInt(widget.configKey, recommended);

        setState(() {
          currColor = Color(recommended);
        });

        popScreen(context: context, result: recommended);
      }

      void onDeny() async {
        final dynamic chosen = await openColorPicker(context);
        popScreen(context: context, result: chosen);
      }

      return showPlatformDialog(
        context: context,
        builder: (BuildContext context) => EzAlertDialog(
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
              child: CircleAvatar(
                backgroundColor: Color(recommended),
                radius: padding * 2,
                child: currColor == Colors.transparent
                    ? Icon(PlatformIcons(context).eyeSlash)
                    : null,
              ),
            ),
          ],
          materialActions: ezMaterialActions(
            context: context,
            onConfirm: onConfirm,
            onDeny: onDeny,
            denyMsg: denyMsg,
          ),
          cupertinoActions: ezCupertinoActions(
            context: context,
            onConfirm: onConfirm,
            onDeny: onDeny,
            denyMsg: denyMsg,
            confirmIsDestructive: true,
          ),
        ),
      );
    }
  }

  /// Opens an [EzAlertDialog] for reconfigKey [widget.configKey] to default
  /// If there is no [EzConfig.defaults] value, the key will simply be removed from [EzConfig.prefs]
  /// If a value is found, a preview of the reset color is shown and the user can confirm/deny
  Future<dynamic> reset(BuildContext context) {
    final int? resetValue = EzConfig.getDefault(widget.configKey);

    if (resetValue == null) {
      EzConfig.remove(widget.configKey);
      return Future<bool>.value(true);
    } else {
      final Color resetColor = Color(resetValue);

      void onConfirm() {
        // Remove the user's configKey and reset the current state
        EzConfig.remove(widget.configKey);

        setState(() {
          currColor = resetColor;
        });

        popScreen(context: context, result: resetColor);
      }

      void onDeny() => popScreen(context: context);

      return showPlatformDialog(
        context: context,
        builder: (BuildContext context) => EzAlertDialog(
          title: Text(
            l10n.csResetTo,
            textAlign: TextAlign.center,
          ),
          // Reset color preview
          contents: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: getTextColor(resetColor)),
              ),
              child: CircleAvatar(
                backgroundColor: resetColor,
                radius: padding * 2,
                child: currColor == Colors.transparent
                    ? Icon(PlatformIcons(context).eyeSlash)
                    : null,
              ),
            ),
          ],
          materialActions: ezMaterialActions(
            context: context,
            onConfirm: onConfirm,
            onDeny: onDeny,
          ),
          cupertinoActions: ezCupertinoActions(
            context: context,
            onConfirm: onConfirm,
            onDeny: onDeny,
          ),
          needsClose: false,
        ),
      );
    }
  }

  /// Opens an [EzAlertDialog] with the all optional actions
  /// Remove from list, reset to default, and set to transparent
  Future<dynamic> options(BuildContext context) {
    if (widget.onRemove == null) {
      return reset(context);
    } else {
      return showPlatformDialog(
          context: context,
          builder: (BuildContext context) {
            return EzAlertDialog(
              title: Text(
                l10n.gOptions,
                textAlign: TextAlign.center,
              ),
              contents: <Widget>[
                // Remove from list
                ElevatedButton.icon(
                  onPressed: widget.onRemove!,
                  icon: Icon(PlatformIcons(context).delete),
                  label: Text(l10n.csRemove),
                ),
                spacer,

                // Reset to default
                ElevatedButton.icon(
                  onPressed: () async {
                    final dynamic resetResponse = await reset(context);
                    popScreen(context: context, result: resetResponse);
                  },
                  icon: Icon(PlatformIcons(context).refresh),
                  label: Text(l10n.csReset),
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
    final String label = getColorName(context, widget.configKey);

    return Semantics(
      button: true,
      hint: l10n.csPickerSemantics(label),
      child: ExcludeSemantics(
        child: ElevatedButton.icon(
          onPressed: () => changeColor(context),
          onLongPress: () => options(context),
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
            child: CircleAvatar(
              backgroundColor: currColor,
              radius: padding * sqrt(2),
              child: currColor == Colors.transparent
                  ? Icon(PlatformIcons(context).eyeSlash)
                  : null,
            ),
          ),
          label: Text(label),
          style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                padding: MaterialStateProperty.all(
                  EdgeInsets.all(padding * 0.75),
                ),
                foregroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.onSurface,
                ),
              ),
        ),
      ),
    );
  }
}
