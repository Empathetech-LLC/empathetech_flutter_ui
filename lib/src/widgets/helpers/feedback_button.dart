/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class EzFeedbackMenuButton extends StatelessWidget {
  final EFUILang l10n;
  final String appName;
  final String supportEmail;

  const EzFeedbackMenuButton({
    super.key,
    required this.l10n,
    required this.appName,
    this.supportEmail = empathSupport,
  });

  @override
  Widget build(BuildContext context) {
    final String message = kIsWeb
        ? '${l10n.gOpeningFeedback}\n${l10n.gSubmitWebFeedback(screenshotHint(context))}'
        : '${l10n.gOpeningFeedback}\n${l10n.gClipboard(l10n.gSupportEmail)}';

    return EzMenuButton(
      onPressed: () async {
        await ezSnackBar(context: context, message: message).closed;

        if (context.mounted) {
          BetterFeedback.of(context).show(
            (UserFeedback feedback) async {
              if (kIsWeb) {
                await launchUrl(Uri.parse(
                  'mailto:$empathSupport?subject=$appName%20feedback&body=${feedback.text}\n\n${l10n.gAttachScreenshot}',
                ));
              } else {
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
              }
            },
          );
        }
      },
      icon: const Icon(Icons.feedback_outlined),
      label: l10n.gGiveFeedback,
    );
  }
}
