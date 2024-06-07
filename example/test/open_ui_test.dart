import 'color_settings_screen.dart' as color;
import 'home_screen.dart' as home;
import 'image_settings_screen.dart' as image;
import 'layout_settings_screen.dart' as layout;
import 'text_settings_screen.dart' as text;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

void main() async {
  //// Setup the test environment ////

  // Load contextual data //

  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  const Locale english = Locale('en');
  const Locale spanish = Locale('es');
  const List<Locale> locales = <Locale>[english, spanish];

  final EFUILang enText = await EFUILang.delegate.load(english);
  final EFUILang esText = await EFUILang.delegate.load(spanish);
  final List<EFUILang> l10ns = <EFUILang>[enText, esText];

  final LocaleNames enNames =
      await const LocaleNamesLocalizationsDelegate().load(english);
  final LocaleNames esNames =
      await const LocaleNamesLocalizationsDelegate().load(spanish);
  final List<LocaleNames> l10nNames = <LocaleNames>[enNames, esNames];

  // Set mock values //

  SharedPreferences.setMockInitialValues(empathetechConfig);
  final SharedPreferences preferences = await SharedPreferences.getInstance();

  EzConfig.init(
    preferences: preferences,
    assetPaths: <String>{},
    defaults: empathetechConfig,
  );

  //// Run the tests ////

  final List<Function> testSuites = <Function>[
    home.testSuite,
    text.testSuite,
    layout.testSuite,
    color.testSuite,
    image.testSuite,
  ];

  final List<String> screenNames = <String>[
    'Home screen',
    'Text settings screen',
    'Layout settings screen',
    'Color settings screen',
    'Image settings screen',
  ];

  for (int i = 0; i < testSuites.length; i++) {
    final Function testSuite = testSuites[i];
    final String screenName = screenNames[i];

    // Test non-default platforms //

    const List<TargetPlatform> otherPlatforms = <TargetPlatform>[
      TargetPlatform.iOS,
      TargetPlatform.macOS,
      TargetPlatform.windows,
      TargetPlatform.linux,
    ];

    for (final TargetPlatform platform in otherPlatforms) {
      testSuite(
        title: '$screenName platform test: ${platform.toString()}',
        locale: english,
        l10n: enText,
        localeNames: enNames,
        platform: platform,
      );
    }

    // Test non-default languages //

    for (int i = 1; i < locales.length; i++) {
      testSuite(
        title: '$screenName language test: ${locales[i].languageCode}',
        locale: locales[i],
        l10n: l10ns[i],
        localeNames: l10nNames[i],
        setup: () async {
          await preferences.setStringList(
            localeKey,
            <String>[locales[i].languageCode],
          );
        },
      );
    }

    // Test screen size && user config smorgasbord //

    const List<Size> screenSizes = <Size>[
      Size(375, 667), // Small phone (iPhone SE 3rd gen)
      Size(430, 932), // Large phone (iPhone 14 Pro Max)
      Size(744, 1133), // Small tablet, (iPad Mini 6th gen)
      Size(1024, 1366), // Large tablet, (iPad Pro, 12.9-inch, 6th gen)
      Size(1920, 1080), // Standard desktop monitor (16:9)
      Size(2560, 1080), // Wide desktop monitor (21:9)
    ];

    for (final Size screenSize in screenSizes) {
      // Default config
      testSuite(
        title:
            '$screenName layout test: Default config on ${screenSize.width}x${screenSize.height}',
        locale: english,
        l10n: enText,
        localeNames: enNames,
        screenSize: screenSize,
      );

      // Minimum config
      testSuite(
        title:
            '$screenName layout test: Minimum config on ${screenSize.width}x${screenSize.height}',
        locale: english,
        l10n: enText,
        localeNames: enNames,
        screenSize: screenSize,
        setup: () async {
          // Text settings //

          // Display
          await preferences.setDouble(displayFontSizeKey, minFontSize);
          await preferences.setDouble(displayFontHeightKey, minFontHeight);
          await preferences.setDouble(
              displayLetterSpacingKey, minFontLetterSpacing);
          await preferences.setDouble(
              displayWordSpacingKey, minFontWordSpacing);

          // Headline
          await preferences.setDouble(headlineFontSizeKey, minFontSize);
          await preferences.setDouble(headlineFontHeightKey, minFontHeight);
          await preferences.setDouble(
              headlineLetterSpacingKey, minFontLetterSpacing);
          await preferences.setDouble(
              headlineWordSpacingKey, minFontWordSpacing);

          // Title
          await preferences.setDouble(titleFontSizeKey, minFontSize);
          await preferences.setDouble(titleFontHeightKey, minFontHeight);
          await preferences.setDouble(
              titleLetterSpacingKey, minFontLetterSpacing);
          await preferences.setDouble(titleWordSpacingKey, minFontWordSpacing);

          // Body
          await preferences.setDouble(bodyFontSizeKey, minFontSize);
          await preferences.setDouble(bodyFontHeightKey, minFontHeight);
          await preferences.setDouble(
              bodyLetterSpacingKey, minFontLetterSpacing);
          await preferences.setDouble(bodyWordSpacingKey, minFontWordSpacing);

          // Label
          await preferences.setDouble(labelFontSizeKey, minFontSize);
          await preferences.setDouble(labelFontHeightKey, minFontHeight);
          await preferences.setDouble(
              labelLetterSpacingKey, minFontLetterSpacing);
          await preferences.setDouble(labelWordSpacingKey, minFontWordSpacing);

          // Layout settings //
          await preferences.setDouble(marginKey, minMargin);
          await preferences.setDouble(paddingKey, minPadding);
          await preferences.setDouble(spacingKey, minSpacing);
        },
      );

      // Maximum config
      testSuite(
        title:
            '$screenName layout test: Maximum config on ${screenSize.width}x${screenSize.height}',
        locale: english,
        l10n: enText,
        localeNames: enNames,
        screenSize: screenSize,
        setup: () async {
          // Text settings //

          // Display
          await preferences.setDouble(displayFontSizeKey, maxFontSize);
          await preferences.setDouble(displayFontHeightKey, maxFontHeight);
          await preferences.setDouble(
              displayLetterSpacingKey, maxFontLetterSpacing);
          await preferences.setDouble(
              displayWordSpacingKey, maxFontWordSpacing);

          // Headline
          await preferences.setDouble(headlineFontSizeKey, maxFontSize);
          await preferences.setDouble(headlineFontHeightKey, maxFontHeight);
          await preferences.setDouble(
              headlineLetterSpacingKey, maxFontLetterSpacing);
          await preferences.setDouble(
              headlineWordSpacingKey, maxFontWordSpacing);

          // Title
          await preferences.setDouble(titleFontSizeKey, maxFontSize);
          await preferences.setDouble(titleFontHeightKey, maxFontHeight);
          await preferences.setDouble(
              titleLetterSpacingKey, maxFontLetterSpacing);
          await preferences.setDouble(titleWordSpacingKey, maxFontWordSpacing);

          // Body
          await preferences.setDouble(bodyFontSizeKey, maxFontSize);
          await preferences.setDouble(bodyFontHeightKey, maxFontHeight);
          await preferences.setDouble(
              bodyLetterSpacingKey, maxFontLetterSpacing);
          await preferences.setDouble(bodyWordSpacingKey, maxFontWordSpacing);

          // Label
          await preferences.setDouble(labelFontSizeKey, maxFontSize);
          await preferences.setDouble(labelFontHeightKey, maxFontHeight);
          await preferences.setDouble(
              labelLetterSpacingKey, maxFontLetterSpacing);
          await preferences.setDouble(labelWordSpacingKey, maxFontWordSpacing);

          // Layout settings //
          await preferences.setDouble(marginKey, maxMargin);
          await preferences.setDouble(paddingKey, maxPadding);
          await preferences.setDouble(spacingKey, maxSpacing);
        },
      );
    }

    // Ditto (sub-set) for left-handed users //

    const List<Size> screenSubSet = <Size>[
      Size(375, 667), // Small phone (iPhone SE 3rd gen)
      Size(430, 932), // Large phone (iPhone 14 Pro Max)
      Size(1920, 1080), // Standard desktop monitor (16:9)
    ];

    for (final Size screenSize in screenSubSet) {
      // Default config
      testSuite(
        title:
            '$screenName layout test: Lefty default config on ${screenSize.width}x${screenSize.height}',
        locale: english,
        l10n: enText,
        localeNames: enNames,
        screenSize: screenSize,
        setup: () async {
          await preferences.setBool(isLeftyKey, true);
        },
      );

      // Minimum config
      testSuite(
        title:
            '$screenName layout test: Lefty minimum config on ${screenSize.width}x${screenSize.height}',
        locale: english,
        l10n: enText,
        localeNames: enNames,
        screenSize: screenSize,
        setup: () async {
          // Global settings //

          await preferences.setBool(isLeftyKey, true);

          // Text settings //

          // Display
          await preferences.setDouble(displayFontSizeKey, minFontSize);
          await preferences.setDouble(displayFontHeightKey, minFontHeight);
          await preferences.setDouble(
              displayLetterSpacingKey, minFontLetterSpacing);
          await preferences.setDouble(
              displayWordSpacingKey, minFontWordSpacing);

          // Headline
          await preferences.setDouble(headlineFontSizeKey, minFontSize);
          await preferences.setDouble(headlineFontHeightKey, minFontHeight);
          await preferences.setDouble(
              headlineLetterSpacingKey, minFontLetterSpacing);
          await preferences.setDouble(
              headlineWordSpacingKey, minFontWordSpacing);

          // Title
          await preferences.setDouble(titleFontSizeKey, minFontSize);
          await preferences.setDouble(titleFontHeightKey, minFontHeight);
          await preferences.setDouble(
              titleLetterSpacingKey, minFontLetterSpacing);
          await preferences.setDouble(titleWordSpacingKey, minFontWordSpacing);

          // Body
          await preferences.setDouble(bodyFontSizeKey, minFontSize);
          await preferences.setDouble(bodyFontHeightKey, minFontHeight);
          await preferences.setDouble(
              bodyLetterSpacingKey, minFontLetterSpacing);
          await preferences.setDouble(bodyWordSpacingKey, minFontWordSpacing);

          // Label
          await preferences.setDouble(labelFontSizeKey, minFontSize);
          await preferences.setDouble(labelFontHeightKey, minFontHeight);
          await preferences.setDouble(
              labelLetterSpacingKey, minFontLetterSpacing);
          await preferences.setDouble(labelWordSpacingKey, minFontWordSpacing);

          // Layout settings //
          await preferences.setDouble(marginKey, minMargin);
          await preferences.setDouble(paddingKey, minPadding);
          await preferences.setDouble(spacingKey, minSpacing);
        },
      );

      // Maximum config
      testSuite(
        title:
            '$screenName layout test: Lefty maximum config on ${screenSize.width}x${screenSize.height}',
        locale: english,
        l10n: enText,
        localeNames: enNames,
        screenSize: screenSize,
        setup: () async {
          // Global settings //

          await preferences.setBool(isLeftyKey, true);

          // Text settings //

          // Display
          await preferences.setDouble(displayFontSizeKey, maxFontSize);
          await preferences.setDouble(displayFontHeightKey, maxFontHeight);
          await preferences.setDouble(
              displayLetterSpacingKey, maxFontLetterSpacing);
          await preferences.setDouble(
              displayWordSpacingKey, maxFontWordSpacing);

          // Headline
          await preferences.setDouble(headlineFontSizeKey, maxFontSize);
          await preferences.setDouble(headlineFontHeightKey, maxFontHeight);
          await preferences.setDouble(
              headlineLetterSpacingKey, maxFontLetterSpacing);
          await preferences.setDouble(
              headlineWordSpacingKey, maxFontWordSpacing);

          // Title
          await preferences.setDouble(titleFontSizeKey, maxFontSize);
          await preferences.setDouble(titleFontHeightKey, maxFontHeight);
          await preferences.setDouble(
              titleLetterSpacingKey, maxFontLetterSpacing);
          await preferences.setDouble(titleWordSpacingKey, maxFontWordSpacing);

          // Body
          await preferences.setDouble(bodyFontSizeKey, maxFontSize);
          await preferences.setDouble(bodyFontHeightKey, maxFontHeight);
          await preferences.setDouble(
              bodyLetterSpacingKey, maxFontLetterSpacing);
          await preferences.setDouble(bodyWordSpacingKey, maxFontWordSpacing);

          // Label
          await preferences.setDouble(labelFontSizeKey, maxFontSize);
          await preferences.setDouble(labelFontHeightKey, maxFontHeight);
          await preferences.setDouble(
              labelLetterSpacingKey, maxFontLetterSpacing);
          await preferences.setDouble(labelWordSpacingKey, maxFontWordSpacing);

          // Layout settings //
          await preferences.setDouble(marginKey, maxMargin);
          await preferences.setDouble(paddingKey, maxPadding);
          await preferences.setDouble(spacingKey, maxSpacing);
        },
      );
    }
  }
}
