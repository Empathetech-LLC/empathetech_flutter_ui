/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../structs/export.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

/// Slightly modified from the standard template README
/// Mostly with Empathetech LLC stuff TODO: Finish this
Future<void> genREADME({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
}) =>
    ezCLI(
      exe: 'echo',
      args: <String>[
        '''# ${config.appName}

A new empathetic Flutter project.

## Getting Started

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [EFUI: Digital accessibility made Ez](https://github.com/Empathetech-LLC/empathetech_flutter_ui)

## Maintaining Momentum

Thanks for using Open UI!

P.S. `Getting Started` and `Maintaining Momentum` are for ${config.publisherName}, we recommend removing them if this project is going to be public.

## Credits

${config.appName} began with [Open UI](https://github.com/Empathetech-LLC/empathetech_flutter_ui/releases)'s app generation service.

It is free and open source, maintained by Empathetech LLC.
''',
        '>',
        'README.md',
      ],
      dir: dir,
      onSuccess: onSuccess,
      onFailure: onFailure,
    );

/// APP_VERSION and CHANGELOG.md
Future<void> genVersionTracking({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
}) async {
  await ezCLI(
    exe: 'echo',
    args: <String>['1.0.0', '>', 'APP_VERSION'],
    dir: dir,
    onSuccess: onSuccess,
    onFailure: onFailure,
  );

  await ezCLI(
    exe: 'echo',
    args: <String>[
      'BLARG',
      '>',
      'CHANGELOG.md',
    ],
    dir: dir,
    onSuccess: onSuccess,
    onFailure: onFailure,
  );
}

/// LICENSE
Future<void> genLicense({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
}) =>
    ezCLI(
      exe: 'echo',
      args: <String>[config.license, '>', 'LICENSE'],
      dir: dir,
      onSuccess: onSuccess,
      onFailure: onFailure,
    );

