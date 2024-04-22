import '../widgets/widgets.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:feedback/feedback.dart';
import 'package:share_plus/share_plus.dart';
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
          late final String screenshotPath;
          try {
            screenshotPath = await writeImageToStorage(feedback.screenshot);
          } catch (_) {
            return;
          }

          await Clipboard.setData(const ClipboardData(text: empathSupport));

          // ignore: deprecated_member_use
          await Share.shareFiles(
            <String>[screenshotPath],
            subject: 'Open UI feedback',
            text: feedback.text,
          ).then((_) async {
            scaffoldMessengerKey.currentState?.showMaterialBanner(
              MaterialBanner(
                content: const Text(
                  'Support email copied to clipboard',
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

  /// Taken from the feedback example app
  /// https://github.com/ueman/feedback/blob/master/feedback/example/lib/main.dart
  Future<String> writeImageToStorage(Uint8List feedbackScreenshot) async {
    final Directory output = await getTemporaryDirectory();
    final String screenshotFilePath = '${output.path}/feedback.png';
    final File screenshotFile = File(screenshotFilePath);
    await screenshotFile.writeAsBytes(feedbackScreenshot);
    return screenshotFilePath;
  }
}
