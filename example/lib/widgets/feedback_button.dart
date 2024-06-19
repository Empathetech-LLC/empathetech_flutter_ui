import './keys.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:feedback/feedback.dart';
import 'package:share_plus/share_plus.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class FeedbackButton extends StatelessWidget {
  final BuildContext parentContext;
  final EFUILang l10n;

  const FeedbackButton({
    super.key,
    required this.parentContext,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return MenuItemButton(
      onPressed: () async {
        final String snackBarText = l10n.gClipboard(l10n.gSupportEmail);

        await scaffoldMessengerKey.currentState
            ?.showSnackBar(SnackBar(
              content: Text(snackBarText, textAlign: TextAlign.center),
              duration: readingTime(snackBarText),
            ))
            .closed;

        BetterFeedback.of(parentContext).show((UserFeedback feedback) async {
          await Clipboard.setData(const ClipboardData(text: empathSupport));

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
        });
      },
      leadingIcon: Icon(
        Icons.feedback,
        size: Theme.of(context).textTheme.titleLarge?.fontSize,
      ),
      child: Text(l10n.gGiveFeedback),
    );
  }
}
