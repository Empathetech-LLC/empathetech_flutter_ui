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

  const ErrorScreen(this.error, {super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ezWindowNamer(context, '404 ${EzConfig.l10n.gError}');
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return OpenUIScaffold(
      body: EzScreen(
        Center(
          child: EzScrollView(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                EzConfig.l10n.g404Wonder,
                style: textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              EzConfig.separator,
              Text(
                EzConfig.l10n.g404,
                style: ezSubTitleStyle(textTheme),
                textAlign: TextAlign.center,
              ),
              EzConfig.separator,
              Text(
                EzConfig.l10n.g404Note,
                style: textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              EzConfig.separator,
            ],
          ),
        ),
        useImageDecoration: false,
      ),
    );
  }
}
