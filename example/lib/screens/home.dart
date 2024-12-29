/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../screens/export.dart';
import '../structs/export.dart';
import '../utils/export.dart';
import '../widgets/export.dart';

import 'package:flutter/material.dart';
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
  late final bool isDesktop = platform == TargetPlatform.linux ||
      platform == TargetPlatform.macOS ||
      platform == TargetPlatform.windows;

  final TextEditingController nameController = TextEditingController();
  String namePreview = 'your_app';
  bool validName = false;

  final TextEditingController pubController = TextEditingController();
  String pubPreview = 'Your org';

  final TextEditingController domainController = TextEditingController();
  bool exampleDomain = false;

  final TextEditingController descriptionController = TextEditingController();

  late final int currentYear = DateTime.now().year;

  bool textSettings = true;
  bool layoutSettings = true;
  bool colorSettings = true;
  bool imageSettings = true;

  bool showAdvanced = false;

  bool autoEmu = false;

  bool showVSC = false;
  bool removeVSC = false;
  // Default at bottom of file
  late final TextEditingController vscController =
      TextEditingController(text: vscDefault);

  bool showAnalysis = false;
  bool removeAnalysis = false;
  // Default at bottom of file
  final TextEditingController analysisController =
      TextEditingController(text: analysisDefault);

  bool showCopyright = false;
  bool removeCopyright = false;
  // Default at bottom of file
  late final TextEditingController copyrightController =
      TextEditingController(text: copyrightDefault);

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
                  maxWidth: measureText('very_long_app_name',
                          context: context, style: textTheme.bodyLarge)
                      .width),
              child: TextFormField(
                controller: nameController,
                textAlign: TextAlign.start,
                maxLines: 1,
                validator: (String? entry) => validateAppName(
                  value: entry,
                  onSuccess: () => setState(() {
                    final String previous = namePreview;
                    validName = true;
                    namePreview = nameController.text;

                    if (!removeVSC) {
                      vscController.text = vscController.text.replaceAll(
                        previous.replaceAll('_', '-'),
                        namePreview.replaceAll('_', '-'),
                      );
                    }

                    if (!removeCopyright) {
                      copyrightController.text = copyrightController.text
                          .replaceAll(previous, namePreview);
                    }
                  }),
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
                  maxWidth: measureText('Very Long Company Name',
                          context: context, style: textTheme.bodyLarge)
                      .width),
              child: TextFormField(
                controller: pubController,
                textAlign: TextAlign.start,
                maxLines: 1,
                validator: (_) {
                  setState(() {
                    final String previous = pubPreview;
                    pubPreview = pubController.text;

                    if (!removeCopyright) {
                      copyrightController.text = copyrightController.text
                          .replaceAll(previous, pubPreview);
                    }
                  });
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUnfocus,
                decoration: const InputDecoration(hintText: 'Your org'),
              ),
            ),
            spacer,

            // Domain name //

            // Title
            Text(
              'Domain name',
              style: textTheme.titleLarge,
              textAlign: TextAlign.start,
            ),

            // Field
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: measureText('very.LongDomainName',
                          context: context, style: textTheme.bodyLarge)
                      .width),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!exampleDomain) ...<Widget>[
                    TextFormField(
                      controller: domainController,
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
            spacer,

            // Description //

            // Title
            Text(
              'Description',
              style: textTheme.titleLarge,
              textAlign: TextAlign.start,
            ),

            // Field
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: measureText(
                'A moderately long app description.',
                context: context,
                style: textTheme.bodyLarge,
              ).width),
              child: TextFormField(
                controller: descriptionController,
                textAlign: TextAlign.start,
                maxLines: 1,
                decoration: const InputDecoration(
                  hintText: 'One sentence about your app.',
                ),
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
                  _SettingsCheckbox(
                    textTheme: textTheme,
                    title: 'Text settings',
                    value: textSettings,
                    onChanged: (bool? value) async {
                      if (value == null) return;
                      setState(() => textSettings = value);
                    },
                  ),
                  _SettingsCheckbox(
                    textTheme: textTheme,
                    title: 'Layout settings',
                    value: layoutSettings,
                    onChanged: (bool? value) async {
                      if (value == null) return;
                      setState(() => layoutSettings = value);
                    },
                  ),
                  _SettingsCheckbox(
                    textTheme: textTheme,
                    title: 'Color settings',
                    value: colorSettings,
                    onChanged: (bool? value) async {
                      if (value == null) return;
                      setState(() => colorSettings = value);
                    },
                  ),
                  _SettingsCheckbox(
                    textTheme: textTheme,
                    title: 'Image settings',
                    value: imageSettings,
                    onChanged: (bool? value) async {
                      if (value == null) return;
                      setState(() => imageSettings = value);
                    },
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
                      'When you generate ${isDesktop ? (validName ? namePreview : 'the app') : 'the config'}, the current ',
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
                      ''' (except images) will become the default config for ${validName ? namePreview : 'your app'}.

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
                  Visibility(
                    visible: isDesktop,
                    child: EzRow(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Run Android emulator when complete (may require install)',
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
                  ),
                  spacer,

                  // Copyright config
                  _AdvancedSettingsField(
                    margin: margin,
                    textTheme: textTheme,
                    title: 'Copyright notice',
                    controller: copyrightController,
                    visible: showCopyright,
                    onHide: () =>
                        setState(() => showCopyright = !showCopyright),
                    removed: removeCopyright,
                    onRemove: () => setState(() => removeCopyright = true),
                  ),

                  // LICENSE config
                  _LicensePicker(
                    notificationStyle: notificationStyle,
                    labelStyle: textTheme.labelLarge,
                  ),

                  // Analysis options config
                  _AdvancedSettingsField(
                    margin: margin,
                    textTheme: textTheme,
                    title: 'analysis_options.yaml',
                    controller: analysisController,
                    visible: showAnalysis,
                    onHide: () => setState(() => showAnalysis = !showAnalysis),
                    removed: removeAnalysis,
                    onRemove: () => setState(() => removeAnalysis = true),
                  ),

                  // VS Code launch config
                  _AdvancedSettingsField(
                    margin: margin,
                    textTheme: textTheme,
                    title: '.vscode/launch.json',
                    controller: vscController,
                    visible: showVSC,
                    onHide: () => setState(() => showVSC = !showVSC),
                    removed: removeVSC,
                    onRemove: () => setState(() => removeVSC = true),
                  ),
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
                          validateDomain(domainController.text) != null)) {
                    ezSnackBar(
                      context: context,
                      message: 'Some fields are invalid',
                    );
                    return;
                  }

                  context.goNamed(
                    progressPath,
                    extra: EAGConfig(
                      appName: nameController.text,
                      publisherName: pubController.text,
                      domainName:
                          exampleDomain ? 'com.example' : domainController.text,
                      textSettings: textSettings,
                      layoutSettings: layoutSettings,
                      colorSettings: colorSettings,
                      imageSettings: imageSettings,
                      autoEmulate: autoEmu,
                      vsCodeConfig: removeVSC ? null : vscController.text,
                      analysisOptions:
                          removeAnalysis ? null : analysisController.text,
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
          nameController.clear();
          namePreview = 'your_app';
          validName = false;

          pubController.clear();
          pubPreview = 'Your org';

          domainController.clear();
          exampleDomain = false;

          textSettings = true;
          layoutSettings = true;
          colorSettings = true;
          imageSettings = true;

          showAdvanced = false;

          autoEmu = false;

          showVSC = false;
          removeVSC = false;
          vscController.text = vscDefault;

          showAnalysis = false;
          removeAnalysis = false;
          analysisController.text = analysisDefault;

          showCopyright = false;
          removeCopyright = false;
          copyrightController.text = copyrightDefault;
        }),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    pubController.dispose();
    domainController.dispose();
    descriptionController.dispose();
    vscController.dispose();
    analysisController.dispose();
    copyrightController.dispose();
    super.dispose();
  }

  late String vscDefault = '''{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "run-${namePreview.replaceAll('_', '-')}",
      "request": "launch",
      "type": "dart",
      "flutterMode": "debug",
      "program": "lib/main.dart",
    },
    {
      "name": "install-${namePreview.replaceAll('_', '-')}",
      "request": "launch",
      "type": "dart",
      "flutterMode": "release",
      "program": "lib/main.dart",
    },
  ]
}''';

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

  late String copyrightDefault = '''/* $namePreview
 * Copyright (c) $currentYear $pubPreview. All rights reserved.
 * See LICENSE for distribution and usage details.
 */
    ''';
}

class _SettingsCheckbox extends StatelessWidget {
  final TextTheme textTheme;

  final String title;
  final bool value;
  final void Function(bool?) onChanged;

  const _SettingsCheckbox({
    required this.textTheme,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return EzRow(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          title,
          style: textTheme.bodyLarge,
          textAlign: TextAlign.start,
        ),
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _AdvancedSettingsField extends StatelessWidget {
  final double margin;
  final TextTheme textTheme;

  final String title;
  final TextEditingController controller;
  final bool visible;
  final void Function() onHide;
  final bool removed;
  final void Function()? onRemove;

  const _AdvancedSettingsField({
    required this.margin,
    required this.textTheme,
    required this.title,
    required this.controller,
    required this.visible,
    required this.onHide,
    required this.removed,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final EzSpacer buttonMargin = EzSpacer(vertical: false, space: margin);

    return Visibility(
      visible: !removed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Title and show buttons
          EzRow(
            children: <Widget>[
              Text(
                title,
                style: textTheme.bodyLarge,
                textAlign: TextAlign.start,
              ),
              buttonMargin,
              IconButton(
                onPressed: onHide,
                icon: Icon(
                  visible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                ),
              ),
              if (onRemove != null) ...<Widget>[
                buttonMargin,
                IconButton(
                  onPressed: onRemove,
                  icon: Icon(PlatformIcons(context).delete),
                ),
              ]
            ],
          ),

          // Form field
          Visibility(
            visible: visible,
            child: ConstrainedBox(
              constraints: ezTextFieldConstraints(context),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: controller,
              ),
            ),
          ),
          const EzSpacer(),
        ],
      ),
    );
  }
}

class _LicensePicker extends StatelessWidget {
  final TextStyle? notificationStyle;
  final TextStyle? labelStyle;

  const _LicensePicker({
    required this.notificationStyle,
    required this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    const EzSpacer spacer = EzSpacer(vertical: false);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Title
        EzRichText(
          <InlineSpan>[
            EzPlainText(
              text: 'LICENSE',
              style: notificationStyle,
            ),
            EzPlainText(
              text: '(required)',
              style: labelStyle,
            ),
          ],
          textAlign: TextAlign.start,
        ),

        // Carousel
        EzScrollView(
          scrollDirection: Axis.horizontal,
          thumbVisibility: false,
          children: <Widget>[
            spacer,
            ElevatedButton(
              onPressed: () {},
              child: const Text('GNU GPLv3'),
            ),
            spacer,
            ElevatedButton(
              onPressed: () {},
              child: const Text('MIT'),
            ),
            spacer,
            ElevatedButton(
              onPressed: () {},
              child: const Text('ISC'),
            ),
            spacer,
            ElevatedButton(
              onPressed: () {},
              child: const Text('Apache 2.0'),
            ),
            spacer,
            ElevatedButton(
              onPressed: () {},
              child: const Text('Mozilla 2.0'),
            ),
            spacer,
            ElevatedButton(
              onPressed: () {},
              child: const Text('Unlicense'),
            ),
            spacer,
            ElevatedButton(
              onPressed: () {},
              child: const Text('DWTFYW'),
            ),
            spacer,
          ],
        ),
        const EzSpacer(),
      ],
    );
  }
}
