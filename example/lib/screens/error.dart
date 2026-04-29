/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class ErrorScreen extends StatelessWidget {
  ErrorScreen() : super(key: ValueKey<int>(EzConfig.seed));

  @override
  Widget build(BuildContext context) => OpenUIScaffold(EzScreen(Center(
        child: EzScrollView(children: <Widget>[
          Text(
            EzConfig.l10n.g404Wonder,
            style: EzConfig.styles.headlineLarge,
            textAlign: TextAlign.center,
          ),
          EzConfig.separator,
          Text(
            EzConfig.l10n.g404,
            style: ezSubTitleStyle(),
            textAlign: TextAlign.center,
          ),
          EzConfig.separator,
          Text(
            EzConfig.l10n.g404Note,
            style: EzConfig.styles.labelLarge,
            textAlign: TextAlign.center,
          ),
        ]),
      )));
}
