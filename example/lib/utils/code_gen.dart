/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/export.dart';

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

// Consts //

const String openUIProdPage = 'https://www.empathetech.net/#/products/open-ui';

// Defaults taken from...
// https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization#configuring-the-l10n-yaml-file

// Sub-string getters //

/// Copyright notice for the top of code files
String genCopyright(EAGConfig config) =>
    config.copyright ?? '/* ${config.appName} */';

/// Returns the .arb file directory
String getArbDir(EAGConfig config) {
  for (final String line in config.l10nConfig.split('\n')) {
    if (line.contains('arb-dir')) {
      final List<String> parts = line.split(':');
      return parts[1].trim();
    }
  }

  return 'lib/10n';
}

/// OutputClass name
String l10nClassName(EAGConfig config) {
  for (final String line in config.l10nConfig.split('\n')) {
    if (line.contains('output-class')) {
      final List<String> parts = line.split(':');
      return parts[1].trim();
    }
  }

  return 'AppLocalizations';
}

/// [l10nClassName].localizationsDelegates
String l10nDelegates(EAGConfig config) =>
    '${l10nClassName(config)}.localizationsDelegates';

/// \n...[l10nDelegates],\n
String l10nDelegateHandler(EAGConfig config) =>
    '\n          ...${l10nDelegates(config)},';

// Code generation //

/// Slightly modified from the standard template README
Future<void> genREADME({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
  required ValueNotifier<String> readout,
}) async {
  final String appName = ezSnakeToTitle(config.appName);
  try {
    // English
    final File enFile = File('$dir/README.md');
    await enFile.writeAsString('''# $appName

An empathetic Flutter project.

## <br>Getting Started

Some helpful documentation if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab) (Flutter)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook) (Flutter)
- [EFUI: Digital accessibility made Ez](https://github.com/Empathetech-LLC/empathetech_flutter_ui) (Empathetech)

And videos:

- [First app tutorial](https://www.youtube.com/watch?v=xWV71C2kp38) (Flutter)
- [First app code lab](https://www.youtube.com/watch?v=8sAyPDLorek) (Flutter)
- [Using external packages](https://www.youtube.com/watch?v=WdXcJdhWcEY) (Net Ninja)

### <br>From scratch

If this is one of your first coding projects, welcome! We're honored to help catalyze something new for you.

Some (free) things that will make your life easier...
1. An IDE (Integrated Development Environment). Essentially Word/Docs for coding. By default, Open UI generated apps pair well with [VS Code](https://code.visualstudio.com/download)
2. If you setup VS Code, some **extensions** (similar ones are likely available for other IDEs)
   1. `Dart`: Flutter is a Dart framework. Dart is the underlying language (like C, Python, Java, etc), while Flutter is similar to a library, but HUGE.
   2. `Flutter`: Needs no introduction
      1. `Flutter Widget Snippets` and `Awesome Flutter Snippets` provide some shortcuts while coding. More seasoned developers will get more out of them, but they also won't hinder new players.
   3. `YAML`: Several configuration files for Flutter projects are in the .yaml format.
   4. `ARB Editor`: .arb files are what Flutter uses for localization (translation).
   5. `Code Spell Checker`: Especially when writing documentation, it's good to have your IDE check your human english as well.
      1. Or your Spanish, French, etc. with extension **add-ons**
   6. `Inno Setup`: If you're planning on releasing Windows apps publicly, you will need to write inno setup scripts.
   7. `Markdown All in One`: simplifies editing and previewing markdown files (like this one)
   8. There's also plugins for all your favorite LLMs, but those aren't free.

## <br>Maintaining Momentum

Thanks for using Open UI! We hope you find it helpful.

All that we ask is that you leave the credits/acknowledgements to Empathetech LLC in the code.

That, and/or donate via one of the many options we provide.

### <br>Building with user customization in mind

As your app grows, use [EFUI](https://github.com/Empathetech-LLC/empathetech_flutter_ui) to keep things Ez

* [Responsive design](https://github.com/Empathetech-LLC/empathetech_flutter_ui/tree/main/lib/src/widgets/responsive_design): `Widget`s that aid in building responsive UI/UX
* [Screen reader support](https://github.com/Empathetech-LLC/empathetech_flutter_ui/tree/main/lib/src/widgets/screen_reader_support): `Widget`s with streamlined `Semantics`
* [User customization](https://github.com/Empathetech-LLC/empathetech_flutter_ui/tree/main/lib/src/widgets/helpers): Wrapper `Widget`s that respond to `EzConfig` data when the `ThemeData` doesn't cut it

### <br>Localization

aka translation. Add new text to the language files in ${getArbDir(config)} and reference them in the dart code with `${l10nClassName(config)}`

There is a step between: after editing the .arb files, run 
``` bash
flutter gen-l10n
``` 
to generate the new aliases.

### <br>Integration testing

Has been setup along with a basic runner script; `integration_test/run_int_tests.sh`

<br>P.S. `Getting Started` and `Maintaining Momentum` are for ${config.publisherName}, we recommend (re)moving them if this project is going to be made public.

## <br>Credits

$appName began with [Open UI]($openUIProdPage)'s app generation service.

It is free and open source, maintained by [Empathetech LLC](https://www.empathetech.net/).

If you have a dream that wants to be made a reality, try Open UI!
''');
  } catch (e) {
    onFailure(e.toString());
  }
  ezLog('README.md successfully generated', buffer: readout);
  onSuccess();
}

