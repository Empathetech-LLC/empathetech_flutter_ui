/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EzLink extends StatefulWidget {
  final Key? key;

  /// Link message
  final String text;

  final TextStyle? style;

  /// Optional [Color] to overwrite the default [ColorScheme.primary]
  final Color? color;

  final TextAlign? textAlign;

  /// Destination function
  final void Function()? onTap;

  /// Destination URL
  final Uri? url;

  /// Message for screen readers
  final String semanticsLabel;

  final MaterialStatesController? statesController;

  /// [TextButton] wrapper that acts like [Text] and either opens an internal link via [onTap]
  /// Or an external link to [url]
  /// Requires [semanticsLabel] for screen readers
  /// Automatically colors [text] with [ColorScheme.primary] and adds an [TextDecoration.underline] on hover/focus
  /// The [color] can optionally be overwritten
  EzLink(
    this.text, {
    this.key,
    this.style,
    this.color,
    this.textAlign,
    this.onTap,
    this.url,
    required this.semanticsLabel,
    this.statesController,
  })  : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.'),
        super(key: key);

  @override
  _EzLinkState createState() => _EzLinkState();
}

class _EzLinkState extends State<EzLink> {
  late final Color _color =
      widget.color ?? Theme.of(context).colorScheme.primary;

  late TextStyle? _style = widget.style?.copyWith(
    color: _color,
    decorationColor: _color,
    decoration: TextDecoration.none,
  );

  void _addUnderline(bool addIt) {
    setState(() {
      _style = _style?.copyWith(
        decoration: addIt ? TextDecoration.underline : TextDecoration.none,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      link: true,
      hint: widget.semanticsLabel,
      child: ExcludeSemantics(
        child: TextButton(
          onPressed: widget.onTap ?? () => launchUrl(widget.url!),
          onHover: (isHovering) => _addUnderline(isHovering),
          onFocusChange: (hasFocus) => _addUnderline(hasFocus),
          child: Text(
            widget.text,
            style: _style,
            textAlign: widget.textAlign,
          ),
        ),
      ),
    );
  }
}
