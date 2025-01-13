/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_saver/file_saver.dart';
import 'package:url_launcher/url_launcher.dart';

class EzFeedbackMenuButton extends StatelessWidget {
  final BuildContext parentContext;
  final String appName;
  final String supportEmail;

  const EzFeedbackMenuButton({
    super.key,
    required this.parentContext,
    required this.appName,
    required this.supportEmail,
  });

  @override
  Widget build(BuildContext context) {
    final EFUILang l10n = EFUILang.of(context)!;

    final bool isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);

    return EzMenuButton(
      onPressed: () async {
        if (isMobile) {
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
              if (isMobile) {
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
              } else {
                await FileSaver.instance.saveFile(
                  name: 'screenshot.png',
                  bytes: feedback.screenshot,
                  mimeType: MimeType.png,
                );
                await launchUrl(Uri.parse(
                  'mailto:$empathSupport?subject=$appName%20feedback&body=${feedback.text}\n\n${l10n.gAttachScreenshot}',
                ));
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
