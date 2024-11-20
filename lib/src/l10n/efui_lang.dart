import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'efui_lang_en.dart' deferred as efui_lang_en;
import 'efui_lang_es.dart' deferred as efui_lang_es;
import 'efui_lang_fr.dart' deferred as efui_lang_fr;

// ignore_for_file: type=lint

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
    Locale('es'),
    Locale('fr')
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

  /// No description provided for @gAnd.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get gAnd;

  /// No description provided for @gOptions.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get gOptions;

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

  /// No description provided for @gError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get gError;

  /// No description provided for @g404Wonder.
  ///
  /// In en, this message translates to:
  /// **'Not all who wander are lost.'**
  String get g404Wonder;

  /// No description provided for @g404.
  ///
  /// In en, this message translates to:
  /// **'But, in this case: 404 page not found.'**
  String get g404;

  /// No description provided for @g404Note.
  ///
  /// In en, this message translates to:
  /// **'Note: Flutter web uses hash routing, like...\nhttps://www.example.com/#/settings'**
  String get g404Note;

  /// No description provided for @gClipboard.
  ///
  /// In en, this message translates to:
  /// **'{thing} has been copied to the clipboard.'**
  String gClipboard(Object thing);

  /// No description provided for @gUpdates.
  ///
  /// In en, this message translates to:
  /// **'Updates available'**
  String get gUpdates;

  /// No description provided for @gOpenSource.
  ///
  /// In en, this message translates to:
  /// **'Open source'**
  String get gOpenSource;

  /// No description provided for @gEFUISourceHint.
  ///
  /// In en, this message translates to:
  /// **'Open the GitHub page for EFUI'**
  String get gEFUISourceHint;

  /// No description provided for @gGiveFeedback.
  ///
  /// In en, this message translates to:
  /// **'Give feedback'**
  String get gGiveFeedback;

  /// No description provided for @gOpeningFeedback.
  ///
  /// In en, this message translates to:
  /// **'Opening the feedback tool.'**
  String get gOpeningFeedback;

  /// No description provided for @gSupportEmail.
  ///
  /// In en, this message translates to:
  /// **'Our support Email'**
  String get gSupportEmail;

  /// No description provided for @gSubmitWebFeedback.
  ///
  /// In en, this message translates to:
  /// **'Please take a screenshot{hint} of the issue.'**
  String gSubmitWebFeedback(Object hint);

  /// No description provided for @gAttachScreenshot.
  ///
  /// In en, this message translates to:
  /// **'Please attach your screenshot'**
  String get gAttachScreenshot;

  /// No description provided for @gValidURL.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid URL'**
  String get gValidURL;

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

  /// No description provided for @gBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get gBack;

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

  /// No description provided for @gEditing.
  ///
  /// In en, this message translates to:
  /// **'Editing: '**
  String get gEditing;

  /// No description provided for @gEditingTheme.
  ///
  /// In en, this message translates to:
  /// **'Editing: {themeType} theme'**
  String gEditingTheme(Object themeType);

  /// No description provided for @gQuick.
  ///
  /// In en, this message translates to:
  /// **'Quick'**
  String get gQuick;

  /// No description provided for @gAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get gAdvanced;

  /// No description provided for @gHowThisWorks.
  ///
  /// In en, this message translates to:
  /// **'How this works'**
  String get gHowThisWorks;

  /// No description provided for @gHowThisWorksHint.
  ///
  /// In en, this message translates to:
  /// **'Open helpful documentation'**
  String get gHowThisWorksHint;

  /// No description provided for @gTranslationsPending.
  ///
  /// In en, this message translates to:
  /// **'Translations pending human review'**
  String get gTranslationsPending;

  /// No description provided for @gAttention.
  ///
  /// In en, this message translates to:
  /// **'Attention'**
  String get gAttention;

  /// No description provided for @gCurrently.
  ///
  /// In en, this message translates to:
  /// **'Currently:'**
  String get gCurrently;

  /// No description provided for @gSetToValue.
  ///
  /// In en, this message translates to:
  /// **'{name} is set to {value}'**
  String gSetToValue(Object name, Object value);

  /// No description provided for @gReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get gReset;

  /// No description provided for @gResetTo.
  ///
  /// In en, this message translates to:
  /// **'Reset:'**
  String get gResetTo;

  /// No description provided for @gResetValue.
  ///
  /// In en, this message translates to:
  /// **'Reset {name}?'**
  String gResetValue(Object name);

  /// No description provided for @gResetValueTo.
  ///
  /// In en, this message translates to:
  /// **'Reset {name} to {value}'**
  String gResetValueTo(Object name, Object value);

  /// No description provided for @gResetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset all'**
  String get gResetAll;

  /// No description provided for @gUndoWarn.
  ///
  /// In en, this message translates to:
  /// **'Cannot be undone'**
  String get gUndoWarn;

  /// No description provided for @gCreditTo.
  ///
  /// In en, this message translates to:
  /// **'Credit to:'**
  String get gCreditTo;

  /// No description provided for @gYou.
  ///
  /// In en, this message translates to:
  /// **'Set by you'**
  String get gYou;

  /// No description provided for @ssPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get ssPageTitle;

  /// No description provided for @ssSettingsGuide.
  ///
  /// In en, this message translates to:
  /// **'Close and reopen the app to apply your changes.\n\nHave fun!'**
  String get ssSettingsGuide;

  /// No description provided for @ssSettingsGuideWeb.
  ///
  /// In en, this message translates to:
  /// **'Reload/refresh the page to apply your changes.\n\nHave fun!'**
  String get ssSettingsGuideWeb;

  /// No description provided for @ssThemeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme mode'**
  String get ssThemeMode;

  /// No description provided for @ssDominantHand.
  ///
  /// In en, this message translates to:
  /// **'Dominant hand'**
  String get ssDominantHand;

  /// No description provided for @ssLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get ssLanguage;

  /// No description provided for @ssLanguages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get ssLanguages;

  /// No description provided for @ssLangHint.
  ///
  /// In en, this message translates to:
  /// **'App language'**
  String get ssLangHint;

  /// No description provided for @ssRandom.
  ///
  /// In en, this message translates to:
  /// **'Randomize'**
  String get ssRandom;

  /// No description provided for @ssRandomize.
  ///
  /// In en, this message translates to:
  /// **'Randomize {themeType} theme?'**
  String ssRandomize(Object themeType);

  /// No description provided for @ssResetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset all settings?'**
  String get ssResetAll;

  /// No description provided for @tsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Text settings'**
  String get tsPageTitle;

  /// No description provided for @tsBatchOverride.
  ///
  /// In en, this message translates to:
  /// **'You have already made granular \"{setting}\" changes in advanced settings.\n\nAre you sure you want to override those changes with a batch update?'**
  String tsBatchOverride(Object setting);

  /// No description provided for @tsDisplay.
  ///
  /// In en, this message translates to:
  /// **'Display'**
  String get tsDisplay;

  /// No description provided for @tsHeadline.
  ///
  /// In en, this message translates to:
  /// **'Headline'**
  String get tsHeadline;

  /// No description provided for @tsTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get tsTitle;

  /// No description provided for @tsBody.
  ///
  /// In en, this message translates to:
  /// **'Body'**
  String get tsBody;

  /// No description provided for @tsLabel.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get tsLabel;

  /// No description provided for @tsLinkHint.
  ///
  /// In en, this message translates to:
  /// **'Activate to edit {style}'**
  String tsLinkHint(Object style);

  /// No description provided for @tsFontFamily.
  ///
  /// In en, this message translates to:
  /// **'Font family'**
  String get tsFontFamily;

  /// No description provided for @tsFontSize.
  ///
  /// In en, this message translates to:
  /// **'Font size'**
  String get tsFontSize;

  /// No description provided for @tsBold.
  ///
  /// In en, this message translates to:
  /// **'Bold'**
  String get tsBold;

  /// No description provided for @tsItalic.
  ///
  /// In en, this message translates to:
  /// **'Italic'**
  String get tsItalic;

  /// No description provided for @tsUnderline.
  ///
  /// In en, this message translates to:
  /// **'Underline'**
  String get tsUnderline;

  /// No description provided for @tsLetterSpacing.
  ///
  /// In en, this message translates to:
  /// **'Letter spacing'**
  String get tsLetterSpacing;

  /// No description provided for @tsWordSpacing.
  ///
  /// In en, this message translates to:
  /// **'Word spacing'**
  String get tsWordSpacing;

  /// No description provided for @tsLineHeight.
  ///
  /// In en, this message translates to:
  /// **'Line height'**
  String get tsLineHeight;

  /// No description provided for @tsDecrease.
  ///
  /// In en, this message translates to:
  /// **'Decrease'**
  String get tsDecrease;

  /// No description provided for @tsIncrease.
  ///
  /// In en, this message translates to:
  /// **'Increase'**
  String get tsIncrease;

  /// No description provided for @tsDisplayP1.
  ///
  /// In en, this message translates to:
  /// **'Does this '**
  String get tsDisplayP1;

  /// No description provided for @tsDisplayLink.
  ///
  /// In en, this message translates to:
  /// **'display'**
  String get tsDisplayLink;

  /// No description provided for @tsDisplayP2.
  ///
  /// In en, this message translates to:
  /// **' well?'**
  String get tsDisplayP2;

  /// No description provided for @tsHeadlineP1.
  ///
  /// In en, this message translates to:
  /// **'Are '**
  String get tsHeadlineP1;

  /// No description provided for @tsHeadlineLink.
  ///
  /// In en, this message translates to:
  /// **'headlines'**
  String get tsHeadlineLink;

  /// No description provided for @tsHeadlineP2.
  ///
  /// In en, this message translates to:
  /// **' distinct...'**
  String get tsHeadlineP2;

  /// No description provided for @tsTitleP1.
  ///
  /// In en, this message translates to:
  /// **'from '**
  String get tsTitleP1;

  /// No description provided for @tsTitleLink.
  ///
  /// In en, this message translates to:
  /// **'titles?'**
  String get tsTitleLink;

  /// No description provided for @tsBodyP1.
  ///
  /// In en, this message translates to:
  /// **'How about '**
  String get tsBodyP1;

  /// No description provided for @tsBodyLink.
  ///
  /// In en, this message translates to:
  /// **'the body?'**
  String get tsBodyLink;

  /// No description provided for @tsBodyP2.
  ///
  /// In en, this message translates to:
  /// **' Is it easy to read?'**
  String get tsBodyP2;

  /// No description provided for @tsLabelP1.
  ///
  /// In en, this message translates to:
  /// **'And '**
  String get tsLabelP1;

  /// No description provided for @tsLabelLink.
  ///
  /// In en, this message translates to:
  /// **'the labels?'**
  String get tsLabelLink;

  /// No description provided for @tsLabelP2.
  ///
  /// In en, this message translates to:
  /// **' Not too big, not too small?'**
  String get tsLabelP2;

  /// No description provided for @tsResetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset all text settings?'**
  String get tsResetAll;

  /// No description provided for @lsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Layout settings'**
  String get lsPageTitle;

  /// No description provided for @lsMargin.
  ///
  /// In en, this message translates to:
  /// **'Margin'**
  String get lsMargin;

  /// No description provided for @lsPadding.
  ///
  /// In en, this message translates to:
  /// **'Padding'**
  String get lsPadding;

  /// No description provided for @lsSpacing.
  ///
  /// In en, this message translates to:
  /// **'Spacing'**
  String get lsSpacing;

  /// No description provided for @lsScroll.
  ///
  /// In en, this message translates to:
  /// **'Hide scrollbars?'**
  String get lsScroll;

  /// No description provided for @lsResetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset all layout settings?'**
  String get lsResetAll;

  /// No description provided for @csPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Color settings'**
  String get csPageTitle;

  /// No description provided for @csPickerHint.
  ///
  /// In en, this message translates to:
  /// **'Open a color picker for {name}. Long press for more options.'**
  String csPickerHint(Object name);

  /// No description provided for @csMonoChrome.
  ///
  /// In en, this message translates to:
  /// **'Use monochrome scheme'**
  String get csMonoChrome;

  /// No description provided for @csHighContrast.
  ///
  /// In en, this message translates to:
  /// **'Use high contrast scheme'**
  String get csHighContrast;

  /// No description provided for @csPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Pick a color'**
  String get csPickerTitle;

  /// No description provided for @csRecommended.
  ///
  /// In en, this message translates to:
  /// **'Use contrast recommendation?'**
  String get csRecommended;

  /// No description provided for @csUseCustom.
  ///
  /// In en, this message translates to:
  /// **'Use custom'**
  String get csUseCustom;

  /// No description provided for @csAddColor.
  ///
  /// In en, this message translates to:
  /// **'Add a color'**
  String get csAddColor;

  /// No description provided for @csRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get csRemove;

  /// No description provided for @csReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get csReset;

  /// No description provided for @csCurrVal.
  ///
  /// In en, this message translates to:
  /// **'Current color value:'**
  String get csCurrVal;

  /// No description provided for @csSchemeBase.
  ///
  /// In en, this message translates to:
  /// **'Build scheme\nfrom image'**
  String get csSchemeBase;

  /// No description provided for @csOptional.
  ///
  /// In en, this message translates to:
  /// **'optional'**
  String get csOptional;

  /// No description provided for @csFromImage.
  ///
  /// In en, this message translates to:
  /// **'Build the color scheme from an image'**
  String get csFromImage;

  /// No description provided for @csColorScheme.
  ///
  /// In en, this message translates to:
  /// **'color scheme'**
  String get csColorScheme;

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

  /// No description provided for @isBackground.
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get isBackground;

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

  /// No description provided for @isEnterURL.
  ///
  /// In en, this message translates to:
  /// **'Enter URL'**
  String get isEnterURL;

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

  /// No description provided for @isPermission.
  ///
  /// In en, this message translates to:
  /// **'Some sites don\'t allow their images to be accessed by others.\nTry an image from another host.'**
  String get isPermission;

  /// No description provided for @isUseForColors.
  ///
  /// In en, this message translates to:
  /// **'Update the app colors using this image'**
  String get isUseForColors;

  /// No description provided for @isFit.
  ///
  /// In en, this message translates to:
  /// **'How should it fit?'**
  String get isFit;

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
      <String>['en', 'es', 'fr'].contains(locale.languageCode);

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
    case 'fr':
      return efui_lang_fr
          .loadLibrary()
          .then((dynamic _) => efui_lang_fr.EFUILangFr());
  }

  throw FlutterError(
      'EFUILang.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
