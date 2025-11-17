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
    Locale('en', 'US'),
    Locale('es'),
    Locale('fr')
  ];

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

  /// No description provided for @gSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get gSkip;

  /// No description provided for @gOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get gOpen;

  /// No description provided for @gOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Open link'**
  String get gOpenLink;

  /// No description provided for @gSuccess.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get gSuccess;

  /// No description provided for @gSuccessExl.
  ///
  /// In en, this message translates to:
  /// **'Success!'**
  String get gSuccessExl;

  /// No description provided for @gYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get gYes;

  /// No description provided for @gAnd.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get gAnd;

  /// No description provided for @gHelp.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get gHelp;

  /// No description provided for @gNA.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get gNA;

  /// No description provided for @gNAHint.
  ///
  /// In en, this message translates to:
  /// **'Not applicable'**
  String get gNAHint;

  /// No description provided for @gOptional.
  ///
  /// In en, this message translates to:
  /// **'optional'**
  String get gOptional;

  /// No description provided for @gOptions.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get gOptions;

  /// No description provided for @gRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get gRequired;

  /// No description provided for @gBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get gBack;

  /// No description provided for @gUndo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get gUndo;

  /// No description provided for @gRedo.
  ///
  /// In en, this message translates to:
  /// **'Redo'**
  String get gRedo;

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

  /// No description provided for @gDisabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get gDisabled;

  /// No description provided for @gError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get gError;

  /// No description provided for @gFailure.
  ///
  /// In en, this message translates to:
  /// **'Failure'**
  String get gFailure;

  /// No description provided for @gNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get gNo;

  /// No description provided for @gDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get gDark;

  /// No description provided for @gLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get gLight;

  /// No description provided for @gSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get gSystem;

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

  /// No description provided for @gAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get gAdvanced;

  /// No description provided for @gQuick.
  ///
  /// In en, this message translates to:
  /// **'Quick'**
  String get gQuick;

  /// No description provided for @gDecrease.
  ///
  /// In en, this message translates to:
  /// **'Decrease'**
  String get gDecrease;

  /// No description provided for @gIncrease.
  ///
  /// In en, this message translates to:
  /// **'Increase'**
  String get gIncrease;

  /// No description provided for @gMaximum.
  ///
  /// In en, this message translates to:
  /// **'Maximum'**
  String get gMaximum;

  /// No description provided for @gMinimum.
  ///
  /// In en, this message translates to:
  /// **'Minimum'**
  String get gMinimum;

  /// No description provided for @gCenterReset.
  ///
  /// In en, this message translates to:
  /// **'Hold center to reset'**
  String get gCenterReset;

  /// No description provided for @gLoadingAnim.
  ///
  /// In en, this message translates to:
  /// **'Loading. The Empathetic logo animated as a spinning hourglass.'**
  String get gLoadingAnim;

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

  /// No description provided for @gUnMute.
  ///
  /// In en, this message translates to:
  /// **'Un-mute'**
  String get gUnMute;

  /// No description provided for @gPlaybackSpeed.
  ///
  /// In en, this message translates to:
  /// **'Playback speed'**
  String get gPlaybackSpeed;

  /// No description provided for @gCaptions.
  ///
  /// In en, this message translates to:
  /// **'Subtitles/captions'**
  String get gCaptions;

  /// No description provided for @gCaptionsHint.
  ///
  /// In en, this message translates to:
  /// **'Hold for fonts'**
  String get gCaptionsHint;

  /// No description provided for @gFullScreen.
  ///
  /// In en, this message translates to:
  /// **'Fullscreen'**
  String get gFullScreen;

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

  /// No description provided for @gUpdates.
  ///
  /// In en, this message translates to:
  /// **'Updates available'**
  String get gUpdates;

  /// No description provided for @gHardRefresh.
  ///
  /// In en, this message translates to:
  /// **'Please hard refresh the page...\nCtrl + Shift + R'**
  String get gHardRefresh;

  /// No description provided for @gHardRefreshMac.
  ///
  /// In en, this message translates to:
  /// **'Please hard refresh the page...\nCommand + Shift + R'**
  String get gHardRefreshMac;

  /// No description provided for @gHardRefreshMobile.
  ///
  /// In en, this message translates to:
  /// **'Please refresh the page in the browser menu.'**
  String get gHardRefreshMobile;

  /// No description provided for @gEnterURL.
  ///
  /// In en, this message translates to:
  /// **'Enter URL'**
  String get gEnterURL;

  /// No description provided for @gValidURL.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid URL'**
  String get gValidURL;

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
  /// **'Note: Flutter web uses hash routing, like...\nhttps://www.example.com/#/destination'**
  String get g404Note;

  /// No description provided for @gOpenSource.
  ///
  /// In en, this message translates to:
  /// **'Open source'**
  String get gOpenSource;

  /// No description provided for @gOpenEmpathetech.
  ///
  /// In en, this message translates to:
  /// **'Open a link to Empathetic LLC'**
  String get gOpenEmpathetech;

  /// No description provided for @gEFUISourceHint.
  ///
  /// In en, this message translates to:
  /// **'Open the GitHub page for EFUI'**
  String get gEFUISourceHint;

  /// No description provided for @gOpenUIReleases.
  ///
  /// In en, this message translates to:
  /// **'Open the releases page for Open UI'**
  String get gOpenUIReleases;

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

  /// No description provided for @gAttachScreenshot.
  ///
  /// In en, this message translates to:
  /// **'Please attach your screenshot (in Downloads folder)'**
  String get gAttachScreenshot;

  /// No description provided for @gSupportEmail.
  ///
  /// In en, this message translates to:
  /// **'Our support Email'**
  String get gSupportEmail;

  /// No description provided for @gClipboard.
  ///
  /// In en, this message translates to:
  /// **'{thing} has been copied to the clipboard.'**
  String gClipboard(Object thing);

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

  /// No description provided for @gRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get gRemove;

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
  /// **'Cannot be undone.'**
  String get gUndoWarn;

  /// No description provided for @gCreditTo.
  ///
  /// In en, this message translates to:
  /// **'Credit to:'**
  String get gCreditTo;

  /// No description provided for @gCreator.
  ///
  /// In en, this message translates to:
  /// **'Creator of'**
  String get gCreator;

  /// No description provided for @gMadeBy.
  ///
  /// In en, this message translates to:
  /// **'Made by'**
  String get gMadeBy;

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

  /// No description provided for @ssNavHint.
  ///
  /// In en, this message translates to:
  /// **'Open the settings page'**
  String get ssNavHint;

  /// No description provided for @ssRestartReminder.
  ///
  /// In en, this message translates to:
  /// **'Close and reopen the app to apply your changes.'**
  String get ssRestartReminder;

  /// No description provided for @ssRestartReminderWeb.
  ///
  /// In en, this message translates to:
  /// **'Reload/refresh the page to apply your changes.'**
  String get ssRestartReminderWeb;

  /// No description provided for @ssHaveFun.
  ///
  /// In en, this message translates to:
  /// **'Have fun!'**
  String get ssHaveFun;

  /// No description provided for @ssDominantHand.
  ///
  /// In en, this message translates to:
  /// **'Dominant hand'**
  String get ssDominantHand;

  /// No description provided for @ssThemeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme mode'**
  String get ssThemeMode;

  /// No description provided for @ssLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get ssLanguage;

  /// No description provided for @ssLangHint.
  ///
  /// In en, this message translates to:
  /// **'Activate to change the app language'**
  String get ssLangHint;

  /// No description provided for @ssLoadPreset.
  ///
  /// In en, this message translates to:
  /// **'Load preset'**
  String get ssLoadPreset;

  /// No description provided for @ssLoadPresetHint.
  ///
  /// In en, this message translates to:
  /// **'Activate to show presets'**
  String get ssLoadPresetHint;

  /// No description provided for @ssBigButtons.
  ///
  /// In en, this message translates to:
  /// **'Big buttons'**
  String get ssBigButtons;

  /// No description provided for @ssHighVisibility.
  ///
  /// In en, this message translates to:
  /// **'High visibility'**
  String get ssHighVisibility;

  /// No description provided for @ssVideoGame.
  ///
  /// In en, this message translates to:
  /// **'Video game'**
  String get ssVideoGame;

  /// No description provided for @ssChalkboard.
  ///
  /// In en, this message translates to:
  /// **'Chalkboard'**
  String get ssChalkboard;

  /// No description provided for @ssFancyPants.
  ///
  /// In en, this message translates to:
  /// **'Fancy pants'**
  String get ssFancyPants;

  /// No description provided for @ssDarkOnly.
  ///
  /// In en, this message translates to:
  /// **'This is a dark theme preset. It will set the theme mode to dark, and update that theme.\nContinue?'**
  String get ssDarkOnly;

  /// No description provided for @ssLightOnly.
  ///
  /// In en, this message translates to:
  /// **'This is a light theme preset. It will set the theme mode to light, and update that theme.\nContinue?'**
  String get ssLightOnly;

  /// No description provided for @ssApplied.
  ///
  /// In en, this message translates to:
  /// **'{config} applied.'**
  String ssApplied(Object config);

  /// No description provided for @ssTryMe.
  ///
  /// In en, this message translates to:
  /// **'Try me'**
  String get ssTryMe;

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

  /// No description provided for @ssConfigTip.
  ///
  /// In en, this message translates to:
  /// **'Save/load config'**
  String get ssConfigTip;

  /// No description provided for @ssSaveConfig.
  ///
  /// In en, this message translates to:
  /// **'Save config'**
  String get ssSaveConfig;

  /// No description provided for @ssConfigSaved.
  ///
  /// In en, this message translates to:
  /// **'Your configuration has been saved to {path}'**
  String ssConfigSaved(Object path);

  /// No description provided for @ssWrongConfigExt.
  ///
  /// In en, this message translates to:
  /// **'The file was not saved as '**
  String get ssWrongConfigExt;

  /// No description provided for @ssLoadConfig.
  ///
  /// In en, this message translates to:
  /// **'Load config'**
  String get ssLoadConfig;

  /// No description provided for @ssResetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset all settings?'**
  String get ssResetAll;

  /// No description provided for @csPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Color settings'**
  String get csPageTitle;

  /// No description provided for @csPickerHint.
  ///
  /// In en, this message translates to:
  /// **'Open a color picker. Long press for more options.'**
  String get csPickerHint;

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

  /// No description provided for @csFromImage.
  ///
  /// In en, this message translates to:
  /// **'A color scheme will be generated from the image.'**
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

  /// No description provided for @dsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Design settings'**
  String get dsPageTitle;

  /// No description provided for @dsAnimDuration.
  ///
  /// In en, this message translates to:
  /// **'Animation duration'**
  String get dsAnimDuration;

  /// No description provided for @dsMilliseconds.
  ///
  /// In en, this message translates to:
  /// **'Milliseconds'**
  String get dsMilliseconds;

  /// No description provided for @dsPreview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get dsPreview;

  /// No description provided for @dsButtonOpacity.
  ///
  /// In en, this message translates to:
  /// **'Button opacity'**
  String get dsButtonOpacity;

  /// No description provided for @dsBackground.
  ///
  /// In en, this message translates to:
  /// **'Background opacity'**
  String get dsBackground;

  /// No description provided for @dsOutline.
  ///
  /// In en, this message translates to:
  /// **'Outline opacity'**
  String get dsOutline;

  /// No description provided for @dsBackgroundImg.
  ///
  /// In en, this message translates to:
  /// **'Background image'**
  String get dsBackgroundImg;

  /// No description provided for @dsImgSettingHint.
  ///
  /// In en, this message translates to:
  /// **'Update the {title} image'**
  String dsImgSettingHint(Object title);

  /// No description provided for @dsFromFile.
  ///
  /// In en, this message translates to:
  /// **'From file'**
  String get dsFromFile;

  /// No description provided for @dsFromCamera.
  ///
  /// In en, this message translates to:
  /// **'From camera'**
  String get dsFromCamera;

  /// No description provided for @dsFromNetwork.
  ///
  /// In en, this message translates to:
  /// **'From URL'**
  String get dsFromNetwork;

  /// No description provided for @dsResetIt.
  ///
  /// In en, this message translates to:
  /// **'Reset it'**
  String get dsResetIt;

  /// No description provided for @dsClearIt.
  ///
  /// In en, this message translates to:
  /// **'Clear it'**
  String get dsClearIt;

  /// No description provided for @dsUseForColors.
  ///
  /// In en, this message translates to:
  /// **'Update the app colors using this image'**
  String get dsUseForColors;

  /// No description provided for @dsImgGetFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to retrieve image'**
  String get dsImgGetFailed;

  /// No description provided for @dsImgSetFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update image'**
  String get dsImgSetFailed;

  /// No description provided for @dsImgPermission.
  ///
  /// In en, this message translates to:
  /// **'Some sites don\'t allow their images to be accessed by others.\nTry an image from another host.'**
  String get dsImgPermission;

  /// No description provided for @dsUseFull.
  ///
  /// In en, this message translates to:
  /// **'Use full image?'**
  String get dsUseFull;

  /// No description provided for @dsFit.
  ///
  /// In en, this message translates to:
  /// **'How should it fit?'**
  String get dsFit;

  /// No description provided for @dsCrop.
  ///
  /// In en, this message translates to:
  /// **'Crop'**
  String get dsCrop;

  /// No description provided for @dsNoWeb.
  ///
  /// In en, this message translates to:
  /// **'Image editing is not supported on web'**
  String get dsNoWeb;

  /// No description provided for @dsDrag.
  ///
  /// In en, this message translates to:
  /// **'Drag'**
  String get dsDrag;

  /// No description provided for @dsDragHint.
  ///
  /// In en, this message translates to:
  /// **'Drag to reposition the image'**
  String get dsDragHint;

  /// No description provided for @dsSwipe.
  ///
  /// In en, this message translates to:
  /// **'Swipe'**
  String get dsSwipe;

  /// No description provided for @dsSwipeHint.
  ///
  /// In en, this message translates to:
  /// **'Swipe to reposition the image'**
  String get dsSwipeHint;

  /// No description provided for @dsPinch.
  ///
  /// In en, this message translates to:
  /// **'Pinch'**
  String get dsPinch;

  /// No description provided for @dsPinchHint.
  ///
  /// In en, this message translates to:
  /// **'Pinch to zoom in/out'**
  String get dsPinchHint;

  /// No description provided for @dsScroll.
  ///
  /// In en, this message translates to:
  /// **'Scroll'**
  String get dsScroll;

  /// No description provided for @dsScrollHint.
  ///
  /// In en, this message translates to:
  /// **'Scroll to zoom in/out'**
  String get dsScrollHint;

  /// No description provided for @dsRotateLeft.
  ///
  /// In en, this message translates to:
  /// **'Rotate left'**
  String get dsRotateLeft;

  /// No description provided for @dsRotateRight.
  ///
  /// In en, this message translates to:
  /// **'Rotate right'**
  String get dsRotateRight;

  /// No description provided for @dsResetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset all global and {themeType} theme design settings?'**
  String dsResetAll(Object themeType);

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
  /// **'Hide scrollbars'**
  String get lsScroll;

  /// No description provided for @lsResetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset all layout settings?'**
  String get lsResetAll;

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

  /// No description provided for @tsTextBackground.
  ///
  /// In en, this message translates to:
  /// **'Text background opacity'**
  String get tsTextBackground;

  /// No description provided for @tsIconSize.
  ///
  /// In en, this message translates to:
  /// **'Icon size'**
  String get tsIconSize;

  /// No description provided for @tsLinkHint.
  ///
  /// In en, this message translates to:
  /// **'Activate to edit {style}'**
  String tsLinkHint(Object style);

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
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'en':
      {
        switch (locale.countryCode) {
          case 'US':
            return efui_lang_en
                .loadLibrary()
                .then((dynamic _) => efui_lang_en.EFUILangEnUs());
        }
        break;
      }
  }

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
