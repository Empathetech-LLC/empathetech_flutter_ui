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

// Sub-string getters //

/// Copyright notice for the top of code files
String genCopyright(EAGConfig config) =>
    config.copyright ?? '/* ${config.appName} */';

/// Returns the .arb file directory
String? getArbDir(EAGConfig config) {
  if (config.l10nConfig == null) return null;

  final List<String> lines = config.l10nConfig!.split('\n');

  for (final String line in lines) {
    if (line.contains('arb-dir')) {
      final List<String> parts = line.split(':');
      return parts[1].trim();
    }
  }

  // Default: https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization#configuring-the-l10n-yaml-file
  return 'lib/10n';
}

/// OutputClass name
String? l10nClassName(EAGConfig config) {
  if (config.l10nConfig == null) return null;

  final List<String> lines = config.l10nConfig!.split('\n');

  for (final String line in lines) {
    if (line.contains('output-class')) {
      final List<String> parts = line.split(':');
      return parts[1].trim();
    }
  }

  // Default: https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization#configuring-the-l10n-yaml-file
  return 'AppLocalizations';
}

/// [l10nClassName].localizationsDelegates
String? l10nDelegates(EAGConfig config) {
  final String? name = l10nClassName(config);
  if (name == null) return null;

  return '$name.localizationsDelegates';
}

/// \n...[l10nDelegates],\n
String l10nDelegateHandler(EAGConfig config) {
  final String? delegate = l10nDelegates(config);

  return delegate == null ? '' : '\n          ...$delegate,';
}

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

