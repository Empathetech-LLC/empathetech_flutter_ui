/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../screens/export.dart';
import '../structs/export.dart';
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

  static const EzSpacer spacer = EzSpacer();
  static const EzSeparator separator = EzSeparator();
  static const Widget divider = Center(child: EzDivider());

  final double margin = EzConfig.get(marginKey);
  final double spacing = EzConfig.get(spacingKey);

  late final EFUILang l10n = EFUILang.of(context)!;

  late final TextTheme textTheme = Theme.of(context).textTheme;
  late final TextStyle? notificationStyle =
      textTheme.bodyLarge?.copyWith(fontSize: textTheme.titleLarge?.fontSize);

  // Define build data //

  late final TargetPlatform platform = getBasePlatform(context);

  final TextEditingController appController = TextEditingController();
  bool validName = false;

  final TextEditingController pubController = TextEditingController();

  final TextEditingController domController = TextEditingController();
  bool exampleDomain = false;

  bool textSettings = true;
  bool layoutSettings = true;
  bool colorSettings = true;
  bool imageSettings = true;

  bool showAdvanced = false;

  bool autoEmu = false;

  bool showVSC = false;
  bool deleteVSC = false;
  static const String vscDefault = '''{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "run-app",
      "request": "launch",
      "type": "dart",
      "flutterMode": "debug",
      "program": "example/lib/main.dart",
    },
    {
      "name": "install-app",
      "request": "launch",
      "type": "dart",
      "flutterMode": "release",
      "program": "example/lib/main.dart",
    },
  ]
}''';
  final TextEditingController vscController =
      TextEditingController(text: vscDefault);

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
        alignment: Alignment.topLeft,
        child: EzScrollView(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // App name //

            // Title
            Text(
              'App name',
              style: textTheme.titleLarge,
              textAlign: TextAlign.start,
            ),

            // Field
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: measureText('long_app_name',
                          context: context, style: textTheme.bodyLarge)
                      .width),
              child: TextFormField(
                controller: appController,
                textAlign: TextAlign.start,
                maxLines: 1,
                validator: (String? entry) => validateAppName(
                  value: entry,
                  onSuccess: () => setState(() => validName = true),
                  onFailure: () => setState(() => validName = false),
                ),
                autovalidateMode: AutovalidateMode.onUnfocus,
                decoration: const InputDecoration(hintText: 'your_app'),
              ),
            ),
            spacer,

            // Publisher name //

            // Title
            Text(
              'Publisher name',
              style: textTheme.titleLarge,
              textAlign: TextAlign.start,
            ),

            // Field
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: measureText('Long Company Name',
                          context: context, style: textTheme.bodyLarge)
                      .width),
              child: TextFormField(
                controller: pubController,
                textAlign: TextAlign.start,
                maxLines: 1,
                decoration: const InputDecoration(hintText: 'You/your LLC'),
              ),
            ),
            spacer,

            // Domain //

            // Title
            Text(
              'Domain name',
              style: textTheme.titleLarge,
              textAlign: TextAlign.start,
            ),

            // Field
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: measureText('com.LongDomainName',
                          context: context, style: textTheme.bodyLarge)
                      .width),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!exampleDomain) ...<Widget>[
                    TextFormField(
                      controller: domController,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      validator: validateDomain,
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      decoration:
                          const InputDecoration(hintText: 'com.example'),
                    ),
                  ],
                  EzRow(
                    mainAxisAlignment: exampleDomain
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'N/A',
                        style: textTheme.bodyLarge,
                        textAlign: TextAlign.start,
                      ),
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
              textAlign: TextAlign.start,
            ),

            // Options
            Padding(
              padding: EdgeInsets.symmetric(horizontal: margin),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  EzRow(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Text settings',
                        style: textTheme.bodyLarge,
                        textAlign: TextAlign.start,
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
                  EzRow(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Layout settings',
                        style: textTheme.bodyLarge,
                        textAlign: TextAlign.start,
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
                  EzRow(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Color settings',
                        style: textTheme.bodyLarge,
                        textAlign: TextAlign.start,
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
                  EzRow(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Image settings',
                        style: textTheme.bodyLarge,
                        textAlign: TextAlign.start,
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
                ],
              ),
            ),
            divider,

            // Default config notice
            EzRichText(
              <InlineSpan>[
                EzPlainText(
                  text:
                      'When you generate ${(kIsWeb || platform == TargetPlatform.iOS || platform == TargetPlatform.android) ? 'the config' : (validName ? appController.text : 'the app')}, the current ',
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
                      ''' (except images) will become the default config for ${validName ? appController.text : 'your app'}.

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
              textAlign: TextAlign.start,
            ),
            divider,

            // Advanced settings //

            // Toggle
            EzRow(
              children: <Widget>[
                Text(
                  'Advanced settings',
                  style: textTheme.titleLarge,
                  textAlign: TextAlign.start,
                ),
                EzSpacer(vertical: false, space: margin),
                IconButton(
                  onPressed: () => setState(() => showAdvanced = !showAdvanced),
                  icon: Icon(
                    showAdvanced ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  ),
                ),
              ],
            ),

            // Settings
            Visibility(
              visible: showAdvanced,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Emulate
                  EzRow(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Run Android emulator when complete',
                        style: textTheme.bodyLarge,
                        textAlign: TextAlign.start,
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
                  spacer,

                  // VS Code config
                  Visibility(
                    visible: !deleteVSC,
                    child: Column(
                      children: <Widget>[
                        EzRow(
                          children: <Widget>[
                            Text(
                              '.vscode/launch.json',
                              style: textTheme.bodyLarge,
                              textAlign: TextAlign.start,
                            ),
                            EzSpacer(vertical: false, space: margin),
                            IconButton(
                              onPressed: () =>
                                  setState(() => showVSC = !showVSC),
                              icon: Icon(
                                showVSC
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                              ),
                            ),
                            EzSpacer(vertical: false, space: margin),
                            IconButton(
                              onPressed: () => setState(() => deleteVSC = true),
                              icon: Icon(PlatformIcons(context).delete),
                            ),
                          ],
                        ),

                        // Field
                        Visibility(
                          visible: showVSC,
                          child: ConstrainedBox(
                            constraints: ezTextFieldConstraints(context),
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: vscController,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            showAdvanced ? divider : separator,

            // Make it so //

            Center(
              child: EzElevatedIconButton(
                onPressed: () {
                  if (!validName ||
                      (!exampleDomain &&
                          validateDomain(domController.text) != null)) {
                    // TOAST OR SOMETHING
                    return;
                  }

                  context.goNamed(
                    progressPath,
                    extra: EAGConfig(
                      appName: appController.text,
                      publisherName: pubController.text,
                      domainName:
                          exampleDomain ? 'com.example' : domController.text,
                      textSettings: textSettings,
                      layoutSettings: layoutSettings,
                      colorSettings: colorSettings,
                      imageSettings: imageSettings,
                      vsCodeConfig: vscController.text,
                      appDefaults: Map<String, dynamic>.fromEntries(
                        allKeys.keys.map(
                          (String key) =>
                              MapEntry<String, dynamic>(key, EzConfig.get(key)),
                        ),
                      ),
                    ),
                  );
                },
                icon: Icon(PlatformIcons(context).create),
                label: 'Generate',
              ),
            ),
            separator,
          ],
        ),
      ),
      fab: ResetFAB(
        clearForms: () => setState(() {
          appController.clear();
          validName = false;

          pubController.clear();

          domController.clear();
          exampleDomain = false;

          textSettings = true;
          layoutSettings = true;
          colorSettings = true;
          imageSettings = true;

          showAdvanced = false;

          autoEmu = false;

          showVSC = false;
          deleteVSC = false;
          vscController.text = vscDefault;
        }),
      ),
    );
  }

  @override
  void dispose() {
    appController.dispose();
    pubController.dispose();
    domController.dispose();
    vscController.dispose();
    super.dispose();
  }
}
