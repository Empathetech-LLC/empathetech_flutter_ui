library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzButton extends StatelessWidget {
  final Key? key;
  final BuildContext context;
  final VoidCallback action;

  /// Default:
  /// [doNothing]
  final VoidCallback longAction;

  final Widget body;
  final ButtonStyle? customStyle;

  /// Default: false
  final bool forceMaterial;

  /// Styles a [PlatformElevatedButton] from [EzConfig.prefs]
  /// If provided, [customStyle] will be merged with [materialButton]
  /// Optionally provide [forceMaterial] to escape the walled garden
  EzButton({
    this.key,
    required this.context,
    required this.action,
    this.longAction = doNothing,
    required this.body,
    this.customStyle,
    this.forceMaterial = false,
  });

  /// Styles a [PlatformElevatedButton] from [EzConfig.prefs]
  /// This constructor behaves like the Material [ElevatedButton.icon]
  /// If provided, [customStyle] will be merged with [materialButton]
  /// Optionally provide [forceMaterial] to escape the walled garden
  EzButton.icon({
    this.key,
    required this.context,
    required this.action,
    this.longAction = doNothing,
    this.customStyle,
    this.forceMaterial = false,
    required Icon icon,
    required String message,
    TextStyle? customTextStyle,
  }) : this.body = Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            icon,
            Container(width: EzConfig.prefs[paddingKey]),
            EzText.simple(message),
          ],
        );

  /// Text styling works differently in Material and Cupertino
  /// so a little redundancy goes a long way
  Widget _buildBody() {
    switch (this.body.runtimeType) {
      case Text:
        Text cast = this.body as Text;

        if (cast.style == null) {
          return EzText.simple(
            cast.data ?? 'Lorem ipsum',
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

  @override
  Widget build(BuildContext context) {
    Widget ezBody = Padding(
      padding: EdgeInsets.all(EzConfig.prefs[paddingKey]),
      child: _buildBody(),
    );
    ButtonStyle ezStyle = _buildStyle();

    Color resolvedColor =
        ezStyle.backgroundColor!.resolve({MaterialState.pressed}) ??
            Color(EzConfig.prefs[buttonColorKey]);

    return (forceMaterial)
        ? ElevatedButton(
            key: key,
            onPressed: action,
            onLongPress: longAction,
            child: ezBody,
            style: ezStyle,
          )
        : GestureDetector(
            onLongPress: longAction,
            child: PlatformElevatedButton(
              key: key,
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

  /// Builds a [CupertinoActionSheetAction] from this button's values
  CupertinoActionSheetAction toAction() {
    /// Merge each child widget with the dialog content [TextStyle]
    Widget buildChild() {
      switch (this.body.runtimeType) {
        case Row: // aka EzButton.icon
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: (this.body as Row).children.map(
              (widget) {
                switch (widget.runtimeType) {
                  case Text:
                    return EzText.simple(
                        (widget as Text).data ?? 'Lorem ipsum');
                  case Icon:
                    return Icon(
                      (widget as Icon).icon,
                      color: Colors.white,
                    );
                  default:
                    return widget;
                }
              },
            ).toList(),
          );

        case Text:
          return EzText.simple((this.body as Text).data ?? 'Lorem ipsum');

        case Icon:
          return Icon(
            (this.body as Icon).icon,
            color: Colors.white,
          );

        default:
          return this.body;
      }
    }

    return CupertinoActionSheetAction(
      onPressed: this.action,
      child: GestureDetector(
        onLongPress: this.longAction,
        child: buildChild(),
      ),
    );
  }
}

/// Material (Android) [ElevatedButton] style built from [EzConfig.prefs]
ButtonStyle materialButton({OutlinedBorder? shape}) {
  return ElevatedButton.styleFrom(
    backgroundColor: Color(EzConfig.prefs[buttonColorKey]),
    foregroundColor: Color(EzConfig.prefs[buttonTextColorKey]),
    padding: EdgeInsets.all(EzConfig.prefs[paddingKey]),
    side: BorderSide(color: Color(EzConfig.prefs[buttonColorKey])),
    shape: shape,
  );
}

/// Cupertino (iOS) [ElevatedButton] data built [from] the passed in Material [ButtonStyle]
CupertinoElevatedButtonData m2cButton({
  required ButtonStyle materialBase,
  required Widget child,
}) {
  Color resolvedColor =
      materialBase.backgroundColor!.resolve({MaterialState.pressed}) ??
          Color(EzConfig.prefs[buttonColorKey]);

  EdgeInsetsGeometry padding =
      materialBase.padding!.resolve({MaterialState.pressed}) ??
          EdgeInsets.all(EzConfig.prefs[paddingKey]);

  return CupertinoElevatedButtonData(
    child: child,
    color: resolvedColor,
    padding: padding,
    borderRadius:
        (materialBase.shape != null) ? BorderRadius.circular(30.0) : null,
  );
}

/// Builds a pair of customizable [EzButton.icon]s for confirming and/or denying things
Widget ezYesNo({
  required BuildContext context,
  required void Function() onConfirm,
  required void Function() onDeny,
  required Axis axis,
  double? spacer,
  String confirmMsg = 'Yes',
  String denyMsg = 'No',
  Icon? customConfirm,
  Icon? customDeny,
}) {
  // Gather theme data

  Icon confirmIcon = customConfirm ?? Icon(PlatformIcons(context).checkMark);
  Icon denyIcon = customDeny ?? Icon(PlatformIcons(context).clear);
  double spacing =
      (spacer is double) ? spacer : EzConfig.prefs[buttonSpacingKey];

  return axis == Axis.vertical
      ? Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            EzButton.icon(
              context: context,
              action: onConfirm,
              icon: confirmIcon,
              message: confirmMsg,
            ),
            Container(height: spacing),
            EzButton.icon(
              context: context,
              action: onDeny,
              icon: denyIcon,
              message: denyMsg,
            ),
          ],
        )
      : Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            EzButton.icon(
              context: context,
              action: onConfirm,
              icon: confirmIcon,
              message: confirmMsg,
            ),
            Container(width: spacing),
            EzButton.icon(
              context: context,
              action: onDeny,
              icon: denyIcon,
              message: denyMsg,
            ),
          ],
        );
}
