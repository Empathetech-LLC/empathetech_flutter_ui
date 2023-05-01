library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzColorSetting extends StatefulWidget {
  /// [EzConfig.prefs] key whose value will be updated
  final String toControl;

  /// Label [String] to display with on the [ElevatedButton]
  final String message;

  /// Optional [EzConfig.prefs] key of whatever will be this colors background
  /// In the event that [toControl] is a [Text]colorKey
  final String? textBackgroundKey;

  /// Creates a tool for updating the value of [toControl] in [EzConfig.prefs]
  /// The [EzColorSetting] title is the passed [message] and is paired with a
  /// preview of the starting color ([toControl]) which, on click, opens an [ezColorPicker]
  /// If a [textBackgroundKey] is provided, it will be used to generate a recommended color pair
  EzColorSetting({
    Key? key,
    required this.toControl,
    required this.message,
    this.textBackgroundKey,
  }) : super(key: key);

  @override
  _ColorSettingState createState() => _ColorSettingState();
}

class _ColorSettingState extends State<EzColorSetting> {
  late Color currColor = Color(EzConfig.prefs[widget.toControl]);

  /// Opens an [ezColorPicker] for updating [currColor]
  /// Returns the [Color.value] of what was chosen (null otherwise)
  Future<dynamic> _openColorPicker() {
    return ezColorPicker(
      context: context,
      startColor: currColor,
      onColorChange: (chosenColor) {
        // Update currColor
        setState(() {
          currColor = chosenColor;
        });
      },
      apply: () {
        // Update the user's setting
        EzConfig.preferences.setInt(widget.toControl, currColor.value);
        popScreen(context: context, pass: currColor.value);
      },
      cancel: () => popScreen(context: context),
    );
  }

  /// Opens an [ezColorPicker] for updating [currColor]
  /// Returns the [Color.value] of what was chosen (null otherwise)
  Future<dynamic> _changeColor() {
    double buttonSpacer = EzConfig.prefs[buttonSpacingKey];

    if (widget.textBackgroundKey != null) {
      String pathKey = widget.textBackgroundKey as String;

      Color backgroundColor = Color(
          EzConfig.preferences.getInt(pathKey) ?? EzConfig.prefs[pathKey]);

      int recommended = getContrastColor(backgroundColor).value;

      return openDialog(
        context: context,
        dialog: EzDialog(
          title: EzSelectableText('Use recommended?'),
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
            Container(height: buttonSpacer),

            // Confirm/deny
            EzYesNo(
              onConfirm: () {
                EzConfig.preferences.setInt(widget.toControl, recommended);
                setState(() {
                  currColor = Color(recommended);
                });
                popScreen(context: context, pass: recommended);
              },
              onDeny: () async {
                dynamic chosen = await _openColorPicker();
                popScreen(context: context, pass: chosen);
              },
              denyIcon: Icon(PlatformIcons(context).edit),
              denyMsg: 'Use custom',
            ),
          ],
          needsClose: true,
        ),
      );
    } else {
      return _openColorPicker();
    }
  }

  /// Opens an [EzDialog] for confirming a reset to [toControl]'s value in [EzConfig.defaults]
  /// A preview of the reset color is shown
  /// Returns the [Color.value] of the "reset color" from [EzConfig.defaults] (null otherwise)
  Future<dynamic> _reset() {
    Color resetColor = Color(EzConfig.defaults[widget.toControl]);

    return openDialog(
      context: context,
      dialog: EzDialog(
        title: EzSelectableText('Reset to...'),
        contents: [
          // Color preview
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: resetColor,
              border: Border.all(color: getContrastColor(resetColor)),
            ),
          ),
          Container(height: EzConfig.prefs[buttonSpacingKey]),

          EzYesNo(
            onConfirm: () {
              // Remove the user's setting and reset the current state
              EzConfig.preferences.remove(widget.toControl);

              setState(() {
                currColor = resetColor;
              });

              popScreen(context: context, pass: resetColor);
            },
            onDeny: () => popScreen(context: context),
            denyMsg: 'Use custom',
            denyIcon: Icon(PlatformIcons(context).edit),
          ),
        ],
        needsClose: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return EzRow(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Color label
        EzSelectableText(widget.message, style: titleMedium(context)),

        Container(width: EzConfig.prefs[buttonSpacingKey]),

        // Color preview/edit button
        ElevatedButton(
          onPressed: _changeColor,
          onLongPress: _reset,
          child: Icon(PlatformIcons(context).edit,
              color: getContrastColor(currColor)),
          style: ElevatedButton.styleFrom(
            backgroundColor: currColor,
            padding: EdgeInsets.all(EzConfig.prefs[paddingKey] * 2),
            shape: CircleBorder(),
          ),
        ),
      ],
    );
  }
}
