import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EzLink extends StatelessWidget {
  final Key? key;

  /// Link message
  final String text;

  final TextStyle? style;
  final TextAlign? textAlign;

  /// Destination function
  final void Function()? onTap;

  /// Destination URL
  final Uri? url;

  /// Optional long press functionality
  final void Function()? onLongPress;

  /// Message for screen readers
  final String semanticsLabel;

  final MaterialStatesController? statesController;

  /// [TextButton] wrapper that acts like [Text] and either opens an internal link via [onTap]
  /// Or an external link to [url]
  /// Requires [semanticsLabel] for screen readers
  /// Automatically colors [text] with [ColorScheme.primary] and adds an [underline] on hover
  EzLink(
    this.text, {
    this.key,
    this.style,
    this.textAlign,
    this.onTap,
    this.url,
    this.onLongPress,
    required this.semanticsLabel,
    this.statesController,
  })  : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      link: true,
      hint: semanticsLabel,
      child: ExcludeSemantics(
        child: TextButton(
          onPressed: onTap ?? () => launchUrl(url!),
          onLongPress: onLongPress,
          onHover: _addUnderline,
          autofocus: false,
          clipBehavior: Clip.none,
          statesController: statesController,
          child: Text(text, style: _style, textAlign: textAlign),
        ),
      ),
    );
  }
}
