/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../structs/export.dart';

import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

/// Slightly modified from the standard template README
Future<void> genREADME({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
}) async {
  try {
    final File file = File('$dir/README.md');
    await file.writeAsString('''# ${config.appName}

An empathetic Flutter project.

## Getting Started

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [EFUI: Digital accessibility made Ez](https://github.com/Empathetech-LLC/empathetech_flutter_ui)

## Maintaining Momentum

Thanks for using Open UI! We hope you find it helpful.

All that we ask is that you leave the credits/acknowledgements for Empathetech LLC in the code, everywhere they are found.

That, and/or donate via one of the many options we provide; if the product that we helped catalyze becomes profitable.

P.S. `Getting Started` and `Maintaining Momentum` are for ${config.publisherName}, we recommend removing them if this project is going to be made public.

## Credits

${config.appName} began with [Open UI](https://github.com/Empathetech-LLC/empathetech_flutter_ui/releases)'s app generation service.

It is free and open source, maintained by [Empathetech LLC](https://www.empathetech.net/).

If you have a dream that wants to be made a reality, try Open UI!

If you are a fan of digital accessibility and want to encourage its existence, please join the [contributors](https://www.empathetech.net/#/contribute)!
''');
  } catch (e) {
    onFailure(e.toString());
  }
  onSuccess();
}

/// APP_VERSION and CHANGELOG.md
Future<void> genVersionTracking({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
}) async {
  try {
    final File version = File('$dir/APP_VERSION');
    await version.writeAsString('1.0.0');

    final DateTime now = DateTime.now();
    final File changelog = File('$dir/CHANGELOG.md');
    await changelog.writeAsString('''# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0] - ${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}
### Added
- ${config.appName} foundation generated via [Open UI](https://github.com/Empathetech-LLC/empathetech_flutter_ui/releases)

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
''');
  } catch (e) {
    onFailure(e.toString());
  }
  onSuccess();
}

/// LICENSE
Future<void> genLicense({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
}) async {
  try {
    final File file = File('$dir/LICENSE');
    await file.writeAsString(config.license);
  } catch (e) {
    onFailure(e.toString());
  }
  onSuccess();
}

/// pubspec.yaml
Future<void> genPubspec({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
}) async {
  Future<String?> getLatest(String packageName) async {
    final Uri url = Uri.parse('https://pub.dev/api/packages/$packageName');
    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse['latest']['version'];
    } else {
      return null;
    }
  }

  // TODO: empathetech_flutter_ui: ${await getLatest('empathetech_flutter_ui') ?? '^8.0.0'}
  try {
    final File file = File('$dir/pubspec.yaml');
    await file.writeAsString('''name: ${config.appName}
description: "${config.description}"
version: 1.0.0
publish_to: 'none'

environment:
  sdk: ^3.6.0

dependencies:
  flutter:
    sdk: flutter

  # Flutter (Google)
  go_router: ${await getLatest('go_router') ?? '^14.6.2'}
  http: ${await getLatest('http') ?? '^1.2.2'}
  shared_preferences: ${await getLatest('shared_preferences') ?? '^2.3.4'}
  url_launcher: ${await getLatest('url_launcher') ?? '^6.3.1'}

  # Community
  empathetech_flutter_ui:
    path: ../../flutter/empathetech_flutter_ui
  flutter_localized_locales: ${await getLatest('flutter_localized_locales') ?? '^2.0.5'}
  flutter_platform_widgets: ${await getLatest('flutter_platform_widgets') ?? '^7.0.1'}

dev_dependencies:
  dependency_validator: ${await getLatest('dependency_validator') ?? '^4.1.2'}
  flutter_lints: ${await getLatest('flutter_lints') ?? '^5.0.0'}
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter

flutter:
  generate: true
  uses-material-design: true
''');
  } catch (e) {
    onFailure(e.toString());
  }
  onSuccess();
}

