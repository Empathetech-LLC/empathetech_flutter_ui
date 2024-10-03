/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EzLink extends StatefulWidget {
  /// Link message
  final String text;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? style;

  /// Defaults to [ColorScheme.primary]
  final Color? color;

  /// Optional [TextDecoration] color override
  /// Defaults to [color]... which defaults to [ColorScheme.primary]
  final Color? decorationColor;

  final TextAlign? textAlign;

  /// Optional padding override for [TextButton.style]
  /// Defaults to [EdgeInsets.all] => [EzConfig.get] => [marginKey]
  final EdgeInsets? padding;

  /// Destination function
  final void Function()? onTap;

  /// Destination URL
  final Uri? url;

  /// Message for screen readers
  /// Don't repeat [text] here, it is appended automatically
  final String semanticsLabel;

  /// On hover/focus hint
  /// Defaults to [semanticsLabel] (or [text])
  final String? tooltip;

  final WidgetStatesController? statesController;

  /// [TextButton] wrapper that either opens an internal link via [onTap]
  /// Or an external link to [url]
  /// Always has a tool [tooltip]. If one is not provided, it will default to [semanticsLabel]
  /// Automatically draws [text] with [ColorScheme.primary] and adds an [TextDecoration.underline] on hover/focus
  /// The [color] can optionally be overwritten
  const EzLink(
    this.text, {
    super.key,
    this.style,
    this.color,
    this.decorationColor,
    this.textAlign,
    this.padding,
    this.onTap,
    this.url,
    required this.semanticsLabel,
    this.tooltip,
    this.statesController,
  }) : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.');

  @override
  State<EzLink> createState() => _EzLinkState();
}

class _EzLinkState extends State<EzLink> {
  // Gather theme data //

  late final ThemeData theme = Theme.of(context);

  late final Color textColor = widget.color ?? theme.colorScheme.primary;

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
            style: TextButton.styleFrom(padding: widget.padding),
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
  /// Link message
  final String label;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? style;

  final Widget icon;

  /// Defaults to [ColorScheme.onSurface]
  final Color? baseColor;

  /// Defaults to [ColorScheme.primary]
  final Color? highlightColor;

  final TextAlign? textAlign;

  /// Destination function
  final void Function()? onTap;

  /// Destination URL
  final Uri? url;

  /// Message for screen readers
  /// Don't repeat [label] here, it is appended automatically
  final String semanticsLabel;

  /// On hover/focus hint
  /// Defaults to [semanticsLabel] (or [label])
  final String? tooltip;

  final WidgetStatesController? statesController;

  /// [TextButton.icon] wrapper that either opens an internal link via [onTap]
  /// Or an external link to [url]
  /// Always has a tool [tooltip]. If one is not provided, it will default to [semanticsLabel]...
  /// Highlights [label] of [baseColor] [ColorScheme.onSurface] with [ColorScheme.primary]
  /// ...and adds an [TextDecoration.underline] on hover/focus
  /// The [highlightColor] and [baseColor] can optionally be overwritten
  const EzIconLink({
    super.key,
    required this.label,
    this.style,
    required this.icon,
    this.baseColor,
    this.highlightColor,
    this.textAlign,
    this.onTap,
    this.url,
    required this.semanticsLabel,
    this.tooltip,
    this.statesController,
  }) : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.');

  @override
  State<EzIconLink> createState() => _EzIconLinkState();
}

class _EzIconLinkState extends State<EzIconLink> {
  // Gather theme data //

  final bool isLefty = EzConfig.get(isLeftyKey) ?? false;

  late final ThemeData theme = Theme.of(context);

  late final Color baseColor = widget.baseColor ?? theme.colorScheme.onSurface;

  late final Color highlightColor =
      widget.highlightColor ?? theme.colorScheme.primary;

  late TextStyle? textStyle =
      (widget.style ?? theme.textTheme.bodyLarge)?.copyWith(
    color: baseColor,
    decoration: TextDecoration.none,
    decorationColor: highlightColor,
  );

  // Define build data //

  late final String semantics = '${widget.label}; ${widget.semanticsLabel}';

  // Define custom functions //

  void highlight(bool addIt) {
    textStyle = textStyle?.copyWith(
      color: addIt ? highlightColor : baseColor,
      decoration: addIt ? TextDecoration.underline : TextDecoration.none,
    );
    setState(() {});
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip ?? widget.semanticsLabel,
      excludeFromSemantics: true,
      child: Semantics(
        link: true,
        hint: semantics,
        child: ExcludeSemantics(
          child: TextButton.icon(
            onPressed: widget.onTap ?? () => launchUrl(widget.url!),
            onLongPress: null,
            onHover: (bool isHovering) => highlight(isHovering),
            onFocusChange: (bool hasFocus) => highlight(hasFocus),
            icon: widget.icon,
            iconAlignment: isLefty ? IconAlignment.start : IconAlignment.end,
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
