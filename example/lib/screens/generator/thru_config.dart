/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../structs/export.dart';
import '../../widgets/export.dart';
import 'package:efui_bios/efui_bios.dart';

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:file_saver/file_saver.dart';
import 'package:file_picker/file_picker.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ThruConfigScreen extends StatefulWidget {
  final EAGConfig config;

  const ThruConfigScreen({super.key, required this.config});

  @override
  State<ThruConfigScreen> createState() => _ThruConfigScreenState();
}

class _ThruConfigScreenState extends State<ThruConfigScreen> {
  // Gather the theme data //

  static const EzSpacer spacer = EzSpacer();

  late final EFUILang l10n = EFUILang.of(context)!;

  late final TextTheme textTheme = Theme.of(context).textTheme;
  late final TextStyle? notificationStyle =
      textTheme.bodyLarge?.copyWith(fontSize: textTheme.titleLarge?.fontSize);

  // Define the build data //

  late final TargetPlatform platform = getBasePlatform(context);
  late final bool isDesktop = platform == TargetPlatform.linux ||
      platform == TargetPlatform.macOS ||
      platform == TargetPlatform.windows;

  late final String defaultPath = platform == TargetPlatform.windows
      ? '${Platform.environment['UserProfile']}\\Documents'
      : '${Platform.environment['HOME']}/Documents';

  late final TextEditingController pathController =
      TextEditingController(text: defaultPath);

  bool validPath = true;
  bool readOnly = false;

  late Widget centerPiece = loadingPage;

  late String successMessage =
      '''\nYour configuration has been saved to ${archivePath()}

Use it on Open UI for desktop to generate the code for ${widget.config.appName}''';

  String errorMessage = 'Something went wrong.\nPlease try again.';

  // Define custom functions //

  /// Save the config
  void archive() async {
    late final String savedConfig;
    try {
      savedConfig = await FileSaver.instance.saveFile(
        name: '${widget.config.appName}_eag_config.json',
        bytes: utf8.encode(jsonEncode(widget.config.toJson())),
        mimeType: MimeType.json,
      );
    } catch (e) {
      errorMessage = 'Something went wrong...\n\n${e.toString()}';
      centerPiece = failurePage;
      setState(() {});
    }

    savedConfig.endsWith('.json')
        ? setState(() => centerPiece = successPage)
        : setState(() => centerPiece = failurePage);
  }

  /// Human readable path for saved config
  String archivePath() {
    switch (platform) {
      case TargetPlatform.android:
        return 'Root > Android > Data > net.empathetech.open_ui > files';
      case TargetPlatform.iOS:
        return 'Files > Browse > Open UI';
      default:
        return 'Downloads';
    }
  }

  /// Validate user configured path for code generation
  void validatePath(String path) async {
    final bool exists = await Directory(path).exists();
    setState(() => validPath = exists);
  }

  /// Confirm func for the project directory alert actions
  void usePath() async {
    const String message = 'Invalid path';

    if (validPath) {
      Navigator.of(context).pop();
    } else {
      // Disable interaction
      readOnly = true;
      pathController.text = message;
      setState(() {});

      // Wait a sec
      await Future<Duration>.delayed(readingTime(message));

      // Retry
      readOnly = false;
      pathController.text = '';
      setState(() {});
    }
  }

  /// Generate the new app!
  void genCode() async {
    await showPlatformDialog(
      context: context,
      builder: (BuildContext pathContext) {
        return EzAlertDialog(
          title: const Text('Confirm project directory'),
          content: TextFormField(
            controller: pathController,
            readOnly: readOnly,
            textAlign: TextAlign.start,
            maxLines: 1,
            validator: (String? path) {
              if (path == null || path.isEmpty) {
                return 'Path required. Cannot use root folder.';
              }
              validatePath(path);

              return validPath ? null : 'Invalid path';
            },
            autovalidateMode: AutovalidateMode.onUnfocus,
          ),
          materialActions: <Widget>[
            EzTextButton(
              onPressed: usePath,
              text: 'Done',
            ),
          ],
          cupertinoActions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              onPressed: usePath,
              child: const Text('Done'),
            ),
          ],
          needsClose: true,
        );
      },
    );

    late final ProcessResult? runResult;
    try {
      runResult = await Process.run(
        'flutter',
        <String>[
          'create',
          '--org',
          widget.config.domainName,
          widget.config.appName,
        ],
        runInShell: true,
        workingDirectory: pathController.text,
      );
    } catch (e) {
      errorMessage = 'Something went wrong...\n\n${e.toString()}';
      centerPiece = failurePage;
      setState(() {});
    }

    runResult != null
        ? setState(() => centerPiece = successPage)
        : setState(() => centerPiece = failurePage);
  }

  /// (Desktop only) confirm if the user wants to...
  /// generate code, save the config, or cancel
  Future<dynamic> confirm() async {
    return await showPlatformDialog(
      context: context,
      builder: (BuildContext confirmContext) {
        return EzAlertDialog(
          title: const Text('Would you like to...'),
          contents: <Widget>[
            // Generate code
            EzElevatedIconButton(
              label: 'Generate ${widget.config.appName}',
              textAlign: TextAlign.center,
              icon: Icon(PlatformIcons(context).folderOpen),
              onPressed: () {
                Navigator.of(confirmContext).pop(true);
                genCode();
              },
            ),
            spacer,

            // Save config
            EzElevatedIconButton(
              label: 'Save config',
              icon: const Icon(Icons.save),
              onPressed: () {
                Navigator.of(confirmContext).pop(false);
                archive();
              },
            ),
          ],
          materialActions: <Widget>[
            EzTextButton(
              text: 'Cancel',
              onPressed: () {
                Navigator.of(confirmContext).pop(null);
                Navigator.of(context).pop(false);
              },
            ),
          ],
          cupertinoActions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(confirmContext).pop(null);
                Navigator.of(context).pop(false);
              },
            ),
          ],
          needsClose: false,
        );
      },
    );
  }

  // Define custom Widgets //

  /// Loading animation
  late final Widget loadingPage = Center(
    child: SizedBox(
      height: heightOf(context) / 2,
      child: const EmpathetechLoadingAnimation(
        height: double.infinity,
        semantics: 'TODO',
      ),
    ),
  );

  /// Tells user what to do next
  late final Widget successPage = EzScrollView(
    children: <Widget>[
      Text(
        'Success!',
        style: textTheme.headlineLarge,
        textAlign: TextAlign.center,
      ),
      Text(
        successMessage,
        style: notificationStyle,
        textAlign: TextAlign.center,
      ),
    ],
  );

  /// Displays the error
  late final Widget failurePage = EzScrollView(
    children: <Widget>[
      Text(
        'Failure',
        style: textTheme.headlineLarge,
        textAlign: TextAlign.center,
      ),
      Text(
        errorMessage,
        style: notificationStyle,
        textAlign: TextAlign.center,
      ),
    ],
  );

  // Init //

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => isDesktop ? confirm() : archive());
  }

  // Return the build //

  @override
  Widget build(_) => OpenUIScaffold(
        title: 'Generator',
        body: EzScreen(child: centerPiece),
      );

  @override
  void dispose() {
    pathController.dispose();
    super.dispose();
  }
}
