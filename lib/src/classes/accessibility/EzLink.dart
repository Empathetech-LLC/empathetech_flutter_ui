/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EzLink extends StatefulWidget {
  /// Link message
  final String text;

  final Key? key;

  final TextStyle? style;

  /// Optional [Color] to overwrite the default [ColorScheme.primary]
  final Color? color;

  final TextAlign? textAlign;

  /// Destination function
  final void Function()? onTap;

  /// Destination URL
  final Uri? url;

  /// Message for screen readers
  /// Defaults to [text]
  final String? semanticsLabel;

  /// On hover/focus hint
  /// Defaults to [semanticsLabel] (or [text])
  final String? tooltip;

  final MaterialStatesController? statesController;

  /// [TextButton] wrapper that acts like [Text] and either opens an internal link via [onTap]
  /// Or an external link to [url]
  /// Always has a [semanticsLabel]; if one is not provided, it will default to [text]
  /// Also has a [tooltip]; if one is not provided, it will default to [semanticsLabel] (or [text])
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
    this.semanticsLabel,
    this.tooltip,
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
    decoration: TextDecoration.none,
    decorationColor: _color,
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
    final String semantics = widget.semanticsLabel ?? widget.text;

    return Tooltip(
      message: widget.tooltip ?? semantics,
      excludeFromSemantics: true,
      child: Semantics(
        link: true,
        hint: semantics,
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
      ),
    );
  }
}
