import 'package:flutter/material.dart';
import 'package:feedback/feedback.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class FeedbackButton extends StatelessWidget {
  final BuildContext parentContext;

  const FeedbackButton({super.key, required this.parentContext});

  @override
  Widget build(BuildContext context) {
    return MenuItemButton(
      onPressed: () {
        BetterFeedback.of(parentContext).show((UserFeedback feedback) {
          // Do something with the feedback
        });
      },
      leadingIcon: Icon(
        Icons.feedback,
        size: Theme.of(context).textTheme.titleLarge?.fontSize,
      ),
      child: Text(EFUILang.of(context)!.gGiveFeedback),
    );
  }
}
