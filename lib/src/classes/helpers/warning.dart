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

  /// What does the user need to know?
  final String body;

  final TextStyle? bodyStyle;

  /// Optional icon [Color] override, defaults to [ColorScheme.secondary]
  final Color? iconColor;

  /// [Card] wrapper designed to grab attention for warnings...
  ///  /!\ [title] /!\
  ///      [body]
  const EzWarning({
    super.key,
    this.title,
    this.titleStyle,
    required this.body,
    this.bodyStyle,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    // Gather theme data //
    final ThemeData theme = Theme.of(context);

    final String warning = title ?? EFUILang.of(context)!.gAttention;

    final TextStyle? tStyle = titleStyle ?? theme.textTheme.titleLarge;
    final TextStyle? bStyle = bodyStyle ?? theme.textTheme.bodyLarge;

    final Color alertColor = iconColor ?? theme.colorScheme.secondary;

    final EzSpacer rowPadding = EzSpacer.row(EzConfig.get(paddingKey));

    // Return the build

    return Semantics(
      button: false,
      readOnly: true,
      label: '$warning, $body',
      child: ExcludeSemantics(
        child: Card(
          child: Container(
            padding: EdgeInsets.all(EzConfig.get(marginKey)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Title
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Thing1
                    Icon(
                      Icons.warning,
                      color: alertColor,
                      size: tStyle?.fontSize,
                    ),
                    rowPadding,

                    Text(
                      warning,
                      style: tStyle,
                      textAlign: TextAlign.center,
                    ),
                    rowPadding,

                    // Thing 2
                    Icon(
                      Icons.warning,
                      color: alertColor,
                      size: tStyle?.fontSize,
                    ),
                  ],
                ),
                EzNewLine(bStyle, textAlign: TextAlign.center),

                // Label
                Text(
                  body,
                  style: bStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
