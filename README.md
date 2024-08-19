# Empathetech Flutter UI <br><br> Build apps for anyone
[![en](https://img.shields.io/badge/lang-en-blue.svg)](https://github.com/Empathetech-LLC/empathetech_flutter_ui/blob/main/README.md)
[![es](https://img.shields.io/badge/lang-es-red.svg)](https://github.com/Empathetech-LLC/empathetech_flutter_ui/blob/main/README.es.md)
[![fr](https://img.shields.io/badge/lang-fr-white.svg)](https://github.com/Empathetech-LLC/empathetech_flutter_ui/blob/main/README.fr.md)

EFUI is a starter kit for building [Flutter](https://flutter.dev/) apps with a solid foundation in every aspect of digital accessibility:

- **Platform availability**
  - Thanks to Flutter, EFUI is fully cross platform! You can use EFUI to create on Android, iOS, Linux, MacOS, Windows and Web!
    - Thanks to integration with [Flutter Platform Widgets](https://pub.dev/packages/flutter_platform_widgets), apps built with EFUI will gracefully adapt to Cupertino (Apple) styling
- **Responsive design**
  - Here's the [definition](https://developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Responsive_Design)
  - Checkout the [demo](#live) to see it in action
- **Screen reader support**
  - All custom Widgets and the example app have been manually verified with [TalkBack](https://support.google.com/accessibility/android/answer/6006598?hl=en) and [VoiceOver](https://support.apple.com/guide/iphone/turn-on-and-practice-voiceover-iph3e2e415f/ios)
- **User customization**
  - The only way to be truly accessible for ALL customers is to empower them with the freedom of choice.
    - EFUI exposes every aspect of an app's theme to be controlled by the user.
- **Internationalization**
  - All of EFUI's [external text](./lib/src/l10n/) has been translated to Spanish and French. Alongside the [infrastructure](./l10n.yaml) for unlimited future translations.
    - Moral fiber moment: Remember that LLMs are a tool for acceleration. But, there's a lot more to winning a race than acceleration. If your translations are generated, disclose that. EFUI's translations started with A.H.I. and ended with [H.I.](#translations)

<br>When built with EFUI, your apps can truly reach any audience. Let's make the internet a better place together!

## Table of Contents

* [Installation](#installation)
* [Usage](#usage)
* [Demo](#demo)
* [Contributing](#contributing)
* [License](#license)
* [Credits](#credits)

# Installation

In your app's base directory, run

```bash
flutter pub add empathetech_flutter_ui
```

And add the following import to any files that use EFUI's library

```Dart
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
```

## Beginner tutorials

If you're new to Flutter: welcome! EFUI is full of comments to help you on your path.

Here are some (unaffiliated) videos you might also find helpful.

- [First app tutorial](https://www.youtube.com/watch?v=xWV71C2kp38)
- [First app code lab](https://www.youtube.com/watch?v=8sAyPDLorek)
- [Using external packages](https://www.youtube.com/watch?v=WdXcJdhWcEY)

# Usage

## TL;DR

--- Required ---
1. Initialize [EzConfig](./lib/src/classes/config.dart) in `void main()`
2. Use [EzAppProvider](./lib/src/classes/platform_availability/app_provider.dart) to build a [PlatformApp](https://pub.dev/documentation/flutter_platform_widgets/latest/flutter_platform_widgets/PlatformApp-class.html)<br>  - OR use [ezThemeData](./lib/src/functions/theme_data.dart) in any existing provider/app<br>  - OR use `EzConfig` to build a custom `ThemeData`

<br>--- Recommended ---
1. Copy the [settings sandbox](./example/lib/screens/) to your project
2. Enjoy

## Setup

### Step 1

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

### Step 2

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

### Step 3

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
            return const SettingsScreen();
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

*NOTE:* The above code snippet assumes you renamed the (just copied) `Home.dart` file and `HomeScreen()` class to `Settings.dart` and `SettingsScreen()`

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

### Step 4

#### Enjoy!

The pillars of **platform availability** and **user customization** are "set it and forget it"; bar any external libraries that break things.

But, as you grow your apps, the other pillars require continuous development.

Thankfully, EFUI's got you covered there too!
* [Responsive design](./lib/src/classes/responsive_design/): Widgets that aid in building responsive UI/UX
* [Screen reader support](./lib/src/classes/screen_reader_support/): Widgets with streamlined semantics

<br>At the risk of information overload, that should be plenty to get you started. Once you're feeling settled, the repo has been organized to aid in exploration!

# Demo

### [Android](https://play.google.com/store/apps/details?id=net.empathetech.open_ui)
### [iOS](https://apps.apple.com/us/app/open-ui/id6499560244)
### [Linux](https://github.com/Empathetech-LLC/empathetech_flutter_ui/releases)
### [MacOS](https://apps.apple.com/us/app/open-ui/id6499560244)
### [Windows](https://github.com/Empathetech-LLC/empathetech_flutter_ui/releases)
### [Web](https://www.empathetech.net/#/settings)

# Contributing

## The vibes!

If you build something with EFUI, let us know!

## Time

Please reach out to the [community](mailto:community@empathetech.net?subject=Becoming%20a%20contributor) contact about becoming a contributor. There's never a shortage of ideas, only time!

### Translations

If you speak English and a currently unsupported language, please reach out! The more the merrier.

OR: If you speak English and a currently supported language, and see something wrong, please reach out! It takes a village.

## Money

Many thanks for any and all donations!

### Paypal

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/donate/?hosted_button_id=NGEL6AB5A6KNL)

### [Venmo](https://venmo.com/empathetech)

### [Cash App](https://cash.app/$empathetech)

### [Patreon](https://patreon.com/empathetech)

### [Buy Me a Coffee](https://www.buymeacoffee.com/empathetech)

### [Ko-fi](https://ko-fi.com/empathetech)

# License

[GNU GPLv3](LICENSE)

# Credits

## Translations

Thank you to [M Ramirez](https://www.linkedin.com/in/mauro-ramirez-rivas) for verifying EFUI's [Spanish](./lib/src/l10n/efui_es.arb) translations!

## Flutter OSS

EFUI wouldn't be as awesome as it is without these other awesome community projects...

* [Country flags](https://pub.dev/packages/country_flags)
* [Feedback](https://pub.dev/packages/feedback)
* [Flex color picker](https://pub.dev/packages/flex_color_picker)
* [Localized locales](https://pub.dev/packages/flutter_localized_locales)
* [Flutter platform widgets](https://pub.dev/packages/flutter_platform_widgets)
* [Provider](https://pub.dev/packages/provider)
* [Share plus](https://pub.dev/packages/share_plus)

And, of course, all the awesome Flutter devs...

* [Google fonts](https://pub.dev/packages/google_fonts)
* [Image picker](https://pub.dev/packages/image_picker)
* [go_router](https://pub.dev/packages/go_router)
* [path](https://pub.dev/packages/path)
* [path provider](https://pub.dev/packages/path_provider)
* [Shared preferences](https://pub.dev/packages/shared_preferences)
* [URL launcher](https://pub.dev/packages/url_launcher)
