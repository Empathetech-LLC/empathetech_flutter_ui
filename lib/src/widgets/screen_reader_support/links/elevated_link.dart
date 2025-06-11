/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class EzElevatedLink extends StatelessWidget {
  /// [Tooltip.message] passthrough
  final String tooltip;

  /// [Semantics] label; What is it?
  final String label;

  /// [Semantics] value; is it unique?
  final String? value;

  /// [Semantics] hint; what does it do?
  final String hint;

  /// Destination URL
  final Uri? url;

  /// [EzElevatedButton.text] passthrough
  final String text;

  /// Minimal [EzElevatedButton] wrapped in a [Link]
  /// If you want an [ElevatedButton] with a web context menu
  const EzElevatedLink({
    super.key,
    required this.tooltip,
    required this.label,
    this.value,
    required this.hint,
    required this.url,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      excludeFromSemantics: true,
      child: Semantics(
        label: label,
        value: value,
        link: true,
        hint: hint,
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
}

class EzElevatedIconLink extends StatelessWidget {
  /// [Tooltip.message] passthrough
  final String tooltip;

  /// [Semantics] label; What is it?
  final String label;

  /// [Semantics] value; is it unique?
  final String? value;

  /// [Semantics] hint; what does it do?
  final String hint;

  /// Destination URL
  final Uri? url;

  /// [EzElevatedIconButton.icon] passthrough
  final Widget icon;

  /// [EzElevatedIconButton.label] passthrough
  final String buttonLabel;

  /// Minimal [EzElevatedIconButton] wrapped in a [Link]
  /// If you want an [ElevatedButton.icon] with a web context menu
  const EzElevatedIconLink({
    super.key,
    required this.tooltip,
    required this.label,
    this.value,
    required this.hint,
    required this.url,
    required this.icon,
    required this.buttonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      excludeFromSemantics: true,
      child: Semantics(
        label: label,
        value: value,
        link: true,
        hint: hint,
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
}
