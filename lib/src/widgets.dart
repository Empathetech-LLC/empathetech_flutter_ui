import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

//// Static widgets

// Standard text box
Widget paddedText(String text, [TextStyle? style, TextAlign? alignment]) {
  return Padding(
    padding: EdgeInsets.all(AppConfig.prefs[paddingKey]),
    child: Text(text, style: style, textAlign: alignment),
  );
}

// Standard title card
Widget titleCard(String title) {
  return Card(
    color: Color(AppConfig.prefs[themeColorKey]),
    child: paddedText(title, getTextStyle(titleStyleKey)),
  );
}

// The word loading with an elipses built from the passed image
Widget loadingMessage(BuildContext context, Image image) {
  TextStyle style = getTextStyle(titleStyleKey);

  double imageSize = style.fontSize!;
  SizedBox elipsis = SizedBox(height: imageSize, width: imageSize, child: image);

  return Container(
    child: Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Loading ', style: style),
          elipsis,
          Text(' ', style: style),
          elipsis,
          Text(' ', style: style),
          elipsis,
        ],
      ),
    ),
  );
}

// Custom title card designed for grabbing attention and displaying a warning
Widget warningCard(BuildContext context, String content) {
  TextStyle titleStyle = getTextStyle(titleStyleKey);
  TextStyle contentStyle = getTextStyle(dialogContentStyleKey);

  double padding = AppConfig.prefs[paddingKey];

  return Card(
    color: Color(AppConfig.prefs[themeColorKey]),
    child: Container(
      width: screenWidth(context),
      padding: EdgeInsets.all(padding),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Title with icons
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(PlatformIcons(context).error, color: Colors.amber),
              Text('WARNING', style: titleStyle),
              Icon(PlatformIcons(context).error, color: Colors.amber),
            ],
          ),
          Container(height: padding),

          // Label
          Text(content, style: contentStyle, textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}

//// Interactive widgets

// Platform elevated button wrapper
Widget ezButton(void Function() action, void Function() longAction, Widget body,
    [ButtonStyle? buttonStyle]) {
  // Gather theme data
  Color color = Color(AppConfig.prefs[buttonColorKey]);

  return GestureDetector(
    onLongPress: longAction,
    child: PlatformElevatedButton(
      child: body,
      color: color,
      onPressed: action,

      // Android button
      material: (context, platform) => MaterialElevatedButtonData(style: buttonStyle),

      // iOS button
      cupertino: (context, platform) => CupertinoElevatedButtonData(),
    ),
  );
}

// Platform elevated button wrapper, only takes text as a body
Widget ezTextButton(void Function() action, void Function() longAction, String text,
    [TextStyle? textStyle, ButtonStyle? buttonStyle]) {
  // Gather theme data
  Color color = Color(AppConfig.prefs[buttonColorKey]);

  return GestureDetector(
    onLongPress: longAction,
    child: PlatformElevatedButton(
      onPressed: action,
      color: color,
      child: Text(text, style: textStyle ?? getTextStyle(buttonStyleKey)),
      padding: EdgeInsets.all(AppConfig.prefs[paddingKey]),

      // Android button
      material: (context, platform) => MaterialElevatedButtonData(style: buttonStyle),

      // iOS button
      cupertino: (context, platform) => CupertinoElevatedButtonData(),
    ),
  );
}

// Ditto but with an icon
Widget ezIconButton(
    void Function() action, void Function() longAction, Icon mIcon, cIcon, Widget body,
    [ButtonStyle? buttonStyle]) {
  return GestureDetector(
    child: PlatformIconButton(
      icon: body,
      onPressed: action,

      // Android button
      material: (context, platform) => MaterialIconButtonData(style: buttonStyle),
      materialIcon: mIcon,

      // iOS button
      cupertino: (context, platform) => CupertinoIconButtonData(),
      cupertinoIcon: cIcon,
    ),
    onLongPress: longAction,
  );
}

// Saves time on standardizing the dialog's padding
void ezDialog(BuildContext context, String? title, List<Widget>? build) {
  // Gather theme data
  double dialogSpacer = AppConfig.prefs[dialogSpacingKey];
  double padding = AppConfig.prefs[paddingKey];

  Color backColor = Color(AppConfig.prefs[themeColorKey]);

  showPlatformDialog(
    context: context,
    builder: (context) => PlatformAlertDialog(
      title: title == null ? null : Text(title, textAlign: TextAlign.center),
      actions: build,

      // Android dialog
      material: (context, platform) => MaterialAlertDialogData(
        backgroundColor: backColor,
        insetPadding: EdgeInsets.all(padding),

        // Title
        titleTextStyle: getTextStyle(dialogTitleStyleKey),
        titlePadding: title == null
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(vertical: dialogSpacer, horizontal: padding),

        // Content
        contentTextStyle: getTextStyle(dialogContentStyleKey),
        contentPadding: EdgeInsets.symmetric(vertical: dialogSpacer, horizontal: padding),
      ),

      // iOS dialog
      cupertino: (context, platform) => CupertinoAlertDialogData(),
    ),
  );
}

// Saves time on creating scroll views
Widget ezScrollView(List<Widget> children,
    [MainAxisSize axisSize = MainAxisSize.min,
    MainAxisAlignment axisAlign = MainAxisAlignment.spaceEvenly,
    Axis direction = Axis.vertical]) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    scrollDirection: direction,
    child: direction == Axis.vertical
        ? Column(
            mainAxisSize: axisSize,
            mainAxisAlignment: axisAlign,
            children: children,
          )
        : Row(
            mainAxisSize: axisSize,
            mainAxisAlignment: axisAlign,
            children: children,
          ),
  );
}

