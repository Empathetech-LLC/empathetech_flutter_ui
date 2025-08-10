/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class EzLink extends StatefulWidget {
  /// The [TextButton.child] will be [Text] with [text] and all provided styling
  final String text;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? style;

  /// Defaults to [ColorScheme.primary]
  final Color? textColor;

  /// Defaults to [textColor]... which defaults to [ColorScheme.primary]
  final Color? decorationColor;

  /// Optional override for [TextButton.style]
  final Color? backgroundColor;

  /// [Text.textAlign] passthrough
  final TextAlign? textAlign;

  /// Optional padding override for [TextButton.style]
  final EdgeInsets? padding;

  /// Destination function
  /// Provide [onTap] or [url], but not both
  final void Function()? onTap;

  /// Destination URL
  /// Provide [onTap] or [url], but not both
  final Uri? url;

  /// Message for screen readers
  /// Don't repeat [text] here, it is appended automatically
  final String hint;

  /// [Tooltip.message] passthrough
  /// On hover/focus hint
  /// Defaults to [hint]
  final String? tooltip;

  /// [TextButton] wrapper that either opens an internal link via [onTap]
  /// Or an external link to [url]
  /// Always has a [tooltip]; if one is not provided, it will default to [hint]
  /// Automatically draws [text] with [decorationColor] and adds an [TextDecoration.underline] on hover/focus
  const EzLink(
    this.text, {
    super.key,
    this.style,
    this.textColor,
    this.decorationColor,
    this.backgroundColor,
    this.textAlign,
    this.padding,
    this.onTap,
    this.url,
    required this.hint,
    this.tooltip,
  }) : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.');

  @override
  State<EzLink> createState() => _EzLinkState();
}

class _EzLinkState extends State<EzLink> {
  // Gather the fixed theme data //

  late final ThemeData theme = Theme.of(context);

  late final Color textColor = widget.textColor ?? theme.colorScheme.primary;

  late TextStyle? textStyle =
      (widget.style ?? theme.textTheme.bodyLarge)?.copyWith(
    color: textColor,
    decoration: TextDecoration.none,
    decorationColor: widget.decorationColor ?? textColor,
  );

  // Define custom functions //

  void underline(bool addIt) {
    textStyle = textStyle?.copyWith(
      decoration: addIt ? TextDecoration.underline : TextDecoration.none,
    );
    setState(() {});
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final String semantics = '${widget.text}; ${widget.hint}';

    final ButtonStyle buttonStyle = TextButton.styleFrom(
      padding: widget.padding,
      overlayColor: widget.decorationColor ?? theme.colorScheme.primary,
      backgroundColor: widget.backgroundColor,
    );

    final Text text = Text(
      widget.text,
      style: textStyle,
      textAlign: widget.textAlign,
    );

    return Tooltip(
      message: widget.tooltip ?? widget.hint,
      excludeFromSemantics: true,
      child: Semantics(
        link: true,
        hint: semantics,
        child: ExcludeSemantics(
          child: (widget.onTap != null)
              ? TextButton(
                  style: buttonStyle,
                  onPressed: widget.onTap,
                  onLongPress: null,
                  onHover: (bool isHovering) => underline(isHovering),
                  onFocusChange: (bool hasFocus) => underline(hasFocus),
                  child: text,
                )
              : Link(
                  uri: widget.url,
                  builder: (_, FollowLink? followLink) => TextButton(
                    style: buttonStyle,
                    onPressed: followLink,
                    onLongPress: null,
                    onHover: (bool isHovering) => underline(isHovering),
                    onFocusChange: (bool hasFocus) => underline(hasFocus),
                    child: text,
                  ),
                ),
        ),
      ),
    );
  }
}
