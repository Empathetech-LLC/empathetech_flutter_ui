/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Calculates [SnackBar.width] based on [message] and [context]
/// [style] defaults to [SnackBarThemeData.contentTextStyle]
double snackWidth({
  required BuildContext context,
  required String message,
  TextStyle? style,
  double? margin,
}) {
  final TextStyle? snackStyle =
      style ?? Theme.of(context).snackBarTheme.contentTextStyle;

  final double iconRadius =
      measureIcon(Icons.circle, context: context, style: snackStyle).width;

  return measureText(message, context: context, style: snackStyle).width +
      iconRadius * 2 +
      3 * (margin ?? EzConfig.get(marginKey));
}

class EzSnackBar extends StatelessWidget {
  final Color? backgroundColor;
  final double? elevation;
  final ShapeBorder? shape;
  final SnackBarBehavior? behavior;
  final SnackBarAction? action;
  final double? actionOverflowThreshold;
  final bool? showCloseIcon;
  final Color? closeIconColor;
  final Animation<double>? animation;
  final VoidCallback? onVisible;
  final DismissDirection? dismissDirection;
  final Clip clipBehavior;
  final double? margin;
  final Duration? duration;
  final String message;

  /// Standardized [message] toast with an [EzCountdownTimer]
  /// Needs to be casted: `EzSnackBar(message: 'Hello World') as SnackBar`
  const EzSnackBar({
    super.key,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.behavior,
    this.action,
    this.actionOverflowThreshold,
    this.showCloseIcon,
    this.closeIconColor,
    this.animation,
    this.onVisible,
    this.dismissDirection,
    this.clipBehavior = Clip.hardEdge,
    this.margin,
    this.duration,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final double toastMargin = margin ?? EzConfig.get(marginKey);
    final Duration toastLength = duration ?? readingTime(message);

    return SnackBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      behavior: behavior,
      action: action,
      actionOverflowThreshold: actionOverflowThreshold,
      showCloseIcon: showCloseIcon,
      closeIconColor: closeIconColor,
      animation: animation,
      onVisible: onVisible,
      dismissDirection: dismissDirection,
      clipBehavior: clipBehavior,
      padding: EdgeInsets.all(toastMargin),
      width: snackWidth(
        context: context,
        message: message,
        margin: toastMargin,
      ),
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(child: Text(message, textAlign: TextAlign.center)),
          EzSpacer(space: toastMargin, vertical: false),
          EzCountdownTimer(duration: toastLength),
        ],
      ),
      duration: toastLength,
    );
  }
}
