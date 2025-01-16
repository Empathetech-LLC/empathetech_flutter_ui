/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../screens/export.dart';
import '../structs/export.dart';
import '../utils/export.dart';
import '../widgets/export.dart';

import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:email_validator/email_validator.dart';
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

  final EzMargin margin = EzMargin();
  late final EzSpacer rowMargin = EzMargin(vertical: false);

  late final TextTheme textTheme = Theme.of(context).textTheme;
  late final TextStyle? subTitle = subTitleStyle(textTheme);

  late final EFUILang l10n = EFUILang.of(context)!;

  late final double singleLineFormWidth = min(
    measureText(
      longestError,
      context: context,
      style: textTheme.bodyLarge,
    ).width,
    widthOf(context) * 0.75,
  );

  // Define build data //

  late final TargetPlatform platform = getBasePlatform(context);
  late final bool isDesktop = platform == TargetPlatform.linux ||
      platform == TargetPlatform.macOS ||
      platform == TargetPlatform.windows;

  late final String defaultPath = platform == TargetPlatform.windows
      ? '${Platform.environment['UserProfile']}\\Documents'
      : '${Platform.environment['HOME']}/Documents';

  final TextEditingController nameController = TextEditingController();
  String namePreview = 'your_app';
  bool validName = false;

  final TextEditingController pubController = TextEditingController();
  String pubPreview = 'Your org';

  final TextEditingController domainController = TextEditingController();
  bool exampleDomain = false;

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController supportEmailController = TextEditingController();

  late final int currentYear = DateTime.now().year;

  bool textSettings = true;
  bool layoutSettings = true;
  bool colorSettings = true;
  bool imageSettings = true;

  bool showAdvanced = false;

  late final TextEditingController pathController =
      TextEditingController(text: defaultPath);

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

  /// Set to false to disable buttons
  bool canGen = true;

  // Define custom functions //

  /// Validate the code gen file path (Desktop only)
  Future<bool> checkPath() async {
    if (await Directory(pathController.text).exists()) return true;

    const String badPath = 'Invalid path';

    // Disable interaction
    setState(() {
      canGen = false;

      showAdvanced = true;
      pathController.text = badPath;
    });

    // Wait a sec
    await Future<void>.delayed(readingTime(badPath));

    // Re-enable interaction
    setState(() {
      pathController.text = defaultPath;

      canGen = true;
    });

    return false;
  }

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
      onUpload: (EAGConfig config) async {
        // Disable buttons
        setState(() => canGen = false);

        // Gather everything
        nameController.text = config.appName;
        namePreview = config.appName;
        validName = true;

        pubController.text = config.publisherName;
        pubPreview = config.publisherName;

        descriptionController.text = config.appDescription;
        if (config.supportEmail != null &&
            EmailValidator.validate(config.supportEmail!)) {
          supportEmailController.text = config.supportEmail!;
        }

        domainController.text = config.domainName;
        if (config.domainName == 'com.example') exampleDomain = true;

        textSettings = config.textSettings;
        layoutSettings = config.layoutSettings;
        colorSettings = config.colorSettings;
        imageSettings = config.imageSettings;

        await EzConfig.loadConfig(config.appDefaults);

        if (config.genPath != null &&
            await Directory(config.genPath!).exists()) {
          pathController.text = config.genPath!;
        }

        config.copyright == null
            ? removeCopyright = true
            : copyrightController.text = config.copyright!;

        if (config.license.contains('GNU General Public License')) {
          license = gnuKey;
        } else if (config.license.contains('MIT License')) {
          license = mitKey;
        } else if (config.license.contains('ISC License')) {
          license = iscKey;
        } else if (config.license.contains('Apache License')) {
          license = apacheKey;
        } else if (config.license.contains('Mozilla Public License')) {
          license = mozillaKey;
        } else if (config.license.contains('free and unencumbered')) {
          license = unlicenseKey;
        } else if (config.license.contains('WHAT THE FU')) {
          license = dwtfywKey;
        } else {
          license = gnuKey;
        }

        config.l10nConfig == null
            ? removeL10n = true
            : l10nController.text = config.l10nConfig!;

        config.analysisOptions == null
            ? removeAnalysis = true
            : analysisController.text = config.analysisOptions!;

        config.vsCodeConfig == null
            ? removeVSC = true
            : vscController.text = config.vsCodeConfig!;

        // Enable buttons
        setState(() => canGen = true);
      },
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
              tip: 'Best App Ever  -->  ${ezTitleToSnake('Best App Ever')}',
              controller: nameController,
              width: singleLineFormWidth,
              validator: (String? entry) => validateAppName(
                value: entry,
                onSuccess: () => setState(() {
                  final String previous = namePreview;
                  validName = true;
                  namePreview = nameController.text;

                  vscController.text = vscController.text.replaceAll(
                    previous.replaceAll('_', '-'),
                    namePreview.replaceAll('_', '-'),
                  );

                  copyrightController.text = copyrightController.text
                      .replaceAll(previous, namePreview);
                }),
                onFailure: () => setState(() => validName = false),
              ),
              hintText: 'example_app',
            ),
            spacer,

            // Publisher name
            _BasicField(
              textTheme: textTheme,
              title: 'Publisher name',
              tip: 'Or: Example Person',
              controller: pubController,
              width: singleLineFormWidth,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }

                setState(() {
                  final String previous = pubPreview;
                  pubPreview = pubController.text;

                  copyrightController.text =
                      copyrightController.text.replaceAll(previous, pubPreview);
                });
                return null;
              },
              hintText: 'Example LLC',
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
              hintText: 'One or two sentences about your app.',
            ),
            spacer,

            // Domain name
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  child: Text(
                    'Domain name',
                    style: textTheme.titleLarge,
                    textAlign: TextAlign.start,
                  ),
                ),
                rowMargin,
                const EzToolTipper('Backwards, it is'),
              ],
            ),
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
                      EzCheckbox(
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

            // Support email
            _BasicField(
              textTheme: textTheme,
              title: 'Support email',
              tip: 'If provided, the feedback system we use will be included.',
              controller: supportEmailController,
              width: singleLineFormWidth,
              validator: (String? value) {
                if (value == null || value.isEmpty) return null;

                return EmailValidator.validate(value) ? null : 'Invalid email';
              },
              hintText: 'optional@example.com',
            ),
            separator,

            // Settings selection //

            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  child: Text(
                    'Include',
                    style: textTheme.titleLarge,
                    textAlign: TextAlign.start,
                  ),
                ),
                rowMargin,
                const EzToolTipper('Easy to change later'),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: EzConfig.get(marginKey),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  margin,
                  _SettingsCheckbox(
                    textTheme: textTheme,
                    title: 'Text settings',
                    value: textSettings,
                    onChanged: (bool? value) async {
                      if (value == null) return;
                      setState(() => textSettings = value);
                    },
                  ),
                  margin,
                  _SettingsCheckbox(
                    textTheme: textTheme,
                    title: 'Layout settings',
                    value: layoutSettings,
                    onChanged: (bool? value) async {
                      if (value == null) return;
                      setState(() => layoutSettings = value);
                    },
                  ),
                  margin,
                  _SettingsCheckbox(
                    textTheme: textTheme,
                    title: 'Color settings',
                    value: colorSettings,
                    onChanged: (bool? value) async {
                      if (value == null) return;
                      setState(() => colorSettings = value);
                    },
                  ),
                  margin,
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

            // Default app config //

            EzRichText(
              <InlineSpan>[
                EzPlainText(
                  text:
                      'When you generate ${isDesktop ? (validName ? namePreview : 'the app') : 'the config'}, the current ',
                  style: subTitle,
                ),
                EzInlineLink(
                  'settings',
                  style: subTitle,
                  onTap: () => context.goNamed(settingsHomePath),
                  semanticsLabel:
                      'Open a link to an online color scheme builder',
                ),
                EzPlainText(
                  text:
                      ''' (except images) will become the default config for ${validName ? namePreview : 'your app'}.

It is recommended to set a custom color scheme. If you need help building one, try starting ''',
                  style: subTitle,
                ),
                EzInlineLink(
                  'here.',
                  style: subTitle,
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
                Flexible(
                  child: Text(
                    'Advanced settings',
                    style: textTheme.titleLarge,
                    textAlign: TextAlign.start,
                  ),
                ),
                rowMargin,
                IconButton(
                  onPressed: () => setState(() => showAdvanced = !showAdvanced),
                  icon: EzIcon(
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

                  // Path picker
                  Visibility(
                    visible: isDesktop,
                    child: EzScrollView(
                      mainAxisSize: MainAxisSize.min,
                      scrollDirection: Axis.horizontal,
                      reverseHands: true,
                      children: <Widget>[
                        // Text
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: singleLineFormWidth,
                          ),
                          child: TextFormField(
                            controller: pathController,
                            readOnly: !canGen,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            validator: (String? path) =>
                                (path == null || path.isEmpty)
                                    ? 'Path required. Cannot use root folder.'
                                    : null,
                            autovalidateMode: AutovalidateMode.onUnfocus,
                          ),
                        ),
                        rowMargin,

                        // Browse
                        IconButton(
                          onPressed: () async {
                            final String? selectedDirectory =
                                await FilePicker.platform.getDirectoryPath();

                            if (selectedDirectory != null) {
                              setState(() =>
                                  pathController.text = selectedDirectory);
                            }
                          },
                          icon: EzIcon(PlatformIcons(context).folderOpen),
                        ),
                      ],
                    ),
                  ),
                  spacer,

                  // Copyright config
                  _AdvancedSettingsField(
                    textTheme: textTheme,
                    title: 'Copyright notice',
                    tip: 'Will be included at the top of every Dart file',
                    controller: copyrightController,
                    visible: showCopyright,
                    onHide: () =>
                        setState(() => showCopyright = !showCopyright),
                    removed: removeCopyright,
                    onRemove: () => setState(() => removeCopyright = true),
                    onRestore: () => setState(() => removeCopyright = false),
                  ),
                  spacer,

                  // LICENSE config
                  _LicensePicker(
                    textTheme: textTheme,
                    notificationStyle: subTitle,
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
                    textTheme: textTheme,
                    title: 'l10n.yaml',
                    tip: 'Localization (aka translations) config',
                    controller: l10nController,
                    visible: showL10n,
                    onHide: () => setState(() => showL10n = !showL10n),
                    removed: removeL10n,
                    onRemove: () => setState(() => removeL10n = true),
                    onRestore: () => setState(() => removeL10n = false),
                  ),
                  spacer,

                  // Analysis options config
                  _AdvancedSettingsField(
                    textTheme: textTheme,
                    title: 'analysis_options.yaml',
                    tip: 'Lint rules',
                    controller: analysisController,
                    visible: showAnalysis,
                    onHide: () => setState(() => showAnalysis = !showAnalysis),
                    removed: removeAnalysis,
                    onRemove: () => setState(() => removeAnalysis = true),
                    onRestore: () => setState(() => removeAnalysis = false),
                  ),
                  spacer,

                  // VS Code launch config
                  _AdvancedSettingsField(
                    textTheme: textTheme,
                    title: '.vscode/launch.json',
                    tip: "Adds launch options to VS Code's debug menu",
                    controller: vscController,
                    visible: showVSC,
                    onHide: () => setState(() => showVSC = !showVSC),
                    removed: removeVSC,
                    onRemove: () => setState(() => removeVSC = true),
                    onRestore: () => setState(() => removeVSC = false),
                  ),
                ],
              ),
            ),
            showAdvanced ? divider : separator,

            // Make it so //

            Center(
              child: EzScrollView(
                scrollDirection: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Save config
                  EzElevatedIconButton(
                    enabled: canGen,
                    onPressed: () async {
                      if (validName &&
                          pubController.text.isNotEmpty &&
                          (exampleDomain ||
                              validateDomain(domainController.text) == null) &&
                          descriptionController.text.isNotEmpty &&
                          (supportEmailController.text.isEmpty ||
                              EmailValidator.validate(
                                  supportEmailController.text)) &&
                          (!isDesktop || await checkPath()) &&
                          context.mounted) {
                        context.goNamed(
                          saveScreenPath,
                          extra: EAGConfig(
                            appName: nameController.text,
                            publisherName: pubController.text,
                            appDescription: descriptionController.text,
                            domainName: exampleDomain
                                ? 'com.example'
                                : domainController.text,
                            supportEmail: supportEmailController.text.isEmpty
                                ? null
                                : supportEmailController.text,
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
                            genPath: isDesktop ? pathController.text : null,
                            copyright: (removeCopyright ||
                                    copyrightController.text.isEmpty)
                                ? null
                                : copyrightController.text,
                            license: pickLicense(
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
                                (removeVSC || vscController.text.isEmpty)
                                    ? null
                                    : vscController.text,
                          ),
                        );
                      }
                    },
                    icon: EzIcon(Icons.save),
                    label: 'Save config',
                    textAlign: TextAlign.center,
                  ),

                  // Generate app
                  if (isDesktop) ...<Widget>[
                    spacer,
                    EzElevatedIconButton(
                      enabled: canGen,
                      onPressed: () async {
                        if (validName &&
                            pubController.text.isNotEmpty &&
                            (exampleDomain ||
                                validateDomain(domainController.text) ==
                                    null) &&
                            descriptionController.text.isNotEmpty &&
                            (supportEmailController.text.isEmpty ||
                                EmailValidator.validate(
                                    supportEmailController.text)) &&
                            await checkPath() &&
                            context.mounted) {
                          context.goNamed(
                            generateScreenPath,
                            extra: EAGConfig(
                              appName: nameController.text,
                              publisherName: pubController.text,
                              appDescription: descriptionController.text,
                              domainName: exampleDomain
                                  ? 'com.example'
                                  : domainController.text,
                              supportEmail: supportEmailController.text.isEmpty
                                  ? null
                                  : supportEmailController.text,
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
                              genPath: pathController.text,
                              copyright: (removeCopyright ||
                                      copyrightController.text.isEmpty)
                                  ? null
                                  : copyrightController.text,
                              license: pickLicense(
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
                                  (removeVSC || vscController.text.isEmpty)
                                      ? null
                                      : vscController.text,
                            ),
                          );
                        } else {
                          setState(() => canGen = false);
                          await ezSnackBar(
                            context: context,
                            message: 'Some fields are invalid',
                          ).closed;
                          setState(() => canGen = true);
                        }
                      },
                      icon: EzIcon(PlatformIcons(context).create),
                      label: 'Generate app',
                    ),
                  ],
                ],
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

          pathController.text = defaultPath;

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
        }),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    pubController.dispose();
    descriptionController.dispose();
    domainController.dispose();
    supportEmailController.dispose();
    pathController.dispose();
    copyrightController.dispose();
    l10nController.dispose();
    analysisController.dispose();
    vscController.dispose();
    super.dispose();
  }

  /// .vscode launch config with debug run and release install
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

  /// Empathetech's recommended l10n config
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

  /// Empathetech's recommended lints
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

  /// Gets copied to the top of every dart file
  /// Includes the app name, publisher, and year of generation
  late String copyrightDefault = '''/* $namePreview
 * Copyright (c) $currentYear $pubPreview. All rights reserved.
 * See LICENSE for distribution and usage details.
 */''';
}

