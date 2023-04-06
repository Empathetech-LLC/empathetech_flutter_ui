library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EZButton extends StatelessWidget {
  final VoidCallback action;
  final VoidCallback longAction;
  final Widget body;
  final ButtonStyle? customStyle;

  /// Styles a [PlatformElevatedButton] from [AppConfig.prefs]
  /// If provided, [customStyle] will be merged with [materialButton]
  EZButton({
    required this.action,
    this.longAction = doNothing,
    required this.body,
    this.customStyle,
  });

  /// Styles a [PlatformElevatedButton] from [AppConfig.prefs]
  /// This constructor behaves like the Material [ElevatedButton.icon]
  /// If provided, [customStyle] will be merged with [materialButton]
  EZButton.icon({
    required this.action,
    this.longAction = doNothing,
    this.customStyle,
    required Icon icon,
    required String message,
    TextStyle? customTextStyle,
  }) : this.body = Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            icon,
            Container(width: AppConfig.prefs[paddingKey]),
            Text(
              message,
              style: customTextStyle ?? getTextStyle(buttonStyleKey),
              textAlign: TextAlign.center,
            ),
          ],
        );

  /// Text styling works differently in Material and Cupertino
  /// so a little redundancy goes a long way
  Widget _buildBody() {
    switch (this.body.runtimeType) {
      case Text:
        Text cast = this.body as Text;

        if (cast.style == null) {
          return Text(
            cast.data ?? 'Lorem ipsum',
            style: getTextStyle(buttonStyleKey),
            textAlign: cast.textAlign,
          );
        } else {
          return this.body;
        }

      default:
        return this.body;
    }
  }

  /// Mimics a [ButtonStyle] replaceAll() style function
  /// Replace and merge values in [materialButton] with values in [customStyle]
  ButtonStyle _buildStyle() {
    ButtonStyle style = materialButton();

    switch (this.body.runtimeType) {
      case Icon:
        style = materialButton(shape: CircleBorder());
        break;
    }

    if (customStyle != null) {
      style = style.copyWith(
        backgroundColor: customStyle!.backgroundColor ?? style.backgroundColor,
        foregroundColor: customStyle!.foregroundColor ?? style.foregroundColor,
        textStyle: customStyle!.textStyle ?? style.textStyle,
        padding: customStyle!.padding ?? style.padding,
        side: customStyle!.side ?? style.side,
        shape: customStyle!.shape ?? style.shape,
      );
      style = style.merge(customStyle!);
    }

    return style;
  }

  /// Builds a [CupertinoActionSheetAction] from this button's values
  Widget toAction() {
    /// Merge each child widget with the dialog content [TextStyle]
    Widget buildChild() {
      switch (this.body.runtimeType) {
        case Row:
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: (this.body as Row).children.map(
              (widget) {
                switch (widget.runtimeType) {
                  case Text:
                    return Text(
                      (widget as Text).data ?? 'Lorem ipsum',
                      style: getTextStyle(dialogContentStyleKey),
                      textAlign: TextAlign.center,
                    );
                  case Icon:
                    return Icon(
                      (widget as Icon).icon,
                      color: Color(AppConfig.prefs[themeTextColorKey]),
                    );
                  default:
                    return widget;
                }
              },
            ).toList(),
          );

        case Text:
          return Text(
            (this.body as Text).data ?? 'Lorem ipsum',
            style: getTextStyle(dialogContentStyleKey),
            textAlign: TextAlign.center,
          );

        case Icon:
          return Icon(
            (this.body as Icon).icon,
            color: Color(AppConfig.prefs[themeTextColorKey]),
          );

        default:
          return this.body;
      }
    }

    return GestureDetector(
      onLongPress: this.longAction,
      child: CupertinoActionSheetAction(
        onPressed: this.action,
        child: buildChild(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget ezBody = _buildBody();
    ButtonStyle ezStyle = _buildStyle();

    Color resolvedColor = ezStyle.backgroundColor!.resolve({MaterialState.pressed}) ??
        Color(AppConfig.prefs[buttonColorKey]);

    return GestureDetector(
      onLongPress: longAction,
      child: PlatformElevatedButton(
        onPressed: action,
        color: resolvedColor,

        // Android config
        material: (context, platform) => MaterialElevatedButtonData(
          child: ezBody,
          style: ezStyle,
        ),

        // iOS config
        cupertino: (context, platform) => m2cButton(
          child: ezBody,
          materialBase: ezStyle,
        ),
      ),
    );
  }
}
