library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzColorSetting extends StatefulWidget {
  /// Creates a tool for updating the value of [toControl]
  /// The [EzColorSetting] title is the passed [message] and is paired with a
  /// preview of the starting color ([toControl]) which, on click, opens an [ezColorPicker]
  /// If a [textBackgroundKey] is provided, it will be used to generate a recommended color pair
  EzColorSetting({
    Key? key,
    required this.toControl,
    required this.message,
    this.textBackgroundKey,
  }) : super(key: key);

  final String toControl;
  final String message;
  final String? textBackgroundKey;

  @override
  _ColorSettingState createState() => _ColorSettingState();
}

class _ColorSettingState extends State<EzColorSetting> {
  late Color currColor = Color(EzConfig.prefs[widget.toControl]);
  late Color themeColor = Color(EzConfig.prefs[themeColorKey]);
  late Color themeTextColor = Color(EzConfig.prefs[themeTextColorKey]);
  late Color buttonColor = Color(EzConfig.prefs[buttonColorKey]);

  /// Opens an [ezColorPicker] for updating [currColor]
  /// Returns the [Color.value] of what was chosen (null otherwise)
  Future<dynamic> _openColorPicker() {
    return ezColorPicker(
      context: context,
      startColor: currColor,
      onColorChange: (chosenColor) {
        setState(() {
          currColor = chosenColor;
        });
      },
      apply: () {
        // Update the users setting
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
    double dialogSpacer = EzConfig.prefs[dialogSpacingKey];

    if (widget.textBackgroundKey != null) {
      String pathKey = widget.textBackgroundKey as String;
      Color backgroundColor =
          Color(EzConfig.preferences.getInt(pathKey) ?? EzConfig.prefs[pathKey]);
      int recommended = getContrastColor(backgroundColor).value;

      return openDialog(
        context: context,
        dialog: EzDialog(
          title: EzText.simple(
            'Use recommended?',
            style: buildTextStyle(styleKey: dialogTitleStyleKey),
          ),
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

            ezYesNo(
              context: context,
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
              customDeny: EzIcon(PlatformIcons(context).edit),
              denyMsg: 'Pick custom',
              axis: Axis.vertical,
              spacer: dialogSpacer,
            ),
          ],
          needsClose: true,
        ),
      );
    } else {
      return _openColorPicker();
    }
  }

  /// Opens an [ezDialog] for confirming a reset to [toControl]'s value in [EzConfig.defaults]
  /// A preview of the reset color is shown
  /// Returns the [Color.value] of the "reset color" from [EzConfig.defaults] (null otherwise)
  Future<dynamic> _reset() {
    Color resetColor = Color(EzConfig.defaults[widget.toControl]);
    double dialogSpacer = EzConfig.prefs[dialogSpacingKey];

    return openDialog(
      context: context,
      dialog: EzDialog(
        title: EzText.simple(
          'Reset to...',
          style: buildTextStyle(styleKey: dialogTitleStyleKey),
        ),
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
          Container(height: dialogSpacer),

          ezYesNo(
            context: context,
            onConfirm: () {
              // Remove the user's setting and reset the current state
              EzConfig.preferences.remove(widget.toControl);

              setState(() {
                currColor = resetColor;
              });

              popScreen(context: context, pass: resetColor);
            },
            onDeny: () => popScreen(context: context),
            axis: Axis.horizontal,
            spacer: dialogSpacer,
          ),
        ],
        needsClose: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Color label
        EzText.simple(
          widget.message,
          style: buildTextStyle(styleKey: dialogTitleStyleKey),
        ),

        // Color preview/edit button
        EzButton(
          action: _changeColor,
          longAction: _reset,
          body: EzIcon(PlatformIcons(context).edit, color: getContrastColor(currColor)),
          customStyle: ElevatedButton.styleFrom(
            backgroundColor: currColor,
            padding: EdgeInsets.all(EzConfig.prefs[paddingKey] * 2),
          ),
          forceMaterial: true,
        ),
      ],
    );
  }
}
