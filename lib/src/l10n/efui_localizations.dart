import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'efui_localizations_en.dart' deferred as efui_localizations_en;
import 'efui_localizations_es.dart' deferred as efui_localizations_es;

/// Callers can lookup localized strings with an instance of EFUILocalizations
/// returned by `EFUILocalizations.of(context)`.
///
/// Applications need to include `EFUILocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/efui_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: EFUILocalizations.localizationsDelegates,
///   supportedLocales: EFUILocalizations.supportedLocales,
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
/// be consistent with the languages listed in the EFUILocalizations.supportedLocales
/// property.
abstract class EFUILocalizations {
  EFUILocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static EFUILocalizations? of(BuildContext context) {
    return Localizations.of<EFUILocalizations>(context, EFUILocalizations);
  }

  static const LocalizationsDelegate<EFUILocalizations> delegate =
      _EFUILocalizationsDelegate();

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

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'WARNING'**
  String get warning;

  /// No description provided for @useCustom.
  ///
  /// In en, this message translates to:
  /// **'Use custom'**
  String get useCustom;

  /// No description provided for @useRecommended.
  ///
  /// In en, this message translates to:
  /// **'Use recommended?'**
  String get useRecommended;

  /// No description provided for @resetTo.
  ///
  /// In en, this message translates to:
  /// **'Reset to...'**
  String get resetTo;

  /// No description provided for @colorSettingSemantics.
  ///
  /// In en, this message translates to:
  /// **'Activate to open a color picker for {name}. Long press to reset {name}.'**
  String colorSettingSemantics(Object name);

  /// No description provided for @right.
  ///
  /// In en, this message translates to:
  /// **'Right'**
  String get right;

  /// No description provided for @left.
  ///
  /// In en, this message translates to:
  /// **'Left'**
  String get left;

  /// No description provided for @dominantHand.
  ///
  /// In en, this message translates to:
  /// **'Dominant hand'**
  String get dominantHand;

  /// No description provided for @handSettingSemantics.
  ///
  /// In en, this message translates to:
  /// **'Open to choose left or right. Currently set to:'**
  String get handSettingSemantics;

  /// No description provided for @defaultTag.
  ///
  /// In en, this message translates to:
  /// **'{font}* (default)'**
  String defaultTag(Object font);

  /// No description provided for @chooseFont.
  ///
  /// In en, this message translates to:
  /// **'Choose a font'**
  String get chooseFont;

  /// No description provided for @fontSettingLabel.
  ///
  /// In en, this message translates to:
  /// **'Text font'**
  String get fontSettingLabel;

  /// No description provided for @fromFile.
  ///
  /// In en, this message translates to:
  /// **'From file'**
  String get fromFile;

  /// No description provided for @fromCamera.
  ///
  /// In en, this message translates to:
  /// **'From camera'**
  String get fromCamera;

  /// No description provided for @resetIt.
  ///
  /// In en, this message translates to:
  /// **'Reset it'**
  String get resetIt;

  /// No description provided for @clearIt.
  ///
  /// In en, this message translates to:
  /// **'Clear it'**
  String get clearIt;

  /// No description provided for @imageSettingDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'How should the {title} image be updated?'**
  String imageSettingDialogTitle(Object title);

  /// No description provided for @imageSettingHint.
  ///
  /// In en, this message translates to:
  /// **'Update the {title} image'**
  String imageSettingHint(Object title);

  /// No description provided for @creditTo.
  ///
  /// In en, this message translates to:
  /// **'Credit to:'**
  String get creditTo;

  /// No description provided for @image.
  ///
  /// In en, this message translates to:
  /// **'image'**
  String get image;

  /// No description provided for @resetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset all'**
  String get resetAll;

  /// No description provided for @resetButtonHint.
  ///
  /// In en, this message translates to:
  /// **'Reset all custom settings'**
  String get resetButtonHint;

  /// No description provided for @resetButtonDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset all settings?'**
  String get resetButtonDialogTitle;

  /// No description provided for @resetButtonDialogContents.
  ///
  /// In en, this message translates to:
  /// **'Cannot be undone'**
  String get resetButtonDialogContents;

  /// No description provided for @currently.
  ///
  /// In en, this message translates to:
  /// **'Currently: '**
  String get currently;

  /// No description provided for @nameSetToValue.
  ///
  /// In en, this message translates to:
  /// **'{name} is currently set to {value}'**
  String nameSetToValue(Object name, Object value);

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset: '**
  String get reset;

  /// No description provided for @resetNameToValue.
  ///
  /// In en, this message translates to:
  /// **'Reset {name} to {value}'**
  String resetNameToValue(Object name, Object value);

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme mode'**
  String get themeMode;

  /// No description provided for @themeSwitchSemantics.
  ///
  /// In en, this message translates to:
  /// **'Open to select a theme mode. Currently set to:'**
  String get themeSwitchSemantics;

  /// No description provided for @margin.
  ///
  /// In en, this message translates to:
  /// **'Margin'**
  String get margin;

  /// No description provided for @padding.
  ///
  /// In en, this message translates to:
  /// **'Padding'**
  String get padding;

  /// No description provided for @circleSize.
  ///
  /// In en, this message translates to:
  /// **'Circle button size'**
  String get circleSize;

  /// No description provided for @buttonSpacing.
  ///
  /// In en, this message translates to:
  /// **'Button spacing'**
  String get buttonSpacing;

  /// No description provided for @textSpacing.
  ///
  /// In en, this message translates to:
  /// **'Text spacing'**
  String get textSpacing;

  /// No description provided for @attention.
  ///
  /// In en, this message translates to:
  /// **'Attention'**
  String get attention;

  /// No description provided for @pickAColor.
  ///
  /// In en, this message translates to:
  /// **'Pick a color!'**
  String get pickAColor;

  /// No description provided for @clipCopy.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get clipCopy;

  /// No description provided for @failedImageGet.
  ///
  /// In en, this message translates to:
  /// **'Failed to retrieve image'**
  String get failedImageGet;

  /// No description provided for @failedImageSet.
  ///
  /// In en, this message translates to:
  /// **'Failed to update image:\n{error}'**
  String failedImageSet(Object error);
}

class _EFUILocalizationsDelegate
    extends LocalizationsDelegate<EFUILocalizations> {
  const _EFUILocalizationsDelegate();

  @override
  Future<EFUILocalizations> load(Locale locale) {
    return lookupEFUILocalizations(locale);
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_EFUILocalizationsDelegate old) => false;
}

Future<EFUILocalizations> lookupEFUILocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return efui_localizations_en
          .loadLibrary()
          .then((dynamic _) => efui_localizations_en.EFUILocalizationsEn());
    case 'es':
      return efui_localizations_es
          .loadLibrary()
          .then((dynamic _) => efui_localizations_es.EFUILocalizationsEs());
  }

  throw FlutterError(
      'EFUILocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
