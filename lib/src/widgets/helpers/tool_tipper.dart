/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class EzToolTipper extends StatelessWidget {
  /// [Tooltip.message] passthrough
  final String? message;

  /// [Tooltip.richMessage] passthrough
  final InlineSpan? richMessage;

  /// Classic question mark tool tip
  const EzToolTipper({super.key, this.message, this.richMessage})
      : assert(((message == null) != (richMessage == null)),
            'Either message or richMessage must be provided, but not both');

  @override
  Widget build(BuildContext context) {
    final GlobalKey<TooltipState> key = GlobalKey<TooltipState>();
    bool isTooltipVisible = false;

    return EzTextBackground(
      Semantics(
        label: EzConfig.l10n.gHelp,
        button: true,
        onTap: () async {
          if (isTooltipVisible) {
            Tooltip.dismissAllToolTips();
          } else {
            key.currentState?.ensureTooltipVisible();

            // Wait for auto-announcement to finish
            await Future<void>.delayed(ezReadingTime(EzConfig.l10n.gHelp));
            String message = this.message ?? '';

            if (richMessage != null) {
              if (richMessage.runtimeType == EzInlineLink) {
                message = (richMessage as EzInlineLink).hint;
              } else if (richMessage.runtimeType == TextSpan) {
                for (final InlineSpan child
                    in (richMessage as TextSpan).children!) {
                  switch (child.runtimeType) {
                    case const (TextSpan):
                      final TextSpan ogSpan = child as TextSpan;
                      message += ogSpan.semanticsLabel ?? ogSpan.text!;
                      break;
                    case const (EzPlainText):
                      final EzPlainText plainSpan = child as EzPlainText;
                      message += plainSpan.semanticsLabel ?? plainSpan.text!;
                      break;
                    case const (EzInlineLink):
                      final EzInlineLink linkSpan = child as EzInlineLink;
                      message += linkSpan.richLabel ?? linkSpan.text;
                      break;
                    default:
                      break;
                  }
                }
              }
            }

            if (context.mounted) {
              SemanticsService.sendAnnouncement(
                View.of(context),
                message,
                TextDirection.ltr,
                assertiveness: Assertiveness.assertive,
              );
            }
          }
          isTooltipVisible = !isTooltipVisible;
        },
        child: Tooltip(
          waitDuration: Duration.zero,
          triggerMode: TooltipTriggerMode.tap,
          enableTapToDismiss: false,
          excludeFromSemantics: true,
          message: message,
          richMessage: richMessage,
          child: EzIcon(
            Icons.help_outline,
            color: EzConfig.colors.outline,
          ),
        ),
      ),
      useSurface: true,
      borderRadius: ezPillEdge,
    );
  }
}
