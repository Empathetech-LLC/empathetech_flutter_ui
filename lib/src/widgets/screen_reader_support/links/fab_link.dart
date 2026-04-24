/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class EzFABLink extends StatelessWidget {
  /// [Link.uri] passthrough
  final Uri uri;

  /// [FloatingActionButton.tooltip] passthrough
  final String? tooltip;

  /// [FloatingActionButton.foregroundColor] passthrough
  final Color? foregroundColor;

  /// [FloatingActionButton.backgroundColor] passthrough
  final Color? backgroundColor;

  /// [FloatingActionButton.heroTag] passthrough
  final Object? heroTag;

  /// [FloatingActionButton.child] passthrough
  final Widget? child;

  /// [FloatingActionButton] wrapped in a [Link]
  const EzFABLink({
    super.key,
    required this.uri,
    this.tooltip,
    this.foregroundColor,
    this.backgroundColor,
    this.heroTag,
    this.child,
  });

  @override
  Widget build(BuildContext context) => Link(
        uri: uri,
        builder: (_, FollowLink? followLink) => FloatingActionButton(
          tooltip: tooltip,
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          heroTag: heroTag,
          onPressed: followLink,
          child: child,
        ),
      );
}
