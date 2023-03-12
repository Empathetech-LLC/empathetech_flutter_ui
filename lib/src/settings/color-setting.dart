library ez_ui;

import 'package:ez_ui/src/helpers.dart';

import '../../ez_ui.dart';
import '../storage.dart';
import '../app-config.dart';
import '../text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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
  //// Initialize state

  late Color currColor = Color(AppConfig.prefs[widget.toControl]);

  // Gather theme data
  late Color themeColor = Color(AppConfig.prefs[themeColorKey]);
  late Color themeTextColor = Color(AppConfig.prefs[themeTextColorKey]);
  late Color buttonColor = Color(AppConfig.prefs[buttonColorKey]);

  //// Define interaction methods

  // Edit button onPressed: update the color to whatever the user chooses
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

  // Edit button onLongPress: reset the color to the app default
  void reset() {
    Color resetColor = Color(AppConfig.defaults[widget.toControl]);

    ezDialog(
      context,
      'Reset to...',
      [
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Color preview
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: resetColor,
                foregroundColor: resetColor,
                shadowColor: resetColor,
                surfaceTintColor: resetColor,
                fixedSize: Size(75, 75),
              ),
              onPressed: () {},
              child: Container(),
            ),
            Container(height: AppConfig.prefs[dialogSpacingKey]),

            // Yes/no buttons
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Yes
                ezIconButton(
                  () {
                    // Remove the users setting
                    AppConfig.preferences.remove(widget.toControl);

                    setState(() {
                      currColor = resetColor;
                    });

                    Navigator.of(context).pop();
                  },
                  () {},
                  Icon(Icons.check),
                  Icon(Icons.check),
                  PlatformText('Yes'),
                ),

                // No
                ezIconButton(
                  () => Navigator.of(context).pop(),
                  () {},
                  Icon(Icons.cancel),
                  Icon(Icons.cancel),
                  PlatformText('No'),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double padding = AppConfig.prefs[paddingKey];

    // Color setting UI
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Color label
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: themeTextColor,
            foregroundColor: themeTextColor,
            padding: EdgeInsets.all(padding),
          ),
          onPressed: () {},
          child: PlatformText(
            widget.message,
            style: getTextStyle(colorSettingStyleKey),
            textAlign: TextAlign.center,
          ),
        ),

        // Color preview/edit button
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: currColor,
            foregroundColor: buttonColor,
            side: BorderSide(color: buttonColor),
            fixedSize: Size(75, 75),
          ),
          onPressed: changeColor,
          onLongPress: reset,
          child: Icon(
            Icons.edit,
            color: getContrastColor(currColor),
            size: 37.5,
          ),
        ),
      ],
    );
  }
}
