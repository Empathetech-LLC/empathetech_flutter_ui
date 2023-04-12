library empathetech_flutter_ui;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

Widget ezLink({
  required Uri url,
  required Widget child,
}) {
  return ezClickable(
    onTap: () => launchUrl(url),
    child: child,
  );
}
