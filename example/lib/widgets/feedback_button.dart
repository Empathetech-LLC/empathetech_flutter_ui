import '../widgets/widgets.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class FeedbackButton extends StatelessWidget {
  final BuildContext parentContext;
  final EFUILang l10n;

  /// Recommended to provide [ColorScheme].surface
  final Color bannerIconColor;

  const FeedbackButton({
    super.key,
    required this.parentContext,
    required this.l10n,
    required this.bannerIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return MenuItemButton(
      onPressed: () {
        BetterFeedback.of(parentContext).show((UserFeedback feedback) async {
          if (kIsWeb) {
            final Uri mailtoUri = Uri(
              scheme: 'mailto',
              path: empathSupport,
              queryParameters: <String, dynamic>{
                'subject': 'Open UI feedback',
                'body': feedback.text,
              },
            );
            await launchUrl(mailtoUri);
            return;
          }

          final String screenshotFilePath =
              await writeImageToStorage(feedback.screenshot);

          await Clipboard.setData(const ClipboardData(text: empathSupport));

          scaffoldMessengerKey.currentState?.showMaterialBanner(
            MaterialBanner(
              content: Text(
                l10n.gCopiedEmail,
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: bannerIconColor,
                  ),
                  onPressed: () => scaffoldMessengerKey.currentState
                      ?.hideCurrentMaterialBanner(),
                ),
              ],
            ),
          );

          // ignore: deprecated_member_use
          await Share.shareFiles(
            <String>[screenshotFilePath],
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

/// Taken better_feedback's example app
/// https://pub.dev/packages/feedback/example
Future<String> writeImageToStorage(Uint8List feedbackScreenshot) async {
  final Directory output = await getTemporaryDirectory();
  final String screenshotFilePath = '${output.path}/feedback.png';
  final File screenshotFile = File(screenshotFilePath);
  await screenshotFile.writeAsBytes(feedbackScreenshot);
  return screenshotFilePath;
}