// Ditto
Widget ezCenterScroll(List<Widget> children,
    [MainAxisSize axisSize = MainAxisSize.min,
    MainAxisAlignment axisAlign = MainAxisAlignment.spaceEvenly,
    Axis direction = Axis.vertical]) {
  return Center(
    child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: direction,
      child: direction == Axis.vertical
          ? Column(
              mainAxisSize: axisSize,
              mainAxisAlignment: axisAlign,
              children: children,
            )
          : Row(
              mainAxisSize: axisSize,
              mainAxisAlignment: axisAlign,
              children: children,
            ),
    ),
  );
}

// Dynamically styled dropdown list
Widget ezList(String title, List<Widget> body, [bool open = false]) {
  TextStyle titleStyle = getTextStyle(titleStyleKey);
  Color themeColor = Color(AppConfig.prefs[themeColorKey]);
  Color themeTextColor = Color(AppConfig.prefs[themeTextColorKey]);

  double padding = AppConfig.prefs[paddingKey];

  return ExpansionTile(
    tilePadding: EdgeInsets.all(padding),
    childrenPadding: EdgeInsets.only(left: padding, right: padding),
    collapsedBackgroundColor: themeColor,
    collapsedTextColor: themeTextColor,
    collapsedIconColor: themeTextColor,
    backgroundColor: themeColor,
    textColor: themeTextColor,
    iconColor: themeTextColor,
    title: Text(title, style: titleStyle),
    children: body,
    initiallyExpanded: open,
    onExpansionChanged: (bool open) => AppConfig.focus.primaryFocus?.unfocus(),
  );
}

// Form field wrapper
Widget ezForm(Key? key, TextEditingController? controller, String? hintText,
    [bool? private,
    Iterable<String>? autofillHints,
    String? Function(String?)? validator,
    AutovalidateMode? autovalidateMode]) {
  Color themeTextColor = Color(AppConfig.prefs[themeTextColorKey]);

  return Form(
    key: key,
    child: PlatformTextFormField(
      cursorColor: themeTextColor,
      controller: controller,
      textAlign: TextAlign.center,
      style: getTextStyle(dialogContentStyleKey),
      obscureText: private,
      hintText: hintText,
      autofillHints: autofillHints,
      validator: validator,
      autovalidateMode: autovalidateMode,
    ),
  );
}
