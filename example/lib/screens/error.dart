/* open_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
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
  // Gather the theme data //

  static const EzSeparator separator = EzSeparator();

  late final EFUILang l10n = EFUILang.of(context)!;

  late final TextTheme textTheme = Theme.of(context).textTheme;

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ezWindowNamer('404 ${l10n.gError}', Theme.of(context).colorScheme.primary);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return OpenUIScaffold(
      body: EzScreen(
        useImageDecoration: false,
        child: Center(
          child: EzScrollView(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                l10n.g404Wonder,
                style: textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              separator,
              Text(
                l10n.g404,
                style: subTitleStyle(textTheme),
                textAlign: TextAlign.center,
              ),
              separator,
              Text(
                l10n.g404Note,
                style: textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              separator,
            ],
          ),
        ),
      ),
    );
  }
}
