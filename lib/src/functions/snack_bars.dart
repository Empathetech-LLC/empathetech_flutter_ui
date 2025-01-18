/* empathetech_flutter_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';

/// Calculates [ezSnackBar] width based on [message] and [context]
/// [style] defaults to [SnackBarThemeData.contentTextStyle]
double snackWidth({
  required BuildContext context,
  required String message,
  TextStyle? style,
  double? margin,
  bool showCloseIcon = true,
}) {
  final TextStyle? snackStyle =
      style ?? Theme.of(context).snackBarTheme.contentTextStyle;

  final double snackMargin = margin ?? EzConfig.get(marginKey);

  final double countDownSize =
      measureIcon(Icons.circle, context, style: snackStyle).width * 2;

  final double closeIconSize = showCloseIcon
      ? (Theme.of(context)
                  .iconButtonTheme
                  .style
                  ?.iconSize
                  ?.resolve(<WidgetState>{WidgetState.selected}) ??
              0) +
          EzConfig.get(spacingKey)
      : 0;

  return measureText(message, context: context, style: snackStyle).width +
      countDownSize +
      closeIconSize +
      (snackMargin * 3);
}

/// Standardized [SnackBar] with an [EzCountdownTimer]
/// Most parameters are available, but [SnackBar.padding], [SnackBar.width], [SnackBar.content], and [SnackBar.duration] are controlled
/// [SnackBar.padding] can be influenced by [margin], [SnackBar.padding] is always [EdgeInsets.all]
/// [SnackBar.width], [SnackBar.content], and [SnackBar.duration] all respond to [message]
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> ezSnackBar({
  Color? backgroundColor,
  double? elevation,
  ShapeBorder? shape,
  SnackBarBehavior? behavior,
  SnackBarAction? action,
  double? actionOverflowThreshold,
  bool? showCloseIcon,
  Color? closeIconColor,
  Animation<double>? animation,
  VoidCallback? onVisible,
  DismissDirection? dismissDirection,
  Clip clipBehavior = Clip.hardEdge,
  required BuildContext context,
  required String message,
  double? margin,
  Duration? duration,
}) {
  final Duration toastLength = duration ?? readingTime(message);
  final double toastMargin = margin ?? EzConfig.get(marginKey);

  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      behavior: behavior,
      action: action,
      actionOverflowThreshold: actionOverflowThreshold,
      showCloseIcon: showCloseIcon ?? true,
      closeIconColor: closeIconColor ?? Theme.of(context).colorScheme.primary,
      animation: animation,
      onVisible: onVisible,
      dismissDirection: dismissDirection ?? DismissDirection.down,
      clipBehavior: clipBehavior,
      padding: EdgeInsets.all(toastMargin),
      width: min(
        snackWidth(
          context: context,
          message: message,
          margin: toastMargin,
          showCloseIcon: showCloseIcon ?? true,
        ),
        widthOf(context),
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
    ),
  );
}
