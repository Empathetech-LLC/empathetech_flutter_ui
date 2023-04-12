library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Quick [MouseRegion] && [GestureDetector] combo
Widget ezClickable({
  required Widget child,
  void Function()? onTap,
  void Function()? onLongPress,
}) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: child,
    ),
  );
}

Stack userVideoControls({
  required BuildContext context,
  required AspectRatio video,
  required void Function() play,
  required void Function() mute,
}) {
  double margin = EzConfig.prefs[dialogSpacingKey];

  return Stack(
    children: [
      video,

      // Play/pause
      Positioned(
        bottom: margin,
        left: margin,
        child: ezClickable(
          child: ezIcon(PlatformIcons(context).playArrow),
          onTap: play,
        ),
      ),

      // Volume
      Positioned(
        bottom: margin,
        left: margin * 2.0,
        child: ezClickable(
          child: ezIcon(PlatformIcons(context).volumeMute),
          onTap: mute,
        ),
      ),
    ],
  );
}
