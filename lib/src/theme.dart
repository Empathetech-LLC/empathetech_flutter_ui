library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Material (Android) [ThemeData] built from [AppConfig.prefs]
MaterialAppData materialAppTheme() {
  Color themeColor = Color(AppConfig.prefs[themeColorKey]);
  Color themeTextColor = Color(AppConfig.prefs[themeTextColorKey]);
  Color buttonColor = Color(AppConfig.prefs[buttonColorKey]);
  Color buttonTextColor = Color(AppConfig.prefs[buttonTextColorKey]);

  TextStyle dialogTitleText = getTextStyle(dialogTitleStyleKey);
  TextStyle dialogContentText = getTextStyle(dialogContentStyleKey);

  return MaterialAppData(
    theme: ThemeData(
      primaryColor: themeColor,

      // App bar
      appBarTheme: AppBarTheme(
        backgroundColor: themeColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: themeTextColor),
        titleTextStyle: getTextStyle(titleStyleKey),
      ),

      // Nav bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: themeColor,
        selectedItemColor: buttonColor,
        selectedIconTheme: IconThemeData(color: buttonColor),
        unselectedItemColor: themeTextColor,
        unselectedIconTheme: IconThemeData(color: themeTextColor),
      ),

      // Text
      textTheme: materialTextTheme(),
      primaryTextTheme: materialTextTheme(),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: themeTextColor,
        selectionColor: themeColor,
        selectionHandleColor: buttonColor,
      ),
      hintColor: themeTextColor,

      // Icons
      iconTheme: IconThemeData(color: themeTextColor),

      // Sliders
      sliderTheme: SliderThemeData(
        thumbColor: buttonColor,
        disabledThumbColor: themeColor,
        overlayColor: buttonColor,
        activeTrackColor: buttonColor,
        activeTickMarkColor: buttonTextColor,
        inactiveTrackColor: themeColor,
        inactiveTickMarkColor: themeTextColor,
        valueIndicatorTextStyle: dialogContentText,
        overlayShape: SliderComponentShape.noOverlay,
      ),

      // Dialogs
      dialogTheme: DialogTheme(
        backgroundColor: themeColor,
        iconColor: themeTextColor,
        alignment: Alignment.center,
        titleTextStyle: dialogTitleText,
        contentTextStyle: dialogContentText,
      ),
    ),
  );
}

/// (iOS) [CupertinoAppData] data built [from] the passed in [MaterialAppData]
CupertinoAppData cupertinoAppTheme() {
  Color themeColor = Color(AppConfig.prefs[themeColorKey]);
  Color themeTextColor = Color(AppConfig.prefs[themeTextColorKey]);

  return CupertinoAppData(
    color: themeColor,
    theme: CupertinoThemeData(
      primaryColor: themeColor,
      primaryContrastingColor: themeTextColor,
      textTheme: cupertinoTextTheme(),
    ),
  );
}

/// Creates a [CupertinoActionSheet] from a Material UI [Drawer]
void _showCupertinoActionSheet(
  BuildContext context,
  Drawer from,
) {
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: from.child,
      cancelButton: ezCancel(
        context: context,
        onCancel: () => Navigator.of(context).pop(),
      ),
    ),
  );
}

/// Cupertino (iOS) [Scaffold] data built [from] the passed in [MaterialScaffoldData]
CupertinoPageScaffoldData m2cScaffold(
  BuildContext context,
  MaterialScaffoldData from,
  String title,
) {
  // Convert endDrawer if present
  Widget? topRight;

  if (from.endDrawer != null) {
    Drawer toConvert = from.endDrawer as Drawer;

    topRight = GestureDetector(
      onTap: () => _showCupertinoActionSheet(context, toConvert),
      child: Icon(
        CupertinoIcons.line_horizontal_3,
        color: Color(AppConfig.prefs[themeTextColorKey]),
      ),
    );
  }

  return CupertinoPageScaffoldData(
    navigationBar: CupertinoNavigationBar(
      leading: Navigator.canPop(context)
          ? CupertinoNavigationBarBackButton(
              onPressed: () => Navigator.pop(context),
            )
          : null,
      middle: Text(
        title,
        style: getTextStyle(titleStyleKey),
        textAlign: TextAlign.center,
      ),
      trailing: topRight,
    ),
  );
}

/// Material (Android) [ElevatedButton] style built from [AppConfig.prefs]
ButtonStyle materialButton({OutlinedBorder? shape}) {
  return ElevatedButton.styleFrom(
    backgroundColor: Color(AppConfig.prefs[buttonColorKey]),
    foregroundColor: Color(AppConfig.prefs[buttonTextColorKey]),
    textStyle: getTextStyle(buttonStyleKey),
    padding: EdgeInsets.all(AppConfig.prefs[paddingKey]),
    side: BorderSide(color: Color(AppConfig.prefs[buttonColorKey])),
    shape: shape,
  );
}

/// Cupertino (iOS) [ElevatedButton] data built [from] the passed in Material [ButtonStyle]
CupertinoElevatedButtonData m2cButton(ButtonStyle from) {
  return CupertinoElevatedButtonData(
    color: (from.backgroundColor is Color)
        ? from.backgroundColor as Color
        : Color(AppConfig.prefs[buttonColorKey]),
    padding: (from.padding is EdgeInsetsGeometry)
        ? from.padding as EdgeInsetsGeometry
        : EdgeInsets.all(AppConfig.prefs[paddingKey]),
  );
}
