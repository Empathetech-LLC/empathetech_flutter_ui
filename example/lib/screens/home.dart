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

  bool showAnalysis = false;
  bool deleteAnalysis = false;
  static const String analysisDefault =
      '''include: package:flutter_lints/flutter.yaml

analyzer:
  exclude: [lib/l10n/**]

linter:
  rules:
    always_declare_return_types: true
    always_specify_types: true
    avoid_null_checks_in_equality_operators: true
    avoid_types_as_parameter_names: true
    await_only_futures: true
    camel_case_types: true
    constant_identifier_names: true
    empty_catches: true
    file_names: true
    hash_and_equals: true
    library_names: true
    library_prefixes: true
    non_constant_identifier_names: true
    package_names: true
    prefer_asserts_with_message: true
    prefer_conditional_assignment: true
    prefer_const_constructors: true
    prefer_const_declarations: true
    prefer_final_fields: true
    prefer_final_in_for_each: true
    prefer_final_locals: true
    prefer_function_declarations_over_variables: true
    prefer_if_null_operators: true
    prefer_single_quotes: true
    provide_deprecation_message: true
    test_types_in_equals: true
    unnecessary_late: true
    unnecessary_library_name: true
    unnecessary_new: true
    use_build_context_synchronously: true
    use_full_hex_values_for_flutter_colors: true
    ''';
  final TextEditingController analysisController =
      TextEditingController(text: analysisDefault);

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
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                  ),
                  spacer,

                  // Analysis options config
                  Visibility(
                    visible: !deleteAnalysis,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        EzRow(
                          children: <Widget>[
                            Text(
                              'analysis_options.yaml',
                              style: textTheme.bodyLarge,
                              textAlign: TextAlign.start,
                            ),
                            EzSpacer(vertical: false, space: margin),
                            IconButton(
                              onPressed: () =>
                                  setState(() => showAnalysis = !showAnalysis),
                              icon: Icon(
                                showAnalysis
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                              ),
                            ),
                            EzSpacer(vertical: false, space: margin),
                            IconButton(
                              onPressed: () =>
                                  setState(() => deleteAnalysis = true),
                              icon: Icon(PlatformIcons(context).delete),
                            ),
                          ],
                        ),

                        // Field
                        Visibility(
                          visible: showAnalysis,
                          child: ConstrainedBox(
                            constraints: ezTextFieldConstraints(context),
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: analysisController,
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

          showAnalysis = false;
          deleteAnalysis = false;
          vscController.text = analysisDefault;
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
    analysisController.dispose();
    super.dispose();
  }
}
