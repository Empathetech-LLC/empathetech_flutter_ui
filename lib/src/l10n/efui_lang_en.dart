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

import 'efui_lang.dart';

/// The translations for English (`en`).
class EFUILangEn extends EFUILang {
  EFUILangEn([String locale = 'en']) : super(locale);

  @override
  String get g_Yes => 'Yes';

  @override
  String get g_No => 'No';

  @override
  String get g_Right => 'Right';

  @override
  String get g_Left => 'Left';

  @override
  String get g_Apply => 'Apply';

  @override
  String get g_Cancel => 'Cancel';

  @override
  String get g_Close => 'Close';

  @override
  String get g_System => 'System';

  @override
  String get g_Light => 'Light';

  @override
  String get g_Dark => 'Dark';

  @override
  String get g_Page => 'Page';

  @override
  String get g_autoPlayDisabled => 'Auto-play videos are disabled.';

  @override
  String get d_HomeHint => 'Return to the home screen';

  @override
  String get d_ResetAll => 'Reset all';

  @override
  String get d_ResetDialogTitle => 'Reset all settings?';

  @override
  String get d_ResetDialogContent => 'Cannot be undone';

  @override
  String get d_Attention => 'Attention';

  @override
  String get d_ResetAllWarn =>
      'Cannot be undone\nChanges take effect on app restart';

  @override
  String get d_ResetAllWarnWeb =>
      'Cannot be undone\nChanges take effect on page reload';

  @override
  String d_EditingTheme(Object themeType) {
    return 'Editing: $themeType theme';
  }

  @override
  String get hs_ThemeMode => 'Theme mode';

  @override
  String get hs_ThemeSemantics =>
      'Open to select a theme mode. Currently set to:';

  @override
  String get hs_DominantHand => 'Dominant hand';

  @override
  String get hs_HandSemantics =>
      'Open to choose left or right. Currently set to:';

  @override
  String get hs_Style => 'Style';

  @override
  String get hs_Colors => 'Colors';

  @override
  String get hs_Images => 'Images';

  @override
  String get ss_PageTitle => 'Settings';

  @override
  String get ss_SettingsGuide =>
      'Each button will preview it\'s changes.\nReload the page for your changes to take full effect!\nHave fun!';

  @override
  String get ss_SettingsGuideWeb =>
      'Each button will preview it\'s changes.\nRestart the app for your changes to take full effect!\nHave fun!';

  @override
  String get sts_PageTitle => 'Style settings';

  @override
  String get sts_TextFont => 'Text font';

  @override
  String get sts_chooseFont => 'Choose a font';

  @override
  String sts_DefaultFont(Object font) {
    return '$font* (default)';
  }

  @override
  String get sts_Margin => 'Margin';

  @override
  String get sts_Padding => 'Padding';

  @override
  String get sts_CircleSize => 'Circle button size';

  @override
  String get sts_ButtonSpacing => 'Button spacing';

  @override
  String get sts_TextSpacing => 'Text spacing';

  @override
  String get sts_Currently => 'Currently: ';

  @override
  String sts_SetToValue(Object name, Object value) {
    return '$name is currently set to $value';
  }

  @override
  String get sts_Reset => 'Reset: ';

  @override
  String sts_ResetToValue(Object name, Object value) {
    return 'Reset $name to $value';
  }

  @override
  String get sts_ResetAll => 'Reset all style settings?';

  @override
  String get cs_PageTitle => 'Color settings';

  @override
  String cs_EditingTheme(Object themeType) {
    return 'Editing: $themeType theme\nLong press buttons to reset individually';
  }

  @override
  String get cs_PickerTitle => 'Pick a color!';

  @override
  String cs_PickerSemantics(Object name) {
    return 'Activate to open a color picker for $name. Long press to reset $name.';
  }

  @override
  String get cs_ResetTo => 'Reset to...';

  @override
  String get cs_Theme => 'Theme';

  @override
  String get cs_ThemeText => 'Theme text';

  @override
  String get cs_Recommended => 'Use recommended?';

  @override
  String get cs_UseCustom => 'Use custom';

  @override
  String get cs_PageText => 'Page text';

  @override
  String get cs_Buttons => 'Buttons';

  @override
  String get cs_ButtonText => 'Buttons text';

  @override
  String get cs_Accent => 'Accent';

  @override
  String get cs_AccentText => 'Accent text';

  @override
  String cs_ResetAll(Object themeType) {
    return 'Reset all $themeType theme colors?';
  }

  @override
  String get is_PageTitle => 'Image settings';

  @override
  String get is_Image => 'image';

  @override
  String is_ButtonHint(Object title) {
    return 'Update the $title image';
  }

  @override
  String is_DialogTitle(Object title) {
    return 'How should the $title image be updated?';
  }

  @override
  String get is_FromFile => 'From file';

  @override
  String get is_FromCamera => 'From camera';

  @override
  String get is_GetFailed => 'Failed to retrieve image';

  @override
  String is_SetFailed(Object error) {
    return 'Failed to update image:\n$error';
  }

  @override
  String get is_ResetIt => 'Reset it';

  @override
  String get is_ClearIt => 'Clear it';

  @override
  String get is_CreditTo => 'Credit to:';

  @override
  String get is_Source => 'Wherever you got it!';

  @override
  String is_ResetAll(Object themeType) {
    return 'Reset all $themeType theme images?';
  }
}
