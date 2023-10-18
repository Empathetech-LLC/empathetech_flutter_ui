import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'efui_lang_en.dart' deferred as efui_lang_en;
import 'efui_lang_es.dart' deferred as efui_lang_es;

/// Callers can lookup localized strings with an instance of EFUILang
/// returned by `EFUILang.of(context)`.
///
/// Applications need to include `EFUILang.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/efui_lang.dart';
///
/// return MaterialApp(
///   localizationsDelegates: EFUILang.localizationsDelegates,
///   supportedLocales: EFUILang.supportedLocales,
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
/// be consistent with the languages listed in the EFUILang.supportedLocales
/// property.
abstract class EFUILang {
  EFUILang(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static EFUILang? of(BuildContext context) {
    return Localizations.of<EFUILang>(context, EFUILang);
  }

  static const LocalizationsDelegate<EFUILang> delegate = _EFUILangDelegate();

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

  /// No description provided for @gYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get gYes;

  /// No description provided for @gNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get gNo;

  /// No description provided for @gRight.
  ///
  /// In en, this message translates to:
  /// **'Right'**
  String get gRight;

  /// No description provided for @gLeft.
  ///
  /// In en, this message translates to:
  /// **'Left'**
  String get gLeft;

  /// No description provided for @gApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get gApply;

  /// No description provided for @gCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get gCancel;

  /// No description provided for @gClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get gClose;

  /// No description provided for @gSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get gSystem;

  /// No description provided for @gLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get gLight;

  /// No description provided for @gDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get gDark;

  /// No description provided for @gPage.
  ///
  /// In en, this message translates to:
  /// **'Page'**
  String get gPage;

  /// No description provided for @gAutoPlayDisabled.
  ///
  /// In en, this message translates to:
  /// **'Auto-play videos are disabled.'**
  String get gAutoPlayDisabled;

  /// No description provided for @dHomeHint.
  ///
  /// In en, this message translates to:
  /// **'Return to the home screen'**
  String get dHomeHint;

  /// No description provided for @dResetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset all'**
  String get dResetAll;

  /// No description provided for @dResetDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset all settings?'**
  String get dResetDialogTitle;

  /// No description provided for @dResetDialogContent.
  ///
  /// In en, this message translates to:
  /// **'Cannot be undone'**
  String get dResetDialogContent;

  /// No description provided for @dAttention.
  ///
  /// In en, this message translates to:
  /// **'Attention'**
  String get dAttention;

  /// No description provided for @dResetAllWarn.
  ///
  /// In en, this message translates to:
  /// **'Cannot be undone\nChanges take effect on app restart'**
  String get dResetAllWarn;

  /// No description provided for @dResetAllWarnWeb.
  ///
  /// In en, this message translates to:
  /// **'Cannot be undone\nChanges take effect on page reload'**
  String get dResetAllWarnWeb;

  /// No description provided for @dEditingTheme.
  ///
  /// In en, this message translates to:
  /// **'Editing: {themeType} theme'**
  String dEditingTheme(Object themeType);

  /// No description provided for @hsThemeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme mode'**
  String get hsThemeMode;

  /// No description provided for @hsThemeSemantics.
  ///
  /// In en, this message translates to:
  /// **'Open to select a theme mode. Currently set to:'**
  String get hsThemeSemantics;

  /// No description provided for @hsDominantHand.
  ///
  /// In en, this message translates to:
  /// **'Dominant hand'**
  String get hsDominantHand;

  /// No description provided for @hsHandSemantics.
  ///
  /// In en, this message translates to:
  /// **'Open to choose left or right. Currently set to:'**
  String get hsHandSemantics;

  /// No description provided for @ssPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get ssPageTitle;

  /// No description provided for @ssSettingsGuide.
  ///
  /// In en, this message translates to:
  /// **'Each button will preview it\'s changes.\nReload the page for your changes to take full effect!\nHave fun!'**
  String get ssSettingsGuide;

  /// No description provided for @ssSettingsGuideWeb.
  ///
  /// In en, this message translates to:
  /// **'Each button will preview it\'s changes.\nRestart the app for your changes to take full effect!\nHave fun!'**
  String get ssSettingsGuideWeb;

  /// No description provided for @stsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Style settings'**
  String get stsPageTitle;

  /// No description provided for @stsTextFont.
  ///
  /// In en, this message translates to:
  /// **'Text font'**
  String get stsTextFont;

  /// No description provided for @stschooseFont.
  ///
  /// In en, this message translates to:
  /// **'Choose a font'**
  String get stschooseFont;

  /// No description provided for @stsDefaultFont.
  ///
  /// In en, this message translates to:
  /// **'{font}* (default)'**
  String stsDefaultFont(Object font);

  /// No description provided for @stsMargin.
  ///
  /// In en, this message translates to:
  /// **'Margin'**
  String get stsMargin;

  /// No description provided for @stsPadding.
  ///
  /// In en, this message translates to:
  /// **'Padding'**
  String get stsPadding;

  /// No description provided for @stsCircleSize.
  ///
  /// In en, this message translates to:
  /// **'Circle button size'**
  String get stsCircleSize;

  /// No description provided for @stsButtonSpacing.
  ///
  /// In en, this message translates to:
  /// **'Button spacing'**
  String get stsButtonSpacing;

  /// No description provided for @stsTextSpacing.
  ///
  /// In en, this message translates to:
  /// **'Text spacing'**
  String get stsTextSpacing;

  /// No description provided for @stsCurrently.
  ///
  /// In en, this message translates to:
  /// **'Currently: '**
  String get stsCurrently;

  /// No description provided for @stsSetToValue.
  ///
  /// In en, this message translates to:
  /// **'{name} is currently set to {value}'**
  String stsSetToValue(Object name, Object value);

  /// No description provided for @stsReset.
  ///
  /// In en, this message translates to:
  /// **'Reset: '**
  String get stsReset;

  /// No description provided for @stsResetToValue.
  ///
  /// In en, this message translates to:
  /// **'Reset {name} to {value}'**
  String stsResetToValue(Object name, Object value);

  /// No description provided for @stsResetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset all style settings?'**
  String get stsResetAll;

  /// No description provided for @csPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Color settings'**
  String get csPageTitle;

  /// No description provided for @csEditingTheme.
  ///
  /// In en, this message translates to:
  /// **'Editing: {themeType} theme\nLong press buttons to reset individually'**
  String csEditingTheme(Object themeType);

  /// No description provided for @csPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Pick a color!'**
  String get csPickerTitle;

  /// No description provided for @csPickerSemantics.
  ///
  /// In en, this message translates to:
  /// **'Activate to open a color picker for {name}. Long press to reset {name}.'**
  String csPickerSemantics(Object name);

  /// No description provided for @csResetTo.
  ///
  /// In en, this message translates to:
  /// **'Reset to...'**
  String get csResetTo;

  /// No description provided for @csTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get csTheme;

  /// No description provided for @csThemeText.
  ///
  /// In en, this message translates to:
  /// **'Theme text'**
  String get csThemeText;

  /// No description provided for @csRecommended.
  ///
  /// In en, this message translates to:
  /// **'Use recommended?'**
  String get csRecommended;

  /// No description provided for @csUseCustom.
  ///
  /// In en, this message translates to:
  /// **'Use custom'**
  String get csUseCustom;

  /// No description provided for @csPageText.
  ///
  /// In en, this message translates to:
  /// **'Page text'**
  String get csPageText;

  /// No description provided for @csButtons.
  ///
  /// In en, this message translates to:
  /// **'Buttons'**
  String get csButtons;

  /// No description provided for @csButtonText.
  ///
  /// In en, this message translates to:
  /// **'Buttons text'**
  String get csButtonText;

  /// No description provided for @csAccent.
  ///
  /// In en, this message translates to:
  /// **'Accent'**
  String get csAccent;

  /// No description provided for @csAccentText.
  ///
  /// In en, this message translates to:
  /// **'Accent text'**
  String get csAccentText;

  /// No description provided for @csResetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset all {themeType} theme colors?'**
  String csResetAll(Object themeType);

  /// No description provided for @isPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Image settings'**
  String get isPageTitle;

  /// No description provided for @isImage.
  ///
  /// In en, this message translates to:
  /// **'image'**
  String get isImage;

  /// No description provided for @isButtonHint.
  ///
  /// In en, this message translates to:
  /// **'Update the {title} image'**
  String isButtonHint(Object title);

  /// No description provided for @isDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'How should the {title} image be updated?'**
  String isDialogTitle(Object title);

  /// No description provided for @isFromFile.
  ///
  /// In en, this message translates to:
  /// **'From file'**
  String get isFromFile;

  /// No description provided for @isFromCamera.
  ///
  /// In en, this message translates to:
  /// **'From camera'**
  String get isFromCamera;

  /// No description provided for @isGetFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to retrieve image'**
  String get isGetFailed;

  /// No description provided for @isSetFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update image:\n{error}'**
  String isSetFailed(Object error);

  /// No description provided for @isResetIt.
  ///
  /// In en, this message translates to:
  /// **'Reset it'**
  String get isResetIt;

  /// No description provided for @isClearIt.
  ///
  /// In en, this message translates to:
  /// **'Clear it'**
  String get isClearIt;

  /// No description provided for @isCreditTo.
  ///
  /// In en, this message translates to:
  /// **'Credit to:'**
  String get isCreditTo;

  /// No description provided for @isSource.
  ///
  /// In en, this message translates to:
  /// **'Wherever you got it!'**
  String get isSource;

  /// No description provided for @isResetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset all {themeType} theme images?'**
  String isResetAll(Object themeType);
}

class _EFUILangDelegate extends LocalizationsDelegate<EFUILang> {
  const _EFUILangDelegate();

  @override
  Future<EFUILang> load(Locale locale) {
    return lookupEFUILang(locale);
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_EFUILangDelegate old) => false;
}

Future<EFUILang> lookupEFUILang(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return efui_lang_en
          .loadLibrary()
          .then((dynamic _) => efui_lang_en.EFUILangEn());
    case 'es':
      return efui_lang_es
          .loadLibrary()
          .then((dynamic _) => efui_lang_es.EFUILangEs());
  }

  throw FlutterError(
      'EFUILang.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
