/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_saver/file_saver.dart';
import 'package:url_launcher/url_launcher.dart';

class EzFeedbackMenuButton extends StatelessWidget {
  /// [BuildContext] passthrough
  final BuildContext parentContext;

  /// Included in the email subject
  final String appName;

  /// Feedback recipient
  final String supportEmail;

  /// Activates the [BetterFeedback] tool and shares the results with [supportEmail]
  /// Uses [SharePlus] on mobile, classic mailto everywhere else
  const EzFeedbackMenuButton({
    super.key,
    required this.parentContext,
    required this.appName,
    required this.supportEmail,
  });

  @override
  Widget build(BuildContext context) {
    final EFUILang l10n = ezL10n(context);

    final bool strictMobile = !kIsWeb && isMobile();

    return EzMenuButton(
      onPressed: () async {
        if (strictMobile) {
          await Clipboard.setData(ClipboardData(text: supportEmail));

          if (parentContext.mounted) {
            await ezSnackBar(
              context: parentContext,
              message:
                  '${l10n.gOpeningFeedback}\n${l10n.gClipboard(l10n.gSupportEmail)}',
            ).closed;
          }
        }

        if (parentContext.mounted) {
          BetterFeedback.of(parentContext).show(
            (UserFeedback feedback) async {
              if (strictMobile) {
                await SharePlus.instance.share(ShareParams(
                  text: feedback.text,
                  files: <XFile>[
                    XFile.fromData(
                      feedback.screenshot,
                      name: 'screenshot.png',
                      mimeType: 'image/png',
                    )
                  ],
                ));
              } else {
                await FileSaver.instance.saveFile(
                  name: 'screenshot.png',
                  bytes: feedback.screenshot,
                  mimeType: MimeType.png,
                );
                await launchUrl(Uri.parse(
                  'mailto:$supportEmail?subject=$appName%20feedback&body=${feedback.text}\n\n----%20%20----%20%20----\n\n${l10n.gAttachScreenshot}',
                ));
              }
            },
          );
        }
      },
      icon: EzIcon(Icons.feedback_outlined),
      label: l10n.gGiveFeedback,
    );
  }
}
