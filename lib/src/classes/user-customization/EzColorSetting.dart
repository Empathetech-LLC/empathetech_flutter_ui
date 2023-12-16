/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
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

  /// Creates a tool for [setting] ColorScheme values via [EzConfig]
  /// When [setting] text ("on") colors, the base color will be used to generate a recommendation via [getTextColor]
  const EzColorSetting({this.key, required this.setting}) : super(key: key);

  @override
  _ColorSettingState createState() => _ColorSettingState();
}

class _ColorSettingState extends State<EzColorSetting> {
  // Gather the theme data //

  late Color currColor = Color(EzConfig.get(widget.setting));
  late final Color primaryColor = Theme.of(context).colorScheme.primary;

  final double _padding = EzConfig.get(paddingKey);

  late final String _label = getColorName(widget.setting, context);

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

        popScreen(context: context, pass: currColor.value);
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
      final String backgroundKey =
          widget.setting.replaceAll(textColorPrefix, "");

      // Find the recommended contrast color for the background
      Color backgroundColor =
          Color(EzConfig.get(backgroundKey) ?? EzConfig.getInt(backgroundKey));

      int recommended = getTextColor(backgroundColor).value;

      // Define action button parameters
      final String denyMsg = EFUILang.of(context)!.csUseCustom;

      final void Function() onConfirm = () {
        // Update the user's setting
        EzConfig.setInt(widget.setting, recommended);

        setState(() {
          currColor = Color(recommended);
        });

        popScreen(context: context, pass: recommended);
      };

      void Function() onDeny = () async {
        dynamic chosen = await _openColorPicker(context);
        popScreen(context: context, pass: chosen);
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
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: Color(recommended),
                border: Border.all(color: backgroundColor),
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

  /// Opens an [EzAlertDialog] for resetting the color(s) to default
  /// A preview of the reset color is shown, taken from the first in the list
  Future<dynamic> _reset(BuildContext context) {
    final Color resetColor = Color(EzConfig.getDefault(widget.setting));

    // Define action button parameters //

    final void Function() onConfirm = () {
      // Remove the user's setting and reset the current state
      EzConfig.remove(widget.setting);

      setState(() {
        currColor = resetColor;
      });

      popScreen(context: context, pass: resetColor);
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
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: resetColor,
              border: Border.all(color: getTextColor(resetColor)),
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

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      hint: EFUILang.of(context)!.csPickerSemantics(_label),
      child: ExcludeSemantics(
        child: ElevatedButton.icon(
          onPressed: () => _changeColor(context),
          onLongPress: () => _reset(context),
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
            child: CircleAvatar(
              backgroundColor: currColor,
              radius: _padding * sqrt(2),
            ),
          ),
          label: Text(
            _label,
            textAlign: TextAlign.center,
          ),
          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                padding: MaterialStateProperty.all(
                  EdgeInsets.all(_padding * 0.75),
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
