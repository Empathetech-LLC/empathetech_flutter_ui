# Empathetech Flutter UI <br><br> Build apps for anyone

EFUI is a holistic foundation for digital accessibility.

EFUI provides a starter kit for every aspect of digital accessibility:
- **Platform availability**
  - Thanks to Flutter, EFUI is fully cross platform! EFUI can build apps for Android, iOs, Linux, MacOS, Windows and Web!
    - Thanks to integration with [Flutter Platform Widgets](https://pub.dev/packages/flutter_platform_widgets), apps built with EFUI will gracefully adapt to Cupertino (Apple) and Material (Android and beyond) styling
- **Screen reader compliance**
  - The [example app](./example/lib/screens/) and all [custom widgets](./lib/src/classes/) have been manually verified with [TalkBack](https://support.google.com/accessibility/android/answer/6006598?hl=en) and [VoiceOver](https://support.apple.com/guide/iphone/turn-on-and-practice-voiceover-iph3e2e415f/ios)
- **User customization**
  - The only way to be truly accessible for ALL customers is to empower them with the freedom of choice.<br>EFUI enables you to expose any aspect of your app's theme to the user.
    - Users can have full control of theme colors, fonts, styling, spacing, and images.
- **Internationalization**
  - The [example app](./example/lib/l10n/) and all [custom widgets](./lib/src/l10n/) have been translated into Spanish. With the [infrastructure](./l10n.yaml) for internationalization layed out, the only work left are the translations themselves.
    - Moral fiber moment: Remember that LLMs are a tool for acceleration. But, there's a lot more to winning a race than acceleration. If your translations are A.H.I. generated, say that. EFUIs translations started with A.H.I. and ended with [H.I.](LINK_HERE)
- **Responsive design**
  - [Readers](https://developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Responsive_Design)
  - [Visual learners](https://www.empathetech.net/#/contribute)

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

If you're new to Flutter: welcome! The [example app](./example/lib/) is full of comments to help you on your path.

Here are some (unafilliated!) videos you might also find helpful.

- [First app tutorial](https://www.youtube.com/watch?v=xWV71C2kp38)
- [First app codelab](https://www.youtube.com/watch?v=8sAyPDLorek)
- [Using external packages](https://www.youtube.com/watch?v=WdXcJdhWcEY)

# Usage

## TL;DR

1. a) Add any imports you're missing from the header below to your `main.dart` and<br>b) Initialize [EzConfig](./lib/src/classes/EzConfig.dart) in your `void main()` to setup the user customizable [theme data](./lib/src/functions/ezThemeData.dart)
2. Use [EzAppProvider](./lib/src/classes/EzAppProvider.dart) to build your [PlatformApp](https://pub.dev/documentation/flutter_platform_widgets/latest/flutter_platform_widgets/PlatformApp-class.html)
3. a) Copy/paste all example app [screens](./example/lib/screens/) and [.arbs](./example/lib/l10n/) to your app and<br>b) Rename `Home.dart` to `Settings.dart` (personal preference) and add a route to it in your app
4. Enjoy

## Setup

### Step 1

In your [main.dart](./example/lib/main.dart) add any imports you're missing

```Dart
import 'l10n/app_localizations.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
```

And initialize [EzConfig](./lib/src/classes/EzConfig.dart) in your  `void main()` Function.

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

[EzConfig](./lib/src/classes/EzConfig.dart) starts with [Empathetech's config](./lib/src/consts/empathetechConfig.dart) to make sure everything is populated. Then it merges in your custom data and the user's [preferences](https://pub.dev/packages/shared_preferences). The [finalized](https://flutterbyexample.com/lesson/const-and-final-variables) instance is then used to create a finalized [theme data](./lib/src/functions/ezThemeData.dart)

### Step 2

In [main.dart](./example/lib/main.dart), use an [EzAppProvider](./lib/src/classes/EzAppProvider.dart) to build your [PlatformApp](https://pub.dev/documentation/flutter_platform_widgets/latest/flutter_platform_widgets/PlatformApp-class.html)

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
        supportedLocales: AppLocalizations.supportedLocales + EFUILocalizations.supportedLocales,

        // Language handlers
        localizationsDelegates:
            AppLocalizations.localizationsDelegates + EFUILocalizations.localizationsDelegates,

        title: "Emapathetech Flutter UI",
        routerConfig: _router,
      ),
    );
  }
}
```

### Step 3

Copy the [settings sandbox](#demo)!

These screens neatly organize all the custom widgets that enable

* [EzThemeModeSwitch](lib/src/classes/EzThemeModeSwitch.dart): A toggle for users to switch between light, dark, or system theming.
* [EzDominantHandSwitch](lib/src/classes/EzDominantHandSwitch.dart): Moves common touch points to benefit lefty's when they want it!
* [EzColorSetting](lib/src/classes/EzColorSetting.dart): A user-friendly color picker to update theme colors.
* [EzFontSetting](lib/src/classes/EzFontSetting.dart): An interface for users to select their preferred font from a predefined list.
* [EzSliderSetting](lib/src/classes/EzSliderSetting.dart): A versatile slider widget for numerical customizations of many kinds (margin, padding, spacing, etc).
* [EzImageSetting](lib/src/classes/EzImageSetting.dart): A user-friendly image uploader to update app assets.

#### [See them in action](https://www.empathetech.net/#/settings)

By default, every base [theme setting](./lib/src/consts/sharedPreferences.dart) is exposed. 

### Step 4

Enjoy!

**It's that Ez!**

There's lots of other cool stuff in EFUI, like [EzRowCol](lib/src/classes/EzRowCol.dart), [EzNotifications](lib/src/classes/EzNotifications.dart), and [EzVideoPlayer](lib/src/classes/EzVideoPlayer.dart)! We think `EzConfig` will hook you in enough to want to explore the rest!

# Demo

## See the example

Vibez

Vidyas

## See it live

* [Company site](https://www.empathetech.net/)
  * [Code](https://github.com/Empathetech-LLC/dotnet-public)

# Contributing

## Time

Please reach out to the [community](mailto:community@empathetech.net?subject=Becoming%20a%20contributor) contact about becoming a contributor.

But you don't have to wait for us! You can make a fork and start your personal changes at any time.

Also, if you build something with EFUI, let us know! We'd love to have a third-party section under [usage](#usage)

### Planned features
#### That we could use some help with!

- An Ez solution to [internationalization](https://docs.flutter.dev/ui/accessibility-and-localization/internationalization)
- More EzWidgets with required and/or preconfigured semantics
- Querying [GoogleFonts](https://pub.dev/packages/google_fonts) rather than relying on a predetermined [list](/lib/src/consts/googleFonts.dart)

## Money

Many thanks for any and all donations! We're happy to have helped!

### Paypal

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/donate/?hosted_button_id=NGEL6AB5A6KNL)

### Venmo

[@empathetech-llc](https://venmo.com/empathetech-llc)

### Cash App

[$empathetech](https://cash.app/$empathetech)

# License

[GNU GPLv3](LICENSE)

# Credits

## Flutter OSS

EFUI would not be as awesome as it is without these other awesome community projects...

* [Flutter Platform Widgets](https://pub.dev/packages/flutter_platform_widgets)
  * OS awareness package!
* [Flutter Colorpicker](https://pub.dev/packages/flutter_colorpicker)
* [Flutter Local Notifications](https://pub.dev/packages/flutter_local_notifications)
* [Line Icons](https://pub.dev/packages/line_icons)
* [Flutter Toast](https://pub.dev/packages/fluttertoast)

And, of course, all the awesome Google devs.
