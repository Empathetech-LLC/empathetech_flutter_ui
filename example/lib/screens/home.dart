/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Gather the theme data //

  static const EzSeparator separator = EzSeparator();

  late final EFUILang l10n = EFUILang.of(context)!;

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(efuiL, Theme.of(context).colorScheme.primary);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return OpenUIScaffold(
      body: EzScreen(
        child: EzScrollView(
          children: <Widget>[
            Center(
              child: Text(
                'Sup',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
            ),
            separator,
          ],
        ),
      ),
    );
  }
}
