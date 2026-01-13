/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class EzElevatedLink extends StatelessWidget {
  /// [Tooltip.message] passthrough
  /// On hover/focus hint
  /// Defaults to [hint]
  final String? tooltip;

  /// [Semantics] hint; what does it do?
  /// Don't repeat [text] here, it is appended automatically
  final String hint;

  /// Destination URL
  final Uri? url;

  /// [EzElevatedButton.text] passthrough
  final String text;

  /// Minimal [EzElevatedButton] wrapped in a [Link]
  /// If you want an [ElevatedButton] with web [Semantics] and context menu
  /// Always has a [tooltip]; if one is not provided, it will default to [hint]
  const EzElevatedLink({
    super.key,
    this.tooltip,
    required this.hint,
    required this.url,
    required this.text,
  });

  @override
  Widget build(BuildContext context) => Tooltip(
        message: tooltip ?? hint,
        excludeFromSemantics: true,
        child: Semantics(
          button: true,
          link: true,
          hint: '$text; $hint',
          child: ExcludeSemantics(
            child: Link(
              uri: url,
              builder: (_, FollowLink? followLink) =>
                  EzElevatedButton(onPressed: followLink, text: text),
            ),
          ),
        ),
      );
}

class EzElevatedIconLink extends StatelessWidget {
  /// [Tooltip.message] passthrough
  /// On hover/focus hint
  /// Defaults to [hint]
  final String? tooltip;

  /// [Semantics] hint; what does it do?
  /// Don't repeat [label] here, it is appended automatically
  final String hint;

  /// Destination URL
  final Uri? url;

  /// [EzElevatedIconButton.icon] passthrough
  final Widget icon;

  /// [EzElevatedIconButton.label] passthrough
  final String label;

  /// Minimal [EzElevatedIconButton] wrapped in a [Link]
  /// If you want an [ElevatedButton.icon] with web [Semantics] and context menu
  /// Always has a [tooltip]; if one is not provided, it will default to [hint]
  const EzElevatedIconLink({
    super.key,
    this.tooltip,
    required this.hint,
    required this.url,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) => Tooltip(
        message: tooltip ?? hint,
        excludeFromSemantics: true,
        child: Semantics(
          button: true,
          link: true,
          hint: '$label; $hint',
          child: ExcludeSemantics(
            child: Link(
              uri: url,
              builder: (_, FollowLink? followLink) => EzElevatedIconButton(
                onPressed: followLink,
                icon: icon,
                label: label,
              ),
            ),
          ),
        ),
      );
}
