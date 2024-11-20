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
  static const EzSeparator separator = EzSeparator();

  final double margin = EzConfig.get(marginKey);

  late final EzSpacer marginer = EzSpacer(space: margin);
  late final EzSpacer rowMargin = EzSpacer(space: margin, vertical: false);

  late final EFUILang l10n = EFUILang.of(context)!;

  // Define build data //

  final TextEditingController nameController = TextEditingController();
  final TextEditingController domController = TextEditingController();

  bool exampleDomain = false;

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
            // App name
            EzRow(
              children: <Widget>[
                const Text('App name:'),
                rowMargin,
                ConstrainedBox(
                  constraints: ezTextFieldConstraints(context),
                  child: TextFormField(
                    controller: nameController,
                    maxLines: 1,
                    validator: validateAppName,
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    decoration: const InputDecoration(hintText: 'My app'),
                  ),
                ),
              ],
            ),
            spacer,

            // Organization name
            EzRow(
              children: <Widget>[
                const Text('Publishing domain:'),
                rowMargin,
                ConstrainedBox(
                  constraints: ezTextFieldConstraints(context),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        controller: domController,
                        maxLines: 1,
                        validator: validateDomain,
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        decoration:
                            const InputDecoration(hintText: 'example.com'),
                      ),
                      marginer,
                      EzRow(
                        children: <Widget>[
                          const Text('N/A'),
                          Checkbox(
                            value: exampleDomain,
                            onChanged: (bool? value) async {
                              if (value == null) return;
                              setState(() => exampleDomain = value);
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            separator,
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    domController.dispose();
    super.dispose();
  }
}
