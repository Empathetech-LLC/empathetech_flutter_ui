/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzWarning extends StatelessWidget {
  /// Warning [String] to grab the user's attention
  final String? title;

  final TextStyle? titleStyle;

  /// Optional icon [Color] override, defaults to [ColorScheme.secondary]
  final Color? iconColor;

  /// Optional [Widget] to display above the [body]
  /// Must include it's own spacing widgets
  final Widget? header;

  /// What does the user need to know?
  final String body;

  final TextStyle? bodyStyle;

  /// Optional [Widget] to display below the [body]
  /// Must include it's own spacing widgets
  final Widget? footer;

  /// [Card] wrapper designed to grab attention for warnings...
  ///  /!\ [title] /!\
  ///      [body]
  const EzWarning({
    super.key,
    this.title,
    this.titleStyle,
    this.iconColor,
    this.header,
    required this.body,
    this.bodyStyle,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    // Gather theme data //

    final double margin = EzConfig.get(marginKey);
    final EzSpacer rowMargin = EzSpacer(space: margin, vertical: false);

    final ThemeData theme = Theme.of(context);

    final TextStyle? tStyle = titleStyle ?? theme.textTheme.titleLarge;
    final TextStyle? bStyle = bodyStyle ?? theme.textTheme.bodyLarge;

    final Color alertColor = iconColor ?? theme.colorScheme.secondary;

    // Return the build

    final String warning = title ?? EFUILang.of(context)!.gAttention;

    return Semantics(
      button: false,
      readOnly: true,
      label: '$warning: $body',
      child: ExcludeSemantics(
        child: Card(
          child: Container(
            padding: EdgeInsets.all(margin),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Title
                EzScrollView(
                  scrollDirection: Axis.horizontal,
                  startCentered: true,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Thing1
                    Icon(
                      Icons.warning,
                      color: alertColor,
                      size: tStyle?.fontSize,
                    ),
                    rowMargin,

                    Text(
                      warning,
                      style: tStyle,
                      textAlign: TextAlign.center,
                    ),
                    rowMargin,

                    // Thing 2
                    Icon(
                      Icons.warning,
                      color: alertColor,
                      size: tStyle?.fontSize,
                    ),
                  ],
                ),

                // Header (optional)
                if (header != null) header!,

                // Body
                Text(body, style: bStyle, textAlign: TextAlign.center),

                // Footer (optional)
                if (footer != null) footer!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
