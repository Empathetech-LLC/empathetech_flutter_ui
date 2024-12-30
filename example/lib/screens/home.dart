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

  late final double singleLineFormWidth = measureText(
    longestError,
    context: context,
    style: textTheme.bodyLarge,
  ).width;

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

  bool showCopyright = false;
  bool removeCopyright = false;
  // Default at the bottom of the Class
  late final TextEditingController copyrightController =
      TextEditingController(text: copyrightDefault);

  bool showLicense = false;
  String license = gnuKey;

  bool showL10n = false;
  bool removeL10n = false;
  // Default at the bottom of the Class
  final TextEditingController l10nController =
      TextEditingController(text: l10nDefault);

  bool showAnalysis = false;
  bool removeAnalysis = false;
  // Default at the bottom of the Class
  final TextEditingController analysisController =
      TextEditingController(text: analysisDefault);

  bool showVSC = false;
  bool removeVSC = false;
  // Default at the bottom of the Class
  late final TextEditingController vscController =
      TextEditingController(text: vscDefault);

  bool autoEmu = false;

  bool noSpam = true;

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
            // Basic settings //

            // App name
            _BasicField(
              textTheme: textTheme,
              title: 'App name',
              controller: nameController,
              width: singleLineFormWidth,
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
              hintText: 'your_app',
            ),
            spacer,

            // Publisher name
            _BasicField(
              textTheme: textTheme,
              title: 'Publisher name',
              controller: pubController,
              width: singleLineFormWidth,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }

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
              hintText: 'Your org',
            ),
            spacer,

            // Domain name
            Text(
              'Domain name',
              style: textTheme.titleLarge,
              textAlign: TextAlign.start,
            ),

            // Field
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: singleLineFormWidth),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
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

            // Description
            _BasicField(
              textTheme: textTheme,
              title: 'Description',
              controller: descriptionController,
              width: singleLineFormWidth,
              validator: (String? value) =>
                  (value == null || value.isEmpty) ? 'Required' : null,
              hintText: 'One sentence about your app.',
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
                  if (!removeCopyright) spacer,

                  // LICENSE config
                  _LicensePicker(
                    textTheme: textTheme,
                    notificationStyle: notificationStyle,
                    visible: showLicense,
                    onHide: () => setState(() => showLicense = !showLicense),
                    groupValue: license,
                    onChanged: (String? picked) {
                      if (picked != null) setState(() => license = picked);
                    },
                  ),
                  spacer,

                  // l10n config
                  _AdvancedSettingsField(
                    margin: margin,
                    textTheme: textTheme,
                    title: 'l10n.yaml',
                    controller: l10nController,
                    visible: showL10n,
                    onHide: () => setState(() => showL10n = !showL10n),
                    removed: removeL10n,
                    onRemove: () => setState(() => removeL10n = true),
                  ),
                  if (!removeL10n) spacer,

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
                  if (!removeAnalysis) spacer,

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
                  if (isDesktop) spacer,

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
                ],
              ),
            ),
            showAdvanced ? divider : separator,

            // Make it so //

            Center(
              child: EzElevatedIconButton(
                onPressed: noSpam
                    ? () async {
                        if (validName &&
                            pubController.text.isNotEmpty &&
                            (exampleDomain ||
                                validateDomain(domainController.text) ==
                                    null) &&
                            descriptionController.text.isNotEmpty) {
                          context.goNamed(
                            thruConfigPath,
                            extra: EAGConfig(
                              appName: nameController.text,
                              publisherName: pubController.text,
                              domainName: exampleDomain
                                  ? 'com.example'
                                  : domainController.text,
                              description: descriptionController.text,
                              textSettings: textSettings,
                              layoutSettings: layoutSettings,
                              colorSettings: colorSettings,
                              imageSettings: imageSettings,
                              appDefaults: Map<String, dynamic>.fromEntries(
                                allKeys.keys.map(
                                  (String key) => MapEntry<String, dynamic>(
                                      key, EzConfig.get(key)),
                                ),
                              ),
                              copyright: (removeCopyright ||
                                      copyrightController.text.isEmpty)
                                  ? null
                                  : copyrightController.text,
                              license: genLicense(
                                license: license,
                                appName: nameController.text,
                                publisher: pubController.text,
                                description: descriptionController.text,
                                year: currentYear.toString(),
                              ),
                              l10nConfig:
                                  (removeL10n || l10nController.text.isEmpty)
                                      ? null
                                      : l10nController.text,
                              analysisOptions: (removeAnalysis ||
                                      analysisController.text.isEmpty)
                                  ? null
                                  : analysisController.text,
                              vsCodeConfig:
                                  removeVSC ? null : vscController.text,
                              autoEmulate: isDesktop ? autoEmu : null,
                            ),
                          );
                        } else {
                          setState(() => noSpam = false);
                          await ezSnackBar(
                            context: context,
                            message: 'Some fields are invalid',
                          ).closed;
                          setState(() => noSpam = true);
                        }
                      }
                    : () {},
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

          descriptionController.clear();

          textSettings = true;
          layoutSettings = true;
          colorSettings = true;
          imageSettings = true;

          showAdvanced = false;

          showCopyright = false;
          removeCopyright = false;
          copyrightController.text = copyrightDefault;

          showLicense = false;
          license = gnuKey;

          showL10n = false;
          removeL10n = false;
          l10nController.text = l10nDefault;

          showAnalysis = false;
          removeAnalysis = false;
          analysisController.text = analysisDefault;

          showVSC = false;
          removeVSC = false;
          vscController.text = vscDefault;

          autoEmu = false;
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
    copyrightController.dispose();
    l10nController.dispose();
    analysisController.dispose();
    vscController.dispose();
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

  static const String l10nDefault = '''arb-dir: lib/l10n
output-dir: lib/l10n
template-arb-file: lang_en.arb
output-localization-file: lang.dart
output-class: Lang
use-deferred-loading: true
gen-inputs-and-outputs-list: lib/l10n
synthetic-package: false
required-resource-attributes: false
format: true
suppress-warnings: false''';

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
    use_full_hex_values_for_flutter_colors: true''';

  late String copyrightDefault = '''/* $namePreview
 * Copyright (c) $currentYear $pubPreview. All rights reserved.
 * See LICENSE for distribution and usage details.
 */''';
}

class _BasicField extends StatelessWidget {
  final TextTheme textTheme;

  final String title;
  final TextEditingController controller;
  final double width;
  final String? Function(String?)? validator;
  final String hintText;

  const _BasicField({
    required this.textTheme,
    required this.title,
    required this.controller,
    required this.width,
    required this.validator,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Title
        Text(
          title,
          style: textTheme.titleLarge,
          textAlign: TextAlign.start,
        ),

        // Field
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width),
          child: TextFormField(
            controller: controller,
            textAlign: TextAlign.start,
            maxLines: 1,
            validator: validator,
            autovalidateMode: AutovalidateMode.onUnfocus,
            decoration: InputDecoration(hintText: hintText),
          ),
        ),
      ],
    );
  }
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
        ],
      ),
    );
  }
}

class _LicensePicker extends StatelessWidget {
  final TextTheme textTheme;
  final TextStyle? notificationStyle;

  final bool visible;
  final void Function() onHide;

  final String groupValue;
  final void Function(String?)? onChanged;

  const _LicensePicker({
    required this.textTheme,
    required this.notificationStyle,
    required this.visible,
    required this.onHide,
    required this.groupValue,
    required this.onChanged,
  });

  static const EzSpacer spacer = EzSpacer(vertical: false);

  @override
  Widget build(BuildContext context) {
    final double margin = EzConfig.get(marginKey);

    Widget radio({
      required String title,
      required String value,
    }) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          Radio<String>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Title and show buttons
        EzRow(
          children: <Widget>[
            Text(
              'LICENSE',
              style: textTheme.bodyLarge,
              textAlign: TextAlign.start,
            ),
            EzSpacer(vertical: false, space: EzConfig.get(marginKey)),
            IconButton(
              onPressed: onHide,
              icon: Icon(
                visible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              ),
            ),
          ],
        ),

        // Options
        Visibility(
          visible: visible,
          child: Padding(
            padding: EdgeInsets.only(top: margin),
            child: EzScrollView(
              scrollDirection: Axis.horizontal,
              thumbVisibility: false,
              children: <Widget>[
                EzSpacer(space: margin),
                radio(
                  title: 'GNU GPLv3',
                  value: gnuKey,
                ),
                spacer,
                radio(
                  title: 'MIT',
                  value: mitKey,
                ),
                spacer,
                radio(
                  title: 'ISC',
                  value: iscKey,
                ),
                spacer,
                radio(
                  title: 'Apache 2.0',
                  value: apacheKey,
                ),
                spacer,
                radio(
                  title: 'Mozilla 2.0',
                  value: mozillaKey,
                ),
                spacer,
                radio(
                  title: 'Unlicense',
                  value: unlicenseKey,
                ),
                spacer,
                radio(
                  title: 'DWTFYW',
                  value: dwtfywKey,
                ),
                spacer,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
