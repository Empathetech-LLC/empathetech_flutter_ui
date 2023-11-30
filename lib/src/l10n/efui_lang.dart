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

  /// No description provided for @gLeft.
  ///
  /// In en, this message translates to:
  /// **'Left'**
  String get gLeft;

  /// No description provided for @gRight.
  ///
  /// In en, this message translates to:
  /// **'Right'**
  String get gRight;

  /// No description provided for @gHomeHint.
  ///
  /// In en, this message translates to:
  /// **'Return to the home screen'**
  String get gHomeHint;

  /// No description provided for @gAttention.
  ///
  /// In en, this message translates to:
  /// **'Attention'**
  String get gAttention;

  /// No description provided for @gApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get gApply;

  /// No description provided for @gContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get gContinue;

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

  /// No description provided for @gDefaultEntry.
  ///
  /// In en, this message translates to:
  /// **'{entry}* (default)'**
  String gDefaultEntry(Object entry);

  /// No description provided for @gCurrently.
  ///
  /// In en, this message translates to:
  /// **'Currently: '**
  String get gCurrently;

  /// No description provided for @gSetToValue.
  ///
  /// In en, this message translates to:
  /// **'{name} is currently set to {value}'**
  String gSetToValue(Object name, Object value);

  /// No description provided for @gReset.
  ///
  /// In en, this message translates to:
  /// **'Reset: '**
  String get gReset;

  /// No description provided for @gResetToValue.
  ///
  /// In en, this message translates to:
  /// **'Reset {name} to {value}'**
  String gResetToValue(Object name, Object value);

  /// No description provided for @gResetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset all'**
  String get gResetAll;

  /// No description provided for @gResetWarn.
  ///
  /// In en, this message translates to:
  /// **'Cannot be undone'**
  String get gResetWarn;

  /// No description provided for @gResetTip.
  ///
  /// In en, this message translates to:
  /// **'Cannot be undone\nChanges take effect on app restart'**
  String get gResetTip;

  /// No description provided for @gResetTipWeb.
  ///
  /// In en, this message translates to:
  /// **'Cannot be undone\nChanges take effect on page reload'**
  String get gResetTipWeb;

  /// No description provided for @gEditingTheme.
  ///
  /// In en, this message translates to:
  /// **'Editing: {themeType} theme'**
  String gEditingTheme(Object themeType);

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

  /// No description provided for @gPlay.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get gPlay;

  /// No description provided for @gPause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get gPause;

  /// No description provided for @gReplay.
  ///
  /// In en, this message translates to:
  /// **'Replay'**
  String get gReplay;

  /// No description provided for @gMute.
  ///
  /// In en, this message translates to:
  /// **'Mute'**
  String get gMute;

  /// No description provided for @gAutoPlayDisabled.
  ///
  /// In en, this message translates to:
  /// **'Auto-play videos are disabled.'**
  String get gAutoPlayDisabled;

  /// No description provided for @ssPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get ssPageTitle;

  /// No description provided for @ssSettingsGuide.
  ///
  /// In en, this message translates to:
  /// **'Each setting will preview it\'s changes.\nReload the page for your changes to take full effect!\nHave fun!'**
  String get ssSettingsGuide;

  /// No description provided for @ssSettingsGuideWeb.
  ///
  /// In en, this message translates to:
  /// **'Each setting will preview it\'s changes.\nRestart the app for your changes to take full effect!\nHave fun!'**
  String get ssSettingsGuideWeb;

  /// No description provided for @ssLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get ssLanguage;

  /// No description provided for @ssLangSemantics.
  ///
  /// In en, this message translates to:
  /// **'Activate to update the app language'**
  String get ssLangSemantics;

  /// No description provided for @ssLanguages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get ssLanguages;

  /// No description provided for @ssResetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset all settings?'**
  String get ssResetAll;

  /// No description provided for @isPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Image settings'**
  String get isPageTitle;

  /// No description provided for @isPage.
  ///
  /// In en, this message translates to:
  /// **'Page'**
  String get isPage;

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

  /// No description provided for @isFromNetwork.
  ///
  /// In en, this message translates to:
  /// **'From URL'**
  String get isFromNetwork;

  /// No description provided for @isEnterURL.
  ///
  /// In en, this message translates to:
  /// **'Enter URL'**
  String get isEnterURL;

  /// No description provided for @isNetworkPreview.
  ///
  /// In en, this message translates to:
  /// **'Preview of your chosen image'**
  String get isNetworkPreview;

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

  /// No description provided for @csPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Color settings'**
  String get csPageTitle;

  /// No description provided for @csThemeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme mode'**
  String get csThemeMode;

  /// No description provided for @csThemeSemantics.
  ///
  /// In en, this message translates to:
  /// **'Open to select a theme mode. Currently set to:'**
  String get csThemeSemantics;

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

  /// No description provided for @csResetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset all {themeType} theme colors?'**
  String csResetAll(Object themeType);

  /// No description provided for @csBackground.
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get csBackground;

  /// No description provided for @csOnBackground.
  ///
  /// In en, this message translates to:
  /// **'Background text'**
  String get csOnBackground;

  /// No description provided for @csSurface.
  ///
  /// In en, this message translates to:
  /// **'Surface'**
  String get csSurface;

  /// No description provided for @csOnSurface.
  ///
  /// In en, this message translates to:
  /// **'Surface text'**
  String get csOnSurface;

  /// No description provided for @csPrimary.
  ///
  /// In en, this message translates to:
  /// **'Primary'**
  String get csPrimary;

  /// No description provided for @csOnPrimary.
  ///
  /// In en, this message translates to:
  /// **'Primary text'**
  String get csOnPrimary;

  /// No description provided for @csSecondary.
  ///
  /// In en, this message translates to:
  /// **'Secondary'**
  String get csSecondary;

  /// No description provided for @csOnSecondary.
  ///
  /// In en, this message translates to:
  /// **'Secondary text'**
  String get csOnSecondary;

  /// No description provided for @csTertiary.
  ///
  /// In en, this message translates to:
  /// **'Tertiary'**
  String get csTertiary;

  /// No description provided for @csOnTertiary.
  ///
  /// In en, this message translates to:
  /// **'Tertiary text'**
  String get csOnTertiary;

  /// No description provided for @csError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get csError;

  /// No description provided for @csOnError.
  ///
  /// In en, this message translates to:
  /// **'Error text'**
  String get csOnError;

  /// No description provided for @csOutline.
  ///
  /// In en, this message translates to:
  /// **'Outline'**
  String get csOutline;

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

  /// No description provided for @lsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Layout settings'**
  String get lsPageTitle;

  /// No description provided for @lsDominantHand.
  ///
  /// In en, this message translates to:
  /// **'Dominant hand'**
  String get lsDominantHand;

  /// No description provided for @lsHandSemantics.
  ///
  /// In en, this message translates to:
  /// **'Open to choose left or right. Currently set to:'**
  String get lsHandSemantics;

  /// No description provided for @lsMargin.
  ///
  /// In en, this message translates to:
  /// **'Margin'**
  String get lsMargin;

  /// No description provided for @lsTextSpacing.
  ///
  /// In en, this message translates to:
  /// **'Text spacing'**
  String get lsTextSpacing;

  /// No description provided for @lsButtonSpacing.
  ///
  /// In en, this message translates to:
  /// **'Button spacing'**
  String get lsButtonSpacing;

  /// No description provided for @lsResetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset all layout settings?'**
  String get lsResetAll;

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

  /// No description provided for @stsFonts.
  ///
  /// In en, this message translates to:
  /// **'Fonts'**
  String get stsFonts;

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

  /// No description provided for @stsResetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset all style settings?'**
  String get stsResetAll;
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
