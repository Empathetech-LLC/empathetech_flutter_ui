/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzWarning extends StatelessWidget {
  /// What does the user need to know?
  final String body;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? bodyStyle;

  /// Warning [String] to grab the user's attention
  /// Defaults to [EFUILang.gAttention]
  final String? title;

  /// Defaults to [TextTheme.titleLarge]
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
    // Gather the contextual theme data //

    final Color alertColor = iconColor ?? EzConfig.colors.secondary;

    final TextStyle? tStyle = titleStyle ?? EzConfig.styles.titleLarge;
    final TextStyle? bStyle = bodyStyle ?? EzConfig.styles.bodyLarge;

    // Return the build //

    final String warning = title ?? EzConfig.l10n.gAttention;

    return Semantics(
      label: '$warning: $body',
      readOnly: true,
      child: ExcludeSemantics(
        child: Card(
          child: Container(
            padding: EdgeInsets.all(EzConfig.marginVal),
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
                    EzConfig.rowMargin,

                    Text(
                      warning,
                      style: tStyle,
                      textAlign: TextAlign.center,
                    ),
                    EzConfig.rowMargin,

                    // Thing 2
                    Icon(
                      Icons.warning,
                      color: alertColor,
                      size: tStyle?.fontSize,
                    ),
                  ],
                ),
                EzConfig.spacer,

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
