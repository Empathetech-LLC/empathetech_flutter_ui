/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class ErrorScreen extends StatefulWidget {
  final GoException? error;

  ErrorScreen(this.error) : super(key: ValueKey<int>(EzConfig.seed));

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  // Set the page title //

  @override
  void initState() {
    super.initState();
    ezWindowNamer(ez404());
  }

  // Return the build //

  @override
  Widget build(BuildContext context) => OpenUIScaffold(EzScreen(
        Center(
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
        ),
        useImageDecoration: false,
      ));
}