/// lib/ and many goodies within
/// Heavily modified from the standard template
Future<void> genLib({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
}) async {
  //// Useful substrings ////

  // Naming //

  final String camelCaseAppName = config.appName.replaceAllMapped(
    RegExp(r'_(\w)'),
    (Match match) => match.group(1)!.toUpperCase(),
  );

  final String classCaseAppName = camelCaseAppName.replaceRange(
    0,
    1,
    config.appName[0].toUpperCase(),
  );

  final String humanCaseAppName = config.appName
      .replaceAllMapped(
        RegExp(r'_(\w)'),
        (Match match) => ' ${match.group(1)!.toUpperCase()}',
      )
      .replaceRange(
        0,
        1,
        config.appName[0].toUpperCase(),
      );

  // Dart code //

  final String copyright = config.copyright ?? '/* ${config.appName} */';

  // yaml files //

  String? l10nName() {
    if (config.l10nConfig == null) return null;

    final List<String> lines = config.l10nConfig!.split('\n');

    for (final String line in lines) {
      if (line.contains('output-class')) {
        final List<String> parts = line.split(':');
        return parts[1].trim();
      }
    }

    return null;
  }

  String? l10nDelegates() {
    final String? name = l10nName();
    if (name == null) return null;

    return '$name.localizationsDelegates';
  }

  String delegateHandler() {
    final String? delegate = l10nDelegates();

    return delegate == null ? '' : '\n...$delegate,\n';
  }

  //// Make it so ////

  // Directories //

  await ezCLI(
    exe: 'mkdir',
    args: <String>[
      'lib',
      'lib/utils',
      'lib/widgets',
      'lib/screens',
      'lib/screens/settings',
    ],
    dir: dir,
    onSuccess: onSuccess,
    onFailure: onFailure,
  );

  // Files //

  // main.dart
  try {
    final File dartMain = File('$dir/lib/main.dart');
    await dartMain.writeAsString("""$copyright

import './screens/export.dart';
import './utils/export.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

void main() async {
  // Setup the app //

  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Initialize EzConfig //

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  EzConfig.init(
    assetPaths: <String>{},
    preferences: prefs,
    defaults: ${camelCaseAppName}Config,
  );

  // Run the app //

  runApp(const $classCaseAppName());
}

/// Initialize a path based router for web-enabled apps
/// Or any other app that requires deep linking
/// https://docs.flutter.dev/ui/navigation/deep-linking
final GoRouter router = GoRouter(
  initialLocation: homePath,
  errorBuilder: (_, GoRouterState state) => ErrorScreen(state.error),
  routes: <RouteBase>[
    GoRoute(
      path: homePath,
      name: homePath,
      builder: (_, __) => const HomeScreen(),
      routes: <RouteBase>[
        GoRoute(
          path: settingsHomePath,
          name: settingsHomePath,
          builder: (_, __) => const SettingsHomeScreen(),
          routes: <RouteBase>[
            GoRoute(
              path: textSettingsPath,
              name: textSettingsPath,
              builder: (_, __) => const TextSettingsScreen(),
            ),
            GoRoute(
              path: layoutSettingsPath,
              name: layoutSettingsPath,
              builder: (_, __) => const LayoutSettingsScreen(),
            ),
            GoRoute(
              path: colorSettingsPath,
              name: colorSettingsPath,
              builder: (_, __) => const ColorSettingsScreen(),
            ),
            GoRoute(
              path: imageSettingsPath,
              name: imageSettingsPath,
              builder: (_, __) => const ImageSettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class $classCaseAppName extends StatelessWidget {
  const $classCaseAppName({super.key});

  @override
  Widget build(BuildContext context) {
    return EzAppProvider(
      app: PlatformApp.router(
        debugShowCheckedModeBanner: false,

        // Language handlers
        localizationsDelegates: <LocalizationsDelegate<dynamic>>{
          const LocaleNamesLocalizationsDelegate(),
          ...EFUILang.localizationsDelegates,${delegateHandler()}
        },

        // Supported languages
        supportedLocales: ${l10nName() ?? 'EFUILang'}.supportedLocales,

        // Current language
        locale: EzConfig.getLocale(),

        title: appTitle,
        routerConfig: router,
      ),
    );
  }
}
""");

    // utils //

    // consts.dart
    String configString() {
      String result = '{';

      for (final MapEntry<String, dynamic> entry
          in config.appDefaults.entries) {
        if (entry.value != null && !entry.key.contains('Image')) {
          result += '${entry.key}Key: ${entry.value},';
        }
      }

      return '$result}';
    }

    final File utilsConsts = File('$dir/lib/utils/consts.dart');
    await utilsConsts.writeAsString("""$copyright

/// $humanCaseAppName
const String appTitle = '$humanCaseAppName';

/// Default [EzConfig] values
const Map<String, Object> ${camelCaseAppName}Config = <String, Object>${configString()};
""");

    // export.dart
    final File utilsExport = File('$dir/lib/utils/export.dart');
    await utilsExport.writeAsString("""$copyright

export 'consts.dart';
""");

    // widgets //

    // fabulous.dart
    final File fabulous = File('$dir/lib/widgets/fabulous.dart');
    await fabulous.writeAsString("""$copyright

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class CountFAB extends StatelessWidget {
  /// [FloatingActionButton.onPressed] passthrough
  final void Function() count;

  /// Increases the count (for the home screen)
  const CountFAB(this.count, {super.key});

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        onPressed: count,
        child: Icon(PlatformIcons(context).add),
      );
}
""");

    // menu_buttons.dart
    final File menuButtons = File('$dir/lib/widgets/menu_buttons.dart');
    await menuButtons.writeAsString("""$copyright

import '../screens/export.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SettingsButton extends StatelessWidget {
  final BuildContext parentContext;

  /// [EzMenuButton] for opening the settings
  const SettingsButton(this.parentContext, {super.key});

  @override
  Widget build(BuildContext context) => EzMenuButton(
        onPressed: () => parentContext.goNamed(settingsHomePath),
        icon: Icon(PlatformIcons(context).settings),
        label: EFUILang.of(context)!.ssPageTitle,
      );
}
""");

    // scaffold file
    final File scaffoldWidget =
        File('$dir/lib/widgets/${config.appName}_scaffold.dart');
    await scaffoldWidget.writeAsString("""$copyright

import './export.dart';
import '../utils/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class ${classCaseAppName}Scaffold extends StatelessWidget {
  /// [AppBar.title] passthrough (via [Text] widget)
  final String title;

  /// Whether to include [SettingsButton] in the [MenuAnchor]
  final bool showSettings;

  /// [Scaffold.body] passthrough
  final Widget body;

  /// [FloatingActionButton]
  final Widget? fab;

  /// Standardized [Scaffold] for all of the EFUI example app's screens
  const ${classCaseAppName}Scaffold({
    super.key,
    this.title = appTitle,
    this.showSettings = true,
    required this.body,
    this.fab,
  });

  @override
  Widget build(BuildContext context) {
    // Gather the theme data //

    final bool isLefty = EzConfig.get(isLeftyKey) ?? false;
    final EFUILang l10n = EFUILang.of(context)!;

    final double toolbarHeight = measureText(
          appTitle,
          style: Theme.of(context).appBarTheme.titleTextStyle,
          context: context,
        ).height +
        EzConfig.get(marginKey);

    // Define custom widgets //

    late final MenuAnchor? options = (showSettings)
        ? MenuAnchor(
            builder: (_, MenuController controller, ___) => IconButton(
              onPressed: () =>
                  controller.isOpen ? controller.close() : controller.open(),
              tooltip: l10n.gOptions,
              icon: const Icon(Icons.more_vert),
            ),
            menuChildren: <Widget>[SettingsButton(context)],
          )
        : null;

    // Return the build //

    final Widget theBuild = SelectionArea(
      child: Scaffold(
        // AppBar
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, toolbarHeight),
          child: AppBar(
            excludeHeaderSemantics: true,
            toolbarHeight: toolbarHeight,

            // Leading (aka left)
            leading: isLefty ? options : null,
            leadingWidth: toolbarHeight,

            // Title
            title: Text(title, textAlign: TextAlign.center),
            centerTitle: true,
            titleSpacing: 0,

            // Actions (aka trailing aka right)
            actions: isLefty
                ? const <Widget>[EzBackAction()]
                : (showSettings ? <Widget>[options!] : null),
          ),
        ),

        // Body
        body: body,

        // FAB
        floatingActionButton: fab,
        floatingActionButtonLocation: isLefty
            ? FloatingActionButtonLocation.startFloat
            : FloatingActionButtonLocation.endFloat,

        // Prevents the keyboard from pushing the body up
        resizeToAvoidBottomInset: false,
      ),
    );

    return EzSwapScaffold(
      small: theBuild,
      large: theBuild,
      threshold: smallBreakpoint,
    );
  }
}
""");

    // export.dart
    final File widgetsExport = File('$dir/lib/widgets/export.dart');
    await widgetsExport.writeAsString("""$copyright

export 'fabulous.dart';
export 'menu_buttons.dart';
export '${config.appName}_scaffold.dart';
""");

    // screens //

    // error.dart
    final File errorScreen = File('$dir/lib/screens/error.dart');
    await errorScreen.writeAsString("""$copyright

import '../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class ErrorScreen extends StatefulWidget {
  final GoException? error;

  const ErrorScreen(this.error, {super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  // Gather the theme data //

  static const EzSeparator separator = EzSeparator();

  late final EFUILang l10n = EFUILang.of(context)!;

  late final TextTheme textTheme = Theme.of(context).textTheme;
  late final TextStyle? bodyStyle = textTheme.bodyLarge;
  late final TextStyle? pitchStyle =
      bodyStyle?.copyWith(fontSize: textTheme.titleLarge?.fontSize);

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle('404 \${l10n.gError}', Theme.of(context).colorScheme.primary);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ${classCaseAppName}Scaffold(
      body: EzScreen(
        useImageDecoration: false,
        child: Center(
          child: EzScrollView(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                l10n.g404Wonder,
                style: pitchStyle,
                textAlign: TextAlign.center,
              ),
              const EzSpacer(),
              Text(
                l10n.g404,
                style: bodyStyle,
                textAlign: TextAlign.center,
              ),
              separator,
              Text(
                l10n.g404Note,
                style: textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              separator,
            ],
          ),
        ),
      ),
    );
  }
}
""");

    // home_screen.dart
    final File homeScreen = File('$dir/lib/screens/home.dart');
    await homeScreen.writeAsString("""$copyright

import '../utils/export.dart';
import '../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Gather the theme data //

  ${config.l10nConfig != null ? 'late final EFUILang l10n = Lang.of(context)!;' : ''}

  late final TextTheme textTheme = Theme.of(context).textTheme;
  late final TextStyle? bigLabelStyle =
      textTheme.bodyLarge?.copyWith(fontSize: textTheme.titleLarge?.fontSize);

  // Define the build data //

  int count = 0;

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(appTitle, Theme.of(context).colorScheme.primary);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ${classCaseAppName}Scaffold(
      title: appTitle,
      body: EzScreen(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                ${config.l10nConfig != null ? 'l10n.counterLabel' : 'You have pushed the button this many times:'},
                style: bigLabelStyle,
                textAlign: TextAlign.center,
              ),
              Text(
                count.toString(),
                style: textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      fab: CountFAB(() => setState(() => count += 1)),
    );
  }
}
""");

    // settings_home.dart
    final File settingsHome =
        File('$dir/lib/screens/settings/settings_home.dart');
    await settingsHome.writeAsString("""$copyright

import '../../screens/export.dart';
import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class SettingsHomeScreen extends StatelessWidget {
  const SettingsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) => ${classCaseAppName}Scaffold(
        title: EFUILang.of(context)!.ssPageTitle,
        showSettings: false,
        body: const SettingsHome(
          ${config.textSettings ? 'textSettingsPath: textSettingsPath,' : ''}
          ${config.layoutSettings ? 'layoutSettingsPath: layoutSettingsPath,' : ''}
          ${config.colorSettings ? 'colorSettingsPath: colorSettingsPath,' : ''}
          ${config.imageSettings ? 'imageSettingsPath: imageSettingsPath,' : ''}                                
        ),
      );
}
""");

    // text_settings_screen.dart?
    if (config.textSettings) {
      final File textSettings =
          File('$dir/lib/screens/settings/text_settings.dart');
      await textSettings.writeAsString("""$copyright

import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class TextSettingsScreen extends StatelessWidget {
  const TextSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => ${classCaseAppName}Scaffold(
        title: EFUILang.of(context)!.tsPageTitle,
        showSettings: false,
        body: const TextSettings(),
      );
}
""");
    }

    // layout_settings_screen.dart?
    if (config.layoutSettings) {
      final File layoutSettings =
          File('$dir/lib/screens/settings/layout_settings.dart');
      await layoutSettings.writeAsString("""$copyright

import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class LayoutSettingsScreen extends StatelessWidget {
  const LayoutSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => ${classCaseAppName}Scaffold(
        title: EFUILang.of(context)!.lsPageTitle,
        showSettings: false,
        body: const LayoutSettings(),
      );
}
""");
    }

    // color_settings_screen.dart?
    if (config.colorSettings) {
      final File colorSettings =
          File('$dir/lib/screens/settings/color_settings.dart');
      await colorSettings.writeAsString("""$copyright

import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class ColorSettingsScreen extends StatelessWidget {
  const ColorSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => ${classCaseAppName}Scaffold(
        title: EFUILang.of(context)!.csPageTitle,
        showSettings: false,
        body: const ColorSettings(),
      );
}
""");
    }

    // image_settings_screen.dart?
    if (config.imageSettings) {
      final File imageSettings =
          File('$dir/lib/screens/settings/image_settings.dart');
      await imageSettings.writeAsString("""$copyright

import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class ImageSettingsScreen extends StatelessWidget {
  const ImageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => ${classCaseAppName}Scaffold(
        title: EFUILang.of(context)!.isPageTitle,
        showSettings: false,
        body: const ImageSettings(),
      );
}
""");
    }

    // export.dart
    final File screensExport = File('$dir/lib/screens/export.dart');
    await screensExport.writeAsString("""$copyright

// Exports //

export 'error.dart';
export 'home.dart';

export 'settings/settings_home.dart';
${config.textSettings ? "export 'settings/text_settings.dart';" : ''}
${config.layoutSettings ? "export 'settings/layout_settings.dart';" : ''}
${config.colorSettings ? "export 'settings/color_settings.dart';" : ''}
${config.imageSettings ? "export 'settings/image_settings.dart';" : ''}

// Route names //

/// 'settings-home'
const String settingsHomePath = 'settings-home';

${config.textSettings ? """/// 'text-settings'
const String textSettingsPath = 'text-settings';""" : ''}

${config.layoutSettings ? """/// 'layout-settings'
const String layoutSettingsPath = 'layout-settings';""" : ''}

${config.colorSettings ? """/// 'color-settings'
const String colorSettingsPath = 'color-settings';""" : ''}

${config.imageSettings ? """/// 'image-settings'
const String imageSettingsPath = 'image-settings';""" : ''}
""");
  } catch (e) {
    onFailure(e.toString());
  }
  onSuccess();
}