/// pubspec.yaml TODO: https://pub.dev/help/api
Future<void> genPubspec({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
}) =>
    ezCLI(
      exe: 'echo',
      args: <String>[
        '''name: example
description: "Open UI is a sandbox application that demonstrates the power of an Empathetech UI. If you like Open UI, check out https://github.com/Empathetech-LLC/empathetech_flutter_ui"
version: 1.5.2+14
publish_to: 'none'

environment:
  sdk: ^3.6.0

dependencies:
  flutter:
    sdk: flutter

  # Flutter (Google)
  go_router: ^14.6.2
  http: ^1.2.2
  shared_preferences: ^2.3.4
  url_launcher: ^6.3.1

  # Community
  feedback: ^3.1.0
  file_picker: ^8.1.7
  file_saver: ^0.2.14
  flutter_localized_locales: ^2.0.5
  flutter_platform_widgets: ^7.0.1
  line_icons: ^2.0.3

  empathetech_flutter_ui:
    path: ../
  efui_bios:
    path: ../../efui_bios

dev_dependencies:
  dependency_validator: ^4.1.2
  flutter_launcher_icons: ^0.14.2
  flutter_lints: ^5.0.0
  flutter_native_splash: ^2.4.4
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter

flutter:
  generate: true # For l10n
  uses-material-design: true

  assets:
    - assets/
    - assets/fonts/
    - assets/fonts/Roboto-Black.ttf
    - assets/fonts/Roboto-BlackItalic.ttf
    - assets/fonts/Roboto-Bold.ttf
    - assets/fonts/Roboto-BoldItalic.ttf
    - assets/fonts/Roboto-Italic.ttf
    - assets/fonts/Roboto-Light.ttf
    - assets/fonts/Roboto-LightItalic.ttf
    - assets/fonts/Roboto-Medium.ttf
    - assets/fonts/Roboto-MediumItalic.ttf
    - assets/fonts/Roboto-Regular.ttf
    - assets/fonts/Roboto-Thin.ttf
    - assets/fonts/Roboto-ThinItalic.ttf
    - assets/images/
    - assets/images/settings-sandbox.jpg
    - assets/images/settings-sandbox-round.png

flutter_launcher_icons:
  image_path: assets/images/settings-sandbox.jpg
  adaptive_icon_foreground: assets/images/settings-sandbox-round.png
  adaptive_icon_background: "#F5F5F5"
  android: true
  ios: true
  remove_alpha_ios: true
  web:
    generate: true
  windows:
    generate: true
  macos:
    generate: true

flutter_native_splash:
  color: "#F5F5F5"
  image: assets/images/settings-sandbox.jpg
  android: true
  ios: true
  web: true
''',
        '>',
        'pubspec.yaml',
      ],
      dir: dir,
      onSuccess: onSuccess,
      onFailure: onFailure,
    );

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
    0,
    config.appName[0].toUpperCase(),
  );

  final String humanCaseAppName = config.appName
      .replaceAllMapped(
        RegExp(r'_(\w)'),
        (Match match) => ' ${match.group(1)!.toUpperCase()}',
      )
      .replaceRange(
        0,
        0,
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

  // Make directories //

  await ezCLI(
    exe: 'mkdir',
    args: <String>['lib', 'lib/utils', 'lib/widgets', 'lib/screens'],
    dir: dir,
    onSuccess: onSuccess,
    onFailure: onFailure,
  );

  //// Make files ////

  // main.dart
  await ezCLI(
    exe: 'echo',
    args: <String>[
      """$copyright

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
""",
      '>',
      'lib/main.dart',
    ],
    dir: dir,
    onSuccess: onSuccess,
    onFailure: onFailure,
  );

  // utils //

  // consts.dart
  await ezCLI(
    exe: 'echo',
    args: <String>[
      """$copyright

/// $humanCaseAppName
const String appTitle = '$humanCaseAppName';
""",
      '>',
      'lib/utils/consts.dart',
    ],
    dir: dir,
    onSuccess: onSuccess,
    onFailure: onFailure,
  );

  // export.dart
  await ezCLI(
    exe: 'echo',
    args: <String>[
      """$copyright

export 'consts.dart';
""",
      '>',
      'lib/utils/export.dart',
    ],
    dir: dir,
    onSuccess: onSuccess,
    onFailure: onFailure,
  );

  // widgets //

  // fabulous.dart

  // menu_buttons.dart

  // scaffold file

  // export.dart
  await ezCLI(
    exe: 'echo',
    args: <String>[
      """$copyright

export 'fabulous.dart';
export 'menu_buttons.dart';
export '${config.appName}_scaffold.dart';
""",
      '>',
      'lib/widgets/export.dart',
    ],
    dir: dir,
    onSuccess: onSuccess,
    onFailure: onFailure,
  );

  // screens //

  // error.dart
  await ezCLI(
    exe: 'echo',
    args: <String>[
      """$copyright

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
""",
      '>',
      'lib/screens/error.dart',
    ],
    dir: dir,
    onSuccess: onSuccess,
    onFailure: onFailure,
  );

  // home_screen.dart
  await ezCLI(
    exe: 'echo',
    args: <String>[
      """BLARG""",
      '>',
      'lib/screens/home.dart',
    ],
    dir: dir,
    onSuccess: onSuccess,
    onFailure: onFailure,
  );

  // text_settings_screen.dart?
  await ezCLI(
    exe: 'echo',
    args: <String>[
      """BLARG""",
      '>',
      'lib/BLARG/BLARG.dart',
    ],
    dir: dir,
    onSuccess: onSuccess,
    onFailure: onFailure,
  );

  // layout_settings_screen.dart?
  await ezCLI(
    exe: 'echo',
    args: <String>[
      """BLARG""",
      '>',
      'lib/BLARG/BLARG.dart',
    ],
    dir: dir,
    onSuccess: onSuccess,
    onFailure: onFailure,
  );

  // color_settings_screen.dart?
  await ezCLI(
    exe: 'echo',
    args: <String>[
      """BLARG""",
      '>',
      'lib/BLARG/BLARG.dart',
    ],
    dir: dir,
    onSuccess: onSuccess,
    onFailure: onFailure,
  );

  // image_settings_screen.dart?
  await ezCLI(
    exe: 'echo',
    args: <String>[
      """BLARG""",
      '>',
      'lib/BLARG/BLARG.dart',
    ],
    dir: dir,
    onSuccess: onSuccess,
    onFailure: onFailure,
  );

  // export.dart
  await ezCLI(
    exe: 'echo',
    args: <String>[
      """$copyright

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
""",
      '>',
      'lib/screens/export.dart',
    ],
    dir: dir,
    onSuccess: onSuccess,
    onFailure: onFailure,
  );
}

/// Localizations config
Future<void> genL10n({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
}) =>
    ezCLI(
      exe: 'echo',
      args: <String>[
        config.l10nConfig ?? 'null',
        '>',
        'l10n.yaml',
      ],
      dir: dir,
      onSuccess: onSuccess,
      onFailure: onFailure,
    );

/// analysis_options.yaml
Future<void> genAnalysis({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
}) =>
    ezCLI(
      exe: 'echo',
      args: <String>[
        config.analysisOptions ?? 'null',
        '>',
        'analysis_options.yaml'
      ],
      dir: dir,
      onSuccess: onSuccess,
      onFailure: onFailure,
    );

/// Launch config
Future<void> genVSCode({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
}) async {
  // Make dir
  await ezCLI(
    exe: 'mkdir',
    args: <String>['.vscode'],
    dir: dir,
    onSuccess: onSuccess,
    onFailure: onFailure,
  );

  // Make file
  await ezCLI(
    exe: 'echo',
    args: <String>[
      config.vsCodeConfig ?? 'null',
      '>',
      '.vscode/launch.json',
    ],
    dir: dir,
    onSuccess: onSuccess,
    onFailure: onFailure,
  );
}

/// Skeleton setup to reduce testing friction
Future<void> genIntegrationTests({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
}) async {
  ezLog("I don't do anything... yet!\nAlso: BLARG");
  // test_driver
  // integration_test
}
