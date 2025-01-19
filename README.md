# Empathetech Flutter UI <br><br> Build apps for anyone
[![en](https://img.shields.io/badge/lang-en-blue.svg)](https://github.com/Empathetech-LLC/empathetech_flutter_ui/blob/main/README.md)
[![es](https://img.shields.io/badge/lang-es-red.svg)](https://github.com/Empathetech-LLC/empathetech_flutter_ui/blob/main/localized_readme/README.es.md)
[![fr](https://img.shields.io/badge/lang-fr-white.svg)](https://github.com/Empathetech-LLC/empathetech_flutter_ui/blob/main/localized_readme/README.fr.md)

<br>EFUI is a [Flutter](https://flutter.dev/) library for building highly accessible apps. EFUI simplifies...

- **Platform availability**
  - Thanks to Flutter, you can use EFUI to create on Android, iOS, Linux, MacOS, Windows and Web!
    - EFUI uses [Flutter Platform Widgets](https://pub.dev/packages/flutter_platform_widgets), so apps will gracefully adapt to Cupertino (Apple) styling.
- **Responsive design**
  - Here's the [definition](https://developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Responsive_Design).
  - Checkout [our site](https://www.empathetech.net/#/contribute) to see it in action.
- **Screen reader support**
  - Empathetech code is manually verified with [TalkBack](https://support.google.com/accessibility/android/answer/6006598?hl=en) and [VoiceOver](https://support.apple.com/guide/iphone/turn-on-and-practice-voiceover-iph3e2e415f/ios).
- **User customization**
  - The only way to be truly accessible for ALL customers is to empower them with the freedom of choice!
    - EFUI provides an elegant UX for full control of an app's appearance.
- **Internationalization**
  - All of EFUI's [external text](./lib/src/l10n/) has been translated to Spanish and French. Alongside the [infrastructure](./l10n.yaml) for unlimited future translations.
    - Moral fiber moment: Remember that LLMs are a tool for acceleration. But, there's a lot more to a great car than just acceleration! If your translations are generated: disclose that. EFUI's translations started with A.I. and ended with [H.I.](#translations)
- **Cost**
  - While we encourage [contributions](#contributing), EFUI is completely free and [open source](LICENSE).
  - [Open UI](#usage) can also get you started with a professionally polished, empathetic app in one click\*
    - \*if you already have Flutter installed. A few more clicks if not.

<br>When built with EFUI, your apps can truly reach any audience. Let's make the internet a better place together!

## <br>Table of Contents

* [Usage](#usage)
* [Contributing](#contributing)
* [License](#license)

# <br>Usage 

## **Open UI**

Is an app generator. It is available everywhere, and can give your idea an accessible, production ready foundation with one click.

&nbsp;&nbsp;&nbsp;[Android](https://play.google.com/store/apps/details?id=net.empathetech.open_ui)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;[iOS](https://apps.apple.com/us/app/open-ui/id6499560244)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;[Linux (deb)](https://github.com/Empathetech-LLC/empathetech_flutter_ui/releases/download/8.0.0/open-ui-linux.deb)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;[Linux (rpm)](https://github.com/Empathetech-LLC/empathetech_flutter_ui/releases/download/8.0.0/open-ui-linux.rpm)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;[MacOS](https://github.com/Empathetech-LLC/empathetech_flutter_ui/releases/download/8.0.0/open-ui-mac.zip)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;[Windows](https://github.com/Empathetech-LLC/empathetech_flutter_ui/releases/download/8.0.0/open-ui-windows.exe)

<br>*Mobile platforms simply save a configuration file that can be used on the Desktop app generator(s). Just ne-click for loading configs too!

### <br>Beginner tutorials

If you're new to Flutter: welcome! EFUI is full of doc comments to help you on your path.

Here are some (unaffiliated) videos you might also find helpful.

- [First app tutorial](https://www.youtube.com/watch?v=xWV71C2kp38)
- [First app code lab](https://www.youtube.com/watch?v=8sAyPDLorek)
- [Using external packages](https://www.youtube.com/watch?v=WdXcJdhWcEY)

## <br>Integrating EFUI with existing projects 

### TL;DR

--- Required ---
1. Initialize [EzConfig](./lib/src/classes/config.dart) in `void main()`
2. Use [EzAppProvider](./lib/src/classes/platform_availability/app_provider.dart) to build a [PlatformApp](https://pub.dev/documentation/flutter_platform_widgets/latest/flutter_platform_widgets/PlatformApp-class.html)<br>  - OR use [ezThemeData](./lib/src/functions/theme_data.dart) in any existing provider/app<br>  - OR use `EzConfig`s data when building your `ThemeData`

--- Recommended ---
1. Copy the [settings sandbox](./example/lib/screens/) to your project
2. Enjoy

### <br>Step 0

In your app's base directory, run

```bash
flutter pub add empathetech_flutter_ui
```

And add the following import to any files that use EFUI's library

```Dart
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
```

### <br>Step 1

#### Initialize [EzConfig](./lib/src/classes/config.dart) in `void main()`

```Dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  EzConfig.init(
    // Paths to any locally stored images the app uses
    assetPaths: {},

    preferences: prefs,

    // Your brand colors, custom styling, etc
    defaults: empathetechConfig, // is an optional starter
  );
  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const YourApp());
}
```

#### How it works

`EzConfig` gathers and stores the app's theme data, merging your `customDefaults` with the user's saved [preferences](https://pub.dev/packages/shared_preferences).

Once gathered, `EzConfig` stores the data in a Singleton instance for efficient access. `EzConfig` has a series of getter and setter methods for safe interactions with the theme data.

### <br>Step 2

#### Use [EzAppProvider](./lib/src/classes/platform_availability/app_provider.dart) to build a [PlatformApp](https://pub.dev/documentation/flutter_platform_widgets/latest/flutter_platform_widgets/PlatformApp-class.html)

```Dart
class YourApp extends StatelessWidget {
  const YourApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EzAppProvider(
      app: PlatformApp.router(
        debugShowCheckedModeBanner: false,

        // Language handlers
        localizationsDelegates: {
          LocaleNamesLocalizationsDelegate(),
          ...EFUILang.localizationsDelegates,
          YourAppFeedbackLocalizationsDelegate,
        },

        // Supported languages
        supportedLocales: EFUILang.supportedLocales,ß

        // Current language
        locale: EzConfig.getLocale(),

        title: yourAppTitle,
        routerConfig: yourAppRouter,
      ),
    );
  }
}
```

#### How it works

`EzAppProvider` is a [PlatformProvider](https://pub.dev/documentation/flutter_platform_Widgets/latest/flutter_platform_Widgets/PlatformProvider-class.html) wrapper that uses [ezThemeData](./lib/src/functions/theme_data.dart) by default.

`ezThemeData` sets up the dynamic color scheme and text theme, and updates some touch points to be higher contrast by default.

You are more than welcome to use your own app/app provider with `ezThemeData` for the same effect.

Or, you can even build your own fully custom base theme with `EzConfig` data.

### <br>Step 3

#### Copy the [settings sandbox](./example/lib/screens/) to your project

The example app is built to be a drop-in solution for your apps' settings.

Copy/paste all the [screen files](./example/lib/screens/) and make paths to them in your apps' routes.

Example `GoRouter` setup...
```Dart
/// A path based router for web-enabled apps
final GoRouter _yourAppRouter = GoRouter(
  initialLocation: homePath,
  routes: <RouteBase>[
    GoRoute(
      path: homePath,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: routes:<RouteBase>[
        /// ...all of your pre/soon to be existing Routes
        GoRoute(
          path: settingsRoute,
          builder: (BuildContext context, GoRouterState state) {
            return const SettingsHomeScreen();
          },
          routes:<RouteBase>[
            GoRoute(
              path: textSettingsPath,
              builder: (BuildContext context, GoRouterState state) {
                return const TextSettingsScreen();
              },
            ),
            GoRoute(
              path: layoutSettingsPath,
              builder: (BuildContext context, GoRouterState state) {
                return const LayoutSettingsScreen();
              },
            ),
            GoRoute(
              path: colorSettingsPath,
              builder: (BuildContext context, GoRouterState state) {
                return const ColorSettingsScreen();
              },
            ),
            GoRoute(
              path: imageSettingsPath,
              builder: (BuildContext context, GoRouterState state) {
                return const ImageSettingsScreen();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
```

And boom!

**It's that Ez!**

*NOTE:* The above code snippet assumes you renamed the (just copied) `Home.dart` file and `HomeScreen()` class to `Settings.dart` and `SettingsHomeScreen()`

#### How it works

The example app's screens neatly organize all the custom Widgets that enable EFUI's user customization!

* [EzDominantHandSwitch](./lib/src/classes/user_customization/dominant_hand_switch.dart): A toggle for switching common touch points to benefit lefties.
* [EzThemeModeSwitch](./lib/src/classes/user_customization/theme_mode_swtich.dart): A toggle menu for selecting the app's theme: light, dark, system.
* [EzLocaleSetting](./lib/src/classes/user_customization/local_setting.dart): A menu for updating the app's language. EFUI currently supports English, Spanish, and French.
* [TextSettings](./lib/src/classes/user_customization/text_style/): A collection of custom Widgets for controlling the app's TextStyles.
* [EzLayoutSetting](./lib/src/classes/user_customization/layout_setting.dart): A dynamic slider Widget, with live previews, for updating the app's layout: margin, padding, and spacing.
* [EzColorSetting](./lib/src/classes/user_customization/color_setting.dart): A color picker for updating each entry in the app's ColorScheme.
* [EzImageSetting](./lib/src/classes/user_customization/image_setting.dart): An image picker for updating app assets.
* [EzResetButton](./lib/src/classes/user_customization/reset_button.dart): A customizable button for resetting groups of preferences.

By default, every base [theme setting](./lib/src/consts/config_keys.dart) is exposed. Additional keys provided to `customDefaults` can be updated with these Widgets as well!

If there are any theme values you wish to stay constant, simply remove the paired setting Widget(s).

### <br>Step 4

#### Enjoy!

The pillars of **platform availability** and **user customization** are "set it and forget it"; bar any external libraries that break things.

But, as you grow your apps, the other pillars require continuous development.

Thankfully, EFUI's got you covered there too!
* [Responsive design](./lib/src/classes/responsive_design/): Widgets that aid in building responsive UI/UX
* [Screen reader support](./lib/src/classes/screen_reader_support/): Widgets with streamlined semantics

<br>At the risk of information overload, that should be plenty to get you started. Once you're feeling settled, the repo has been organized to aid in exploration!

# <br>Contributing

## The vibes!

If you build something with EFUI, let us know!

## <br>Time

Please reach out to the [community](mailto:community@empathetech.net?subject=Becoming%20a%20contributor) contact about becoming a contributor. There's never a shortage of ideas, only time!

### Translations

If you speak English and a currently unsupported language, please reach out! The more the merrier.

OR: If you speak English and a currently supported language, and see something wrong, please reach out! It takes a village.

## <br>Money

Many thanks for any and all donations!

&nbsp;&nbsp;&nbsp;[GoFundMe](https://gofund.me/c047d07e)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;[Patreon](https://patreon.com/empathetech)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;[Buy Me a Coffee](https://www.buymeacoffee.com/empathetech)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;[Ko-fi](https://ko-fi.com/empathetech)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;[PayPal](https://www.paypal.com/donate/?hosted_button_id=NGEL6AB5A6KNL)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;[Venmo](https://venmo.com/empathetech)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;[Cash App](https://cash.app/$empathetech)

# <br>License

[GNU GPLv3](LICENSE)