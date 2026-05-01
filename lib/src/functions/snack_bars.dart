/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';

/// Standardized [SnackBar] with an [EzCountdownTimer]
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> ezSnackBar(
  BuildContext context, {
  required String message,
  Color? backgroundColor,
  VoidCallback? onVisible,
  bool? showCloseIcon,
  Future<void> Function()? undo,
  String? undoMessage,
}) {
  final Duration toastLength =
      (undo == null) ? ezReadingTime(message) : ezReadingTime(message) + const Duration(seconds: 2);

  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      showCloseIcon: showCloseIcon ?? true,
      onVisible: onVisible,
      padding: EdgeInsets.all(EzConfig.marginVal),
      width: min(
        _snackWidth(
          context: context,
          message: message,
          showCloseIcon: showCloseIcon ?? true,
          showUndo: undo != null,
        ),
        widthOf(context),
      ),
      content: EzRow(
        reverseHands: false,
        children: <Widget>[
          // Text
          Flexible(child: Text(message, textAlign: TextAlign.center)),

          // Undo (conditional)
          if (undo != null) ...<Widget>[
            EzConfig.rowMargin,
            EzTextButton(
              text: undoMessage ?? EzConfig.l10n.gUndo,
              textStyle: EzConfig.styles.bodyLarge?.copyWith(color: EzConfig.colors.primary),
              onPressed: () async {
                await undo();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                }
              },
            ),
          ],

          // Timer
          EzConfig.rowMargin,
          EzCountdownTimer(duration: toastLength),

          // Close (inherited, above)
        ],
      ),
      duration: toastLength,
    ),
  );
}

double _snackWidth({
  required BuildContext context,
  required String message,
  required bool showCloseIcon,
  required bool showUndo,
}) =>
    // Text width
    ezTextSize(
      message,
      context: context,
      style: EzConfig.theme.snackBarTheme.contentTextStyle,
    ).width +
    // Countdown width
    (EzConfig.iconSize + EzConfig.padding) +
    // Close width
    (showCloseIcon ? (EzConfig.iconSize + EzConfig.spacing) : 0) +
    // Margin(s) width
    (EzConfig.marginVal * 3);
