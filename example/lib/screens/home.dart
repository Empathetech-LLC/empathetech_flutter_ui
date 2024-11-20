/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/export.dart';
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

  static const EzSpacer spacer = EzSpacer();
  static const EzSpacer rowSpacer = EzSpacer(vertical: false);
  static const EzSeparator separator = EzSeparator();

  late final EFUILang l10n = EFUILang.of(context)!;

  // Define build data //

  final TextEditingController nameController = TextEditingController();
  final TextEditingController orgController = TextEditingController();

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(appTitle, Theme.of(context).colorScheme.primary);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return OpenUIScaffold(
      title: 'Builder',
      body: EzScreen(
        child: EzScrollView(
          children: <Widget>[
            Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // App name
                  EzRow(
                    children: <Widget>[
                      const Text('App Name:'),
                      rowSpacer,
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter your app name',
                        ),
                      ),
                    ],
                  ),
                  spacer,

                  // Organization name
                  EzRow(
                    children: <Widget>[
                      const Text('Organization Name:'),
                      rowSpacer,
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter your organization name',
                        ),
                      ),
                    ],
                  ),
                  separator,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    orgController.dispose();
    super.dispose();
  }
}