/// Localizations config
Future<void> genL10n({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
}) async {
  if (config.l10nConfig == null) return;

  String l10nName() {
    final List<String> lines = config.l10nConfig!.split('\n');

    for (final String line in lines) {
      if (line.contains('output-class')) {
        final List<String> parts = line.split(':');
        return parts[1].trim().toLowerCase();
      }
    }

    return 'lang';
  }

  String l10nPath() {
    final List<String> lines = config.l10nConfig!.split('\n');

    for (final String line in lines) {
      if (line.contains('arb-dir')) {
        final List<String> parts = line.split(':');
        return parts[1].trim();
      }
    }

    return 'lib/10n';
  }

  // Make dir
  await ezCLI(
    exe: 'mkdir',
    args: <String>[l10nPath()],
    dir: dir,
    onSuccess: onSuccess,
    onFailure: onFailure,
  );

  // Make files
  try {
    final File english = File('$dir/${l10nPath()}/${l10nName()}_en.arb');
    await english.writeAsString(config.l10nConfig!);

    final File spanish = File('$dir/${l10nPath()}/${l10nName()}_es.arb');
    await spanish.writeAsString(config.l10nConfig!);

    final File french = File('$dir/${l10nPath()}/${l10nName()}_fr.arb');
    await french.writeAsString(config.l10nConfig!);
  } catch (e) {
    onFailure(e.toString());
  }
  onSuccess();
}

