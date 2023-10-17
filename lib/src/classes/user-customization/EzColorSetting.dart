/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzColorSetting extends StatefulWidget {
  final Key? key;

  /// [EzConfig.instance] key whose value will be updated
  final String toControl;

  /// User-friendly name of the color whose value will be updated
  /// [name] will be on the left when [EzConfig.dominantHand] is [Hand.right], and vice versa
  final String name;

  /// Optional [EzConfig.instance] key that controls the background color...
  /// in the event [toControl] is a [Text]colorKey
  final String? textBackgroundKey;

  /// Creates a tool for updating the value of [toControl] in [EzConfig]
  /// If [toControl] is a [Text]colorKey, provide [textBackgroundKey]
  /// [textBackgroundKey]s current [Color] in [EzConfig.instance] will be used to generate a recommended color (based on readability)
  /// The user will still be given the option to fully customize the [Color]
  const EzColorSetting({
    this.key,
    required this.toControl,
    required this.name,
    this.textBackgroundKey,
  }) : super(key: key);

  @override
  _ColorSettingState createState() => _ColorSettingState();
}

class _ColorSettingState extends State<EzColorSetting> {
  // Gather theme data //

  late Color currColor = Color(EzConfig.instance.prefs[widget.toControl]);

  final double _buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];
  final double _diameter = EzConfig.instance.prefs[circleDiameterKey];

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
        EzConfig.instance.preferences.setInt(widget.toControl, currColor.value);
        popScreen(context: context, pass: currColor.value);
      },
      onDeny: () => popScreen(context: context),
    );
  }

  /// Opens an [EzAlertDialog] for the user to choose their next action
  /// Returns the [Color.value] of what was chosen (null if none)
  Future<dynamic> _changeColor(BuildContext context) {
    if (widget.textBackgroundKey != null) {
      // Color is a text color

      // Find the recommended contrast color for the background //
      final String pathKey = widget.textBackgroundKey as String;

      Color backgroundColor = Color(
          EzConfig.instance.preferences.getInt(pathKey) ??
              EzConfig.instance.prefs[pathKey]);

      int recommended = getTextColor(backgroundColor).value;

      // Define action button parameters //
      final String denyMsg = EFUIPhrases.of(context)!.useCustom;

      final void Function() onConfirm = () {
        EzConfig.instance.preferences.setInt(widget.toControl, recommended);
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
          title: EzText(EFUIPhrases.of(context)!.useRecommended),
          content: Container(
            // Recommended color preview
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: Color(recommended),
              border: Border.all(color: backgroundColor),
            ),
          ),
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
    } else {
      // This is a background color, simply return color picker
      return _openColorPicker(context);
    }
  }

  /// Opens an [EzAlertDialog] for confirming a reset to [widget.toControl]'s value in [empathetechConfig]
  /// A preview of the reset color is shown
  Future<dynamic> _reset(BuildContext context) {
    final Color resetColor =
        Color(EzConfig.instance.defaults[widget.toControl]);

    // Define action button parameters //

    final void Function() onConfirm = () {
      // Remove the user's setting and reset the current state
      EzConfig.instance.preferences.remove(widget.toControl);

      setState(() {
        currColor = resetColor;
      });

      popScreen(context: context, pass: resetColor);
    };

    final void Function() onDeny = () => popScreen(context: context);

    return showPlatformDialog(
      context: context,
      builder: (context) => EzAlertDialog(
        title: EzText(EFUIPhrases.of(context)!.resetTo),
        content: Container(
          // Reset color preview
          width: 75,
          height: 75,
          decoration: BoxDecoration(
            color: resetColor,
            border: Border.all(color: getTextColor(resetColor)),
          ),
        ),
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
        EzText(widget.name, style: _labelStyle),
        EzSpacer.row(_buttonSpacer),

        // Color preview/edit button
        Semantics(
          button: true,
          hint: EFUIPhrases.of(context)!.colorSettingSemantics(widget.name),
          child: ExcludeSemantics(
            child: ElevatedButton(
              onPressed: () => _changeColor(context),
              onLongPress: () => _reset(context),
              child: Center(
                child: Icon(
                  PlatformIcons(context).edit,
                  color: getTextColor(currColor),
                  size: _diameter / 2,
                ),
              ),
              style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                    backgroundColor: MaterialStatePropertyAll(currColor),
                    shape: MaterialStatePropertyAll(const CircleBorder()),
                    padding: MaterialStatePropertyAll(EdgeInsets.zero),
                    fixedSize:
                        MaterialStatePropertyAll(Size(_diameter, _diameter)),
                  ),
            ),
          ),
        ),
      ],
    );
  }
}