class _BasicField extends StatelessWidget {
  final TextTheme textTheme;

  final String title;
  final String? tip;
  final TextEditingController controller;
  final double width;
  final String? Function(String?)? validator;
  final String hintText;

  const _BasicField({
    required this.textTheme,
    required this.title,
    this.tip,
    required this.controller,
    required this.width,
    required this.validator,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final Widget titleText = Text(
      title,
      style: textTheme.titleLarge,
      textAlign: TextAlign.start,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Title
        (tip == null)
            ? titleText
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(child: titleText),
                  EzMargin(vertical: false),
                  EzToolTipper(tip!),
                ],
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
        Flexible(
          child: Text(
            title,
            style: textTheme.bodyLarge,
            textAlign: TextAlign.start,
          ),
        ),
        EzCheckbox(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _AdvancedSettingsField extends StatelessWidget {
  final TextTheme textTheme;

  final String title;
  final String? tip;
  final TextEditingController controller;
  final bool visible;
  final void Function() onHide;
  final bool removed;
  final void Function()? onRemove;
  final void Function()? onRestore;

  const _AdvancedSettingsField({
    required this.textTheme,
    required this.title,
    this.tip,
    required this.controller,
    required this.visible,
    required this.onHide,
    required this.removed,
    required this.onRemove,
    required this.onRestore,
  });

  @override
  Widget build(BuildContext context) {
    late final EzSpacer rowMargin = EzMargin(vertical: false);
    late final bool isLefty = EzConfig.get(isLeftyKey) ?? false;

    late final Widget titleText = Text(
      title,
      style: textTheme.titleLarge,
      textAlign: TextAlign.start,
    );

    late final Widget hideButton = IconButton(
      onPressed: onHide,
      icon: EzIcon(
        visible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
      ),
    );

    late final Widget removeButton = IconButton(
      onPressed: onRemove,
      icon: EzIcon(PlatformIcons(context).delete),
    );

    return removed
        ? EzTextIconButton(
            onPressed: onRestore,
            icon: EzIcon(Icons.undo),
            label: "Restore '$title'",
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Title and show buttons
              EzScrollView(
                mainAxisSize: MainAxisSize.min,
                scrollDirection: Axis.horizontal,
                children: isLefty
                    ? <Widget>[
                        hideButton,
                        rowMargin,
                        titleText,
                        if (onRemove != null) ...<Widget>[
                          rowMargin,
                          removeButton,
                        ],
                        if (tip != null) ...<Widget>[
                          rowMargin,
                          EzToolTipper(tip!),
                        ],
                      ]
                    : <Widget>[
                        titleText,
                        rowMargin,
                        hideButton,
                        if (onRemove != null) ...<Widget>[
                          rowMargin,
                          removeButton,
                        ],
                        if (tip != null) ...<Widget>[
                          rowMargin,
                          EzToolTipper(tip!),
                        ],
                      ],
              ),

              // Form field
              Visibility(
                visible: visible,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    EzMargin(),
                    ConstrainedBox(
                      constraints: ezTextFieldConstraints(context),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: controller,
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
    final EzMargin margin = EzMargin();
    final EzMargin rowMargin = EzMargin(vertical: false);

    final bool isLefty = EzConfig.get(isLeftyKey) ?? false;

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
          EzRadio<String>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
        ],
      );
    }

    final Widget title = Text(
      'LICENSE',
      style: textTheme.bodyLarge,
      textAlign: TextAlign.start,
    );

    final Widget hideButton = IconButton(
      onPressed: onHide,
      icon: EzIcon(
        visible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
      ),
    );

    const Widget tip = EzToolTipper('https://choosealicense.com/');

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Title and show buttons
        EzScrollView(
          mainAxisSize: MainAxisSize.min,
          scrollDirection: Axis.horizontal,
          children: isLefty
              ? <Widget>[
                  hideButton,
                  rowMargin,
                  title,
                  rowMargin,
                  tip,
                ]
              : <Widget>[
                  title,
                  rowMargin,
                  hideButton,
                  rowMargin,
                  tip,
                ],
        ),

        // Options
        Visibility(
          visible: visible,
          child: Padding(
            padding: EdgeInsets.only(top: EzConfig.get(marginKey)),
            child: EzScrollView(
              scrollDirection: Axis.horizontal,
              thumbVisibility: false,
              children: <Widget>[
                margin,
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
                margin,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
