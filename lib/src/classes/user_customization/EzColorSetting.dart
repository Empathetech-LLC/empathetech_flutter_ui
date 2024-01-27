/* empathetech_flutter_ui
 * Copyright (c) 2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzColorSetting extends StatefulWidget {
  final Key? key;

  /// [EzConfig] key whose [Color.value] will be updated
  final String setting;

  /// Optional callback for when the setting is removed, if it is part of a dynamic set/list
  /// If null, the remove button will not be shown
  final void Function()? onRemove;

  /// Creates a tool for [setting] ColorScheme values via [EzConfig]
  /// When [setting] text ("on") colors, the base color will be used to generate a recommendation via [getTextColor]
  const EzColorSetting({
    this.key,
    required this.setting,
    this.onRemove,
  }) : super(key: key);

  @override
  _ColorSettingState createState() => _ColorSettingState();
}

class _ColorSettingState extends State<EzColorSetting> {
  // Gather the theme data //

  late final int? _prefsValue = EzConfig.get(widget.setting);
  late Color currColor =
      (_prefsValue == null) ? getLiveColor(context, widget.setting) : Color(_prefsValue);

  final double padding = EzConfig.get(paddingKey);
  final double buttonSpace = EzConfig.get(buttonSpacingKey);

  late final EzSpacer _buttonSpacer = EzSpacer(buttonSpace);

  // Define button functions //

  /// Opens an [ezColorPicker] for updating [currColor]
  /// Returns the [Color.value] of what was chosen (null otherwise)
  Future<dynamic> _openColorPicker(BuildContext context) {
    return ezColorPicker(
      context: context,
      startColor: currColor,
      onColorChange: (chosenColor) {
        // Update currColor
        setState(() {
          currColor = chosenColor;
        });
      },
      onConfirm: () {
        // Update the user's setting
        EzConfig.setInt(widget.setting, currColor.value);

        popScreen(context: context, result: currColor.value);
      },
      onDeny: () => popScreen(context: context),
    );
  }

  /// Opens an [EzAlertDialog] for users to chose how they want to update the color
  /// Returns the [Color.value] of what was chosen (null if none)
  Future<dynamic> _changeColor(BuildContext context) {
    if (!widget.setting.contains(textColorPrefix)) {
      // Base color //

      // Just open a color picker
      return _openColorPicker(context);
    } else {
      // "on" (aka text) color //
      final String backgroundKey = widget.setting.replaceAll(textColorPrefix, "");

      // Find the recommended contrast color for the background
      final int? backgroundColorValue = EzConfig.get(backgroundKey);
      final Color backgroundColor = backgroundColorValue == null
          ? getLiveColor(context, widget.setting)
          : Color(backgroundColorValue);

      final int recommended = getTextColor(backgroundColor).value;

      // Define action button parameters
      final String denyMsg = EFUILang.of(context)!.csUseCustom;

      final void Function() onConfirm = () {
        // Update the user's setting
        EzConfig.setInt(widget.setting, recommended);

        setState(() {
          currColor = Color(recommended);
        });

        popScreen(context: context, result: recommended);
      };

      void Function() onDeny = () async {
        dynamic chosen = await _openColorPicker(context);
        popScreen(context: context, result: chosen);
      };

      return showPlatformDialog(
        context: context,
        builder: (context) => EzAlertDialog(
          title: Text(
            EFUILang.of(context)!.csRecommended,
            textAlign: TextAlign.center,
          ),
          // Recommended color preview
          contents: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: backgroundColor),
              ),
              child: CircleAvatar(
                backgroundColor: Color(recommended),
                radius: padding * 2,
                child:
                    currColor == Colors.transparent ? Icon(PlatformIcons(context).eyeSlash) : null,
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

  /// Opens an [EzAlertDialog] for resetting [widget.setting] to default
  /// If there is no [EzConfig.defaults] value, the key will simply be removed from [EzConfig.prefs]
  /// If a value is found, a preview of the reset color is shown and the user can confirm/deny
  Future<dynamic> _reset(BuildContext context) {
    final int? resetValue = EzConfig.getDefault(widget.setting);

    if (resetValue == null) {
      EzConfig.remove(widget.setting);
      return Future.value(true);
    } else {
      final Color resetColor = Color(resetValue);

      final void Function() onConfirm = () {
        // Remove the user's setting and reset the current state
        EzConfig.remove(widget.setting);

        setState(() {
          currColor = resetColor;
        });

        popScreen(context: context, result: resetColor);
      };

      final void Function() onDeny = () => popScreen(context: context);

      return showPlatformDialog(
        context: context,
        builder: (context) => EzAlertDialog(
          title: Text(
            EFUILang.of(context)!.csResetTo,
            textAlign: TextAlign.center,
          ),
          // Reset color preview
          contents: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: getTextColor(resetColor)),
              ),
              child: CircleAvatar(
                backgroundColor: resetColor,
                radius: padding * 2,
                child:
                    currColor == Colors.transparent ? Icon(PlatformIcons(context).eyeSlash) : null,
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
  Future<dynamic> _options(BuildContext context) {
    if (widget.onRemove == null) {
      return _reset(context);
    } else {
      return showPlatformDialog(
          context: context,
          builder: (context) {
            return EzAlertDialog(
              title: Text(
                EFUILang.of(context)!.gOptions,
                textAlign: TextAlign.center,
              ),
              contents: [
                // Remove from list
                ElevatedButton.icon(
                  onPressed: widget.onRemove!,
                  icon: Icon(PlatformIcons(context).delete),
                  label: Text(EFUILang.of(context)!.csRemove),
                ),
                _buttonSpacer,

                // Reset to default
                ElevatedButton.icon(
                  onPressed: () async {
                    final resetResponse = await _reset(context);
                    popScreen(context: context, result: resetResponse);
                  },
                  icon: Icon(PlatformIcons(context).refresh),
                  label: Text(EFUILang.of(context)!.csReset),
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
    final String label = getColorName(context, widget.setting);

    return Semantics(
      button: true,
      hint: EFUILang.of(context)!.csPickerSemantics(label),
      child: ExcludeSemantics(
        child: ElevatedButton.icon(
          onPressed: () => _changeColor(context),
          onLongPress: () => _options(context),
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
              child:
                  currColor == Colors.transparent ? Icon(PlatformIcons(context).eyeSlash) : null,
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
