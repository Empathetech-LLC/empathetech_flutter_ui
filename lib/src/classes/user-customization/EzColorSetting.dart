/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzColorSetting extends StatefulWidget {
  final Key? key;

  /// [EzConfig] key whose [Color.value] will be updated
  final String setting;

  /// User-friendly [label] for the color whose value will be updated
  final String label;

  /// Optional [EzConfig] key that should be automatically changed alongside the base [setting]
  /// If provided, the [pairedTextSetting] key will be set via [getTextColor]
  /// And/or reset alongside the base [setting]
  final String? pairedTextSetting;

  /// Optional [EzConfig] key that controls the background color when [setting] text colors
  /// This will update the user's prompt, first asking if they would like to use the color from [getTextColor]
  /// Or provide a custom color
  final String? textBackgroundKey;

  /// Creates a tool for [setting] color values in [EzConfig]
  /// If [setting] surface colors, optionally provide a [pairedTextSetting]
  /// When provided, the [pairedTextSetting] key will be set via [getTextColor]
  /// If [setting] text ("on") colors, provide the [textBackgroundKey]
  /// [textBackgroundKey]s [EzConfig] value will be used to generate a recommendation via [getTextColor]
  const EzColorSetting({
    this.key,
    required this.setting,
    required this.label,
    this.pairedTextSetting,
    this.textBackgroundKey,
  })  : assert(
          (!(pairedTextSetting != null && textBackgroundKey != null)),
          'Either pairedTextSetting or textBackgroundKey can be provided, but not both.',
        ),
        super(key: key);

  @override
  _ColorSettingState createState() => _ColorSettingState();
}

class _ColorSettingState extends State<EzColorSetting> {
  // Gather theme data //

  late Color currColor = Color(EzConfig.get(widget.setting));

  final double _buttonSpacer = EzConfig.get(buttonSpacingKey);

  late final TextStyle? _labelStyle =
      Theme.of(context).dropdownMenuTheme.textStyle;

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

        if (widget.pairedTextSetting != null) {
          EzConfig.setInt(
              widget.pairedTextSetting!, getTextColor(currColor).value);
        }

        popScreen(context: context, pass: currColor.value);
      },
      onDeny: () => popScreen(context: context),
    );
  }

  /// Opens an [EzAlertDialog] for users to chose how they want to update the color
  /// Returns the [Color.value] of what was chosen (null if none)
  Future<dynamic> _changeColor(BuildContext context) {
    if (widget.textBackgroundKey == null) {
      // Base color //

      // Just open a color picker
      return _openColorPicker(context);
    } else {
      // "on" (aka text) color //

      // Find the recommended contrast color for the background
      Color backgroundColor = Color(EzConfig.get(widget.textBackgroundKey!) ??
          EzConfig.getInt(widget.textBackgroundKey!));

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

      if (widget.pairedTextSetting != null) {
        EzConfig.remove(widget.pairedTextSetting!);
      }

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
    return EzRow(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Color label
        Text(
          widget.label,
          style: _labelStyle,
          textAlign: TextAlign.center,
        ),
        EzSpacer.row(_buttonSpacer),

        // Color preview/edit button
        Semantics(
          button: true,
          hint: EFUILang.of(context)!.csPickerSemantics(widget.label),
          child: ExcludeSemantics(
            child: ElevatedButton(
              onPressed: () => _changeColor(context),
              onLongPress: () => _reset(context),
              child: Center(
                child: Icon(
                  PlatformIcons(context).edit,
                  color: getTextColor(currColor),
                ),
              ),
              style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                    backgroundColor: MaterialStatePropertyAll(currColor),
                    shape: MaterialStatePropertyAll(const CircleBorder()),
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
