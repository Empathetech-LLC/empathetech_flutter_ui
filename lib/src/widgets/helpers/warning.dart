/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzWarning extends StatelessWidget {
  /// What does the user need to know?
  final String body;

  /// Warning [String] to grab the user's attention
  /// Defaults to [EFUILang.gAttention]
  final String? title;

  /// [Card] wrapper designed to grab attention for warnings...
  ///  /!\  [title]  /!\
  ///       [body]
  const EzWarning(this.body, {this.title, super.key});

  @override
  Widget build(BuildContext context) => Semantics(
        label: '${title ?? EzConfig.l10n.gAttention}: $body',
        readOnly: true,
        child: ExcludeSemantics(
          child: Card(
            child: Container(
              padding: EdgeInsets.all(EzConfig.marginVal),
              child: EzCol(children: <Widget>[
                // Title
                EzScrollView(
                  scrollDirection: Axis.horizontal,
                  startCentered: true,
                  children: <Widget>[
                    // Thing1
                    EzIcon(Icons.warning, color: EzConfig.colors.secondary),
                    EzConfig.rowMargin,

                    Text(
                      title ?? EzConfig.l10n.gAttention,
                      style: EzConfig.styles.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    EzConfig.rowMargin,

                    // Thing 2
                    EzIcon(Icons.warning, color: EzConfig.colors.secondary),
                  ],
                ),
                EzConfig.spacer,

                // Body
                Text(
                  body,
                  style: EzConfig.styles.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ]),
            ),
          ),
        ),
      );
}
