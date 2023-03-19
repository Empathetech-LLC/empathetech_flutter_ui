import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Text that values its personal space
Widget paddedText(String text, [TextStyle? style, TextAlign? alignment]) {
  return Padding(
    padding: EdgeInsets.all(AppConfig.prefs[paddingKey]),
    child: Text(text, style: style, textAlign: alignment),
  );
}

/// Say it loud, say it proud
/// Background and text colors are built from [AppConfig.prefs] theme values
Widget titleCard(String title) {
  return Card(
    color: Color(AppConfig.prefs[themeColorKey]),
    child: paddedText(title, getTextStyle(titleStyleKey)),
  );
}

/// 'Loading...' text but the elipsis is built from the passed [Image] (gifs recommended)
/// The text is "naked"; wrap in a container if necessary
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

/// [titleCard] designed to grab attention for warnings...
/// [Icon] 'WARNING' [Icon]
/// 'Your message here'
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

/// Style a [PlatformElevatedButton] from [AppConfig.prefs]
/// Intended for a widget child, see [ezTextButton] for text child
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

/// Style a [PlatformElevatedButton] from [AppConfig.prefs]
/// Intended for a text child, see [ezButton] for widget child
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

/// Style a [PlatformIconButton] from [AppConfig.prefs]
/// See [ezTextIconButton] for adding a message
Widget ezIconButton(void Function() action, void Function() longAction, IconData icon,
    [Color? buttonColor, Color? iconColor]) {
  double padding = AppConfig.prefs[paddingKey];
  double buttonTextSize = getTextStyle(buttonStyleKey).fontSize ?? 24.0;

  return GestureDetector(
    onLongPress: longAction,
    child: Container(
      width: buttonTextSize * 2 + padding,
      height: buttonTextSize * 2 + padding,
      decoration: BoxDecoration(
        color: buttonColor ?? Color(AppConfig.prefs[buttonColor]),
        shape: BoxShape.circle,
      ),
      child: PlatformIconButton(
        onPressed: action,
        icon: Icon(
          icon,
          color: iconColor ?? Color(AppConfig.prefs[buttonTextColorKey]),
          size: buttonTextSize,
        ),
      ),
    ),
  );
}

/// Style a [PlatformElevatedButton] from [AppConfig.prefs] that mimics the original
/// behavior of [ElevatedButton.icon]
Widget ezTextIconButton(
    void Function() action, void Function() longAction, String text, IconData icon,
    [TextStyle? textStyle, Color? buttonColor, Color? iconColor]) {
  Color color = Color(AppConfig.prefs[buttonColorKey]);
  double padding = AppConfig.prefs[paddingKey];
  double buttonTextSize = getTextStyle(buttonStyleKey).fontSize ?? 24.0;

  return GestureDetector(
    onLongPress: longAction,
    child: PlatformElevatedButton(
      onPressed: action,
      color: color,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Icon
          Icon(
            icon,
            color: iconColor ?? Color(AppConfig.prefs[buttonTextColorKey]),
            size: buttonTextSize,
          ),
          Container(width: padding),

          // Text
          Text(text, style: textStyle ?? getTextStyle(buttonStyleKey)),
        ],
      ),
      padding: EdgeInsets.all(AppConfig.prefs[paddingKey]),
    ),
  );
}

/// Styles a [PlatformAlertDialog] from [AppConfig.prefs]
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

/// Styles a [SingleChildScrollView] from [AppConfig.prefs]
/// Dynamically switches between row/col based on [direction]
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

/// Styles a centered [SingleChildScrollView] from [AppConfig.prefs]
/// Dynamically switches between row/col based on [direction]
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

/// Styles a [ExpansionTile] from [AppConfig.prefs]
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

/// Styles a [PlatformTextFormField] from [AppConfig.prefs]
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
    ),
  );
}

/// Builds a pair of customizable [ezTextIconButton]s for yes/no in a column
Widget ezYesNoCol(BuildContext context, void Function() onConfirm, void Function() onDeny,
    [String confirmMsg = 'Yes',
    String denyMsg = 'No',
    IconData? customConfirm,
    IconData? customDeny]) {
  // Gather theme data
  IconData confirmIcon = customConfirm ?? PlatformIcons(context).checkMark;
  IconData denyIcon = customConfirm ?? PlatformIcons(context).clear;

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

/// Builds a pair of customizable [ezTextIconButton]s for yes/no in a row
Widget ezYesNoRow(BuildContext context, void Function() onConfirm, void Function() onDeny,
    [String confirmMsg = 'Yes',
    String denyMsg = 'No',
    IconData? customConfirm,
    IconData? customDeny]) {
  // Gather theme data
  IconData confirmIcon = customConfirm ?? PlatformIcons(context).checkMark;
  IconData denyIcon = customConfirm ?? PlatformIcons(context).clear;

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

/// Styles a [PlatformSwitch] from [AppConfig.prefs]
Widget ezSwitch(BuildContext context, bool value, void Function(bool)? onChanged) {
  return PlatformSwitch(
    value: value,
    onChanged: onChanged,
    activeColor: Color(AppConfig.prefs[buttonColorKey]),
  );
}
