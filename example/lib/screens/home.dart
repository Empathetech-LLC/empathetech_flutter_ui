/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../screens/export.dart';
import '../utils/export.dart';
import '../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
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

  final EzSpacer margin = EzSpacer(space: EzConfig.get(marginKey));

  late final EFUILang l10n = EFUILang.of(context)!;

  late final TextTheme textTheme = Theme.of(context).textTheme;
  late final TextStyle? notificationStyle =
      textTheme.bodyLarge?.copyWith(fontSize: textTheme.titleLarge?.fontSize);

  // Define build data //

  final TextEditingController nameController = TextEditingController();
  final TextEditingController domController = TextEditingController();

  bool exampleDomain = false;

  bool textSettings = true;
  bool layoutSettings = true;
  bool colorSettings = true;
  bool imageSettings = true;

  late final TargetPlatform platform = getBasePlatform(context);

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
            Text(
              'App name',
              style: textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            margin,
            ConstrainedBox(
              constraints: ezTextFieldConstraints(context),
              child: TextFormField(
                controller: nameController,
                textAlign: TextAlign.center,
                maxLines: 1,
                validator: validateAppName,
                autovalidateMode: AutovalidateMode.onUnfocus,
                decoration: const InputDecoration(hintText: 'my_app'),
              ),
            ),
            separator,

            // Organization name
            Text(
              'Publishing domain',
              style: textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            margin,
            ConstrainedBox(
              constraints: ezTextFieldConstraints(context),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!exampleDomain) ...<Widget>[
                    TextFormField(
                      controller: domController,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      validator: validateDomain,
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      decoration:
                          const InputDecoration(hintText: 'example.com'),
                    ),
                    margin,
                  ],
                  EzRow(
                    mainAxisAlignment: exampleDomain
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.end,
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
                  ),
                ],
              ),
            ),
            separator,

            // Settings selection //
            Text(
              'Include',
              style: textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            EzSpacer(space: EzConfig.get(paddingKey)),

            // Text
            EzRow(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Text settings',
                  style: textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                Checkbox(
                  value: textSettings,
                  onChanged: (bool? value) async {
                    if (value == null) return;
                    setState(() => textSettings = value);
                  },
                ),
              ],
            ),
            spacer,

            // Layout
            EzRow(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Layout settings',
                  style: textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                Checkbox(
                  value: layoutSettings,
                  onChanged: (bool? value) async {
                    if (value == null) return;
                    setState(() => layoutSettings = value);
                  },
                ),
              ],
            ),
            spacer,

            // Color
            EzRow(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Color settings',
                  style: textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                Checkbox(
                  value: colorSettings,
                  onChanged: (bool? value) async {
                    if (value == null) return;
                    setState(() => colorSettings = value);
                  },
                ),
              ],
            ),
            spacer,

            // Image
            EzRow(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Image settings',
                  style: textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                Checkbox(
                  value: imageSettings,
                  onChanged: (bool? value) async {
                    if (value == null) return;
                    setState(() => imageSettings = value);
                  },
                ),
              ],
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: widthOf(context) * 0.667),
              child: const Divider(),
            ),

            // Default config notice
            EzRichText(
              <InlineSpan>[
                EzPlainText(
                  text:
                      'When you generate ${(kIsWeb || platform == TargetPlatform.iOS || platform == TargetPlatform.android) ? 'the config' : 'the app'}, the current ',
                  style: notificationStyle,
                ),
                EzInlineLink(
                  'settings',
                  style: notificationStyle,
                  onTap: () => context.goNamed(settingsHomePath),
                  semanticsLabel:
                      'Open a link to an online color scheme builder',
                ),
                EzPlainText(
                  text:
                      ''' (except images) will become the default config for ${nameController.text.isNotEmpty ? nameController.text : 'your app'}.
It is recommended to set a custom color scheme. If you need help building one, try starting ''',
                  style: notificationStyle,
                ),
                EzInlineLink(
                  'here.',
                  style: notificationStyle,
                  url: Uri.parse('https://www.canva.com/colors/color-wheel/'),
                  semanticsLabel:
                      'Open a link to an online color scheme builder',
                ),
              ],
              textAlign: TextAlign.center,
            ),
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
