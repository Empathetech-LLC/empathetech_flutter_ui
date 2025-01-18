/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzToolTipper extends StatelessWidget {
  /// [Tooltip.message] passthrough
  final String? message;

  /// [Tooltip.richMessage] passthrough
  final InlineSpan? richMessage;

  /// Classic question mark tool tip
  const EzToolTipper({
    super.key,
    this.message,
    this.richMessage,
  }) : assert(((message == null) != (richMessage == null)),
            'Either message or richMessage must be provided, but not both');

  @override
  Widget build(BuildContext context) {
    final GlobalKey<TooltipState> key = GlobalKey<TooltipState>();
    bool isTooltipVisible = false;

    return EzTextBackground(
      Semantics(
        label: 'Help',
        button: true,
        onTap: () async {
          if (isTooltipVisible) {
            Tooltip.dismissAllToolTips();
          } else {
            key.currentState?.ensureTooltipVisible();

            // Custom Semantics announcements for richMessage
            if (richMessage != null) {
              // Wait for auto-announcement to finish
              await Future<void>.delayed(readingTime('Help'));

              if (richMessage.runtimeType == EzInlineLink) {
                // If it's just a link, use the included semanticsLabel
                SemanticsService.announce(
                  (richMessage as EzInlineLink).semanticsLabel,
                  TextDirection.ltr,
                  assertiveness: Assertiveness.assertive,
                );
              } else if (richMessage.runtimeType == TextSpan) {
                // If it's a TextSpan, we can assume it's a list and combine the semantics of all the children
                String message = '';

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
                      message += linkSpan.richSemanticsLabel ?? linkSpan.text;
                      break;
                    default:
                      break;
                  }
                }

                SemanticsService.announce(
                  message,
                  TextDirection.ltr,
                  assertiveness: Assertiveness.assertive,
                );
              }
            }
          }
          isTooltipVisible = !isTooltipVisible;
        },
        child: Tooltip(
          key: key,
          waitDuration: Duration.zero,
          triggerMode: TooltipTriggerMode.tap,
          enableTapToDismiss: false,
          excludeFromSemantics: true,
          message: message,
          richMessage: richMessage,
          child: EzIcon(
            PlatformIcons(context).helpOutline,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
      useSurface: true,
      borderRadius: ezPillShape,
    );
  }
}
