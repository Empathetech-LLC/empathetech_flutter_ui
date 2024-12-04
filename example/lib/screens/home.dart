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
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Gather the theme data //

  static const EzSeparator separator = EzSeparator();
  static const EzDivider divider = EzDivider();
  final EzSpacer margin = EzSpacer(space: EzConfig.get(marginKey));

  late final EdgeInsets wrapPadding =
      EzInsets.col(EzConfig.get(paddingKey) * 2);
  late BoxConstraints textConstraints = ezTextFieldConstraints(context);

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
  bool validName = false;

  bool showAdvanced = false;

  bool autoEmu = false;

  // Define custom widgets //

  Widget settingsToggle(String title, bool toggle) {
    return Padding(
      padding: wrapPadding,
      child: EzRow(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title, style: textTheme.bodyLarge, textAlign: TextAlign.center),
          Checkbox(
            value: toggle,
            onChanged: (bool? value) async {
              if (value == null) return;
              setState(() => toggle = value);
            },
          ),
        ],
      ),
    );
  }

  late final List<Widget> advancedSettings = <Widget>[
    // Emulate
    EzRow(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Run Android emulator when complete',
          style: textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        Checkbox(
          value: autoEmu,
          onChanged: (bool? value) async {
            if (value == null) return;
            setState(() => autoEmu = value);
          },
        ),
      ],
    ),
    divider,
  ];

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
            // App name //

            // Title
            Text(
              'App name',
              style: textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            margin,

            // Field
            ConstrainedBox(
              constraints: textConstraints,
              child: TextFormField(
                controller: nameController,
                textAlign: TextAlign.center,
                maxLines: 1,
                validator: (String? entry) => validateAppName(
                  value: entry,
                  onSuccess: () => setState(() => validName = true),
                  onFailure: () => setState(() => validName = false),
                ),
                autovalidateMode: AutovalidateMode.onUnfocus,
                decoration: const InputDecoration(hintText: 'my_app'),
              ),
            ),
            separator,

            // Organization name //

            // Title
            Text(
              'Publishing domain',
              style: textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            margin,

            // Field
            ConstrainedBox(
              constraints: textConstraints,
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

            // Title
            Text(
              'Include',
              style: textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            EzSpacer(space: EzConfig.get(paddingKey)),

            // Options
            ConstrainedBox(
              constraints: textConstraints,
              child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  settingsToggle('Text settings', textSettings),
                  settingsToggle('Layout settings', layoutSettings),
                  settingsToggle('Color settings', colorSettings),
                  settingsToggle('Image settings', imageSettings),
                ],
              ),
            ),
            divider,

            // Default config notice
            EzRichText(
              <InlineSpan>[
                EzPlainText(
                  text:
                      'When you generate ${(kIsWeb || platform == TargetPlatform.iOS || platform == TargetPlatform.android) ? 'the config' : (validName ? nameController.text : 'the app')}, the current ',
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
                      ''' (except images) will become the default config for ${validName ? nameController.text : 'your app'}.

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
            divider,

            // Advanced settings //

            ...(showAdvanced
                ? advancedSettings
                : <Widget>[
                    EzTextIconButton(
                      onPressed: () => setState(() => showAdvanced = true),
                      icon: Icon(PlatformIcons(context).addCircledOutline),
                      label: 'Show advanced settings',
                    ),
                    separator,
                  ]),

            // Make it so //

            EzElevatedIconButton(
              onPressed: () {},
              icon: Icon(PlatformIcons(context).create),
              label: 'Generate',
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
