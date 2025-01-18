/* empathetech_flutter_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzWarning extends StatelessWidget {
  /// What does the user need to know?
  final String body;

  /// Default to [TextTheme.bodyLarge]
  final TextStyle? bodyStyle;

  /// Warning [String] to grab the user's attention
  /// Defaults to [EFUILang.gAttention]
  final String? title;

  /// Default to [TextTheme.titleLarge]
  final TextStyle? titleStyle;

  /// Defaults to [ColorScheme.secondary]
  final Color? iconColor;

  /// [Card] wrapper designed to grab attention for warnings...
  ///  /!\ [title] /!\
  ///      [body]
  const EzWarning(
    this.body, {
    this.bodyStyle,
    this.title,
    this.titleStyle,
    this.iconColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Gather theme data //

    final EzSpacer margin = EzMargin(vertical: false);

    final ThemeData theme = Theme.of(context);

    final TextStyle? tStyle = titleStyle ?? theme.textTheme.titleLarge;
    final TextStyle? bStyle = bodyStyle ?? theme.textTheme.bodyLarge;

    final Color alertColor = iconColor ?? theme.colorScheme.secondary;

    // Return the build

    final String warning = title ?? EFUILang.of(context)!.gAttention;

    return Semantics(
      label: '$warning: $body',
      readOnly: true,
      child: ExcludeSemantics(
        child: Card(
          child: Container(
            padding: EdgeInsets.all(EzConfig.get(marginKey)),
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
                    margin,

                    Text(
                      warning,
                      style: tStyle,
                      textAlign: TextAlign.center,
                    ),
                    margin,

                    // Thing 2
                    Icon(
                      Icons.warning,
                      color: alertColor,
                      size: tStyle?.fontSize,
                    ),
                  ],
                ),
                const EzSpacer(),

                // Body
                Text(body, style: bStyle, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
