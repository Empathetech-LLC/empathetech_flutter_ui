# empathetech_flutter_ui
#### EFUI

UIs designed with EFUI will be... 
 - fully responsive (fits well on all screens)
 - user accessible
 - massively user customizable
 - dynamically styled on mobile to match OS convention (iOS looks natural)
   - [thanks to](#flutter-oss)

## Table of Contents

* [Installation](#installation)
* [Usage](#usage)
* [Contributing](#contributing)
* [License](#license)
* [Credits](#credits)

# Installation

Thankfully, these instructions are auto-generated by Flutter. They can be found at the [pub.dev](https://pub.dev/packages/empathetech_flutter_ui/install) page

# Usage

Check out our public projects using EFUI:
* [dotnet](https://github.com/Empathetech-LLC/dotnet-public)
  * [Live!](https://www.empathetech.net/)
* [Smoke Signal](https://github.com/Empathetech-LLC/smoke_signal)

An official /example app is coming soon as well!

## How it works

First, in main, initialize [EzConfig](lib/classes/EzConfig.dart)

```Dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize EzConfig
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  EzConfig(
    assetPaths: assets,
    preferences: prefs,
  );

  // Set device orientations
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const ETechDotNet());
}
```
taken from [dotnet-public](https://github.com/Empathetech-LLC/dotnet-public/blob/main/lib/main.dart)

then, initialize your [EzApp](lib/classes/EzApp.dart)

```Dart
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      name: 'home',
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          name: 'products',
          path: 'products',
          builder: (BuildContext context, GoRouterState state) {
            return const ProductsScreen();
          },
        ),
        ...
      ],
    ),
  ],
)
...
return EzApp(
  title: appTitle,
  routerConfig: _router,
);
```

It's that Ez! `EzConfig` stores the styling information for the app, in a globally accessible instance.

On startup, `EzConfig` is used to generate [theme data](lib/functions/ezThemeData.dart) based on user preferences stored with [shared preferences](https://pub.dev/packages/shared_preferences).

In conjunction with the custom widgets below, `EzConfig` enables real-time theme alterations in app

* [EzColorSetting](lib/classes/EzColorSetting.dart): A user-friendly color picker to update theme colors.
* [EzDominantHandSwitch](lib/classes/EzDominantHandSwitch.dart): Moves common touch points to benefit lefty's when they want it!
* [EzFontSetting](lib/classes/EzFontSetting.dart): An interface for users to select their preferred font from a predefined list.
* [EzImageSetting](lib/classes/EzImageSetting.dart): A user-friendly image uploader to update app assets.
* [EzSliderSetting](lib/classes/EzSliderSetting.dart): A versatile slider widget for numerical customizations of many kinds (margin, padding, spacing, etc).
* [EzThemeModeSwitch](lib/classes/EzThemeModeSwitch.dart): A toggle for users to switch between light, dark, or system theming.

[See them in action](https://www.empathetech.net/#/settings)

There's lots of other cool stuff in EFUI, like [EzRowCol](lib/classes/EzRowCol.dart), [EzNotifications](lib/classes/EzNotifications.dart), and [EzVideoPlayer](lib/classes/EzVideoPlayer.dart)! We think `EzConfig` will hook you in enough to want to explore the rest!

# Contributing

## Time

Please reach out to the [community](mailto:community@empathetech.net?subject=Becoming%20a%20contributor) contact about becoming a contributor.

But you don't have to wait for us! You can make a fork and start your personal changes at any time.

Also, if you build something with EFUI, let us know! We'd love to have a third-party section under [usage](#usage)

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
* [Flutter Colorpicker](https://pub.dev/packages/flutter_colorpicker)
* [Flutter Local Notifications](https://pub.dev/packages/flutter_local_notifications)
* [Line Icons](https://pub.dev/packages/line_icons)
* [Flutter Toast](https://pub.dev/packages/fluttertoast)

And, of course, all the awesome Google devs.
