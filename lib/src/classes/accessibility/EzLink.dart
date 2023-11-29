import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EzLink extends StatelessWidget {
  /// Link message
  final String text;

  final TextStyle? style;

  /// Message for screen readers
  final String semanticsLabel;

  /// Destination function
  final void Function()? onTap;

  /// Destination URL
  final Uri? url;

  final Key? key;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextScaler? textScaler;
  final int? maxLines;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  /// [Text] wrapper that either opens an internal link via [onTap]
  /// Or an external link to [url]
  /// Requires [semanticsLabel] for screen readers
  EzLink(
    this.text, {
    this.style,
    required this.semanticsLabel,
    this.onTap,
    this.url,
    this.key,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.textScaler,
    this.maxLines,
    this.textWidthBasis,
    this.textHeightBehavior,
  })  : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      link: true,
      hint: semanticsLabel,
      child: ExcludeSemantics(
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onTap ?? () => launchUrl(url!),
            child: Text(
              text,
              style: style,
              strutStyle: strutStyle,
              textAlign: textAlign,
              textDirection: textDirection,
              textScaler: textScaler,
              maxLines: maxLines,
              semanticsLabel: null,
              textWidthBasis: textWidthBasis,
              textHeightBehavior: textHeightBehavior,
            ),
          ),
        ),
      ),
    );
  }
}
