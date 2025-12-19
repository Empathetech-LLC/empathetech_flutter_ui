/* open_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
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
import 'package:email_validator/email_validator.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Gather the fixed theme data //

  late final EFUILang el10n = ezL10n(context);
  late final Lang l10n = Lang.of(context)!;

  // Define the build data //

  final TargetPlatform platform = getBasePlatform();
  late final bool isDesktop = kIsWeb
      ? false
      : (platform == TargetPlatform.linux ||
          platform == TargetPlatform.macOS ||
          platform == TargetPlatform.windows);

  late final bool isMac = isDesktop && platform == TargetPlatform.macOS;
  late final bool isWindows = isDesktop && platform == TargetPlatform.windows;

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

  final TextEditingController nameController = TextEditingController();
  late String namePreview = l10n.csNamePreview;
  bool validName = false;

  final TextEditingController pubController = TextEditingController();
  late String pubPreview = l10n.csPubPreview;

  final TextEditingController domainController = TextEditingController();
  bool exampleDomain = false;

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController supportEmailController = TextEditingController();

  late final int currentYear = DateTime.now().year;

  bool colorSettings = true;
  bool designSettings = true;
  bool layoutSettings = true;
  bool textSettings = true;

  late final TextEditingController flutterPathControl = TextEditingController();

  bool showAdvanced = false;

  late final TextEditingController workPathControl =
      TextEditingController(text: docsPath);

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
  Future<bool> checkPath(TextEditingController controller) async {
    if (await Directory(controller.text).exists()) return true;

    final String badPath = l10n.csBadPath;

    // Disable interaction
    setState(() {
      canGen = false;

      showAdvanced = true;
      controller.text = badPath;
    });

    // Wait a sec
    await Future<void>.delayed(ezReadingTime(badPath));

    // Re-enable interaction
    setState(() => canGen = true);

    return false;
  }

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ezWindowNamer(context, appName);
  }

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextStyle? subTitle = ezSubTitleStyle(textTheme);

    // Return the build //

    return OpenUIScaffold(
      title: l10n.csPageTitle,
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

        colorSettings = config.colorSettings;
        designSettings = config.designSettings;
        layoutSettings = config.layoutSettings;
        textSettings = config.textSettings;

        await EzConfig.loadConfig(config.appDefaults);

        if (config.flutterPath != null &&
            isMac &&
            await Directory(config.flutterPath!).exists()) {
          flutterPathControl.text = config.flutterPath!;
        }

        if (config.workPath != null &&
            await Directory(config.workPath!).exists()) {
          workPathControl.text = config.workPath!;
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
                  EzPlainText(
                      text: '  -->  ', semanticsLabel: ' ${l10n.csBecomes} '),
                  EzPlainText(text: ezTitleToSnake(l10n.csNameTip)),
                ],
                style: textTheme.bodyLarge,
              ),
              controller: nameController,
              validator: (String? entry) => validateAppName(
                value: entry,
                context: context,
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
              hintText: l10n.csNamePreview,
            ),
            ezSpacer,

            // Publisher name
            _BasicField(
              title: l10n.csPubName,
              tip: l10n.csPubTip,
              controller: pubController,
              validator: (String? value) {
                if (value == null || value.isEmpty) return el10n.gRequired;

                setState(() {
                  final String previous = pubPreview;
                  pubPreview = pubController.text;

                  copyrightController.text =
                      copyrightController.text.replaceAll(previous, pubPreview);
                });
                return null;
              },
              hintText: l10n.csPubPreview,
            ),
            ezSpacer,

            // Description
            _BasicField(
              title: l10n.csDescription,
              controller: descriptionController,
              validator: (String? value) =>
                  (value == null || value.isEmpty) ? el10n.gRequired : null,
              hintText: l10n.csDescPreview,
            ),
            ezSpacer,

            // Domain name
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  child: EzText(
                    l10n.csDomainName,
                    style: textTheme.titleLarge,
                    textAlign: TextAlign.start,
                  ),
                ),
                EzToolTipper(message: l10n.csDomainTip),
              ],
            ),
            ConstrainedBox(
              constraints: ezTextFieldConstraints(context),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (!exampleDomain) ...<Widget>[
                    TextFormField(
                      controller: domainController,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      validator: (String? text) =>
                          validateDomain(text, context),
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      decoration:
                          const InputDecoration(hintText: 'com.example'),
                    ),
                  ],
                  EzSwitchPair(
                    key: ValueKey<bool>(exampleDomain),
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: (exampleDomain || EzConfig.isLefty)
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    text: el10n.gNA,
                    semanticsLabel: el10n.gNAHint,
                    textAlign: TextAlign.start,
                    value: exampleDomain,
                    onChanged: (bool? value) {
                      if (value == null) return;
                      setState(() => exampleDomain = value);
                    },
                  ),
                ],
              ),
            ),
            ezSpacer,

            // Support email
            _BasicField(
              title: l10n.csSupportEmail,
              tip: l10n.csSupportTip,
              controller: supportEmailController,
              validator: (String? value) {
                if (value == null || value.isEmpty) return null;

                return EmailValidator.validate(value)
                    ? null
                    : l10n.csInvalidEmail;
              },
              hintText: '${el10n.gOptional}@example.com',
            ),
            ezSeparator,

            // Settings selection //

            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  child: EzText(
                    l10n.csInclude,
                    style: textTheme.titleLarge,
                    textAlign: TextAlign.start,
                  ),
                ),
                EzToolTipper(message: l10n.csEasy),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: EzConfig.margin),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ezMargin,
                  EzCheckboxPair(
                    text: el10n.csPageTitle,
                    value: colorSettings,
                    onChanged: (bool? value) {
                      if (value == null) return;
                      setState(() => colorSettings = value);
                    },
                  ),
                  ezMargin,
                  EzCheckboxPair(
                    text: el10n.dsPageTitle,
                    value: designSettings,
                    onChanged: (bool? value) {
                      if (value == null) return;
                      setState(() => designSettings = value);
                    },
                  ),
                  ezMargin,
                  EzCheckboxPair(
                    text: el10n.lsPageTitle,
                    value: layoutSettings,
                    onChanged: (bool? value) {
                      if (value == null) return;
                      setState(() => layoutSettings = value);
                    },
                  ),
                  ezMargin,
                  EzCheckboxPair(
                    text: el10n.tsPageTitle,
                    value: textSettings,
                    onChanged: (bool? value) {
                      if (value == null) return;
                      setState(() => textSettings = value);
                    },
                  ),
                ],
              ),
            ),
            ezDivider,

            // Default app config //

            EzRichText(
              <InlineSpan>[
                EzPlainText(
                  text: l10n.csGenApp(isDesktop
                      ? (validName ? namePreview : l10n.csTheApp)
                      : l10n.csTheConfig),
                ),
                EzInlineLink(
                  el10n.ssPageTitle.toLowerCase(),
                  style: subTitle,
                  textAlign: TextAlign.start,
                  onTap: () => context.goNamed(settingsHomePath),
                  hint: el10n.ssNavHint,
                ),
                EzPlainText(
                    text: l10n
                        .csSetColors(validName ? namePreview : l10n.csYourApp)),
                EzInlineLink(
                  l10n.csHere,
                  style: subTitle,
                  textAlign: TextAlign.start,
                  url: Uri.parse('https://www.canva.com/colors/color-wheel/'),
                  hint: l10n.csHereHint,
                ),
              ],
              style: subTitle,
              textAlign: TextAlign.start,
            ),
            ezDivider,

            // Flutter path picker
            Visibility(
              visible: isMac,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Title
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        child: EzText(
                          l10n.csFlutterPath,
                          style: textTheme.titleLarge,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      EzToolTipper(message: l10n.csNoSpaces),
                    ],
                  ),

                  // Picker
                  EzScrollView(
                    mainAxisSize: MainAxisSize.min,
                    scrollDirection: Axis.horizontal,
                    reverseHands: true,
                    children: <Widget>[
                      // Text box
                      ConstrainedBox(
                        constraints: ezTextFieldConstraints(context),
                        child: TextFormField(
                          controller: flutterPathControl,
                          readOnly: !canGen,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          validator: (String? path) =>
                              (path == null || path.isEmpty)
                                  ? l10n.csPathRequired
                                  : null,
                          autovalidateMode: AutovalidateMode.onUnfocus,
                          decoration: InputDecoration(
                              hintText: isWindows
                                  ? 'example_path\\flutter\\bin'
                                  : 'example_path/flutter/bin'),
                        ),
                      ),
                      ezRowMargin,

                      // Browse
                      EzIconButton(
                        onPressed: () async {
                          final String? selectedDirectory =
                              await FilePicker.platform.getDirectoryPath(
                                  dialogTitle: l10n.csFlutterPath);

                          if (selectedDirectory == null) return;

                          setState(() {
                            flutterPathControl.text = selectedDirectory
                                    .contains(homePath)
                                ? '$homePath${selectedDirectory.split(homePath)[1]}'
                                : selectedDirectory;
                          });
                        },
                        tooltip: l10n.csFileBrowser,
                        icon: EzIcon(PlatformIcons(context).folderOpen),
                      ),
                    ],
                  ),
                  ezSpacer,

                  EzScrollView(
                    mainAxisSize: MainAxisSize.min,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      EzText(
                        l10n.csNotInstalled,
                        textAlign: TextAlign.start,
                      ),
                      ezSpacer,
                      EzElevatedIconLink(
                        url: Uri.parse(installFlutter),
                        tooltip: installFlutter,
                        hint: l10n.rsInstallHint,
                        icon: EzIcon(Icons.computer),
                        label: Lang.of(context)!.rsInstall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (isMac) ezDivider,

            // Advanced settings //

            // Toggle
            EzRow(
              children: <Widget>[
                Flexible(
                  child: EzText(
                    l10n.csAdvanced,
                    style: textTheme.titleLarge,
                    textAlign: TextAlign.start,
                  ),
                ),
                ezRowMargin,
                Semantics(
                  hint: showAdvanced ? el10n.gClose : el10n.gOpen,
                  button: true,
                  child: ExcludeSemantics(
                    child: EzIconButton(
                      onPressed: () =>
                          setState(() => showAdvanced = !showAdvanced),
                      tooltip: showAdvanced ? el10n.gClose : el10n.gOpen,
                      icon: EzIcon(
                        showAdvanced
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                      ),
                    ),
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
                  if (isDesktop) ezSpacer,

                  // Work path picker
                  Visibility(
                    visible: isDesktop,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Title
                        EzText(
                          l10n.csOutputPath,
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),

                        // Picker
                        EzScrollView(
                          mainAxisSize: MainAxisSize.min,
                          scrollDirection: Axis.horizontal,
                          reverseHands: true,
                          children: <Widget>[
                            // Text
                            ConstrainedBox(
                              constraints: ezTextFieldConstraints(context),
                              child: TextFormField(
                                controller: workPathControl,
                                readOnly: !canGen,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                validator: (String? path) =>
                                    (path == null || path.isEmpty)
                                        ? l10n.csPathRequired
                                        : null,
                                autovalidateMode: AutovalidateMode.onUnfocus,
                              ),
                            ),
                            ezRowMargin,

                            // Browse
                            EzIconButton(
                              onPressed: () async {
                                final String? selectedDirectory =
                                    await FilePicker.platform
                                        .getDirectoryPath();

                                if (selectedDirectory == null) return;

                                setState(() {
                                  workPathControl.text = selectedDirectory
                                          .contains(homePath)
                                      ? '$homePath${selectedDirectory.split(homePath)[1]}'
                                      : selectedDirectory;
                                });
                              },
                              tooltip: l10n.csFileBrowser,
                              icon: EzIcon(PlatformIcons(context).folderOpen),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ezSpacer,

                  // Copyright config
                  _AdvancedSettingsField(
                    title: l10n.csCopyright,
                    tip: l10n.csCopyrightTip,
                    controller: copyrightController,
                    visible: showCopyright,
                    onHide: () =>
                        setState(() => showCopyright = !showCopyright),
                    removed: removeCopyright,
                    onRemove: () => setState(() => removeCopyright = true),
                    onRestore: () => setState(() => removeCopyright = false),
                  ),
                  ezSpacer,

                  // LICENSE config
                  _LicensePicker(
                    visible: showLicense,
                    onHide: () => setState(() => showLicense = !showLicense),
                    groupValue: license,
                    onChanged: (String? picked) {
                      if (picked != null) setState(() => license = picked);
                    },
                  ),
                  ezSpacer,

                  // l10n config
                  _AdvancedSettingsField(
                    title: 'l10n.yaml',
                    tip: l10n.csL10nTip,
                    controller: l10nController,
                    visible: showL10n,
                    onHide: () => setState(() => showL10n = !showL10n),
                    removed: removeL10n,
                    onRemove: () => setState(() => removeL10n = true),
                    onRestore: () => setState(() => removeL10n = false),
                  ),
                  ezSpacer,

                  // Analysis options config
                  _AdvancedSettingsField(
                    title: 'analysis_options.yaml',
                    tip: l10n.csLintTip,
                    controller: analysisController,
                    visible: showAnalysis,
                    onHide: () => setState(() => showAnalysis = !showAnalysis),
                    removed: removeAnalysis,
                    onRemove: () => setState(() => removeAnalysis = true),
                    onRestore: () => setState(() => removeAnalysis = false),
                  ),
                  ezSpacer,

                  // VS Code launch config
                  _AdvancedSettingsField(
                    title: '.vscode/launch.json',
                    tip: l10n.csLaunchTip,
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
            showAdvanced ? ezDivider : ezSeparator,

            // Make it so //

            EzScrollView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                // Save config
                EzElevatedIconButton(
                  enabled: canGen,
                  onPressed: () async {
                    if (validName &&
                        pubController.text.isNotEmpty &&
                        (exampleDomain ||
                            validateDomain(domainController.text, context) ==
                                null) &&
                        descriptionController.text.isNotEmpty &&
                        (supportEmailController.text.isEmpty ||
                            EmailValidator.validate(
                                supportEmailController.text)) &&
                        (!isDesktop ||
                            ((!isMac || await checkPath(flutterPathControl)) &&
                                await checkPath(workPathControl))) &&
                        context.mounted) {
                      context.goNamed(
                        archiveScreenPath,
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
                          colorSettings: colorSettings,
                          designSettings: designSettings,
                          layoutSettings: layoutSettings,
                          textSettings: textSettings,
                          appDefaults: Map<String, dynamic>.fromEntries(
                            allEZConfigKeys.keys.map(
                              (String key) => MapEntry<String, dynamic>(
                                  key, EzConfig.get(key)),
                            ),
                          ),
                          flutterPath: isMac ? flutterPathControl.text : null,
                          workPath: isDesktop ? workPathControl.text : null,
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
                        message:
                            '${l10n.csInvalidFields}.\n${l10n.csRequired}.',
                      ).closed;
                      setState(() => canGen = true);
                    }
                  },
                  icon: EzIcon(Icons.save),
                  label: el10n.ssSaveConfig,
                ),

                // Generate app
                if (isDesktop) ...<Widget>[
                  ezSpacer,
                  EzElevatedIconButton(
                    enabled: canGen,
                    onPressed: () async {
                      if (validName &&
                          pubController.text.isNotEmpty &&
                          (exampleDomain ||
                              validateDomain(domainController.text, context) ==
                                  null) &&
                          descriptionController.text.isNotEmpty &&
                          (supportEmailController.text.isEmpty ||
                              EmailValidator.validate(
                                  supportEmailController.text)) &&
                          (!isMac || await checkPath(flutterPathControl)) &&
                          await checkPath(workPathControl) &&
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
                            colorSettings: colorSettings,
                            designSettings: designSettings,
                            layoutSettings: layoutSettings,
                            textSettings: textSettings,
                            appDefaults: Map<String, dynamic>.fromEntries(
                              allEZConfigKeys.keys.map(
                                (String key) => MapEntry<String, dynamic>(
                                    key, EzConfig.get(key)),
                              ),
                            ),
                            flutterPath: isMac ? flutterPathControl.text : null,
                            workPath: workPathControl.text,
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
                          message:
                              '${l10n.csInvalidFields}.\n${l10n.csRequired}.',
                        ).closed;
                        setState(() => canGen = true);
                      }
                    },
                    icon: EzIcon(PlatformIcons(context).create),
                    label: l10n.csGenerate,
                  ),
                ],
              ],
            ),
            ezSeparator,
          ],
        ),
        alignment: Alignment.topLeft,
      ),
      fabs: <Widget>[
        ezSpacer,
        ResetFAB(
          clearForms: () => setState(() {
            nameController.clear();
            namePreview = l10n.csNamePreview;
            validName = false;

            pubController.clear();
            pubPreview = l10n.csPubPreview;

            descriptionController.clear();

            domainController.clear();
            exampleDomain = false;

            supportEmailController.clear();

            colorSettings = true;
            designSettings = true;
            layoutSettings = true;
            textSettings = true;

            flutterPathControl.clear();

            showAdvanced = false;

            workPathControl.text = docsPath;

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
      ],
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    pubController.dispose();
    descriptionController.dispose();
    domainController.dispose();
    supportEmailController.dispose();
    flutterPathControl.dispose();
    workPathControl.dispose();
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
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Title
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: EzText(
                title,
                style: Theme.of(context).textTheme.titleLarge,
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
}

class _AdvancedSettingsField extends StatelessWidget {
  final String title;
  final dynamic tip;
  final TextEditingController controller;
  final bool visible;
  final void Function() onHide;
  final bool removed;
  final void Function()? onRemove;
  final void Function()? onRestore;

  const _AdvancedSettingsField({
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
    late final EFUILang el10n = ezL10n(context);
    late final Lang l10n = Lang.of(context)!;

    late final bool isLefty = EzConfig.get(isLeftyKey);

    late final Widget titleText = EzText(title, textAlign: TextAlign.start);

    late final Widget hideButton = Semantics(
      label: visible ? el10n.gClose : el10n.gOpen,
      button: true,
      child: ExcludeSemantics(
        child: EzIconButton(
          onPressed: onHide,
          tooltip: visible ? el10n.gClose : el10n.gOpen,
          icon: EzIcon(
            visible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          ),
        ),
      ),
    );

    late final Widget removeButton = Semantics(
      hint: el10n.gRemove,
      button: true,
      child: ExcludeSemantics(
        child: EzIconButton(
          onPressed: onRemove,
          tooltip: el10n.gRemove,
          icon: EzIcon(PlatformIcons(context).delete),
        ),
      ),
    );

    late final Widget tooltip = tip.runtimeType == String
        ? EzToolTipper(message: tip)
        : EzToolTipper(richMessage: tip);

    return removed
        ? EzTextIconButton(
            onPressed: onRestore,
            icon: EzIcon(Icons.undo),
            label: l10n.csRestore(title),
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
                        ezRowMargin,
                        titleText,
                        if (onRemove != null) ...<Widget>[
                          ezRowMargin,
                          removeButton,
                        ],
                        if (tip != null) ...<Widget>[
                          ezRowMargin,
                          tooltip,
                        ],
                      ]
                    : <Widget>[
                        titleText,
                        ezRowMargin,
                        hideButton,
                        if (onRemove != null) ...<Widget>[
                          ezRowMargin,
                          removeButton,
                        ],
                        if (tip != null) ...<Widget>[
                          ezRowMargin,
                          tooltip,
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
                    ezMargin,
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
  final bool visible;
  final void Function() onHide;

  final String groupValue;
  final void Function(String?) onChanged;

  const _LicensePicker({
    required this.visible,
    required this.onHide,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final EFUILang el10n = ezL10n(context);
    final Lang l10n = Lang.of(context)!;

    final bool isLefty = EzConfig.get(isLeftyKey);

    Widget radio({
      required String title,
      required String value,
    }) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          EzTextButton(
            text: title,
            textAlign: TextAlign.center,
            onPressed: () => onChanged(value),
          ),
          ExcludeSemantics(child: EzRadio<String>(value: value)),
        ],
      );
    }

    const Widget title = EzText('LICENSE', textAlign: TextAlign.start);

    final Widget hideButton = Semantics(
      label: visible ? el10n.gClose : el10n.gOpen,
      button: true,
      child: ExcludeSemantics(
        child: EzIconButton(
          onPressed: onHide,
          tooltip: visible ? el10n.gClose : el10n.gOpen,
          icon: EzIcon(
            visible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          ),
        ),
      ),
    );

    const String chooseALicense = 'https://choosealicense.com/';
    final Widget tip = EzToolTipper(
      richMessage: EzInlineLink(
        chooseALicense,
        textAlign: TextAlign.center,
        url: Uri.parse(chooseALicense),
        hint: l10n.csLicenseDocs,
      ),
    );

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
                  ezRowMargin,
                  title,
                  tip,
                ]
              : <Widget>[
                  title,
                  ezRowMargin,
                  hideButton,
                  ezRowMargin,
                  tip,
                ],
        ),

        // Options
        Visibility(
          visible: visible,
          child: Padding(
            padding: EdgeInsets.only(top: EzConfig.margin),
            child: RadioGroup<String>(
              groupValue: groupValue,
              onChanged: onChanged,
              child: EzScrollView(
                scrollDirection: Axis.horizontal,
                thumbVisibility: false,
                children: <Widget>[
                  ezRowMargin,
                  radio(
                    title: 'GNU GPLv3',
                    value: gnuKey,
                  ),
                  ezRowSpacer,
                  radio(
                    title: 'MIT',
                    value: mitKey,
                  ),
                  ezRowSpacer,
                  radio(
                    title: 'ISC',
                    value: iscKey,
                  ),
                  ezRowSpacer,
                  radio(
                    title: 'Apache 2.0',
                    value: apacheKey,
                  ),
                  ezRowSpacer,
                  radio(
                    title: 'Mozilla 2.0',
                    value: mozillaKey,
                  ),
                  ezRowSpacer,
                  radio(
                    title: 'Unlicense',
                    value: unlicenseKey,
                  ),
                  ezRowSpacer,
                  radio(
                    title: 'DWTFYW',
                    value: dwtfywKey,
                  ),
                  ezRowMargin,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
