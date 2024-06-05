import 'utils.dart';

import 'package:example/screens/export.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

void main() async {
  // Setup the test environment //

  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  SharedPreferences.setMockInitialValues(empathetechConfig);
  final SharedPreferences preferences = await SharedPreferences.getInstance();

  EzConfig.init(
    preferences: preferences,
    assetPaths: <String>{},
    defaults: empathetechConfig,
  );

  final EFUILang enText = await EFUILang.delegate.load(const Locale('en'));
  final LocaleNames enNames =
      await const LocaleNamesLocalizationsDelegate().load(const Locale('en'));

  final EFUILang esText = await EFUILang.delegate.load(const Locale('es'));
  final LocaleNames esNames =
      await const LocaleNamesLocalizationsDelegate().load(const Locale('es'));

  // Run the tests //

  // Default config, English
  testSuite(
    title: 'Home screen tests: Default config, English',
    prefs: empathetechConfig,
    locale: 'en',
    l10n: enText,
    localeNames: enNames,
  );

  // Default config, Spanish
  testSuite(
    title: 'Home screen tests: Default config, Spanish',
    prefs: empathetechConfig,
    locale: 'es',
    l10n: esText,
    localeNames: esNames,
    setup: () async {
      await preferences.setStringList(localeKey, <String>['es']);
    },
  );
}

void testSuite({
  required String title,
  required Map<String, Object> prefs,
  required String locale,
  required EFUILang l10n,
  required LocaleNames localeNames,
  Function()? setup,
}) =>
    testWidgets(title, (WidgetTester tester) async {
      // Run the tests //
      // Load the app //

      setup?.call();

      final Widget testApp = testOpenUI(title: title, locale: Locale(locale));

      debugPrint('Loading Open UI');

      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      expect(find.byType(PlatformApp), findsOneWidget);
      expect(find.byType(HomeScreen), findsOneWidget);

      // Test navigation //

      debugPrint('Navigating to Text settings');

      final Finder textSettingsButton = find.widgetWithText(
        ElevatedButton,
        l10n.tsPageTitle,
      );

      expect(textSettingsButton, findsOneWidget);
      await touch(tester, textSettingsButton);
      await goBack(tester);

      debugPrint('Navigating to Layout settings');

      final Finder layoutSettingsButton = find.widgetWithText(
        ElevatedButton,
        l10n.lsPageTitle,
      );

      expect(layoutSettingsButton, findsOneWidget);
      await touch(tester, layoutSettingsButton);
      await goBack(tester);

      debugPrint('Navigating to Color settings');

      final Finder colorSettingsButton = find.widgetWithText(
        ElevatedButton,
        l10n.csPageTitle,
      );

      expect(colorSettingsButton, findsOneWidget);
      await touch(tester, colorSettingsButton);
      await goBack(tester);

      debugPrint('Navigating to Image settings');

      final Finder imageSettingsButton = find.widgetWithText(
        ElevatedButton,
        l10n.isPageTitle,
      );

      expect(imageSettingsButton, findsOneWidget);
      await touch(tester, imageSettingsButton);
      await goBack(tester);

      // Functionality //

      debugPrint('Toggling Dominant hand setting');

      final Finder dominantHandButton = find.byType(DropdownMenu<Hand>);

      expect(dominantHandButton, findsOneWidget);
      await touch(tester, dominantHandButton);

      final Finder rightButton = find.text(l10n.gRight).last;
      final Finder leftButton = find.text(l10n.gLeft).last;

      expect(rightButton, findsOneWidget);
      expect(leftButton, findsOneWidget);

      await tester.tap(leftButton);
      await tester.pumpAndSettle();

      final Finder handButtonsRowFinder = find.byType(Row).at(1);
      Row handButtonsRow = tester.widget(handButtonsRowFinder);
      List<Widget> children = handButtonsRow.children;

      expect(children[0], isA<DropdownMenu<Hand>>());
      expect(children[1], isA<EzSpacer>());
      expect(children[2], isA<Text>());

      await touch(tester, dominantHandButton);

      await tester.tap(rightButton);
      await tester.pumpAndSettle();

      handButtonsRow = tester.widget(handButtonsRowFinder);
      children = handButtonsRow.children;

      expect(children[0], isA<Text>());
      expect(children[1], isA<EzSpacer>());
      expect(children[2], isA<DropdownMenu<Hand>>());

      debugPrint('Selecting each theme mode');

      final Finder themeModeButton = find.byType(DropdownMenu<ThemeMode>);

      expect(themeModeButton, findsOneWidget);
      await touch(tester, themeModeButton);

      final Finder systemButton = find.text(l10n.gSystem).last;
      final Finder darkButton = find.text(l10n.gDark).last;
      final Finder lightButton = find.text(l10n.gLight).last;

      expect(systemButton, findsOneWidget);
      expect(darkButton, findsOneWidget);
      expect(lightButton, findsOneWidget);

      await tester.tap(systemButton);
      await tester.pumpAndSettle();

      await touch(tester, themeModeButton);
      await tester.tap(darkButton);
      await tester.pumpAndSettle();

      await touch(tester, themeModeButton);
      await tester.tap(lightButton);
      await tester.pumpAndSettle();

      debugPrint('Toggling Spanish language');

      final Finder languageButton = find.byType(EzLocaleSetting);

      expect(languageButton, findsOneWidget);
      await touch(tester, languageButton);

      final Finder englishButton = find.text(localeNames.nameOf('en')!).last;
      final Finder spanishButton = find.text(localeNames.nameOf('es')!).last;

      expect(englishButton, findsOneWidget);
      expect(spanishButton, findsOneWidget);

      await tester.tap(spanishButton);
      await tester.pumpAndSettle();

      await touch(tester, languageButton);

      await tester.tap(englishButton);
      await tester.pumpAndSettle();

      debugPrint('Selecting reset all');

      final Finder resetButton = find.byType(EzResetButton);

      expect(resetButton, findsOneWidget);
      await touch(tester, resetButton);

      final Finder noButton = find.text(l10n.gNo).last;
      final Finder yesButton = find.text(l10n.gYes).last;

      expect(noButton, findsOneWidget);
      expect(yesButton, findsOneWidget);

      await tester.tap(yesButton);
      await tester.pumpAndSettle();
    });
