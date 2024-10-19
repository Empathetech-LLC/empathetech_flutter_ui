/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:feedback/feedback.dart';
import 'package:share_plus/share_plus.dart';

class FeedbackButton extends StatelessWidget {
  final EFUILang l10n;
  final String supportEmail;

  const FeedbackButton({
    super.key,
    required this.l10n,
    this.supportEmail = empathSupport,
  });

  @override
  Widget build(BuildContext context) {
    late final double margin = EzConfig.get(marginKey);

    late final String message = l10n.gClipboard(l10n.gSupportEmail);
    late final Duration duration = readingTime(message);

    return EzMenuButton(
      onPressed: () async {
        await ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(
              padding: EdgeInsets.all(margin),
              width: snackWidth(context: context, message: message),
              content: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(child: Text(message, textAlign: TextAlign.center)),
                  EzSpacer(space: margin, vertical: false),
                  EzCountdownTimer(duration: duration),
                ],
              ),
              duration: duration,
            ))
            .closed;

        if (context.mounted) {
          BetterFeedback.of(context).show(
            (UserFeedback feedback) async {
              await Clipboard.setData(ClipboardData(text: supportEmail));

              await Share.shareXFiles(
                <XFile>[
                  XFile.fromData(
                    feedback.screenshot,
                    name: 'screenshot.png',
                    mimeType: 'image/png',
                  )
                ],
                text: feedback.text,
              );
            },
          );
        }
      },
      icon: const Icon(Icons.feedback_outlined),
      label: l10n.gGiveFeedback,
    );
  }
}
