/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
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

  final double snackMargin = margin ?? EzConfig.marginVal;
  final double countDownSize = EzConfig.iconSize * 1.5;

  final double closeIconSize = showCloseIcon
      ? (Theme.of(context)
                  .iconButtonTheme
                  .style
                  ?.iconSize
                  ?.resolve(<WidgetState>{WidgetState.selected}) ??
              0) +
          EzConfig.spacing
      : 0;

  return ezTextSize(message, context: context, style: snackStyle).width +
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
  Future<void> Function()? undo,
  String? undoMessage,
  double? margin,
  Duration? duration,
}) {
  late final Duration readingTime = (undo == null)
      ? ezReadingTime(message)
      : ezReadingTime(message) + const Duration(seconds: 1);
  late final Duration toastLength = duration ?? readingTime;

  final double toastMargin = margin ?? EzConfig.marginVal;

  late final TextStyle? bodyStyle = EzConfig.styles.bodyLarge;
  late final Color primary = EzConfig.colors.primary;

  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      behavior: behavior,
      action: action,
      actionOverflowThreshold: actionOverflowThreshold,
      showCloseIcon: showCloseIcon ?? true,
      closeIconColor: closeIconColor ?? EzConfig.colors.primary,
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
          // Text
          Flexible(child: Text(message, textAlign: TextAlign.center)),

          // Undo (conditional)
          if (undo != null) ...<Widget>[
            EzSpacer(space: toastMargin, vertical: false),
            EzTextButton(
              text: undoMessage ?? EzConfig.l10n.gUndo,
              textStyle: bodyStyle?.copyWith(color: primary),
              onPressed: () async {
                await undo();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                }
              },
            ),
          ],

          // Timer
          EzSpacer(space: toastMargin, vertical: false),
          EzCountdownTimer(duration: toastLength),

          // Close (inherited, above)
        ],
      ),
      duration: toastLength,
    ),
  );
}
