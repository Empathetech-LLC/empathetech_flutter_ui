// ignore_for_file: non_constant_identifier_names
/* We use the following convention: scope_CamelName
 * g == global
 * d == default
 * hs == home screen
 * ss == settings screen
 * sss == style settings screen
 * cs == color settings screen
 * is == image settings screen
 */

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

  /// No description provided for @g_Yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get g_Yes;

  /// No description provided for @g_No.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get g_No;

  /// No description provided for @g_Right.
  ///
  /// In en, this message translates to:
  /// **'Right'**
  String get g_Right;

  /// No description provided for @g_Left.
  ///
  /// In en, this message translates to:
  /// **'Left'**
  String get g_Left;

  /// No description provided for @g_Apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get g_Apply;

  /// No description provided for @g_Cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get g_Cancel;

  /// No description provided for @g_Close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get g_Close;

  /// No description provided for @g_System.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get g_System;

  /// No description provided for @g_Light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get g_Light;

  /// No description provided for @g_Dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get g_Dark;

  /// No description provided for @g_Page.
  ///
  /// In en, this message translates to:
  /// **'Page'**
  String get g_Page;

  /// No description provided for @g_autoPlayDisabled.
  ///
  /// In en, this message translates to:
  /// **'Auto-play videos are disabled.'**
  String get g_autoPlayDisabled;

  /// No description provided for @d_HomeHint.
  ///
  /// In en, this message translates to:
  /// **'Return to the home screen'**
  String get d_HomeHint;

  /// No description provided for @d_ResetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset all'**
  String get d_ResetAll;

  /// No description provided for @d_ResetDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset all settings?'**
  String get d_ResetDialogTitle;

  /// No description provided for @d_ResetDialogContent.
  ///
  /// In en, this message translates to:
  /// **'Cannot be undone'**
  String get d_ResetDialogContent;

  /// No description provided for @d_Attention.
  ///
  /// In en, this message translates to:
  /// **'Attention'**
  String get d_Attention;

  /// No description provided for @d_ResetAllWarn.
  ///
  /// In en, this message translates to:
  /// **'Cannot be undone\nChanges take effect on app restart'**
  String get d_ResetAllWarn;

  /// No description provided for @d_ResetAllWarnWeb.
  ///
  /// In en, this message translates to:
  /// **'Cannot be undone\nChanges take effect on page reload'**
  String get d_ResetAllWarnWeb;

  /// No description provided for @d_EditingTheme.
  ///
  /// In en, this message translates to:
  /// **'Editing: {themeType} theme'**
  String d_EditingTheme(Object themeType);

  /// No description provided for @hs_ThemeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme mode'**
  String get hs_ThemeMode;

  /// No description provided for @hs_ThemeSemantics.
  ///
  /// In en, this message translates to:
  /// **'Open to select a theme mode. Currently set to:'**
  String get hs_ThemeSemantics;

  /// No description provided for @hs_DominantHand.
  ///
  /// In en, this message translates to:
  /// **'Dominant hand'**
  String get hs_DominantHand;

  /// No description provided for @hs_HandSemantics.
  ///
  /// In en, this message translates to:
  /// **'Open to choose left or right. Currently set to:'**
  String get hs_HandSemantics;

  /// No description provided for @hs_Style.
  ///
  /// In en, this message translates to:
  /// **'Style'**
  String get hs_Style;

  /// No description provided for @hs_Colors.
  ///
  /// In en, this message translates to:
  /// **'Colors'**
  String get hs_Colors;

  /// No description provided for @hs_Images.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get hs_Images;

  /// No description provided for @ss_PageTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get ss_PageTitle;

  /// No description provided for @ss_SettingsGuide.
  ///
  /// In en, this message translates to:
  /// **'Each button will preview it\'s changes.\nReload the page for your changes to take full effect!\nHave fun!'**
  String get ss_SettingsGuide;

  /// No description provided for @ss_SettingsGuideWeb.
  ///
  /// In en, this message translates to:
  /// **'Each button will preview it\'s changes.\nRestart the app for your changes to take full effect!\nHave fun!'**
  String get ss_SettingsGuideWeb;

  /// No description provided for @sts_PageTitle.
  ///
  /// In en, this message translates to:
  /// **'Style settings'**
  String get sts_PageTitle;

  /// No description provided for @sts_TextFont.
  ///
  /// In en, this message translates to:
  /// **'Text font'**
  String get sts_TextFont;

  /// No description provided for @sts_chooseFont.
  ///
  /// In en, this message translates to:
  /// **'Choose a font'**
  String get sts_chooseFont;

  /// No description provided for @sts_DefaultFont.
  ///
  /// In en, this message translates to:
  /// **'{font}* (default)'**
  String sts_DefaultFont(Object font);

  /// No description provided for @sts_Margin.
  ///
  /// In en, this message translates to:
  /// **'Margin'**
  String get sts_Margin;

  /// No description provided for @sts_Padding.
  ///
  /// In en, this message translates to:
  /// **'Padding'**
  String get sts_Padding;

  /// No description provided for @sts_CircleSize.
  ///
  /// In en, this message translates to:
  /// **'Circle button size'**
  String get sts_CircleSize;

  /// No description provided for @sts_ButtonSpacing.
  ///
  /// In en, this message translates to:
  /// **'Button spacing'**
  String get sts_ButtonSpacing;

  /// No description provided for @sts_TextSpacing.
  ///
  /// In en, this message translates to:
  /// **'Text spacing'**
  String get sts_TextSpacing;

  /// No description provided for @sts_Currently.
  ///
  /// In en, this message translates to:
  /// **'Currently: '**
  String get sts_Currently;

  /// No description provided for @sts_SetToValue.
  ///
  /// In en, this message translates to:
  /// **'{name} is currently set to {value}'**
  String sts_SetToValue(Object name, Object value);

  /// No description provided for @sts_Reset.
  ///
  /// In en, this message translates to:
  /// **'Reset: '**
  String get sts_Reset;

  /// No description provided for @sts_ResetToValue.
  ///
  /// In en, this message translates to:
  /// **'Reset {name} to {value}'**
  String sts_ResetToValue(Object name, Object value);

  /// No description provided for @sts_ResetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset all style settings?'**
  String get sts_ResetAll;

  /// No description provided for @cs_PageTitle.
  ///
  /// In en, this message translates to:
  /// **'Color settings'**
  String get cs_PageTitle;

  /// No description provided for @cs_EditingTheme.
  ///
  /// In en, this message translates to:
  /// **'Editing: {themeType} theme\nLong press buttons to reset individually'**
  String cs_EditingTheme(Object themeType);

  /// No description provided for @cs_PickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Pick a color!'**
  String get cs_PickerTitle;

  /// No description provided for @cs_PickerSemantics.
  ///
  /// In en, this message translates to:
  /// **'Activate to open a color picker for {name}. Long press to reset {name}.'**
  String cs_PickerSemantics(Object name);

  /// No description provided for @cs_ResetTo.
  ///
  /// In en, this message translates to:
  /// **'Reset to...'**
  String get cs_ResetTo;

  /// No description provided for @cs_Theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get cs_Theme;

  /// No description provided for @cs_ThemeText.
  ///
  /// In en, this message translates to:
  /// **'Theme text'**
  String get cs_ThemeText;

  /// No description provided for @cs_Recommended.
  ///
  /// In en, this message translates to:
  /// **'Use recommended?'**
  String get cs_Recommended;

  /// No description provided for @cs_UseCustom.
  ///
  /// In en, this message translates to:
  /// **'Use custom'**
  String get cs_UseCustom;

  /// No description provided for @cs_PageText.
  ///
  /// In en, this message translates to:
  /// **'Page text'**
  String get cs_PageText;

  /// No description provided for @cs_Buttons.
  ///
  /// In en, this message translates to:
  /// **'Buttons'**
  String get cs_Buttons;

  /// No description provided for @cs_ButtonText.
  ///
  /// In en, this message translates to:
  /// **'Buttons text'**
  String get cs_ButtonText;

  /// No description provided for @cs_Accent.
  ///
  /// In en, this message translates to:
  /// **'Accent'**
  String get cs_Accent;

  /// No description provided for @cs_AccentText.
  ///
  /// In en, this message translates to:
  /// **'Accent text'**
  String get cs_AccentText;

  /// No description provided for @cs_ResetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset all {themeType} theme colors?'**
  String cs_ResetAll(Object themeType);

  /// No description provided for @is_PageTitle.
  ///
  /// In en, this message translates to:
  /// **'Image settings'**
  String get is_PageTitle;

  /// No description provided for @is_Image.
  ///
  /// In en, this message translates to:
  /// **'image'**
  String get is_Image;

  /// No description provided for @is_ButtonHint.
  ///
  /// In en, this message translates to:
  /// **'Update the {title} image'**
  String is_ButtonHint(Object title);

  /// No description provided for @is_DialogTitle.
  ///
  /// In en, this message translates to:
  /// **'How should the {title} image be updated?'**
  String is_DialogTitle(Object title);

  /// No description provided for @is_FromFile.
  ///
  /// In en, this message translates to:
  /// **'From file'**
  String get is_FromFile;

  /// No description provided for @is_FromCamera.
  ///
  /// In en, this message translates to:
  /// **'From camera'**
  String get is_FromCamera;

  /// No description provided for @is_GetFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to retrieve image'**
  String get is_GetFailed;

  /// No description provided for @is_SetFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update image:\n{error}'**
  String is_SetFailed(Object error);

  /// No description provided for @is_ResetIt.
  ///
  /// In en, this message translates to:
  /// **'Reset it'**
  String get is_ResetIt;

  /// No description provided for @is_ClearIt.
  ///
  /// In en, this message translates to:
  /// **'Clear it'**
  String get is_ClearIt;

  /// No description provided for @is_CreditTo.
  ///
  /// In en, this message translates to:
  /// **'Credit to:'**
  String get is_CreditTo;

  /// No description provided for @is_Source.
  ///
  /// In en, this message translates to:
  /// **'Wherever you got it!'**
  String get is_Source;

  /// No description provided for @is_ResetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset all {themeType} theme images?'**
  String is_ResetAll(Object themeType);
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