/// APP_VERSION and CHANGELOG.md
Future<void> genVersionTracking({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
  required ValueNotifier<String> readout,
}) async {
  try {
    final File version = File('$dir/APP_VERSION');
    await version.writeAsString('1.0.0');

    final DateTime now = DateTime.now();
    final File changelog = File('$dir/CHANGELOG.md');
    await changelog.writeAsString('''# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0] - ${now.year}-XX-XX
### Added
- ${config.appName} V1

## [0.0.0] - ${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}
### Added
- ${config.appName} foundation generated via [Open UI]($openUIProdPage)

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
''');
  } catch (e) {
    onFailure(e.toString());
  }
  ezLog('Version tracking files successfully generated', buffer: readout);
  onSuccess();
}

/// LICENSE
Future<void> genLicense({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
  required ValueNotifier<String> readout,
}) async {
  try {
    final File file = File('$dir/LICENSE');
    await file.writeAsString(config.license);
  } catch (e) {
    onFailure(e.toString());
  }
  ezLog('LICENSE successfully generated', buffer: readout);
  onSuccess();
}

/// pubspec.yaml
Future<void> genPubspec({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
  required ValueNotifier<String> readout,
}) async {
  try {
    final File file = File('$dir/pubspec.yaml');
    await file.writeAsString('''name: ${config.appName}
description: "${config.appDescription}"
version: 1.0.0
publish_to: 'none'

environment:
  sdk: ^3.6.0

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter

  # Flutter (Google)
  go_router: ^14.8.1
  intl: ^0.20.2
  shared_preferences: ^2.5.3

  # Community
  empathetech_flutter_ui: ^11.0.0
  flutter_localized_locales: ^2.0.5

dev_dependencies:
  dependency_validator: ^5.0.2
  flutter_lints: ^6.0.0

flutter:
  generate: true
  uses-material-design: true
''');
  } catch (e) {
    onFailure(e.toString());
  }
  ezLog('pubspec.yaml successfully generated', buffer: readout);
  onSuccess();
}