/// analysis_options.yaml
Future<void> genAnalysis({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
}) async {
  if (config.analysisOptions == null) return;

  try {
    final File file = File('$dir/analysis_options.yaml');
    await file.writeAsString(config.analysisOptions!);
  } catch (e) {
    onFailure(e.toString());
  }
  onSuccess();
}

/// Launch config
Future<void> genVSCode({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
}) async {
  if (config.vsCodeConfig == null) return;

  // Make dir
  await ezCLI(
    exe: 'mkdir',
    args: <String>['.vscode'],
    dir: dir,
    onSuccess: onSuccess,
    onFailure: onFailure,
  );

  // Make file
  final File file = File('$dir/.vscode/launch.json');
  await file.writeAsString(config.vsCodeConfig!);
}

/// Skeleton setup to reduce testing friction
Future<void> genIntegrationTests({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
}) async {
  // Shared Strings //

  final String copyright = config.copyright ?? '/* ${config.appName} */';

  final String camelCaseAppName = config.appName.replaceAllMapped(
    RegExp(r'_(\w)'),
    (Match match) => match.group(1)!.toUpperCase(),
  );

  final String classCaseAppName = camelCaseAppName.replaceRange(
    0,
    1,
    config.appName[0].toUpperCase(),
  );

  final String humanCaseAppName = config.appName
      .replaceAllMapped(
        RegExp(r'_(\w)'),
        (Match match) => ' ${match.group(1)!.toUpperCase()}',
      )
      .replaceRange(
        0,
        1,
        config.appName[0].toUpperCase(),
      );

  // Testing dirs //

  await ezCLI(
    exe: 'mkdir',
    args: <String>[
      'test_driver',
      'integration_test',
    ],
    dir: dir,
    onSuccess: onSuccess,
    onFailure: onFailure,
  );

  // Testing files //

  // Driver
  final File driver = File('$dir/test_driver/integration_test_driver.dart');
  await driver.writeAsString("""$copyright

import 'package:integration_test/integration_test_driver.dart';

Future<void> main() => integrationDriver();
""");

  // Tests
  final File tests = File('$dir/integration_test/test.dart');
  await tests.writeAsString("""$copyright

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  final Map<String, Object> testConfig = <String, Object>{
    ...${camelCaseAppName}Config,
    isDarkThemeKey: true,
  };

  SharedPreferences.setMockInitialValues(testConfig);
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  EzConfig.init(
    assetPaths: <String>{},
    preferences: prefs,
    defaults: testConfig,
  );

  group(
    'default-test',
    () {
      testWidgets('test-app', (WidgetTester tester) async {
      // Load localization(s) //

      ezLog('Loading localizations');
      final EFUILang l10n = await EFUILang.delegate.load(locale);

      // Load the app //

      ezLog('Loading $humanCaseAppName');
      await tester.pumpWidget(const $classCaseAppName());
      await tester.pumpAndSettle();
    },
  );
}
""");
}
