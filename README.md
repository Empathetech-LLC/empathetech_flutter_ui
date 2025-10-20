# Empathetech Flutter UI <br><br> Build apps for anyone
[![en](https://img.shields.io/badge/lang-en-blue.svg)](https://github.com/Empathetech-LLC/empathetech_flutter_ui/blob/main/README.md)
[![es](https://img.shields.io/badge/lang-es-red.svg)](https://github.com/Empathetech-LLC/empathetech_flutter_ui/blob/main/localized_readme/README.es.md)
[![fr](https://img.shields.io/badge/lang-fr-white.svg)](https://github.com/Empathetech-LLC/empathetech_flutter_ui/blob/main/localized_readme/README.fr.md)

<br>EFUI is a [Flutter](https://flutter.dev/) library for building truly accessible apps. It simplifies...

- **Platform availability**
  - Thanks to Flutter, you can use EFUI to create on Android, iOS, Linux, macOS, Windows and Web!
- **Responsive design**
  - Here's the [definition](https://developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Responsive_Design); check out [our site](https://www.empathetech.net/#/contribute) to see it in action.
- **Screen reader support**
  - Empathetech code is manually verified with [TalkBack](https://support.google.com/accessibility/android/answer/6006598?hl=en) and [VoiceOver](https://support.apple.com/guide/iphone/turn-on-and-practice-voiceover-iph3e2e415f/ios).
- **User customization**
  - The only way to be truly accessible to ALL customers is to empower them with the freedom of choice!
    - EFUI provides an elegant UX for full control over an app's appearance.
- **Internationalization**
  - Empathetech apps have been translated to Spanish and French (so far).
  - EFUI also provides the infrastructure for unlimited future translations.
    - Moral fiber moment: Remember that LLMs are a tool for acceleration. But, there's a lot more to a great car than just acceleration! If your translations are generated: disclose that. EFUI's translations started with A.I. and ended with H.I.
- **Cost**
  - While we encourage [contributions](#contributing), EFUI is completely free and [open source](./LICENSE).
  - [Open UI](#usage) can also get you started with a professionally polished, empathetic app in one click\*
    - \*There's some first time setup. After that, one click per app.

<br><br>When built with EFUI, your apps can truly reach any audience!
<br>Let's build a better world together, bit x bit.

## <br>Table of Contents

* [Usage](#usage)
* [Contributing](#contributing)
* [License](#license)

# <br>Usage 
## **Open UI**

Is an app generator. It is available everywhere, and can give your idea an accessible, production ready foundation with one click.

&nbsp;&nbsp;&nbsp;[Android (Google Play)](https://play.google.com/store/apps/details?id=net.empathetech.open_ui)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;[Android (.apk)](https://github.com/Empathetech-LLC/empathetech_flutter_ui/releases/download/10.2.0/open-ui-android.apk)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;[iOS](https://apps.apple.com/us/app/open-ui/id6499560244)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;[Linux (deb)](https://github.com/Empathetech-LLC/empathetech_flutter_ui/releases/download/10.2.0/open-ui-linux.deb)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;[Linux (rpm)](https://github.com/Empathetech-LLC/empathetech_flutter_ui/releases/download/10.2.0/open-ui-linux.rpm)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;[macOS](https://github.com/Empathetech-LLC/empathetech_flutter_ui/releases/download/10.2.0/open-ui-mac.zip)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;[Windows](https://github.com/Empathetech-LLC/empathetech_flutter_ui/releases/download/10.2.0/open-ui-windows.exe)

<br>*Mobile platforms simply save a configuration file that can be used on Desktop. Flutter must be [installed](https://docs.flutter.dev/get-started/install) (on Desktop) for code generation to work.

### <br>Beginner tutorials

If you're new to Flutter: welcome! EFUI is full of doc comments to help you on your path.

Here are some (unaffiliated) videos you might also find helpful.

- [First app tutorial](https://www.youtube.com/watch?v=xWV71C2kp38) (Flutter)
- [First app code lab](https://www.youtube.com/watch?v=8sAyPDLorek) (Flutter)
- [Using external packages](https://www.youtube.com/watch?v=WdXcJdhWcEY) (Net Ninja)

## <br>Integrating EFUI with existing projects 
### TL;DR

--- Required ---
1. Initialize [EzConfig](./lib/src/classes/config.dart) in `void main()`
2. Use [EzAppProvider](./lib/src/classes/platform_availability/app_provider.dart) to build a [PlatformApp](https://pub.dev/documentation/flutter_platform_widgets/latest/flutter_platform_widgets/PlatformApp-class.html) (from a recommended external library)<br>  - OR use [ezThemeData](./lib/src/functions/theme_data.dart) in any existing provider/app<br>  - OR use `EzConfig`s data when building your `ThemeData`

--- Recommended ---
1. Copy the [settings sandbox](./lib/src/sample_screens/) to your app
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
#### Initialize [EzConfig](./lib/src/classes/config.dart) in `void main()`<br>

`main.dart`
```Dart
//...
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences preferences = await SharedPreferences.getInstance();

  EzConfig.init(
    preferences: preferences,

    // Your brand colors, custom styling, etc
    defaults: <String, Object>{},

    // Fallback Lang for unsupported Locales
    fallbackLang: await EFUILang.delegate.load(americanEnglish),

    // Paths to any locally stored images the app uses
    assetPaths: <String>{},
  );
  
  // the rest of your code...

  runApp(const YourApp());
}
//...
```

#### <br>How it works

`EzConfig` gathers the app's theme data, merging your `defaults` with the user's saved [preferences](https://pub.dev/packages/shared_preferences).

Once gathered, `EzConfig` stores the data in a Singleton instance for efficient access. `EzConfig` has a series of getter and setter methods for safe interactions with the theme data.

### <br>Step 2
#### Use [EzAppProvider](./lib/src/classes/platform_availability/app_provider.dart) to build a [PlatformApp](https://pub.dev/documentation/flutter_platform_widgets/latest/flutter_platform_widgets/PlatformApp-class.html)<br>

`main.dart`
```Dart
//...
class YourApp extends StatelessWidget {
  const YourApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EzAppProvider(
      app: PlatformApp.router(
        debugShowCheckedModeBanner: false,

        // Language handlers
        localizationsDelegates: <LocalizationsDelegate<dynamic>>{
          const LocaleNamesLocalizationsDelegate(),
          ...EFUILang.localizationsDelegates,
          ...YourLang.localizationsDelegates,
          YourAppFeedbackLocalizationsDelegate(),
        },

        // Supported languages
        supportedLocales: YourLang.supportedLocales,

        // Current language
        locale: EzConfig.getLocale(),

        title: appName,
        routerConfig: router,
      ),
    );
  }
}
```

#### <br>How it works

`EzAppProvider` is a [PlatformProvider](https://pub.dev/documentation/flutter_platform_Widgets/latest/flutter_platform_Widgets/PlatformProvider-class.html) wrapper that uses [ezThemeData](./lib/src/functions/theme_data.dart) by default.

`ezThemeData` creates a `ThemeData` from the values in `EzConfig`.

You are more than welcome to use your own app/app provider with `ezThemeData` for the same effect.

Or, simply integrate `EzConfig` data into your existing `ThemeData`.

### <br>Step 3
#### Copy the [settings sandbox](./lib/src/sample_screens/) to your project<br>

Each of the settings screens we use is a callable (and configurable) `Widget`.

Copy/paste all the [sample screens](./lib/src/sample_screens/) you want and make paths to them in your apps.

<br>Example combo using a go_router...<br>

`text_settings.dart`
```Dart
//...
class TextSettingsScreen extends StatelessWidget {
  const TextSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => OpenUIScaffold(
        title: ezL10n(context).tsPageTitle,
        showSettings: false,
        body: const EzTextSettings(),
      );
}
```
`main.dart`
```Dart
//...
   GoRoute(
     path: textSettingsPath,
     name: textSettingsPath,
     builder: (_, __) => const TextSettingsScreen(),
   ),
//...
```

<br>And boom! **It's that Ez!**

#### <br>How it works

The sample screens elegantly organize all the custom Widgets that enable EFUI's user customization!

* [EzDominantHandSwitch](./lib/src/widgets/user_customization/dominant_hand_switch.dart): A toggle for switching common touch points to benefit lefties.
* [EzThemeModeSwitch](./lib/src/widgets/user_customization/theme_mode_swtich.dart): A toggle menu for selecting the app's theme: light, dark, system.
* [EzLocaleSetting](./lib/src/widgets/user_customization/locale_setting.dart): A menu for updating the app's language. EFUI currently supports English, Spanish, and French.
* [TextSettings](./lib/src/widgets/user_customization/text_theme/): A collection of custom Widgets for controlling the app's TextStyles.
* [EzLayoutSetting](./lib/src/widgets/user_customization/layout_setting.dart): A dynamic slider Widget, with live previews, for updating the app's layout: margin, padding, and spacing.
* [EzColorSetting](./lib/src/widgets/user_customization/color_scheme/): A color picker for updating each entry in the app's ColorScheme.
* [EzImageSetting](./lib/src/widgets/user_customization/image_setting.dart): An image picker for updating app assets.
* [EzRandomButton](./lib/src/widgets/user_customization/random_button.dart): A fun (and optional) button for (pseudo)randomizing the settings.
* [EzResetButton](./lib/src/widgets/user_customization/reset_button.dart): A customizable button for resetting groups of preferences.

<br>By default, every base [theme setting](./lib/src/consts/config_keys.dart) is exposed. Unique keys provided to `EzConfig.defaults` can be updated with these Widgets too!

And, If our samples don't fit your vibe, feel free to use the above widgets to build your own settings screen(s).

### <br>Step 4
#### Enjoy!

<br>And, as your app grows, use our library to keep things Ez

* [Platform availability](./lib/src/widgets/platform_availability/): Platform responsive `Widget`s that will help along the way
* [Responsive design](./lib/src/widgets/responsive_design/): `Widget`s that aid in building responsive UI/UX
* [Screen reader support](./lib/src/widgets/screen_reader_support/): `Widget`s with streamlined `Semantics`
* [User customization](./lib/src/widgets/helpers/): Wrapper `Widget`s that respond to `EzConfig` data when the `ThemeData` doesn't cut it

<br><br>We hope that wasn't information overload! Good news is: that's everything you need.
<br>Once you're feeling settled, please do explore! The library is organized, commented, and continuously maintained.

# <br>Contributing

## The vibes!

If you build something with EFUI, let us know!

## <br>Time

Please reach out to the [community](mailto:community@empathetech.net?subject=Becoming%20a%20contributor) contact about becoming a contributor. There's never a shortage of ideas, only time!

### <br>Translations

If you speak English and a currently unsupported language, please reach out! The more the merrier.

OR: If you speak English and a currently supported language, and see something wrong, please reach out! It takes a village.

## <br>Money

Many thanks for any and all donations!

&nbsp;&nbsp;&nbsp;[GoFundMe](https://gofund.me/c047d07e)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;[Patreon](https://patreon.com/empathetech)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;[Buy Me a Coffee](https://www.buymeacoffee.com/empathetech)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;[Ko-fi](https://ko-fi.com/empathetech)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;[PayPal](https://www.paypal.com/donate/?hosted_button_id=NGEL6AB5A6KNL)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;[Venmo](https://venmo.com/empathetech)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;[Cash App](https://cash.app/$empathetech)

# <br>License

[GNU GPLv3](./LICENSE)