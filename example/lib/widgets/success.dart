/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class SuccessHeader extends StatelessWidget {
  /// Core message to display... under 'Success'
  /// Used in an [Flexible] wrapped [EzText]
  /// Provide [message] or [richMessage]
  final String? message;

  /// Core message to display... under 'Success'
  /// Provide [message] or [richMessage]
  final Widget? richMessage;

  /// header [Widget] for a successful run
  const SuccessHeader({
    super.key,
    this.message,
    this.richMessage,
  }) : assert((message == null) != (richMessage == null),
            'Either message or richMessage must be provided, but not both.');

  @override
  Widget build(BuildContext context) => EzCol(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Headline
          Flexible(
            child: EzText(
              EzConfig.l10n.gSuccessExl,
              style: EzConfig.styles.headlineLarge,
              textAlign: TextAlign.center,
            ),
          ),
          EzConfig.spacer,

          // Where to go next
          message == null
              ? richMessage!
              : Flexible(
                  child: EzText(
                    message!,
                    style: ezSubTitleStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
        ],
      );
}
