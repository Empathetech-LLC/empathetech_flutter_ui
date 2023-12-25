/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzWarning extends StatelessWidget {
  /// Warning [String] to grab the user's attention
  final String? title;

  /// What does the user need to know?
  final String body;

  final TextStyle? titleStyle;
  final TextStyle? bodyStyle;

  /// [Card] wrapper designed to grab attention for warnings...
  ///  /!\ [title] /!\
  ///      [body]
  const EzWarning({
    this.title,
    required this.body,
    this.titleStyle,
    this.bodyStyle,
  });

  @override
  Widget build(BuildContext context) {
    final Color? iconColor = Theme.of(context).colorScheme.secondary;

    final EzSpacer rowPadding = EzSpacer.row(EzConfig.get(paddingKey));

    final String _title = title ?? EFUILang.of(context)!.gAttention;

    return Semantics(
      button: false,
      readOnly: true,
      label: '$_title, $body',
      child: ExcludeSemantics(
        child: Card(
          child: Container(
            padding: EdgeInsets.all(EzConfig.get(marginKey)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Thing1
                    Icon(
                      Icons.warning,
                      color: iconColor,
                      size: titleStyle?.fontSize,
                    ),
                    rowPadding,

                    Text(
                      _title,
                      style: titleStyle,
                      textAlign: TextAlign.center,
                    ),
                    rowPadding,

                    // Thing 2
                    Icon(
                      Icons.warning,
                      color: iconColor,
                      size: titleStyle?.fontSize,
                    ),
                  ],
                ),
                EzNewLine(bodyStyle, textAlign: TextAlign.center),

                // Label
                Text(
                  body,
                  style: bodyStyle,
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