* [Platform availability](https://github.com/Empathetech-LLC/empathetech_flutter_ui/tree/main/lib/src/widgets/platform_availability): Platform responsive `Widget`s that will help along the way
* [Responsive design](https://github.com/Empathetech-LLC/empathetech_flutter_ui/tree/main/lib/src/widgets/responsive_design): `Widget`s that aid in building responsive UI/UX
* [Screen reader support](https://github.com/Empathetech-LLC/empathetech_flutter_ui/tree/main/lib/src/widgets/screen_reader_support): `Widget`s with streamlined `Semantics`
* [User customization](https://github.com/Empathetech-LLC/empathetech_flutter_ui/tree/main/lib/src/widgets/helpers): Wrapper `Widget`s that respond to `EzConfig` data when the `ThemeData` doesn't cut it

${config.l10nConfig != null ? '''### <br>Localization

aka translation. Add new text to the language files in ${getArbDir(config)} and reference them in the dart code with `${l10nClassName(config)}`

There is a step between: after editing the .arb files, run 
``` bash
flutter gen-l10n
``` 
to generate the new aliases.
''' : ''}
### <br>Integration testing

Has been setup along with a basic runner script; `integration_test/run_int_tests.sh`

<br>P.S. `Getting Started` and `Maintaining Momentum` are for ${config.publisherName}, we recommend (re)moving them if this project is going to be made public.

## <br>Credits

$appName began with [Open UI]($openUIProdPage)'s app generation service.

It is free and open source, maintained by [Empathetech LLC](https://www.empathetech.net/).

If you have a dream that wants to be made a reality, try Open UI!
''');

    const String localeDir = 'localized_readme';

    // Make localized dir
    await ezCmd(
      'mkdir $localeDir',
      dir: dir,
      onSuccess: doNothing,
      onFailure: onFailure,
      readout: readout,
    );

    // Spanish
    final File esFile = File('$dir/$localeDir/README.es.md');
    await esFile.writeAsString('''# $appName

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

* [Platform availability](https://github.com/Empathetech-LLC/empathetech_flutter_ui/tree/main/lib/src/widgets/platform_availability): Platform responsive `Widget`s that will help along the way
* [Responsive design](https://github.com/Empathetech-LLC/empathetech_flutter_ui/tree/main/lib/src/widgets/responsive_design): `Widget`s that aid in building responsive UI/UX
* [Screen reader support](https://github.com/Empathetech-LLC/empathetech_flutter_ui/tree/main/lib/src/widgets/screen_reader_support): `Widget`s with streamlined `Semantics`
* [User customization](https://github.com/Empathetech-LLC/empathetech_flutter_ui/tree/main/lib/src/widgets/helpers): Wrapper `Widget`s that respond to `EzConfig` data when the `ThemeData` doesn't cut it

${config.l10nConfig != null ? '''### <br>Localization

aka translation. Add new text to the language files in ${getArbDir(config)} and reference them in the dart code with `${l10nClassName(config)}`

There is a step between: after editing the .arb files, run 
``` bash
flutter gen-l10n
``` 
to generate the new aliases.
''' : ''}
### <br>Integration testing

Has been setup along with a basic runner script; `integration_test/run_int_tests.sh`

<br>P.S. `Getting Started` and `Maintaining Momentum` are for ${config.publisherName}, we recommend (re)moving them if this project is going to be made public.

## <br>Credits

$appName began with [Open UI]($openUIProdPage)'s app generation service.

It is free and open source, maintained by [Empathetech LLC](https://www.empathetech.net/).

If you have a dream that wants to be made a reality, try Open UI!
''');

    // French
    final File frFile = File('$dir/$localeDir/README.fr.md');
    await frFile.writeAsString('''# $appName

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

* [Platform availability](https://github.com/Empathetech-LLC/empathetech_flutter_ui/tree/main/lib/src/widgets/platform_availability): Platform responsive `Widget`s that will help along the way
* [Responsive design](https://github.com/Empathetech-LLC/empathetech_flutter_ui/tree/main/lib/src/widgets/responsive_design): `Widget`s that aid in building responsive UI/UX
* [Screen reader support](https://github.com/Empathetech-LLC/empathetech_flutter_ui/tree/main/lib/src/widgets/screen_reader_support): `Widget`s with streamlined `Semantics`
* [User customization](https://github.com/Empathetech-LLC/empathetech_flutter_ui/tree/main/lib/src/widgets/helpers): Wrapper `Widget`s that respond to `EzConfig` data when the `ThemeData` doesn't cut it

${config.l10nConfig != null ? '''### <br>Localization

aka translation. Add new text to the language files in ${getArbDir(config)} and reference them in the dart code with `${l10nClassName(config)}`

There is a step between: after editing the .arb files, run 
``` bash
flutter gen-l10n
``` 
to generate the new aliases.
''' : ''}
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
  ezLog('pubspec.yaml successfully generated', buffer: readout);
  onSuccess();
}

/// `lib/` and many goodies within
/// Heavily modified from the standard template
Future<void> genLib({
  required EAGConfig config,
  required TargetPlatform platform,
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

  //* Make it so *//

  // Directories //

  await ezCmd(
    platform == TargetPlatform.windows
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
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:go_transitions/go_transitions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

void main() async {
  // Setup the app //

  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(DeviceOrientation.values);

  // Initialize EzConfig //

  final SharedPreferencesAsync preferences = SharedPreferencesAsync();
  EzConfig.init(
    assetPaths: <String>{},
    defaults: ${camelCaseAppName}Config,
    localeFallback: americanEnglish,
    l10nFallback: await EFUILang.delegate.load(americanEnglish),
    preferences: await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(
          allowList: allEZConfigKeys.keys.toSet()),
    ),
  );

  // Run the app //
  
  runApp(const $classCaseAppName());
}

class $classCaseAppName extends StatelessWidget {
  const $classCaseAppName({super.key});

  @override
  Widget build(BuildContext context) {
    // Prep the router //

    GoTransition.defaultCurve = Curves.easeInOut;

    final TargetPlatform currPlatform = getBasePlatform();
    Page<dynamic> getTransition(BuildContext context, GoRouterState state) =>
        ezGoTransition(context, state, EzConfig.animDuration, currPlatform);

    // Return the app //

    return EzAppProvider(
      app: MaterialApp.router(
        debugShowCheckedModeBanner: false,

        // Language handlers
        localizationsDelegates: <LocalizationsDelegate<dynamic>>{
          const LocaleNamesLocalizationsDelegate(),
          ...EFUILang.localizationsDelegates,${l10nDelegateHandler(config)}
        },
        supportedLocales: ${l10nClassName(config) ?? 'EFUILang'}.supportedLocales,
        locale: getStoredLocale(),

        // App title
        title: appName,

        // Router (page) config
        routerConfig: GoRouter(
          initialLocation: homePath,
          errorBuilder: (_, GoRouterState state) => ErrorScreen(state.error),
          routes: <RouteBase>[
            GoRoute(
              path: homePath,
              name: homePath,
              builder: (_, __) => const HomeScreen(),
              pageBuilder: getTransition,
              routes: <RouteBase>[
                GoRoute(
                  path: settingsHomePath,
                  name: settingsHomePath,
                  builder: (_, __) => const SettingsHomeScreen(),
                  pageBuilder: getTransition,
                  routes: <RouteBase>[
                    ${config.colorSettings ? '''GoRoute(
                      path: colorSettingsPath,
                      name: colorSettingsPath,
                      builder: (_, __) => const ColorSettingsScreen(),
                      pageBuilder: getTransition,
                      routes: <RouteBase>[
                        GoRoute(
                          path: EzCSType.quick.path,
                          name: EzCSType.quick.name,
                          builder: (_, __) =>
                              const ColorSettingsScreen(target: EzCSType.quick),
                          pageBuilder: getTransition,
                        ),
                        GoRoute(
                          path: EzCSType.advanced.path,
                          name: EzCSType.advanced.name,
                          builder: (_, __) =>
                              const ColorSettingsScreen(target: EzCSType.advanced),
                          pageBuilder: getTransition,
                        ),
                      ],
                    ),''' : ''}
                    ${config.designSettings ? '''GoRoute(
                      path: designSettingsPath,
                      name: designSettingsPath,
                      builder: (_, __) => const DesignSettingsScreen(),
                      pageBuilder: getTransition,
                    ),''' : ''}
                    ${config.layoutSettings ? '''GoRoute(
                      path: layoutSettingsPath,
                      name: layoutSettingsPath,
                      builder: (_, __) => const LayoutSettingsScreen(),
                      pageBuilder: getTransition,
                    ),''' : ''}
                    ${config.textSettings ? '''GoRoute(
                      path: textSettingsPath,
                      name: textSettingsPath,
                      builder: (_, __) => const TextSettingsScreen(),
                      pageBuilder: getTransition,
                      routes: <RouteBase>[
                        GoRoute(
                          path: EzTSType.quick.path,
                          name: EzTSType.quick.name,
                          builder: (_, __) =>
                              const TextSettingsScreen(target: EzTSType.quick),
                          pageBuilder: getTransition,
                        ),
                        GoRoute(
                          path: EzTSType.advanced.path,
                          name: EzTSType.advanced.name,
                          builder: (_, __) =>
                              const TextSettingsScreen(target: EzTSType.advanced),
                          pageBuilder: getTransition,
                        ),
                      ],
                    ),''' : ''}                     
                  ],
                ),
              ],
            ),
          ],
        ),
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

    // export.dart
    final File utilsExport = File('$dir/lib/utils/export.dart');
    await utilsExport.writeAsString("""$copyright

export 'consts.dart';

${config.l10nConfig != null ? "export '../l10n/${ezClassToSnake(l10nClassName(config)!)}.dart'" : ''};
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

  /// [FloatingActionButton]s to add on top of the [EzUpdaterFAB]
  /// BYO spacing widgets
  final List<Widget>? fabs;

  /// Standardized [Scaffold] for all of the EFUI example app's screens
  const ${classCaseAppName}Scaffold({
    super.key,
    this.title = appName,
    this.showSettings = true,
    required this.body,
    this.fabs,
  });

  @override
  Widget build(BuildContext context) {
    // Gather the fixed theme data //

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

    // Return the build //

    return EzAdaptiveParent(
      small: SelectionArea(
        child: Scaffold(
          // AppBar
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

          // Body
          body: body,

          // FABs
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[updater, if (fabs != null) ...fabs!],
          ),
          floatingActionButtonLocation: EzConfig.isLefty
              ? FloatingActionButtonLocation.startFloat
              : FloatingActionButtonLocation.endFloat,

          // Prevents the keyboard from pushing the body up
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

  const ErrorScreen(this.error, {super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ezWindowNamer(context, '404 \${EzConfig.l10n.gError}');
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ${classCaseAppName}Scaffold(
      body: EzScreen(
        Center(
          child: EzScrollView(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                EzConfig.l10n.g404Wonder,
                style: textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              EzConfig.separator,
              Text(
                EzConfig.l10n.g404,
                style: ezSubTitleStyle(textTheme),
                textAlign: TextAlign.center,
              ),
              EzConfig.separator,
              Text(
                EzConfig.l10n.g404Note,
                style: textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              EzConfig.separator,
            ],
          ),
        ),
        useImageDecoration: false,
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
  ${config.l10nConfig != null ? '''// Gather the fixed theme data //

  late final ${l10nClassName(config)} l10n = ${l10nClassName(config)}.of(context)!;

  ''' : ''}// Define the build data //

  int count = 0;

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

    return ${classCaseAppName}Scaffold(
      title: appName,
      body: EzScreen(
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                ${config.l10nConfig != null ? 'EzConfig.l10n.hsCounterLabel' : 'You have pushed the button this many times:'},
                style: subTitle,
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
      fabs: <Widget>[EzConfig.spacer, CountFAB(() => setState(() => count += 1))],
    );
  }
}
""");

    // settings_home.dart
    final File settingsHome = File(
      '$dir/lib/screens/settings/settings_home.dart',
    );
    await settingsHome.writeAsString("""$copyright

import '../../screens/export.dart';
import '../../utils/export.dart';
import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class SettingsHomeScreen extends StatelessWidget {
  const SettingsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) => ${classCaseAppName}Scaffold(
        title: EzConfig.l10n.ssPageTitle,
        showSettings: false,
        body: const EzScreen(EzSettingsHome(
          colorSettingsPath: ${config.colorSettings ? 'colorSettingsPath,' : 'null,'}
          designSettingsPath: ${config.designSettings ? 'designSettingsPath,' : 'null,'}   
          layoutSettingsPath: ${config.layoutSettings ? 'layoutSettingsPath,' : 'null,'}
          textSettingsPath: ${config.textSettings ? 'textSettingsPath,' : 'null,'}
        )),
        fabs: <Widget>[
          EzConfig.spacer,
          EzConfigFAB(
            context,
            appName: appName,
            androidPackage: androidPackage,
          ),
          EzConfig.spacer,
          const EzBackFAB(showHome: true),
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

  const ColorSettingsScreen({super.key, this.target});

  @override
  Widget build(BuildContext context) => ${classCaseAppName}Scaffold(
        title: EzConfig.l10n.csPageTitle,
        showSettings: false,
        body: EzScreen(EzColorSettings(target: target)),
        fabs: <Widget>[
          EzConfig.spacer,
          EzConfigFAB(
            context,
            appName: appName,
            androidPackage: androidPackage,
          ),
          EzConfig.spacer,
          const EzBackFAB(),
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
  const DesignSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => ${classCaseAppName}Scaffold(
        title: EzConfig.l10n.dsPageTitle,
        showSettings: false,
        body: const EzScreen(EzDesignSettings()),
        fabs: <Widget>[
          EzConfig.spacer,
          EzConfigFAB(
            context,
            appName: appName,
            androidPackage: androidPackage,
          ),
          EzConfig.spacer,
          const EzBackFAB(),
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
  const LayoutSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => ${classCaseAppName}Scaffold(
        title: EzConfig.l10n.lsPageTitle,
        showSettings: false,
        body: const EzScreen(EzLayoutSettings()),
        fabs: <Widget>[
          EzConfig.spacer,
          EzConfigFAB(
            context,
            appName: appName,
            androidPackage: androidPackage,
          ),
          EzConfig.spacer,
          const EzBackFAB(),
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

  const TextSettingsScreen({super.key, this.target});

  @override
  Widget build(BuildContext context) => ${classCaseAppName}Scaffold(
        title: EzConfig.l10n.tsPageTitle,
        showSettings: false,
        body: EzScreen(EzTextSettings(target: target)),
        fabs: <Widget>[
          EzConfig.spacer,
          EzConfigFAB(
            context,
            appName: appName,
            androidPackage: androidPackage,
          ),
          EzConfig.spacer,
          const EzBackFAB(),
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
  required TargetPlatform platform,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
  required ValueNotifier<String> readout,
}) async {
  if (config.l10nConfig == null) return;

  // Gather setup //

  final String snakeName = ezClassToSnake(l10nClassName(config)!);
  final String arbPath = platform == TargetPlatform.windows
      ? getArbDir(config)!.replaceAll('/', '\\')
      : getArbDir(config)!;

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
    await l10nConfig.writeAsString(config.l10nConfig!);
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

/// Skeleton setup to reduce testing friction
Future<void> genIntegrationTests({
  required EAGConfig config,
  required TargetPlatform platform,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
  required ValueNotifier<String> readout,
}) async {
  // Gather Strings //

  final String camelCaseAppName = ezSnakeToCamel(config.appName);
  final String titleCaseAppName = ezSnakeToTitle(config.appName);
  final String classCaseAppName = ezSnakeToClass(config.appName);

  final String copyright = genCopyright(config);

  // Make dir(s) //

  await ezCmd(
    'mkdir test_driver integration_test',
    dir: dir,
    onSuccess: doNothing,
    onFailure: onFailure,
    readout: readout,
  );

  // Make files //

  try {
    // Driver
    final File driver = File('$dir/test_driver/integration_test_driver.dart');
    await driver.writeAsString("""$copyright

import 'package:integration_test/integration_test_driver.dart';

Future<void> main() => integrationDriver();
""");

    // Tests
    final File tests = File('$dir/integration_test/test.dart');
    await tests.writeAsString("""$copyright

import 'package:${config.appName}/main.dart';
import 'package:${config.appName}/utils/export.dart';
import 'package:${config.appName}/widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

void main() async {
  // Setup the test environment //

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();


  final SharedPreferencesAsync preferences = SharedPreferencesAsync();
  EzConfig.init(
    assetPaths: <String>{},
    defaults: ${camelCaseAppName}Config,
    localeFallback: americanEnglish,
    l10nFallback: await EFUILang.delegate.load(americanEnglish),
    preferences: await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(
          allowList: allEZConfigKeys.keys.toSet()),
    ),
  );
  
  // Run the tests //

  group(
    'Generated tests',
    () {
      testWidgets('Test randomizer', (WidgetTester tester) async {
        // Load the app //

        ezLog('Loading $titleCaseAppName');
        await tester.pumpWidget(const $classCaseAppName());
        await tester.pumpAndSettle();

        // Randomize the settings //

        // Open the settings menu
        await ezTouch(tester, find.byIcon(Icons.more_vert));

        // Go to the settings page
        await ezTouchText(tester, EzConfig.l10n.ssPageTitle);

        // Randomize the settings
        await ezTouchText(tester, EzConfig.l10n.ssRandom);
        await ezTouchText(tester, EzConfig.l10n.gYes);

        // Return to home screen
        await ezTapBack(tester, EzConfig.l10n.gBack);
      });

      testWidgets('Test CountFAB', (WidgetTester tester) async {
        // Re-load the app //

        ezLog('Loading $titleCaseAppName');
        await tester.pumpWidget(const $classCaseAppName());
        await tester.pumpAndSettle();

        // ♫ It's as Ez as... ♫ //

        await ezTouch(tester, find.byType(CountFAB)); // 1
        await ezTouch(tester, find.byType(CountFAB)); // 2
        await ezTouch(tester, find.byType(CountFAB)); // 3
      });
    },
  );
}
""");

    String relativeDir() {
      final String? home = Platform.environment['HOME'];

      if (home == null) return dir;

      final List<String> split = dir.split(home);

      return (split.length > 1 ? '$home${split.last}' : split.first).replaceAll(
        ' ',
        '\\ ',
      );
    }

    final File runner = File('$dir/integration_test/run_int_tests.sh');
    await runner.writeAsString('''#!/usr/bin/env bash

set -e

## Setup ##

project_dir="${relativeDir()}"
device=""

# Gather flag variables
while [[ "\$1" != "" ]]; do
  case \$1 in
    -d ) shift
               device="-d \$1"
               ;;
    -p ) shift
              project_dir="\$1"
              ;;
    * ) echo "Invalid input. Aborting."; exit 1
  esac
  shift
done

## Tests ##

flutter drive --driver="\$project_dir/test_driver/integration_test_driver.dart" --target="\$project_dir/integration_test/test.dart" \$device
''');

    await ezCmd(
      platform == TargetPlatform.windows
          ? 'attrib +x integration_test\\run_int_tests.sh'
          : 'chmod a+x integration_test/run_int_tests.sh',
      dir: dir,
      onSuccess: doNothing,
      onFailure: onFailure,
      readout: readout,
    );
  } catch (e) {
    onFailure(e.toString());
  }
  ezLog('Integration test code successfully generated', buffer: readout);
  onSuccess();
}
