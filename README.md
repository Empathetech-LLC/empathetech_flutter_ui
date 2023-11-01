# Empathetech Flutter UI <br><br> Build apps for anyone

EFUI is a holistic foundation for digital accessibility.

EFUI provides a starter kit for every pillar of digital accessibility:
- **Platform availability**
  - Thanks to Flutter, EFUI is fully cross platform! EFUI can build apps for Android, iOS, Linux, MacOS, Windows and Web!
    - Thanks to integration with [Flutter Platform Widgets](https://pub.dev/packages/flutter_platform_Widgets), apps built with EFUI will gracefully adapt to Cupertino (Apple) and Material (Android and beyond) styling
- **Screen reader compliance**
  - All custom Widgets and the example app have been manually verified with [TalkBack](https://support.google.com/accessibility/android/answer/6006598?hl=en) and [VoiceOver](https://support.apple.com/guide/iphone/turn-on-and-practice-voiceover-iph3e2e415f/ios)
- **User customization**
  - The only way to be truly accessible for ALL customers is to empower them with the freedom of choice.<br>EFUI enables you to expose any piece of your app's theme to the user.
    - Users can have full control of theme colors, fonts, styling, spacing, and images.
- **Internationalization**
  - All of EFUI's [external text](./lib/src/l10n/) has been translated to Spanish. With the [infrastructure](./l10n.yaml) for internationalization laid out, the only work left are the translations themselves.
    - Moral fiber moment: Remember that LLMs are a tool for acceleration. But, there's a lot more to winning a race than acceleration. If your translations are generated, disclose that. EFUI's translations started with A.H.I. and ended with [H.I.](#translations)
- **Responsive design**
  - Here's the [definition](https://developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Responsive_Design)
  - Checkout the [demo](#responsive-design) to see it in action

<br>When built with EFUI, your apps can truly reach any audience. Let's make the internet a more accessible place together!

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

And add the following import to any files that use EFUI's library!

```Dart
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
```

## Beginner tutorials

If you're new to Flutter: welcome! The example app is full of comments to help you on your path.

Here are some (unaffilliated!) videos you might also find helpful.

- [First app tutorial](https://www.youtube.com/watch?v=xWV71C2kp38)
- [First app codelab](https://www.youtube.com/watch?v=8sAyPDLorek)
- [Using external packages](https://www.youtube.com/watch?v=WdXcJdhWcEY)

# Usage

## TL;DR

1. a) Add any imports you're missing from the header below to your `main.dart` and<br>b) Initialize [EzConfig](./lib/src/classes/user-customization/EzConfig.dart) in your `void main()`
2. Use an [EzAppProvider](./lib/src/classes/user-customization/EzAppProvider.dart) to build your [PlatformApp](https://pub.dev/documentation/flutter_platform_Widgets/latest/flutter_platform_Widgets/PlatformApp-class.html)<br>OR use [ezThemeData](./lib/src/functions/ezThemeData.dart) in your existing provider/app<br>OR use `EzConfig.instance` data to build your theme
3. Migrate all example app [screens](./example/lib/screens/) to your project
4. Enjoy

## Setup

### Step 1

In your [main.dart](./example/lib/main.dart) add any imports you're missing...

```Dart
import 'utils/utils.dart';
import 'screens/screens.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_platform_Widgets/flutter_platform_Widgets.dart';
```

...and initialize `EzConfig` in your `void main()` Function.

```Dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  EzConfig(
    // Paths to any locally stored images the app uses
    assetPaths: [],

    preferences: prefs,

    // Your brand colors, custom styling, etc
    customDefaults: {},
  );
  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const EFUIExample());
}
```

#### How it works

`EzConfig` gathers all the theme data for our apps. It starts with [Empathetech's config](./lib/src/consts/empathetechConfig.dart) to make sure every key has a value, then it merges in your `customDefaults` and the user's saved [preferences](https://pub.dev/packages/shared_preferences).

Once complete, EzConfig stores the gathered data in a globally accessible [finalized](https://flutterbyexample.com/lesson/const-and-final-variables) instance.

### Step 2

In `main.dart`, use an [EzAppProvider](./lib/src/classes/user-customization/EzAppProvider.dart) to build your [PlatformApp](https://pub.dev/documentation/flutter_platform_Widgets/latest/flutter_platform_Widgets/PlatformApp-class.html)

```Dart
class EFUIExample extends StatelessWidget {
  final Key? key;

  const EFUIExample({this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EzAppProvider(
      app: PlatformApp.router(
        debugShowCheckedModeBanner: false,

        // Supported languages
        supportedLocales: Lang.supportedLocales + EFUILang.supportedLocales,

        // Language handlers
        localizationsDelegates:
            Lang.localizationsDelegates + EFUILang.localizationsDelegates,

        title: "Emapathetech Flutter UI",
        routerConfig: _router,
      ),
    );
  }
}
```

#### How it works

`EzAppProvider` is a [PlatformProvider](https://pub.dev/documentation/flutter_platform_Widgets/latest/flutter_platform_Widgets/PlatformProvider-class.html) wrapper that uses [ezThemeData](./lib/src/functions/ezThemeData.dart) by default.

You are more than welcome to use your own app/app provider with `ezThemeData` for the same effect.

Or, with quite a bit more effort, you can even build your own fully custom base theme with `EzConfig.instance` data.

### Step 3

#### Copy the [settings sandbox](#user-customization)!

The example app is built to be a drop-in solution for your app's settings section.

Copy/paste all the [screen files](./example/lib/screens/) and routes from `main.dart` (below)

```Dart
// Initialize a path based router for web-enabled apps
// Or any other app that requires deep linking
// https://docs.flutter.dev/ui/navigation/deep-linking
final GoRouter _router = GoRouter(
  initialLocation: homeRoute,
  routes: <RouteBase>[
    GoRoute(
      name: homeRoute,
      path: homeRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          name: styleSettingsRoute,
          path: styleSettingsRoute,
          builder: (BuildContext context, GoRouterState state) {
            return const StyleSettingsScreen();
          },
        ),
        GoRoute(
          name: colorSettingsRoute,
          path: colorSettingsRoute,
          builder: (BuildContext context, GoRouterState state) {
            return const ColorSettingsScreen();
          },
        ),
        GoRoute(
          name: imageSettingsRoute,
          path: imageSettingsRoute,
          builder: (BuildContext context, GoRouterState state) {
            return const ImageSettingsScreen();
          },
        ),
      ],
    ),
  ],
);
```

Rename the (just copied) `Home.dart` file and `HomeScreen()` class to something more appropriate; like `Settings.dart` and `SettingsScreen()`. Then, create a link to `SettingsScreen` in your app, and boom!

**It's that Ez!**

#### How it works

The example app's screens neatly organize all the custom Widgets that enable EFUI's user customization!

* [EzThemeModeSwitch](./lib/src/classes/user-customization/EzThemeModeSwitch.dart): A toggle for switching between light, dark, and system theming.
* [EzDominantHandSwitch](./lib/src/classes/user-customization/EzDominantHandSwitch.dart): A toggle for switching common touch points to benefit lefties.
* [EzColorSetting](./lib/src/classes/user-customization/EzColorSetting.dart): A color picker for updating theme colors.
* [EzFontSetting](./lib/src/classes/user-customization/EzFontSetting.dart): A list of available [Google Fonts](https://pub.dev/packages/google_fonts) for the app to use.
* [EzSliderSetting](./lib/src/classes/user-customization/EzSliderSetting.dart): A versatile slider Widget, with a live preview, for updating numerical theme values (spacing, sizing, etc).
* [EzImageSetting](./lib/src/classes/user-customization/EzImageSetting.dart): An image uploader for updating app assets.
* [EzResetButton](./lib/src/classes/user-customization/EzResetButton.dart): A text button for resetting groups of preferences.

By default, every base [theme setting](./lib/src/consts/keys.dart) is exposed. Any keys provided to `customDefaults` can be updated with these Widgets. If there are any theme values you wish to stay constant, simply remove the paired setting Widget.

### Step 4

**Enjoy!**

The pillars of platform availability and user customization are "set it and forget it"; bar any external libraries that break things.

But, as you grow your apps, the other pillars require continuous development.

Thankfully, EFUI's got you covered there too! Check out the...
* [Responsive Widgets](./lib/src/classes/responsive-design/): Widgets that aid in building responsive UI/UXs
* [Accessibility Widgets](./lib/src/classes/accessibility/): Widgets with streamlined semantics and/or Widgets that adapt to accessibilty flags, like `EzDominantHandSwitch` 

and even extension packages, like [efui_video_player](https://github.com/Empathetech-LLC/efui_video_player)!

But, this should be plenty to get you started (and avoid overload). Once you're feeling settled, the code has been organized to aid in exploration!

# Demo

## From the example

### Platform availability

| Android | iOS |
|---|---|
| <img src="./assets/images/home-android.png" alt="Home page on Android" width="250"/> | <img src="./assets/images/home-ios.png" alt="Home page on iOS" width="250"/> |

| Linux | MacOS | Windows |
|---|---|---|
| <img src="./assets/images/home-linux.png" alt="Home page on Linux" width="500"/> | <img src="./assets/images/home-macos.png" alt="Home page on macOS" width="500"/> | <img src="./assets/images/home-windows.png" alt="Home page on Windows" width="500"/> |

| Web |
|---|
| <img src="./assets/images/home-web.png" alt="Home page on Web" width="500"/> |

### Screen reader compliance

<video width="350" controls aria-label="iOS voice over demo">
  <source src="./assets/videos/en-voice-over.mp4" type="video/mp4">
</video>

### User customization

| | | |
|---|---|---|
| <img src="./assets/images/home-ios.png" alt="Core settings example" width="250"/> | <img src="./assets/images/style-settings-ios.png" alt="Style settings example" width="250"/> | <img src="./assets/images/color-settings-ios.png" alt="Color settings example" width="250"/> |
| <img src="./assets/images/image-settings-ios.png" alt="Image settings example" width="250"/> | <img src="./assets/images/font-picker-ios.png" alt="Font picker preview" width="250"/> | <img src="./assets/images/margin-setting-ios.png" alt="Margin setting preview" width="250"/> |
| <img src="./assets/images/circle-setting-ios.png" alt="Circle setting preview" width="250"/> | <img src="./assets/images/color-picker-ios.png" alt="Color picker preview" width="250"/> | <img src="./assets/images/update-image-ios.png" alt="Update image preview" width="250"/> |

### Internationalization

| | | | |
|---|---|---|---|
| <img src="./assets/images/es-home-ios.png" alt="Core settings in Spanish" width="250"/> | <img src="./assets/images/es-style-settings-ios.png" alt="Style settings in Spanish" width="250"/> | <img src="./assets/images/es-color-settings-ios.png" alt="Color settings in Spanish" width="250"/> | <img src="./assets/images/es-image-settings-ios.png" alt="Image settings in Spanish" width="250"/> |

**Screen reader semantics are also internationalized!**

### Responsive design

Checkout the link to our site below. If you're using a monitor, play around with the window size! Using a phone or tablet? Rotate your device!

## Live

* [Company site](https://www.empathetech.net/#/settings)
  * [Source code](https://github.com/Empathetech-LLC/dotnet-public)

# Contributing

## The vibes!

If you build something with EFUI, let us know! We'd love to have a third-party live section

## Time

Please reach out to the [community](mailto:community@empathetech.net?subject=Becoming%20a%20contributor) contact about becoming a contributor. Emapthetech LLC doesn't tend to run out of ideas, only time! Here are a few current...

### Planned features

- More languages! If you speak English and a currently unsupported language, please reach out!
- More EzWidgets with required and/or preconfigured semantics
- Querying [GoogleFonts](https://pub.dev/packages/google_fonts) rather than relying on a predetermined [list](./lib/src/consts/googleFonts.dart)

## Money

Many thanks for any and all donations! We're happy to have helped!

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

* [Flutter Platform Widgets](https://pub.dev/packages/flutter_platform_Widgets)
* [Flutter Colorpicker](https://pub.dev/packages/flutter_colorpicker)

And, of course, all the awesome Flutter (Google) devs.
