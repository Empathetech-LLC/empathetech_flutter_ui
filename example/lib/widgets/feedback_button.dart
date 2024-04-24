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

  const FeedbackButton({super.key, required this.parentContext});

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

          late final XFile screenshot;
          try {
            screenshot = await saveImage(feedback.screenshot);
          } catch (_) {
            return;
          }

          await Clipboard.setData(const ClipboardData(text: empathSupport));

          await Share.shareXFiles(
            <XFile>[screenshot],
            subject: 'Open UI feedback',
            text: feedback.text,
          ).then((_) async {
            scaffoldMessengerKey.currentState?.showMaterialBanner(
              MaterialBanner(
                content: Text(
                  EFUILang.of(context)!.gCopiedEmail,
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.close_outlined),
                    onPressed: () => scaffoldMessengerKey.currentState
                        ?.hideCurrentMaterialBanner(),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ],
              ),
            );
          });
        });
      },
      leadingIcon: Icon(
        Icons.feedback,
        size: Theme.of(context).textTheme.titleLarge?.fontSize,
      ),
      child: Text(EFUILang.of(context)!.gGiveFeedback),
    );
  }

  Future<XFile> saveImage(Uint8List feedbackScreenshot) async {
    final Directory output = await getTemporaryDirectory();
    final String screenshotFilePath = '${output.path}/feedback.png';
    return XFile(screenshotFilePath);
  }
}
