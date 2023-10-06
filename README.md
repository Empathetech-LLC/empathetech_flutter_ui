# Empathetech Flutter UI <br><br> Build apps for anyone

EFUI is a holistic foundation for digital accessibility.

EFUI :
- **User-Centric Accessibilities**
  - Verified with [TalkBack](https://support.google.com/accessibility/android/answer/6006598?hl=en) and [VoiceOver](https://support.apple.com/guide/iphone/turn-on-and-practice-voiceover-iph3e2e415f/ios), with enhanced custom semantics for a clearer user understanding.
- **Rich Customization Capabilities**
  - Users revel in the freedom to modify theme colors, styles, and imagery, making your app a canvas for their expressions.
- **Dynamic Styling & Platform Awareness**
  - Thanks to the integration with [Flutter Platform Widgets](https://pub.dev/packages/flutter_platform_widgets), your app gracefully adapts to Material or Cupertino aesthetics matching the native OS convention.
- **Responsive Design**
  - A consistent user experience across various screen sizes, tested and affirmed across all seven Flutter platforms.
- **Internationalization Ready**
  - A foundation set for language translations, kicking off with Spanish, making your app globally amiable.
- **Copy-Paste Ready Settings Segment**
  - The example app is crafted to be a robust settings section of "your" next app, ready to be integrated with a simple copy/paste. 

The journey of crafting accessible and highly customizable apps is simplified, yet enriched with EFUI. A testament to what’s achievable when user-centric design meets developer-friendly implementation.

## Table of Contents


EFUI provides a rock-solid foundation for building user accessible apps.

EFUI is a starter kit for every aspect of digital accessibility...
- User accessible
  - Manually verified with [TalkBack](https://support.google.com/accessibility/android/answer/6006598?hl=en) and [VoiceOver](https://support.apple.com/guide/iphone/turn-on-and-practice-voiceover-iph3e2e415f/ios)
- User customizable
  - Users can/will have control over colors, fonts, spacing, and so much more
- Dynamically styled to match OS convention (Apple ecosystem apps will feel more native)
  - [Shoutout](#flutter-oss)
- Responsive to screen size

Last and DEFINITELY NOT least, thanks to Flutter, fully cross platform! EFUI works seamlessly across Android, iOs, iPadOS, MacOS (via iPadOS), Windows, Linux, and Web!

## Table of Contents

* [Installation](#installation)
* [Usage](#usage)
* [Contributing](#contributing)
* [License](#license)
* [Credits](#credits)

# Installation

If you're new to Flutter: welcome! The EFUI example app is full of comments to help you on your path.

Otherwise, installation instructions can be found on [pub.dev](https://pub.dev/packages/empathetech_flutter_ui/install)

## Beginner tutorials

For those starting out, here are some videos you might find helpful (unafilliated)

- [First app tutorial](https://www.youtube.com/watch?v=xWV71C2kp38)
- [First app codelab](https://www.youtube.com/watch?v=8sAyPDLorek)
- [Using external packages](https://www.youtube.com/watch?v=WdXcJdhWcEY)

# Usage

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
