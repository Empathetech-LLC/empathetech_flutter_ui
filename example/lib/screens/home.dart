/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../screens/export.dart';
import '../utils/export.dart';
import '../widgets/export.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

// TODO: get scroll to disappear with time?

class HomeScreen extends StatefulWidget {
  HomeScreen() : super(key: ValueKey<int>(EzConfig.seed));

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Define the build data //

  final bool isDesktop = kIsWeb
      ? false
      : (EzConfig.platform == TargetPlatform.linux ||
          EzConfig.platform == TargetPlatform.macOS ||
          EzConfig.platform == TargetPlatform.windows);

  final bool isMac = !kIsWeb && EzConfig.platform == TargetPlatform.macOS;
  final bool isWindows = !kIsWeb && EzConfig.platform == TargetPlatform.windows;

  late final String homePath = isDesktop
      ? isWindows
          ? Platform.environment['UserProfile'] ?? ''
          : Platform.environment['HOME'] ?? ''
      : '';

  late final String docsPath = isDesktop
      ? isWindows
          ? '$homePath\\Documents'
          : '$homePath/Documents'
      : '';

  final TextEditingController nameTC = TextEditingController();
  late String namePreview = l10n.csNamePreview;
  bool validName = false;

  final TextEditingController publisherTC = TextEditingController();
  late String pubPreview = l10n.csPubPreview;

  final TextEditingController domainTC = TextEditingController();
  bool exampleDomain = false;

  final TextEditingController descriptionTC = TextEditingController();

  late final int currYear = DateTime.now().year;

  final ExpansibleController advancedEC = ExpansibleController();
  late final TextEditingController workPathTC = TextEditingController(text: docsPath);

  final ExpansibleController copyrightEC = ExpansibleController();
  late final TextEditingController copyrightTC = TextEditingController(text: copyrightDefault);

  final ExpansibleController licenseEC = ExpansibleController();
  String license = gnuKey;

  final ExpansibleController l10nEC = ExpansibleController();
  final TextEditingController l10nTC = TextEditingController(text: l10nDefault);

  final ExpansibleController analysisEC = ExpansibleController();
  final TextEditingController analysisTC = TextEditingController(text: analysisDefault);

  final ExpansibleController launchEC = ExpansibleController();
  late final TextEditingController launchTC = TextEditingController(text: vscDefault);

  late final TextEditingController flutterPathTC = TextEditingController();

  bool canGen = true;

  // Define custom functions //

  /// Validate the code gen file path (Desktop only)
  Future<bool> checkPath(TextEditingController controller) async {
    if (await Directory(controller.text).exists()) return true;

    final String badPath = l10n.csBadPath;

    // Disable interaction
    setState(() {
      canGen = false;
      advancedEC.expand();
      controller.text = badPath;
    });

    // Wait a sec
    await Future<void>.delayed(ezReadingTime(badPath));

    // Re-enable interaction
    setState(() => canGen = true);

    return false;
  }

  // Init //

