import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'lang_en.dart' deferred as lang_en;
import 'lang_es.dart' deferred as lang_es;

/// Callers can lookup localized strings with an instance of Lang
/// returned by `Lang.of(context)`.
///
/// Applications need to include `Lang.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/lang.dart';
///
/// return MaterialApp(
///   localizationsDelegates: Lang.localizationsDelegates,
///   supportedLocales: Lang.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the Lang.supportedLocales
/// property.
abstract class Lang {
  Lang(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static Lang? of(BuildContext context) {
    return Localizations.of<Lang>(context, Lang);
  }

  static const LocalizationsDelegate<Lang> delegate = _LangDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @homeLinkHint.
  ///
  /// In en, this message translates to:
  /// **'Return to the home screen'**
  String get homeLinkHint;

  /// No description provided for @editingTheme.
  ///
  /// In en, this message translates to:
  /// **'Editing: {themeType} theme'**
  String editingTheme(Object themeType);

  /// No description provided for @resetAllWarning.
  ///
  /// In en, this message translates to:
  /// **'Cannot be undone\nChanges take effect on app restart'**
  String get resetAllWarning;

  /// No description provided for @resetAllWarningWeb.
  ///
  /// In en, this message translates to:
  /// **'Cannot be undone\nChanges take effect on page reload'**
  String get resetAllWarningWeb;

  /// No description provided for @imageSettings.
  ///
  /// In en, this message translates to:
  /// **'Image settings'**
  String get imageSettings;

  /// No description provided for @resetAllImages.
  ///
  /// In en, this message translates to:
  /// **'Reset all {themeType} theme images?'**
  String resetAllImages(Object themeType);

  /// No description provided for @page.
  ///
  /// In en, this message translates to:
  /// **'Page'**
  String get page;

  /// No description provided for @yourSourceCredit.
  ///
  /// In en, this message translates to:
  /// **'Wherever you got it!'**
  String get yourSourceCredit;

  /// No description provided for @colorSettings.
  ///
  /// In en, this message translates to:
  /// **'Color settings'**
  String get colorSettings;

  /// No description provided for @resetAllColors.
  ///
  /// In en, this message translates to:
  /// **'Reset all {themeType} theme colors?'**
  String resetAllColors(Object themeType);

  /// No description provided for @editingThemeColors.
  ///
  /// In en, this message translates to:
  /// **'Editing: {themeType} theme\nLong press buttons to reset individually'**
  String editingThemeColors(Object themeType);

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @themeText.
  ///
  /// In en, this message translates to:
  /// **'Theme text'**
  String get themeText;

  /// No description provided for @pageText.
  ///
  /// In en, this message translates to:
  /// **'Page text'**
  String get pageText;

  /// No description provided for @buttons.
  ///
  /// In en, this message translates to:
  /// **'Buttons'**
  String get buttons;

  /// No description provided for @buttonText.
  ///
  /// In en, this message translates to:
  /// **'Buttons text'**
  String get buttonText;

  /// No description provided for @accent.
  ///
  /// In en, this message translates to:
  /// **'Accent'**
  String get accent;

  /// No description provided for @accentText.
  ///
  /// In en, this message translates to:
  /// **'Accent text'**
  String get accentText;

  /// No description provided for @styleSettings.
  ///
  /// In en, this message translates to:
  /// **'Style settings'**
  String get styleSettings;

  /// No description provided for @resetAllStyle.
  ///
  /// In en, this message translates to:
  /// **'Reset all style settings?'**
  String get resetAllStyle;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @attention.
  ///
  /// In en, this message translates to:
  /// **'ATTENTION'**
  String get attention;

  /// No description provided for @resetWarning.
  ///
  /// In en, this message translates to:
  /// **'Each button will preview it\'s changes.\nReload the page for your changes to take full effect!\nHave fun!'**
  String get resetWarning;

  /// No description provided for @resetWarningWeb.
  ///
  /// In en, this message translates to:
  /// **'Each button will preview it\'s changes.\nRestart the app for your changes to take full effect!\nHave fun!'**
  String get resetWarningWeb;

  /// No description provided for @styling.
  ///
  /// In en, this message translates to:
  /// **'Styling'**
  String get styling;

  /// No description provided for @colors.
  ///
  /// In en, this message translates to:
  /// **'Colors'**
  String get colors;

  /// No description provided for @images.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get images;
}

class _LangDelegate extends LocalizationsDelegate<Lang> {
  const _LangDelegate();

  @override
  Future<Lang> load(Locale locale) {
    return lookupLang(locale);
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_LangDelegate old) => false;
}

Future<Lang> lookupLang(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return lang_en.loadLibrary().then((dynamic _) => lang_en.LangEn());
    case 'es':
      return lang_es.loadLibrary().then((dynamic _) => lang_es.LangEs());
  }

  throw FlutterError(
      'Lang.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
