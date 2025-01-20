import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'lang_en.dart' deferred as lang_en;
import 'lang_es.dart' deferred as lang_es;
import 'lang_fr.dart' deferred as lang_fr;

// ignore_for_file: type=lint

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
    Locale('es'),
    Locale('fr')
  ];

  /// No description provided for @gRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get gRequired;

  /// No description provided for @gSuccess.
  ///
  /// In en, this message translates to:
  /// **'Success!'**
  String get gSuccess;

  /// No description provided for @gFailure.
  ///
  /// In en, this message translates to:
  /// **'Failure'**
  String get gFailure;

  /// No description provided for @csInvalidName.
  ///
  /// In en, this message translates to:
  /// **'Lowercase letters, numbers, and underscores are allowed.'**
  String get csInvalidName;

  /// No description provided for @csInvalidDomain.
  ///
  /// In en, this message translates to:
  /// **'\'dom.name\' only; r\'^[a-z0-9_]+\\.[a-z]+\$\''**
  String get csInvalidDomain;

  /// No description provided for @csLoad.
  ///
  /// In en, this message translates to:
  /// **'Load config'**
  String get csLoad;

  /// No description provided for @csResetHint.
  ///
  /// In en, this message translates to:
  /// **'Activate and confirm what should be reset.'**
  String get csResetHint;

  /// No description provided for @csResetBuilder.
  ///
  /// In en, this message translates to:
  /// **'Builder values'**
  String get csResetBuilder;

  /// No description provided for @csResetApp.
  ///
  /// In en, this message translates to:
  /// **'App settings'**
  String get csResetApp;

  /// No description provided for @csResetBoth.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get csResetBoth;

  /// No description provided for @csResetNothing.
  ///
  /// In en, this message translates to:
  /// **'Nothing'**
  String get csResetNothing;

  /// No description provided for @rsWouldYou.
  ///
  /// In en, this message translates to:
  /// **'would you like to...'**
  String get rsWouldYou;

  /// No description provided for @rsInstall.
  ///
  /// In en, this message translates to:
  /// **'Install it'**
  String get rsInstall;

  /// No description provided for @rsRun.
  ///
  /// In en, this message translates to:
  /// **'Run it'**
  String get rsRun;

  /// No description provided for @rsWipe.
  ///
  /// In en, this message translates to:
  /// **'Wipe it'**
  String get rsWipe;

  /// No description provided for @rsNextTime.
  ///
  /// In en, this message translates to:
  /// **'Success, fingers crossed for next time!'**
  String get rsNextTime;

  /// No description provided for @rsAnotherOne.
  ///
  /// In en, this message translates to:
  /// **'Another failure; you should probably take over...'**
  String get rsAnotherOne;

  /// No description provided for @rsLeave.
  ///
  /// In en, this message translates to:
  /// **'Leave it'**
  String get rsLeave;
}

class _LangDelegate extends LocalizationsDelegate<Lang> {
  const _LangDelegate();

  @override
  Future<Lang> load(Locale locale) {
    return lookupLang(locale);
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'fr'].contains(locale.languageCode);

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
    case 'fr':
      return lang_fr.loadLibrary().then((dynamic _) => lang_fr.LangFr());
  }

  throw FlutterError(
      'Lang.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
