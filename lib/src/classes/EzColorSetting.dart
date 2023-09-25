/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzColorSetting extends StatefulWidget {
  final Key? key;

  /// [EzConfig] key whose value will be updated
  final String toControl;

  /// Label [String] to display with on the [ElevatedButton]
  final String message;

  /// Optional [EzConfig] key of whatever will be this colors background
  /// In the event that [toControl] is a [Text]colorKey
  final String? textBackgroundKey;

  /// Creates a tool for updating the value of [toControl] in [EzConfig]
  /// The [EzColorSetting] title is the passed [message] and is paired with a
  /// preview of the starting color ([toControl]) which, on click, opens an [ezColorPicker]
  /// If a [textBackgroundKey] is provided, it will be used to generate a recommended color pair
  const EzColorSetting({
    this.key,
    required this.toControl,
    required this.message,
    this.textBackgroundKey,
  }) : super(key: key);

  @override
  _ColorSettingState createState() => _ColorSettingState();
}

class _ColorSettingState extends State<EzColorSetting> {
  late Color currColor = Color(EzConfig.instance.prefs[widget.toControl]);

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

      Color backgroundColor =
          Color(EzConfig.instance.preferences.getInt(pathKey) ?? EzConfig.instance.prefs[pathKey]);

      int recommended = EzContrastColor(backgroundColor).value;

      // Define action button parameters //
      const String denyMsg = 'Use custom';

      final Icon denyIcon = Icon(PlatformIcons(context).edit);

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
          title: const EzSelectableText('Use recommended?'),
          contents: [
            // Recommended preview
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
            onConfirm: onConfirm,
            onDeny: onDeny,
            denyMsg: denyMsg,
            denyIcon: denyIcon,
          ),
          cupertinoActions: ezCupertinoActions(
            onConfirm: onConfirm,
            onDeny: onDeny,
            denyMsg: denyMsg,
            confirmIsDestructive: true,
          ),
          needsClose: true,
        ),
      );
    } else {
      // This is a background color, simply return color picker
      return _openColorPicker(context);
    }
  }

  /// Opens an [EzAlertDialog] for confirming a reset to [toControl]'s value in [EzConfig.instance.defaults]
  /// A preview of the reset color is shown
  /// Returns the [Color.value] of the "reset color" from [EzConfig.instance.defaults] (null otherwise)
  Future<dynamic> _reset(BuildContext context) {
    final Color resetColor = Color(EzConfig.instance.defaults[widget.toControl]);

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
        title: const EzSelectableText('Reset to...'),
        contents: [
          // Color preview
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: resetColor,
              border: Border.all(color: EzContrastColor(resetColor)),
            ),
          ),
        ],
        materialActions: ezMaterialActions(onConfirm: onConfirm, onDeny: onDeny),
        cupertinoActions: ezCupertinoActions(onConfirm: onConfirm, onDeny: onDeny),
        needsClose: false,
      ),
    );
  }

  final double space = EzConfig.instance.prefs[buttonSpacingKey];
  final double diameter = EzConfig.instance.prefs[circleDiameterKey];

  @override
  Widget build(BuildContext context) {
    final TextStyle? style = Theme.of(context).dropdownMenuTheme.textStyle;

    return EzRow(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Color label
        EzSelectableText(
          widget.message,
          style: style,
          semanticsLabel: 'Customize the ${widget.message} color',
        ),
        EzSpacer.row(space),

        // Color preview/edit button
        Semantics(
          button: true,
          hint: 'Open a color picker',
          child: ExcludeSemantics(
            child: ElevatedButton(
              onPressed: () => _changeColor(context),
              onLongPress: () => _reset(context),
              child: Center(
                child: Icon(
                  PlatformIcons(context).edit,
                  color: EzContrastColor(currColor),
                  size: diameter / 2,
                ),
              ),
              style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                    backgroundColor: MaterialStatePropertyAll(currColor),
                    shape: MaterialStatePropertyAll(const CircleBorder()),
                    padding: MaterialStatePropertyAll(EdgeInsets.zero),
                    fixedSize: MaterialStatePropertyAll(Size(diameter, diameter)),
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
