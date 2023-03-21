library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Creates a tool for updating the value of [toControl]
/// The [ColorSetting] title is the passed [message] and is paired with a
/// preview of the starting color ([toControl]) which, on click, opens a [colorPicker]
class ColorSetting extends StatefulWidget {
  const ColorSetting({
    Key? key,
    required this.toControl,
    required this.message,
  }) : super(key: key);

  final String toControl;
  final String message;

  @override
  _ColorSettingState createState() => _ColorSettingState();
}

class _ColorSettingState extends State<ColorSetting> {
  // Initialize state

  late Color currColor = Color(AppConfig.prefs[widget.toControl]);
  late Color themeColor = Color(AppConfig.prefs[themeColorKey]);
  late Color themeTextColor = Color(AppConfig.prefs[themeTextColorKey]);
  late Color buttonColor = Color(AppConfig.prefs[buttonColorKey]);

  /// Opens a [colorPicker] for updating [currColor]
  void changeColor() {
    colorPicker(
      context,

      // Starting color
      currColor,

      // onColorChange
      (chosenColor) {
        setState(() {
          currColor = chosenColor;
        });
      },

      // Apply
      () {
        // Update the users setting
        AppConfig.preferences.setInt(widget.toControl, currColor.value);
        Navigator.of(context).pop();
      },

      // Cancel
      () => Navigator.of(context).pop(),
    );
  }

  /// Opens an [ezDialog] for confirming a reset to [widget.toControl]'s value in [AppConfig.defaults]
  /// A preview of the reset color is shown
  void reset() {
    Color resetColor = Color(AppConfig.defaults[widget.toControl]);

    ezDialog(
      context,
      'Reset to...',
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Color preview
          Container(width: 75, height: 75, color: resetColor),
          Container(height: AppConfig.prefs[dialogSpacingKey]),

          ezYesNoRow(
            context,
            // On yes
            () {
              // Remove the users setting
              AppConfig.preferences.remove(widget.toControl);

              setState(() {
                currColor = resetColor;
              });

              Navigator.of(context).pop();
            },

            // On no
            () => Navigator.of(context).pop(),
          ),
        ],
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
        ezButton(
          () {},
          () {},
          Text(widget.message, style: getTextStyle(colorSettingStyleKey)),
        ),

        // Color preview/edit button
        GestureDetector(
          onLongPress: reset,
          child: ezIconButton(
            changeColor,
            reset,
            PlatformIcons(context).edit,
            currColor,
            getContrastColor(currColor),
          ),
        ),
      ],
    );
  }
}