/// `lib/` and many goodies within
/// Heavily modified from the standard template
Future<void> genLib({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
  required ValueNotifier<String> readout,
}) async {
  // Useful substrings //

  final String camelCaseAppName = ezSnakeToCamel(config.appName);
  final String classCaseAppName = ezSnakeToClass(config.appName);
  final String titleCaseAppName = ezSnakeToTitle(config.appName);

  final String copyright = genCopyright(config);

  final String? l10nClass = l10nClassName(config);

  //* Make it so *//

  // Directories //

  await ezCmd(
    EzConfig.platform == TargetPlatform.windows
        ? 'mkdir lib lib\\utils lib\\widgets lib\\screens lib\\screens\\settings'
        : 'mkdir lib lib/utils lib/widgets lib/screens lib/screens/settings',
    dir: dir,
    onSuccess: doNothing,
    onFailure: onFailure,
    readout: readout,
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
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

void main() async {
  // Setup the app //

  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(DeviceOrientation.values);

  // Initialize EzConfig //

  EzConfig.init(
    assetPaths: <String>{},
    defaults: ${camelCaseAppName}Config,
    localeFallback: americanEnglish,
    l10nFallback: await EFUILang.delegate.load(americanEnglish),
    preferences: await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(
        allowList: allEZConfigKeys.keys.toSet(),
      ),
    ),
  );

  // Run the app //
  
  final (Locale storedLocale, EFUILang storedEFUILang) = await ezStoredL10n();

  runApp($classCaseAppName(
    storedLocale,
    storedEFUILang,
    await $l10nClass.delegate.load(storedLocale),
  ));
}

class $classCaseAppName extends StatelessWidget {
  final Locale storedLocale;
  final EFUILang storedEFUILang;
  final $l10nClass storedLang;
  
  const $classCaseAppName(
    this.storedLocale,
    this.storedEFUILang,
    this.storedLang, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return EzConfigurableApp(
      localizationsDelegates: <LocalizationsDelegate<dynamic>>{
        const LocaleNamesLocalizationsDelegate(),
        ...EFUILang.localizationsDelegates,${l10nDelegateHandler(config)}
      },
      supportedLocales: $l10nClass.supportedLocales,
      locale: storedLocale,
      el10n: storedEFUILang,
      appCache: ${classCaseAppName}Cache(storedLocale, storedLang),
      appName: appName,
      routerConfig: GoRouter(
        navigatorKey: ezRootNav,
        initialLocation: homePath,
        errorBuilder: (_, GoRouterState state) => ErrorScreen(state.error),
        routes: <RouteBase>[
          // Home
          GoRoute(
            path: homePath,
            name: homePath,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                ezPageBuilder(context, state, HomeScreen()),
            routes: <RouteBase>[
              // Settings home
              GoRoute(
                path: settingsHomePath,
                name: settingsHomePath,
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    ezPageBuilder(context, state, SettingsHomeScreen()),
                routes: <RouteBase>[
                  ${config.colorSettings ? '''// Color settings
                  GoRoute(
                    path: colorSettingsPath,
                    name: colorSettingsPath,
                    pageBuilder: (BuildContext context, GoRouterState state) =>
                        ezPageBuilder(
                            context, state, ColorSettingsScreen()),
                    routes: <RouteBase>[
                      GoRoute(
                        path: EzCSType.quick.path,
                        name: EzCSType.quick.name,
                        pageBuilder:
                            (BuildContext context, GoRouterState state) =>
                                ezPageBuilder(
                          context,
                          state,
                          ColorSettingsScreen(target: EzCSType.quick),
                        ),
                      ),
                      GoRoute(
                        path: EzCSType.advanced.path,
                        name: EzCSType.advanced.name,
                        pageBuilder:
                            (BuildContext context, GoRouterState state) =>
                                ezPageBuilder(
                          context,
                          state,
                          ColorSettingsScreen(target: EzCSType.advanced),
                        ),
                      ),
                    ],
                  ),''' : ''}
                  ${config.designSettings ? '''
                  // Design settings
                  GoRoute(
                    path: designSettingsPath,
                    name: designSettingsPath,
                    pageBuilder: (BuildContext context, GoRouterState state) =>
                        ezPageBuilder(
                            context, state, DesignSettingsScreen()),
                  ),''' : ''}
                  ${config.layoutSettings ? '''
                  // Layout settings
                  GoRoute(
                    path: layoutSettingsPath,
                    name: layoutSettingsPath,
                    pageBuilder: (BuildContext context, GoRouterState state) =>
                        ezPageBuilder(
                            context, state, LayoutSettingsScreen()),
                  ),''' : ''}
                  ${config.textSettings ? '''
                  // Text settings
                  GoRoute(
                    path: textSettingsPath,
                    name: textSettingsPath,
                    pageBuilder: (BuildContext context, GoRouterState state) =>
                        ezPageBuilder(
                            context, state, TextSettingsScreen()),
                    routes: <RouteBase>[
                      GoRoute(
                        path: EzTSType.quick.path,
                        name: EzTSType.quick.name,
                        pageBuilder:
                            (BuildContext context, GoRouterState state) =>
                                ezPageBuilder(
                          context,
                          state,
                          TextSettingsScreen(target: EzTSType.quick),
                        ),
                      ),
                      GoRoute(
                        path: EzTSType.advanced.path,
                        name: EzTSType.advanced.name,
                        pageBuilder:
                            (BuildContext context, GoRouterState state) =>
                                ezPageBuilder(
                          context,
                          state,
                          TextSettingsScreen(target: EzTSType.advanced),
                        ),
                      ),
                    ],
                  ),''' : ''}                     
                ],
              ),
            ],
          ),
        ],
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
          // Handle specific cases //

          if (entry.key == appLocaleKey) {
            // Update to the default Locale
            result +=
                '${entry.key}Key: <String>${entry.value.toString().replaceAll('[', "['").replaceAll(']', "']")},';
          } else if (entry.key == userDarkColorsKey ||
              entry.key == userLightColorsKey) {
            // Updates to which colors are default in the advanced color settings screen
            final String colorList = entry.value.toString().replaceAll(
                  ',',
                  'Key,',
                );

            result +=
                '${entry.key}Key: <String>${colorList.replaceRange(colorList.length - 1, null, 'Key,]')},';
          } else {
            // Default case
            result += '${entry.key}Key: ${entry.value},';
          }
        }
      }

      return '$result}';
    }

    final File utilsConsts = File('$dir/lib/utils/consts.dart');
    await utilsConsts.writeAsString("""$copyright

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

/// $titleCaseAppName
const String appName = '$titleCaseAppName';

/// ${config.domainName}.${config.appName}
const String androidPackage = '${config.domainName}.${config.appName}';

/// Default [EzConfig] values
const Map<String, Object> ${camelCaseAppName}Config = <String, Object>${configString()};
""");

    // APP_cache.dart
    final File appCache = File('$dir/lib/utils/${config.appName}_cache.dart');
    await appCache.writeAsString("""$copyright

import './export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class ${classCaseAppName}Cache extends EzAppCache {
  // Construct //

  Locale _locale;
  Lang _l10n;

  ${classCaseAppName}Cache(Locale locale, $l10nClass l10n)
      : _locale = locale,
        _l10n = l10n;

  // Get //

  Lang get l10n => _l10n;

  // Set //

  @override
  Future<void> rebuild() async {
    if (_locale != EzConfig.locale) {
      _l10n = await $l10nClass.delegate.load(EzConfig.locale);
      _locale = EzConfig.locale;
    }
  }
}

Lang get l10n => (EzConfig.appCache! as ${classCaseAppName}Cache).l10n;
""");

    // export.dart
    final File utilsExport = File('$dir/lib/utils/export.dart');
    await utilsExport.writeAsString("""$copyright

export 'consts.dart';
export '${config.appName}_cache.dart';

export '../l10n/${ezClassToSnake(l10nClass!)}.dart';
""");

    // widgets //

    // fabulous.dart
    final File fabulous = File('$dir/lib/widgets/fabulous.dart');
    await fabulous.writeAsString("""$copyright

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class CountFAB extends StatelessWidget {
  /// [FloatingActionButton.onPressed] passthrough
  final void Function() count;

  /// Increases the count (for the home screen)
  const CountFAB(this.count, {super.key});

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        onPressed: count,
        child: EzIcon(Icons.add),
      );
}

// TODO: Complete link placeholders (_PH)
const Widget updater = EzUpdaterFAB(
  appVersion: '1.0.0', // TODO (recommended): include a check for this in your release scripts
  versionSource:
      'https://raw.githubusercontent.com/USER_PH/REPO_PH/refs/heads/main/APP_VERSION',
  gPlay:
      'https://play.google.com/store/apps/details?id=${config.domainName}.${config.appName}',
  appStore: 'https://apps.apple.com/us/app/${config.appName.replaceAll('_', '-')}/APP_ID_PH',
  github: 'https://github.com/USER_PH/REPO_PH/releases',
);
""");

    // menu_buttons.dart
    final File menuButtons = File('$dir/lib/widgets/menu_buttons.dart');
    await menuButtons.writeAsString("""$copyright

import '../screens/export.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class SettingsButton extends StatelessWidget {
  final BuildContext parentContext;

  /// [EzMenuButton] for opening the settings
  const SettingsButton(this.parentContext, {super.key});

  @override
  Widget build(BuildContext context) => EzMenuButton(
        onPressed: () => parentContext.goNamed(settingsHomePath),
        icon: EzIcon(Icons.settings),
        label: EzConfig.l10n.ssPageTitle,
      );
}

class EFUICredits extends StatelessWidget {
  final BuildContext parentContext;

  /// [EzMenuButton] for opening Open UI's product page
  /// Honor system: keep a version of this in your app
  /// Remove iff appropriate contributions have been made to Empathetech LLC
  /// https://www.empathetech.net/#/contribute
  const EFUICredits(this.parentContext, {super.key});

  @override
  Widget build(BuildContext context) {
    final String label = EzConfig.isLefty ? EzConfig.l10n.gMadeBy : EzConfig.l10n.gCreator;
    final String tip = EzConfig.l10n.gOpenEmpathetech;
    final String settings = EzConfig.l10n.ssPageTitle;

    return Tooltip(
      message: tip,
      excludeFromSemantics: true,
      child: EzMenuLink(
        uri: Uri.parse('https://www.empathetech.net/#/products/open-ui'),
        icon: EzIcon(Icons.settings),
        label: label,
        semanticsLabel:
          '\${EzConfig.isLefty ? '\$settings \$label' : '\$label \$settings'}. \$tip',
      ),
    );
  }
}
""");

    // scaffold file
    final File scaffoldWidget = File(
      '$dir/lib/widgets/${config.appName}_scaffold.dart',
    );
    await scaffoldWidget.writeAsString("""$copyright

import '../utils/export.dart';
import './export.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class ${classCaseAppName}Scaffold extends StatelessWidget {
  /// [AppBar.title] passthrough (via [Text] widget)
  final String title;

  /// Whether to include [SettingsButton] in the [MenuAnchor]
  final bool showSettings;

  /// [Scaffold.body] passthrough
  final Widget body;

  /// [FloatingActionButton]s to add on top of the [EzUpdaterFAB]
  /// BYO spacing widgets
  final List<Widget>? fabs;

  /// Standardized [Scaffold] for all of the EFUI example app's screens
  const ${classCaseAppName}Scaffold(this.body, {
    super.key,
    this.title = appName,
    this.showSettings = true,
    this.fabs,
  });

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final double toolbarHeight =
        ezToolbarHeight(context: context, title: appName);

    // Define custom widgets //

    late final Widget options = MenuAnchor(
      builder: (_, MenuController controller, ___) => IconButton(
        onPressed: () =>
            controller.isOpen ? controller.close() : controller.open(),
        tooltip: EzConfig.l10n.gOptions,
        icon: Icon(Icons.more_vert, semanticLabel: EzConfig.l10n.gOptions),
      ),
      menuChildren: <Widget>[
        (showSettings) ? SettingsButton(context) : EFUICredits(context),
      ],
    );

    // Return the build //

    return EzAdaptiveParent(
      small: Consumer<EzConfigProvider>(
        builder: (_, EzConfigProvider config, __) => Scaffold(
          key: ValueKey<int>(config.seed),
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, toolbarHeight),
            child: AppBar(
              excludeHeaderSemantics: true,
              toolbarHeight: toolbarHeight,

              // Leading (aka left)
              leading: EzConfig.isLefty ? options : const EzBackAction(),
              leadingWidth: toolbarHeight,

              // Title
              title: Text(title, textAlign: TextAlign.center),
              centerTitle: true,
              titleSpacing: 0,

              // Actions (aka trailing aka right)
              actions: <Widget>[EzConfig.isLefty ? const EzBackAction() : options],
            ),
          ),
          body: body,
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[updater, if (fabs != null) ...fabs!],
          ),
          floatingActionButtonLocation: EzConfig.isLefty
              ? FloatingActionButtonLocation.startFloat
              : FloatingActionButtonLocation.endFloat,
          resizeToAvoidBottomInset: false,
        ),
      ),
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

  ErrorScreen(this.error) : super(key: ValueKey<int>(EzConfig.seed));

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  // Set the page title //

  @override
  void initState() {
    super.initState();
    ezWindowNamer(ez404());
  }

  // Return the build //

  @override
  Widget build(BuildContext context) => ${classCaseAppName}Scaffold(EzScreen(
      Center(
        child: EzScrollView(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              EzConfig.l10n.g404Wonder,
              style: EzConfig.styles.headlineLarge,
              textAlign: TextAlign.center,
            ),
            EzConfig.separator,
            Text(
              EzConfig.l10n.g404,
              style: ezSubTitleStyle(),
              textAlign: TextAlign.center,
            ),
            EzConfig.separator,
            Text(
              EzConfig.l10n.g404Note,
              style: EzConfig.styles.labelLarge,
              textAlign: TextAlign.center,
            ),
            EzConfig.separator,
          ],
        ),
      ),
      useImageDecoration: false,
    ));
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
  HomeScreen():super(key: ValueKey<int>(EzConfig.seed));

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Define the build data //

  int count = 0;

  // Set the page title //

  @override
  void initState() {
    super.initState();
    ezWindowNamer(appName);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ${classCaseAppName}Scaffold(
      EzScreen(
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                l10n.hsCounterLabel,
                style: ezSubTitleStyle(),
                textAlign: TextAlign.center,
              ),
              Text(
                count.toString(),
                style: EzConfig.styles.headlineLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      title: appName,
      fabs: <Widget>[
        EzConfig.spacer,
        CountFAB(() => setState(() => count += 1)),
      ],
    );
  }
}
""");

    // home.dart
    final File settingsHome = File('$dir/lib/screens/settings/home.dart');
    await settingsHome.writeAsString("""$copyright

import '../../screens/export.dart';
import '../../utils/export.dart';
import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class SettingsHomeScreen extends StatelessWidget {
  SettingsHomeScreen() : super(key: ValueKey<int>(EzConfig.seed));

  @override
  Widget build(BuildContext context) => ${classCaseAppName}Scaffold(
        const EzScreen(EzSettingsHome(
          colorSettingsPath: ${config.colorSettings ? 'colorSettingsPath,' : 'null,'}
          designSettingsPath: ${config.designSettings ? 'designSettingsPath,' : 'null,'}   
          layoutSettingsPath: ${config.layoutSettings ? 'layoutSettingsPath,' : 'null,'}
          textSettingsPath: ${config.textSettings ? 'textSettingsPath,' : 'null,'}
          appName: appName,
          androidPackage: androidPackage,
        )),
        title: EzConfig.l10n.ssPageTitle,
        showSettings: false,
        fabs: <Widget>[
          EzConfig.spacer,
          EzConfigFAB(
            context,
            appName: appName,
            androidPackage: androidPackage,
          ),
        ],
      );
}
""");

    // Color settings?
    if (config.colorSettings) {
      final File colorSettings = File(
        '$dir/lib/screens/settings/color.dart',
      );
      await colorSettings.writeAsString("""$copyright

import '../../utils/export.dart';
import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class ColorSettingsScreen extends StatelessWidget {
  final EzCSType? target;

  ColorSettingsScreen() : super(key: ValueKey<int>(EzConfig.seed));

  @override
  Widget build(BuildContext context) => ${classCaseAppName}Scaffold(
        EzScreen(EzColorSettings(
          target: target,
          appName: appName,
          androidPackage: androidPackage,
        )),
        title: EzConfig.l10n.csPageTitle,
        showSettings: false,
        fabs: <Widget>[
          EzConfig.spacer,
          EzConfigFAB(
            context,
            appName: appName,
            androidPackage: androidPackage,
          ),
        ],
      );
}
""");
    }

    // Design settings?
    if (config.designSettings) {
      final File designSettings = File(
        '$dir/lib/screens/settings/design.dart',
      );
      await designSettings.writeAsString("""$copyright

import '../../utils/export.dart';
import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class DesignSettingsScreen extends StatelessWidget {
  DesignSettingsScreen() : super(key: ValueKey<int>(EzConfig.seed));

  @override
  Widget build(BuildContext context) => ${classCaseAppName}Scaffold(
        const EzScreen(EzDesignSettings(
          appName: appName,
          androidPackage: androidPackage,
        )),
        title: EzConfig.l10n.dsPageTitle,
        showSettings: false,
        fabs: <Widget>[
          EzConfig.spacer,
          EzConfigFAB(
            context,
            appName: appName,
            androidPackage: androidPackage,
          ),
        ],
      );
}
""");
    }

    // Layout settings?
    if (config.layoutSettings) {
      final File layoutSettings = File(
        '$dir/lib/screens/settings/layout.dart',
      );
      await layoutSettings.writeAsString("""$copyright

import '../../utils/export.dart';
import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class LayoutSettingsScreen extends StatelessWidget {
  LayoutSettingsScreen() : super(key: ValueKey<int>(EzConfig.seed));

  @override
  Widget build(BuildContext context) => ${classCaseAppName}Scaffold(
        const EzScreen(EzLayoutSettings(
          appName: appName,
          androidPackage: androidPackage,
        )),
        title: EzConfig.l10n.lsPageTitle,
        showSettings: false,
        fabs: <Widget>[
          EzConfig.spacer,
          EzConfigFAB(
            context,
            appName: appName,
            androidPackage: androidPackage,
          ),
        ],
      );
}
""");
    }

    // Text settings?
    if (config.textSettings) {
      final File textSettings = File(
        '$dir/lib/screens/settings/text.dart',
      );
      await textSettings.writeAsString("""$copyright

import '../../utils/export.dart';
import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class TextSettingsScreen extends StatelessWidget {
  final EzTSType? target;

  TextSettingsScreen(this.target) : super(key: ValueKey<int>(EzConfig.seed));

  @override
  Widget build(BuildContext context) => ${classCaseAppName}Scaffold(
        EzScreen(EzTextSettings(
          target: target,
          appName: appName,
          androidPackage: androidPackage,
        )),
        title: EzConfig.l10n.tsPageTitle,
        showSettings: false,
        fabs: <Widget>[
          EzConfig.spacer,
          EzConfigFAB(
            context,
            appName: appName,
            androidPackage: androidPackage,
          ),
        ],
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

export 'settings/home.dart';

${config.colorSettings ? "export 'settings/color.dart';" : ''}
${config.designSettings ? "export 'settings/design.dart';" : ''}
${config.layoutSettings ? "export 'settings/layout.dart';" : ''}
${config.textSettings ? "export 'settings/text.dart';" : ''}

// Route names //

/// settings-home
const String settingsHomePath = 'settings-home';

${config.colorSettings ? """/// color-settings
const String colorSettingsPath = 'color-settings';""" : ''}

${config.designSettings ? """/// design-settings
const String designSettingsPath = 'design-settings';""" : ''}

${config.layoutSettings ? """/// layout-settings
const String layoutSettingsPath = 'layout-settings';""" : ''}

${config.textSettings ? """/// text-settings
const String textSettingsPath = 'text-settings';""" : ''}
""");
  } catch (e) {
    onFailure(e.toString());
  }
  ezLog('Dart code successfully generated', buffer: readout);
  onSuccess();
}

/// Localizations config
Future<void> genL10n({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
  required ValueNotifier<String> readout,
}) async {
  // Gather setup //

  final String snakeName = ezClassToSnake(l10nClassName(config));
  final String arbPath = EzConfig.platform == TargetPlatform.windows
      ? getArbDir(config).replaceAll('/', '\\')
      : getArbDir(config);

  // Make dir
  await ezCmd(
    'mkdir $arbPath',
    dir: dir,
    onSuccess: doNothing,
    onFailure: onFailure,
    readout: readout,
  );

  // Make files
  try {
    final File english = File('$dir/$arbPath/${snakeName}_en.arb');
    await english.writeAsString('''{
  "@@locale": "en",



  "hsCounterLabel": "You have pushed the button this many times:"
}''');

    final File spanish = File('$dir/$arbPath/${snakeName}_es.arb');
    await spanish.writeAsString('''{
  "@@locale": "es",



  "hsCounterLabel": "Has pulsado el botón muchas veces:"
}''');

    final File french = File('$dir/$arbPath/${snakeName}_fr.arb');
    await french.writeAsString('''{
  "@@locale": "fr",



  "hsCounterLabel": "Vous avez appuyé sur le bouton autant de fois que cela :"
}''');

    final File l10nConfig = File('$dir/l10n.yaml');
    await l10nConfig.writeAsString(config.l10nConfig);
  } catch (e) {
    onFailure(e.toString());
  }
  ezLog('Localizations successfully generated', buffer: readout);
  onSuccess();
}

/// analysis_options.yaml
Future<void> genAnalysis({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
  required ValueNotifier<String> readout,
}) async {
  if (config.analysisOptions == null) return;

  try {
    final File file = File('$dir/analysis_options.yaml');
    await file.writeAsString(config.analysisOptions!);
  } catch (e) {
    onFailure(e.toString());
  }
  ezLog(
    'Analysis options (lint rules) successfully generated',
    buffer: readout,
  );
  onSuccess();
}

/// Launch config
Future<void> genVSCode({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
  required ValueNotifier<String> readout,
}) async {
  if (config.vsCodeConfig == null) return;

  // Make dir
  await ezCmd(
    'mkdir .vscode',
    dir: dir,
    onSuccess: doNothing,
    onFailure: onFailure,
    readout: readout,
  );

  // Make file
  try {
    final File file = File('$dir/.vscode/launch.json');
    await file.writeAsString(config.vsCodeConfig!);
  } catch (e) {
    onFailure(e.toString());
  }
  ezLog('VS Code launch config successfully generated', buffer: readout);
  onSuccess();
}
