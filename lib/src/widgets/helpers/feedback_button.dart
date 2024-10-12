/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:feedback/feedback.dart';
import 'package:share_plus/share_plus.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

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
    return EzMenuButton(
      onPressed: () async {
        final String snackBarText = l10n.gClipboard(l10n.gSupportEmail);

        await ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(
              content: Text(snackBarText, textAlign: TextAlign.center),
              duration: readingTime(snackBarText),
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
