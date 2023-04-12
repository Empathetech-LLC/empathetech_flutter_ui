library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

Stack userVideoControls({
  required BuildContext context,
  required AspectRatio video,
  required Icon playIcon,
  required void Function() playClick,
  required Icon muteIcon,
  required void Function() muteClick,
  required Icon replayIcon,
  required void Function() replayClick,
}) {
  double margin = EzConfig.prefs[dialogSpacingKey];

  return Stack(
    children: [
      video,
      Positioned(
        bottom: margin,
        left: margin,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Play/pause
            ezClickable(
              child: playIcon,
              onTap: playClick,
            ),
            Container(width: margin),

            // Volume
            ezClickable(
              child: muteIcon,
              onTap: muteClick,
            ),

            // Replay
            ezClickable(
              child: replayIcon,
              onTap: replayClick,
            ),
          ],
        ),
      ),
    ],
  );
}