  @override
  void initState() {
    super.initState();
    ezWindowNamer(appName);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) => OpenUIScaffold(
        EzScreen(
          EzScrollView(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Basic settings //

              // App name
              _BasicField(
                title: l10n.csAppName,
                tip: TextSpan(
                  children: <InlineSpan>[
                    EzPlainText(text: l10n.csNameTip),
                    EzPlainText(text: '  -->  ', semanticsLabel: ' ${l10n.csBecomes} '),
                    EzPlainText(text: ezTitleToSnake(l10n.csNameTip)),
                  ],
                  style: EzConfig.styles.bodyLarge,
                ),
                controller: nameTC,
                validator: (String? entry) => validateAppName(
                  value: entry,
                  onSuccess: () => setState(() {
                    final String previous = namePreview;
                    validName = true;
                    namePreview = nameTC.text;

                    launchTC.text = launchTC.text.replaceAll(
                      previous.replaceAll('_', '-'),
                      namePreview.replaceAll('_', '-'),
                    );

                    copyrightTC.text = copyrightTC.text.replaceAll(previous, namePreview);
                  }),
                  onFailure: () => setState(() => validName = false),
                ),
                hintText: l10n.csNamePreview,
              ),
              EzConfig.spacer,

              // Publisher name
              _BasicField(
                title: l10n.csPubName,
                tip: l10n.csPubTip,
                controller: publisherTC,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return EzConfig.l10n.gRequired;
                  }

                  setState(() {
                    final String previous = pubPreview;
                    pubPreview = publisherTC.text;

                    copyrightTC.text = copyrightTC.text.replaceAll(previous, pubPreview);
                  });
                  return null;
                },
                hintText: l10n.csPubPreview,
              ),
              EzConfig.spacer,

              // Description
              _BasicField(
                title: l10n.csDescription,
                controller: descriptionTC,
                validator: (String? value) =>
                    (value == null || value.isEmpty) ? EzConfig.l10n.gRequired : null,
                hintText: l10n.csDescPreview,
              ),
              EzConfig.spacer,

              // Domain name
              EzRow(
                reverseHands: false,
                children: <Widget>[
                  Flexible(
                    child: EzText(
                      l10n.csDomainName,
                      style: EzConfig.styles.titleLarge,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  EzToolTipper(message: l10n.csDomainTip),
                ],
              ),
              ConstrainedBox(
                constraints: ezTextFieldConstraints(context),
                child: EzCol(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    EzAnimVis(
                      visible: !exampleDomain,
                      mod: 0.75,
                      forceType: EzTransitionType.zoom,
                      kid: TextFormField(
                        controller: domainTC,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        validator: (String? text) => validateDomain(text),
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        decoration: const InputDecoration(hintText: 'com.example'),
                      ),
                    ),
                    EzAnimSwitch(
                      mod: 0.75,
                      forceType: EzTransitionType.zoom,
                      child: EzSwitchPair(
                        key: ValueKey<bool>(exampleDomain),
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: (exampleDomain || EzConfig.isLefty)
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        text: EzConfig.l10n.gNA,
                        semanticsLabel: EzConfig.l10n.gNAHint,
                        textAlign: TextAlign.start,
                        value: exampleDomain,
                        onChanged: (bool? value) {
                          if (value == null) return;
                          setState(() => exampleDomain = value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              EzConfig.separator,

              // Default app config //

              EzRichText(
                <InlineSpan>[
                  EzPlainText(
                    text: l10n.csGenApp(isDesktop
                        ? (validName ? namePreview : l10n.csTheApp)
                        : l10n.csTheConfig),
                  ),
                  EzInlineLink(
                    EzConfig.l10n.gSettings.toLowerCase(),
                    style: ezSubTitleStyle(),
                    textAlign: TextAlign.start,
                    onTap: () => context.goNamed(settingsHubPath),
                    hint: EzConfig.l10n.ssNavHint,
                  ),
                  EzPlainText(
                      text: l10n.csSetColors(validName ? namePreview : l10n.csYourApp)),
                  EzInlineLink(
                    l10n.csHere,
                    style: ezSubTitleStyle(),
                    textAlign: TextAlign.start,
                    url: Uri.parse('https://www.canva.com/colors/color-wheel/'),
                    hint: l10n.csHereHint,
                  ),
                ],
                style: ezSubTitleStyle(),
                textAlign: TextAlign.start,
              ),
              EzConfig.separator,

              // Advanced settings //

              ExpansionTile(
                // TODO: check semantics
                // TODO: update padding. definitely here, maybe everywhere
                backgroundColor: EzConfig.colors.surfaceContainer,
                collapsedBackgroundColor: EzConfig.colors.surfaceContainer,
                controller: advancedEC,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                showTrailingIcon: false,
                title: EzRow(
                  children: <Widget>[
                    Flexible(
                      child: EzText(
                        l10n.csAdvanced,
                        style: EzConfig.styles.titleLarge,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    EzConfig.rowMargin,
                    Semantics(
                      hint: advancedEC.isExpanded ? EzConfig.l10n.gClose : EzConfig.l10n.gOpen,
                      button: true,
                      child: ExcludeSemantics(
                        child: EzIconButton(
                          icon: Icon(ezVisIcon(advancedEC.isExpanded)),
                          onPressed: () {
                            advancedEC.isExpanded
                                ? advancedEC.collapse()
                                : advancedEC.expand();
                            setState(() {});
                          },
                          tooltip: advancedEC.isExpanded
                              ? EzConfig.l10n.gClose
                              : EzConfig.l10n.gOpen,
                        ),
                      ),
                    ),
                  ],
                ),
                children: <Widget>[
                  EzConfig.spacer,

                  // Work path picker
                  if (isDesktop) ...<Widget>[
                    EzText(
                      l10n.csOutputPath,
                      style: EzConfig.styles.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    EzScrollView(
                      scrollDirection: Axis.horizontal,
                      reverseHands: true,
                      children: <Widget>[
                        // Text field
                        ConstrainedBox(
                          constraints: ezTextFieldConstraints(context),
                          child: TextFormField(
                            controller: workPathTC,
                            readOnly: !canGen,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            validator: (String? path) =>
                                (path == null || path.isEmpty) ? l10n.csPathRequired : null,
                            autovalidateMode: AutovalidateMode.onUnfocus,
                          ),
                        ),
                        EzConfig.rowMargin,

                        // Browse
                        EzIconButton(
                          onPressed: () async {
                            final String? selectedDirectory =
                                await FilePicker.getDirectoryPath();

                            if (selectedDirectory == null) return;

                            setState(() {
                              workPathTC.text = selectedDirectory.contains(homePath)
                                  ? '$homePath${selectedDirectory.split(homePath)[1]}'
                                  : selectedDirectory;
                            });
                          },
                          tooltip: l10n.csFileBrowser,
                          icon: const Icon(Icons.folder_open),
                        ),
                      ],
                    ),
                    EzConfig.spacer,
                  ],

                  // Copyright config
                  _AdvancedSettingsField(
                    title: l10n.csCopyright,
                    tip: l10n.csCopyrightTip,
                    ec: copyrightEC,
                    tc: copyrightTC,
                  ),
                  EzConfig.spacer,

                  // LICENSE config
                  _LicensePicker(
                    ec: licenseEC,
                    groupValue: license,
                    onChanged: (String? picked) {
                      if (picked != null) {
                        setState(() => license = picked);
                      }
                    },
                  ),
                  EzConfig.spacer,

                  // l10n config
                  _AdvancedSettingsField(
                    title: 'l10n.yaml',
                    tip: l10n.csL10nTip,
                    ec: l10nEC,
                    tc: l10nTC,
                  ),
                  EzConfig.spacer,

                  // Analysis options config
                  _AdvancedSettingsField(
                    title: 'analysis_options.yaml',
                    tip: l10n.csLintTip,
                    ec: analysisEC,
                    tc: analysisTC,
                  ),
                  EzConfig.spacer,

                  // VS Code launch config
                  _AdvancedSettingsField(
                    title: '.vscode/launch.json',
                    tip: l10n.csLaunchTip,
                    ec: launchEC,
                    tc: launchTC,
                  ),
                ],
              ),
              advancedEC.isExpanded
                  ? EzConfig.spacer
                  : EzDivider(constraints: ezTextFieldConstraints(context, prop: 0.333)),

              // Flutter path picker (Mac only)
              if (isMac) ...<Widget>[
                // Title
                EzRow(
                  reverseHands: false,
                  children: <Widget>[
                    Flexible(
                      child: EzText(
                        l10n.csFlutterPath,
                        style: EzConfig.styles.titleLarge,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    EzToolTipper(message: l10n.csNoSpaces),
                  ],
                ),

                // Picker
                EzScrollView(
                  scrollDirection: Axis.horizontal,
                  reverseHands: true,
                  children: <Widget>[
                    // Text box
                    ConstrainedBox(
                      constraints: ezTextFieldConstraints(context),
                      child: TextFormField(
                        controller: flutterPathTC,
                        readOnly: !canGen,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        validator: (String? path) =>
                            (path == null || path.isEmpty) ? l10n.csPathRequired : null,
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        decoration: InputDecoration(
                            hintText: isWindows
                                ? 'example_path\\flutter\\bin'
                                : 'example_path/flutter/bin'),
                      ),
                    ),
                    EzConfig.rowMargin,

                    // Browse
                    EzIconButton(
                      onPressed: () async {
                        final String? selectedDirectory =
                            await FilePicker.getDirectoryPath(dialogTitle: l10n.csFlutterPath);

                        if (selectedDirectory == null) return;

                        setState(() {
                          flutterPathTC.text = selectedDirectory.contains(homePath)
                              ? '$homePath${selectedDirectory.split(homePath)[1]}'
                              : selectedDirectory;
                        });
                      },
                      tooltip: l10n.csFileBrowser,
                      icon: const Icon(Icons.folder_open),
                    ),
                  ],
                ),
                EzConfig.margin,
                EzRichText(
                  <InlineSpan>[
                    EzPlainText(
                      text: '${l10n.csNotInstalled} ',
                      style: EzConfig.styles.bodyLarge,
                    ),
                    EzInlineLink(
                      l10n.rsInstall,
                      style: EzConfig.styles.bodyLarge,
                      textAlign: TextAlign.start,
                      url: Uri.parse(installFlutter),
                      hint: l10n.rsInstallHint,
                      tooltip: installFlutter,
                    ),
                    EzPlainText(
                      text: '.',
                      style: EzConfig.styles.bodyLarge,
                    ),
                  ],
                ),
                EzConfig.separator,
              ],

              // Make it so //

              EzScrollView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  // Save config
                  EzElevatedIconButton(
                    enabled: canGen,
                    onPressed: () async {
                      if (validName &&
                          publisherTC.text.isNotEmpty &&
                          (exampleDomain || validateDomain(domainTC.text) == null) &&
                          descriptionTC.text.isNotEmpty &&
                          (!isDesktop ||
                              ((!isMac || await checkPath(flutterPathTC)) &&
                                  await checkPath(workPathTC))) &&
                          context.mounted) {
                        context.goNamed(
                          archiveScreenPath,
                          extra: EAGConfig(
                            appName: nameTC.text,
                            publisherName: publisherTC.text,
                            appDescription: descriptionTC.text,
                            domainName: exampleDomain ? 'com.example' : domainTC.text,
                            appDefaults: Map<String, dynamic>.fromEntries(
                              allEZConfigKeys.keys.map(
                                (String key) =>
                                    MapEntry<String, dynamic>(key, EzConfig.get(key)),
                              ),
                            ),
                            flutterPath: isMac ? flutterPathTC.text : null,
                            workPath: isDesktop ? workPathTC.text : null,
                            copyright: copyrightTC.text,
                            license: pickLicense(
                              license: license,
                              appName: nameTC.text,
                              publisher: publisherTC.text,
                              description: descriptionTC.text,
                              year: currYear.toString(),
                            ),
                            l10nConfig: l10nTC.text,
                            analysisOptions: analysisTC.text,
                            vsCodeConfig: launchTC.text,
                          ),
                        );
                      } else {
                        setState(() => canGen = false);
                        await ezSnackBar(
                          context,
                          message: '${l10n.csInvalidFields}.\n${l10n.csRequired}.',
                        ).closed;
                        setState(() => canGen = true);
                      }
                    },
                    icon: const Icon(Icons.save),
                    label: EzConfig.l10n.ssSaveConfig,
                  ),

                  // Generate app
                  if (isDesktop) ...<Widget>[
                    EzConfig.spacer,
                    EzElevatedIconButton(
                      enabled: canGen,
                      onPressed: () async {
                        if (validName &&
                            publisherTC.text.isNotEmpty &&
                            (exampleDomain || validateDomain(domainTC.text) == null) &&
                            descriptionTC.text.isNotEmpty &&
                            (!isMac || await checkPath(flutterPathTC)) &&
                            await checkPath(workPathTC) &&
                            context.mounted) {
                          context.goNamed(
                            generateScreenPath,
                            extra: EAGConfig(
                              appName: nameTC.text,
                              publisherName: publisherTC.text,
                              appDescription: descriptionTC.text,
                              domainName: exampleDomain ? 'com.example' : domainTC.text,
                              appDefaults: Map<String, dynamic>.fromEntries(
                                allEZConfigKeys.keys.map(
                                  (String key) =>
                                      MapEntry<String, dynamic>(key, EzConfig.get(key)),
                                ),
                              ),
                              flutterPath: isMac ? flutterPathTC.text : null,
                              workPath: workPathTC.text,
                              copyright: copyrightTC.text,
                              license: pickLicense(
                                license: license,
                                appName: nameTC.text,
                                publisher: publisherTC.text,
                                description: descriptionTC.text,
                                year: currYear.toString(),
                              ),
                              l10nConfig: l10nTC.text,
                              analysisOptions: analysisTC.text,
                              vsCodeConfig: launchTC.text,
                            ),
                          );
                        } else {
                          setState(() => canGen = false);
                          await ezSnackBar(
                            context,
                            message: '${l10n.csInvalidFields}.\n${l10n.csRequired}.',
                          ).closed;
                          setState(() => canGen = true);
                        }
                      },
                      icon: const Icon(Icons.build),
                      label: l10n.csGenerate,
                    ),
                  ],
                ],
              ),
              EzConfig.separator,
            ],
          ),
          alignment: Alignment.topLeft,
        ),
        title: l10n.csPageTitle,
        onUpload: (EAGConfig config) async {
          // Disable buttons
          setState(() => canGen = false);

          // Gather everything
          nameTC.text = config.appName;
          namePreview = config.appName;
          validName = true;

          publisherTC.text = config.publisherName;
          pubPreview = config.publisherName;

          descriptionTC.text = config.appDescription;

          domainTC.text = config.domainName;
          if (config.domainName == 'com.example') exampleDomain = true;

          await EzConfig.loadConfig(config.appDefaults);

          if (config.flutterPath != null &&
              isMac &&
              await Directory(config.flutterPath!).exists()) {
            flutterPathTC.text = config.flutterPath!;
          }

          if (config.workPath != null && await Directory(config.workPath!).exists()) {
            workPathTC.text = config.workPath!;
          }

          copyrightTC.text = config.copyright;

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

          l10nTC.text = config.l10nConfig;
          analysisTC.text = config.analysisOptions;
          launchTC.text = config.vsCodeConfig;

          // Enable buttons
          setState(() => canGen = true);
        },
        fabs: <Widget>[
          EzConfig.spacer,
          ResetFAB(
            clearForms: () => setState(() {
              nameTC.clear();
              namePreview = l10n.csNamePreview;
              validName = false;

              publisherTC.clear();
              pubPreview = l10n.csPubPreview;

              descriptionTC.clear();

              domainTC.clear();
              exampleDomain = false;

              flutterPathTC.clear();

              advancedEC.collapse();

              workPathTC.text = docsPath;

              copyrightEC.collapse();
              copyrightTC.text = copyrightDefault;

              licenseEC.collapse();
              license = gnuKey;

              l10nEC.collapse();
              l10nTC.text = l10nDefault;

              analysisEC.collapse();
              analysisTC.text = analysisDefault;

              launchEC.collapse();
              launchTC.text = vscDefault;
            }),
            onComplete: () => setState(() {}),
          ),
        ],
      );

  @override
  void dispose() {
    nameTC.dispose();
    publisherTC.dispose();
    descriptionTC.dispose();
    domainTC.dispose();
    advancedEC.dispose();
    workPathTC.dispose();
    copyrightEC.dispose();
    copyrightTC.dispose();
    l10nEC.dispose();
    l10nTC.dispose();
    analysisEC.dispose();
    analysisTC.dispose();
    launchEC.dispose();
    launchTC.dispose();
    flutterPathTC.dispose();
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

  /// Recommended Empathetech l10n config
  static const String l10nDefault = '''arb-dir: lib/l10n
output-dir: lib/l10n
template-arb-file: lang_en.arb
output-localization-file: lang.dart
output-class: Lang
use-deferred-loading: true
gen-inputs-and-outputs-list: lib/l10n
required-resource-attributes: false
format: true
suppress-warnings: false''';

  /// Recommended Empathetech lints
  static const String analysisDefault = '''include: package:flutter_lints/flutter.yaml

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
    unawaited_futures: true
    unnecessary_async: true
    unnecessary_late: true
    unnecessary_library_name: true
    unnecessary_new: true
    use_build_context_synchronously: true
    use_full_hex_values_for_flutter_colors: true''';

  /// Gets copied to the top of every dart file
  /// Includes the app name, publisher, and year of generation
  late String copyrightDefault = '''/* $namePreview
 * Copyright (c) $currYear $pubPreview. All rights reserved.
 * See LICENSE for distribution and usage details.
 */''';
}

class _BasicField extends StatelessWidget {
  final String title;
  final dynamic tip;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;

  const _BasicField({
    required this.title,
    this.tip,
    required this.controller,
    required this.validator,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) => EzCol(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Title
          EzRow(
            reverseHands: false,
            children: <Widget>[
              Flexible(
                child: EzText(
                  title,
                  style: EzConfig.styles.titleLarge,
                  textAlign: TextAlign.start,
                ),
              ),
              if (tip != null)
                tip.runtimeType == String
                    ? EzToolTipper(message: tip)
                    : EzToolTipper(richMessage: tip),
            ],
          ),

          // Field
          ConstrainedBox(
            constraints: ezTextFieldConstraints(context),
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

class _AdvancedSettingsField extends StatefulWidget {
  final String title;
  final dynamic tip;
  final ExpansibleController ec;
  final TextEditingController tc;

  const _AdvancedSettingsField({
    required this.title,
    this.tip,
    required this.ec,
    required this.tc,
  });

  @override
  State<_AdvancedSettingsField> createState() => _AdvancedSettingsFieldState();
}

class _AdvancedSettingsFieldState extends State<_AdvancedSettingsField> {
  @override
  Widget build(BuildContext context) => ExpansionTile(
        backgroundColor: EzConfig.colors.surfaceContainer,
        collapsedBackgroundColor: EzConfig.colors.surfaceContainer,
        controller: widget.ec,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        showTrailingIcon: false,
        title: EzRow(
          children: <Widget>[
            Flexible(
              child: EzText(
                widget.title,
                textAlign: TextAlign.start,
              ),
            ),
            EzConfig.rowMargin,
            Semantics(
              label: widget.ec.isExpanded ? EzConfig.l10n.gClose : EzConfig.l10n.gOpen,
              button: true,
              child: ExcludeSemantics(
                child: EzIconButton(
                  onPressed: () {
                    widget.ec.isExpanded ? widget.ec.collapse() : widget.ec.expand();
                    setState(() {});
                  },
                  tooltip: widget.ec.isExpanded ? EzConfig.l10n.gClose : EzConfig.l10n.gOpen,
                  icon: Icon(ezVisIcon(widget.ec.isExpanded)),
                ),
              ),
            ),
            if (widget.tip != null) ...<Widget>[
              EzConfig.rowMargin,
              widget.tip.runtimeType == String
                  ? EzToolTipper(message: widget.tip)
                  : EzToolTipper(richMessage: widget.tip),
            ],
          ],
        ),
        children: <Widget>[
          EzConfig.margin,
          ConstrainedBox(
            constraints: ezTextFieldConstraints(context),
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: widget.tc,
            ),
          ),
        ],
      );
}

class _LicensePicker extends StatefulWidget {
  final ExpansibleController ec;
  final String groupValue;
  final void Function(String?) onChanged;

  const _LicensePicker({
    required this.ec,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  State<_LicensePicker> createState() => _LicensePickerState();
}

class _LicensePickerState extends State<_LicensePicker> {
  Widget radio({
    required String title,
    required String value,
  }) =>
      EzCol(children: <Widget>[
        EzTextButton(
          text: title,
          textAlign: TextAlign.center,
          onPressed: () => widget.onChanged(value),
        ),
        ExcludeSemantics(child: EzRadio<String>(value: value)),
      ]);

  @override
  Widget build(BuildContext context) => ExpansionTile(
        backgroundColor: EzConfig.colors.surfaceContainer,
        collapsedBackgroundColor: EzConfig.colors.surfaceContainer,
        controller: widget.ec,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        showTrailingIcon: false,
        title: EzRow(
          children: <Widget>[
            const Flexible(child: EzText('LICENSE', textAlign: TextAlign.start)),
            EzConfig.rowMargin,
            Semantics(
              label: widget.ec.isExpanded ? EzConfig.l10n.gClose : EzConfig.l10n.gOpen,
              button: true,
              child: ExcludeSemantics(
                child: EzIconButton(
                  onPressed: () {
                    widget.ec.isExpanded ? widget.ec.collapse() : widget.ec.expand();
                    setState(() {});
                  },
                  tooltip: widget.ec.isExpanded ? EzConfig.l10n.gClose : EzConfig.l10n.gOpen,
                  icon: Icon(ezVisIcon(widget.ec.isExpanded)),
                ),
              ),
            ),
            EzConfig.rowMargin,
            EzToolTipper(
              richMessage: EzInlineLink(
                'https://choosealicense.com/',
                textAlign: TextAlign.center,
                url: Uri.parse('https://choosealicense.com/'),
                hint: l10n.csLicenseDocs,
              ),
            ),
          ],
        ),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: EzConfig.marginVal),
            child: RadioGroup<String>(
              groupValue: widget.groupValue,
              onChanged: widget.onChanged,
              child: EzScrollView(
                scrollDirection: Axis.horizontal,
                thumbVisibility: false,
                showScrollHint: true,
                children: <Widget>[
                  EzConfig.rowMargin,
                  radio(title: 'GNU GPLv3', value: gnuKey),
                  EzConfig.rowSpacer,
                  radio(title: 'MIT', value: mitKey),
                  EzConfig.rowSpacer,
                  radio(title: 'ISC', value: iscKey),
                  EzConfig.rowSpacer,
                  radio(title: 'Apache 2.0', value: apacheKey),
                  EzConfig.rowSpacer,
                  radio(title: 'Mozilla 2.0', value: mozillaKey),
                  EzConfig.rowSpacer,
                  radio(title: 'Unlicense', value: unlicenseKey),
                  EzConfig.rowSpacer,
                  radio(title: 'DWTFYW', value: dwtfywKey),
                  EzConfig.rowMargin,
                ],
              ),
            ),
          ),
        ],
      );
}
