/* empathetech_flutter_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
  /// Defaults to [EdgeInsets.all] => [EzConfig.get] => [marginKey]
  final EdgeInsets? padding;

  /// Destination function
  /// Provide [onTap] or [url], but not both
  final void Function()? onTap;

  /// Destination URL
  /// Provide [onTap] or [url], but not both
  final Uri? url;

  /// Message for screen readers
  /// Don't repeat [text] here, it is appended automatically
  final String semanticsLabel;

  /// On hover/focus hint
  /// Defaults to [semanticsLabel] (or [text])
  final String? tooltip;

  /// [TextButton] wrapper that either opens an internal link via [onTap]
  /// Or an external link to [url]
  /// Always has a [tooltip]; if one is not provided, it will default to [semanticsLabel]
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
    required this.semanticsLabel,
    this.tooltip,
  }) : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.');

  @override
  State<EzLink> createState() => _EzLinkState();
}

class _EzLinkState extends State<EzLink> {
  // Gather theme data //

  late final ThemeData theme = Theme.of(context);

  late final Color textColor = widget.textColor ?? theme.colorScheme.primary;

  late TextStyle? textStyle =
      (widget.style ?? theme.textTheme.bodyLarge)?.copyWith(
    color: textColor,
    decoration: TextDecoration.none,
    decorationColor: widget.decorationColor ?? textColor,
  );

  // Define custom functions //

  void addUnderline(bool addIt) {
    textStyle = textStyle?.copyWith(
      decoration: addIt ? TextDecoration.underline : TextDecoration.none,
    );
    setState(() {});
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final String semantics = '${widget.text}; ${widget.semanticsLabel}';

    return Tooltip(
      message: widget.tooltip ?? widget.semanticsLabel,
      excludeFromSemantics: true,
      child: Semantics(
        link: true,
        hint: semantics,
        child: ExcludeSemantics(
          child: TextButton(
            style: TextButton.styleFrom(
              padding: widget.padding,
              overlayColor: widget.decorationColor ?? theme.colorScheme.primary,
              backgroundColor: widget.backgroundColor,
            ),
            onPressed: widget.onTap ?? () => launchUrl(widget.url!),
            onLongPress: null,
            onHover: (bool isHovering) => addUnderline(isHovering),
            onFocusChange: (bool hasFocus) => addUnderline(hasFocus),
            child: Text(
              widget.text,
              style: textStyle,
              textAlign: widget.textAlign,
            ),
          ),
        ),
      ),
    );
  }
}

class EzIconLink extends StatefulWidget {
  /// The [TextButton.icon] label will be [Text] with [label] and all provided styling
  final String label;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? style;

  /// [TextButton.icon] passthrough
  final Widget icon;

  /// Defaults to [ColorScheme.onSurface]
  final Color? textColor;

  /// Defaults to [ColorScheme.primary]
  final Color? decorationColor;

  /// [Text.textAlign] passthrough
  final TextAlign? textAlign;

  /// Optional padding override for [TextButton.style]
  /// Defaults to [EdgeInsets.all] => [EzConfig.get] => [marginKey]
  final EdgeInsets? padding;

  /// Destination function
  /// Provide [onTap] or [url], but not both
  final void Function()? onTap;

  /// Destination URL
  /// Provide [onTap] or [url], but not both
  final Uri? url;

  /// Message for screen readers
  /// Don't repeat [label] here, it is appended automatically
  final String semanticsLabel;

  /// On hover/focus hint
  /// Defaults to [semanticsLabel] (or [label])
  final String? tooltip;

  /// [TextButton.icon] wrapper that either opens an internal link via [onTap]
  /// Or an external link to [url]
  /// Always has a tool [tooltip]; if one is not provided, it will default to [semanticsLabel]
  /// Highlights [label] with [decorationColor] and adds an [TextDecoration.underline] on hover/focus
  const EzIconLink({
    super.key,
    required this.label,
    this.style,
    required this.icon,
    this.textColor,
    this.decorationColor,
    this.textAlign,
    this.padding,
    this.onTap,
    this.url,
    required this.semanticsLabel,
    this.tooltip,
  }) : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.');

  @override
  State<EzIconLink> createState() => _EzIconLinkState();
}

class _EzIconLinkState extends State<EzIconLink> {
  // Gather theme data //

  late final ThemeData theme = Theme.of(context);

  late final Color textColor = widget.textColor ?? theme.colorScheme.onSurface;

  late TextStyle? textStyle =
      (widget.style ?? theme.textTheme.bodyLarge)?.copyWith(
    color: textColor,
    decoration: TextDecoration.none,
    decorationColor: widget.decorationColor ?? theme.colorScheme.primary,
  );

  // Define custom functions //

  void highlight(bool addIt) {
    textStyle = textStyle?.copyWith(
      decoration: addIt ? TextDecoration.underline : TextDecoration.none,
    );
    setState(() {});
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final String semantics = '${widget.label}; ${widget.semanticsLabel}';

    return Tooltip(
      message: widget.tooltip ?? widget.semanticsLabel,
      excludeFromSemantics: true,
      child: Semantics(
        link: true,
        hint: semantics,
        child: ExcludeSemantics(
          child: TextButton.icon(
            style: TextButton.styleFrom(
              padding: widget.padding,
              overlayColor: widget.decorationColor ?? theme.colorScheme.primary,
            ),
            onPressed: widget.onTap ?? () => launchUrl(widget.url!),
            onLongPress: null,
            onHover: (bool isHovering) => highlight(isHovering),
            onFocusChange: (bool hasFocus) => highlight(hasFocus),
            icon: widget.icon,
            iconAlignment: (EzConfig.get(isLeftyKey) ?? false)
                ? IconAlignment.start
                : IconAlignment.end,
            label: Text(
              widget.label,
              style: textStyle,
              textAlign: widget.textAlign,
            ),
          ),
        ),
      ),
    );
  }
}
