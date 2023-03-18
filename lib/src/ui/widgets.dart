import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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

      // Android config
      material: (context, platform) => MaterialElevatedButtonData(style: buttonStyle),
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

      // Android config
      material: (context, platform) => MaterialElevatedButtonData(style: buttonStyle),
    ),
  );
}

// Platform icon button wrapper
Widget ezIconButton(void Function() action, void Function() longAction, Icon icon) {
  return GestureDetector(
    child: PlatformIconButton(
      icon: icon,
      onPressed: action,
    ),
    onLongPress: longAction,
  );
}

// Platform elevated button wrapper that requires an icon
Widget ezTextIconButton(
    void Function() action, void Function() longAction, String text, Icon icon,
    [TextStyle? textStyle]) {
  // Gather theme data
  Color color = Color(AppConfig.prefs[buttonColorKey]);
  double padding = AppConfig.prefs[paddingKey];

  return GestureDetector(
    onLongPress: longAction,
    child: PlatformElevatedButton(
      onPressed: action,
      color: color,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          icon,
          Container(width: padding),
          Text(text, style: textStyle ?? getTextStyle(buttonStyleKey)),
        ],
      ),
      padding: EdgeInsets.all(AppConfig.prefs[paddingKey]),
    ),
  );
}

// Saves time on standardizing the dialog's padding
void ezDialog(BuildContext context, String? title, Widget build) {
  // Gather theme data
  double dialogSpacer = AppConfig.prefs[dialogSpacingKey];
  double padding = AppConfig.prefs[paddingKey];

  Color backColor = Color(AppConfig.prefs[themeColorKey]);

  showPlatformDialog(
    context: context,
    builder: (context) => PlatformAlertDialog(
      title: title == null ? null : Text(title, textAlign: TextAlign.center),
      content: build,

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
  // Gather theme data
  Color buttonColor = Color(AppConfig.prefs[buttonColorKey]);
  Color themeTextColor = Color(AppConfig.prefs[themeTextColorKey]);

  return Container(
    decoration: BoxDecoration(border: Border.all(color: buttonColor)),
    child: PlatformTextFormField(
      key: key,
      cursorColor: themeTextColor,
      controller: controller,
      textAlign: TextAlign.center,
      style: getTextStyle(dialogContentStyleKey),
      obscureText: private,
      hintText: hintText,
      autofillHints: autofillHints,
      validator: validator,
      autovalidateMode: autovalidateMode,
      material: (context, platform) => MaterialTextFormFieldData(
        decoration: InputDecoration(hintStyle: getTextStyle(dialogContentStyleKey)),
      ),
    ),
  );
}

// Wrapper for quickly making confirm/deny button in a column
Widget ezYesNoCol(BuildContext context, void Function() onConfirm, void Function() onDeny,
    [String confirmMsg = 'Yes',
    String denyMsg = 'No',
    Icon? customConfirm,
    Icon? customDeny]) {
  // Gather theme data
  Icon confirmIcon = customConfirm ?? Icon(PlatformIcons(context).checkMark);
  Icon denyIcon = customConfirm ?? Icon(PlatformIcons(context).clear);

  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      // Confirm
      ezTextIconButton(onConfirm, () {}, confirmMsg, confirmIcon),

      // Spacer
      Container(height: AppConfig.prefs[buttonSpacingKey]),

      // Deny
      ezTextIconButton(onDeny, () {}, denyMsg, denyIcon),
    ],
  );
}

// Wrapper for quickly making confirm/deny button in a row
Widget ezYesNoRow(BuildContext context, void Function() onConfirm, void Function() onDeny,
    [String confirmMsg = 'Yes',
    String denyMsg = 'No',
    Icon? customConfirm,
    Icon? customDeny]) {
  // Gather theme data
  Icon confirmIcon = customConfirm ?? Icon(PlatformIcons(context).checkMark);
  Icon denyIcon = customConfirm ?? Icon(PlatformIcons(context).clear);

  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      // Confirm
      ezTextIconButton(onConfirm, () {}, confirmMsg, confirmIcon),

      // Spacer
      Container(width: AppConfig.prefs[paddingKey]),

      // Deny
      ezTextIconButton(onDeny, () {}, denyMsg, denyIcon),
    ],
  );
}

// Platform switch wrapper
Widget ezSwitch(BuildContext context, bool value, void Function(bool)? onChanged) {
  return PlatformSwitch(
    value: value,
    onChanged: onChanged,
    activeColor: Color(AppConfig.prefs[buttonColorKey]),
  );
}
