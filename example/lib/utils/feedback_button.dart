import 'package:flutter/material.dart';
import 'package:feedback/feedback.dart';

class FeedbackButton extends StatelessWidget {
  const FeedbackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: Theme.of(context).textTheme.titleLarge?.fontSize,
      icon: const Icon(Icons.feedback),
      onPressed: () {
        BetterFeedback.of(context).show((UserFeedback feedback) {
          // Do something with the feedback
        });
      },
    );
  }
}
