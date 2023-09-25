/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzWarning extends StatelessWidget {
  final String warning;
  final String message;
  final TextStyle? style;

  /// [Card] wrapper designed to grab attention for warnings...
  ///  (!) [warning] (!)
  ///      [message]
  const EzWarning({
    this.warning = 'WARNING',
    required this.message,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final Color? iconColor = Theme.of(context).colorScheme.secondary;

    final double padding = EzConfig.instance.prefs[paddingKey];

    return Semantics(
      button: false,
      readOnly: true,
      label: warning + ', ' + message,
      child: MergeSemantics(
        child: Card(
          child: Container(
            padding: EdgeInsets.all(padding),
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
                      size: style?.fontSize,
                    ),
                    EzSpacer.row(padding),

                    ExcludeSemantics(child: EzSelectableText(warning, style: style)),
                    EzSpacer.row(padding),

                    // Thing 2
                    Icon(
                      Icons.warning,
                      color: iconColor,
                      size: style?.fontSize,
                    ),
                  ],
                ),
                EzSpacer(padding),

                // Label
                ExcludeSemantics(child: EzSelectableText(message, style: style)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
