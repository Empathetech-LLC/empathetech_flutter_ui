# Empathetech Flutter UI <br><br> Build apps for anyone

EFUI is a holistic foundation for digital accessibility.

EFUI provides a starter kit for every aspect of digital accessibility:
- **Platform availability**
  - Thanks to Flutter, EFUI is fully cross platform! EFUI can make apps for Android, iOs, iPadOS, MacOS (via iPadOS), Windows, Linux, and Web!
    - Thanks to integration with [Flutter Platform Widgets](https://pub.dev/packages/flutter_platform_widgets), your apps will gracefully adapt to Cupertino (Apple) and Material (Android & Beyond) styling
- **Screen reader compliance**
  - The [example app](./example/) and all custom widgets have been manually verified with [TalkBack](https://support.google.com/accessibility/android/answer/6006598?hl=en) and [VoiceOver](https://support.apple.com/guide/iphone/turn-on-and-practice-voiceover-iph3e2e415f/ios)
- **User customization**
  - The only way to be truly accessible for ALL customers is to empower them with the freedom of choice.<br>EFUI enables developers to expose any aspect of their app's theme to the user.
    - Users can have full control of theme colors, fonts, styling, spacing, and images.
- **Internationalization**
  - The [example app](./example/) and all custom widgets have been translated into Spanish. With the infrastructure for internationalization layed out, the only work left are the translations themselves.
    - Moral fiber moment: Remember that LLMs are a tool for acceleration. But, there's a lot more to winning a race than acceleration. If your translations are A.H.I. generated, say that. EFUIs translations started with A.H.I. and ended with [H.I.](LINK_HERE)
- **Responsive design**
  - [Readers](https://developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Responsive_Design)
  - [Visual learners](https://www.empathetech.net/#/contribute)

<br>Apps built with EFUI can truly reach any audience. Let's make the internet a more accessible place together!

## Table of Contents

* [Installation](#installation)
* [Usage](#usage)
* [Contributing](#contributing)
* [License](#license)
* [Credits](#credits)

# Installation

If you're new to Flutter: welcome! The [example app](./example/) is full of comments to help you on your path.

If you've Fluttered before, head on over to [pub.dev](https://pub.dev/packages/empathetech_flutter_ui/install)

## Beginner tutorials

For those starting out, here are some videos you might find helpful (unafilliated!)

- [First app tutorial](https://www.youtube.com/watch?v=xWV71C2kp38)
- [First app codelab](https://www.youtube.com/watch?v=8sAyPDLorek)
- [Using external packages](https://www.youtube.com/watch?v=WdXcJdhWcEY)

# Usage

## TL;DR

For my Flutter veterans...
1. Check out [EzConfig](./lib/src/classes/EzConfig.dart) to see how EFUI builds the theme, and how you can merge your custom defaults
2. Use [EzAppProvider](./lib/src/classes/EzAppProvider.dart)
3. a)  Copy/paste all example app [screens](./example/lib/screens/) and [.arbs](./example/lib/l10n/) to your app<br>b) Rename Home.dart to Settings.dart (dev preference) and create a link to it in your app
4. Enjoy

## Setup
*All code below was adapted from the [example app](example/lib/main.dart)*

First, in main, initialize [EzConfig](lib/src/classes/EzConfig.dart)

```Dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  EzConfig(
    /// your [AssetImage] paths for this app
    assetPaths: [],

    preferences: prefs,

    /// your brand colors, custom styling, etc
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

then, use an [EzAppProvider](/lib/src/classes/EzAppProvider.dart) in your build (which pairs well with an [EzApp](lib/src/classes/EzApp.dart))

```Dart
class EFUIExample extends StatelessWidget {
  final Key? key;

  const EFUIExample({this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EzAppProvider(
      app: EzApp(
        title: 'EFUI example',
        routerConfig: GoRouter(initialLocation: '/', routes: ...),
      ),
    );
  }
}

```

### It's that Ez!

## How it works

When an `EzApp` starts, `EzConfig` generates the app's [theme data](lib/src/functions/ezThemeData.dart), starting with the [defaults](/lib/src/consts/empathetechConfig.dart) gathers the user's [preferences](https://pub.dev/packages/shared_preferences) and .

In the code, `EzConfig` has a globally accessible instance that can be used to query the live configuration.

Then, in conjunction with the custom widgets below, `EzConfig` enables user customization

* [EzThemeModeSwitch](lib/src/classes/EzThemeModeSwitch.dart): A toggle for users to switch between light, dark, or system theming.
* [EzDominantHandSwitch](lib/src/classes/EzDominantHandSwitch.dart): Moves common touch points to benefit lefty's when they want it!
* [EzColorSetting](lib/src/classes/EzColorSetting.dart): A user-friendly color picker to update theme colors.
* [EzFontSetting](lib/src/classes/EzFontSetting.dart): An interface for users to select their preferred font from a predefined list.
* [EzSliderSetting](lib/src/classes/EzSliderSetting.dart): A versatile slider widget for numerical customizations of many kinds (margin, padding, spacing, etc).
* [EzImageSetting](lib/src/classes/EzImageSetting.dart): A user-friendly image uploader to update app assets.
  * Not shown in the example app

#### [See them in action](https://www.empathetech.net/#/settings)

There's lots of other cool stuff in EFUI, like [EzRowCol](lib/src/classes/EzRowCol.dart), [EzNotifications](lib/src/classes/EzNotifications.dart), and [EzVideoPlayer](lib/src/classes/EzVideoPlayer.dart)! We think `EzConfig` will hook you in enough to want to explore the rest!

**P.S.** 

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
