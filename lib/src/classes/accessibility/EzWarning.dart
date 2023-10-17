/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzWarning extends StatelessWidget {
  /// Short header [String] to grab the user's attention
  final String? warning;

  /// Body of the [EzWarning]
  final String message;

  final TextStyle? style;

  /// [Card] wrapper designed to grab attention for warnings...
  ///  (!) [warning] (!)
  ///      [message]
  const EzWarning({
    this.warning,
    required this.message,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final Color? iconColor = Theme.of(context).colorScheme.secondary;

    final double padding = EzConfig.instance.prefs[paddingKey];

    final String _warning = warning ?? EFUIPhrases.of(context)!.warning;

    return Semantics(
      button: false,
      readOnly: true,
      label: '$_warning, $message',
      child: ExcludeSemantics(
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

                    EzText(_warning, style: style),
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
                EzText(message, style: style),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
