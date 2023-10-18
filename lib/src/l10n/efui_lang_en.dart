import 'efui_lang.dart';

/// The translations for English (`en`).
class EFUILangEn extends EFUILang {
  EFUILangEn([String locale = 'en']) : super(locale);

  @override
  String get gYes => 'Yes';

  @override
  String get gNo => 'No';

  @override
  String get gRight => 'Right';

  @override
  String get gLeft => 'Left';

  @override
  String get gApply => 'Apply';

  @override
  String get gCancel => 'Cancel';

  @override
  String get gClose => 'Close';

  @override
  String get gSystem => 'System';

  @override
  String get gLight => 'Light';

  @override
  String get gDark => 'Dark';

  @override
  String get gPage => 'Page';

  @override
  String get gAutoPlayDisabled => 'Auto-play videos are disabled.';

  @override
  String get dHomeHint => 'Return to the home screen';

  @override
  String get dResetAll => 'Reset all';

  @override
  String get dResetDialogTitle => 'Reset all settings?';

  @override
  String get dResetDialogContent => 'Cannot be undone';

  @override
  String get dAttention => 'Attention';

  @override
  String get dResetAllWarn =>
      'Cannot be undone\nChanges take effect on app restart';

  @override
  String get dResetAllWarnWeb =>
      'Cannot be undone\nChanges take effect on page reload';

  @override
  String dEditingTheme(Object themeType) {
    return 'Editing: $themeType theme';
  }

  @override
  String get hsThemeMode => 'Theme mode';

  @override
  String get hsThemeSemantics =>
      'Open to select a theme mode. Currently set to:';

  @override
  String get hsDominantHand => 'Dominant hand';

  @override
  String get hsHandSemantics =>
      'Open to choose left or right. Currently set to:';

  @override
  String get hsStyle => 'Style';

  @override
  String get hsColors => 'Colors';

  @override
  String get hsImages => 'Images';

  @override
  String get ssPageTitle => 'Settings';

  @override
  String get ssSettingsGuide =>
      'Each button will preview it\'s changes.\nReload the page for your changes to take full effect!\nHave fun!';

  @override
  String get ssSettingsGuideWeb =>
      'Each button will preview it\'s changes.\nRestart the app for your changes to take full effect!\nHave fun!';

  @override
  String get stsPageTitle => 'Style settings';

  @override
  String get stsTextFont => 'Text font';

  @override
  String get stschooseFont => 'Choose a font';

  @override
  String stsDefaultFont(Object font) {
    return '$font* (default)';
  }

  @override
  String get stsMargin => 'Margin';

  @override
  String get stsPadding => 'Padding';

  @override
  String get stsCircleSize => 'Circle button size';

  @override
  String get stsButtonSpacing => 'Button spacing';

  @override
  String get stsTextSpacing => 'Text spacing';

  @override
  String get stsCurrently => 'Currently: ';

  @override
  String stsSetToValue(Object name, Object value) {
    return '$name is currently set to $value';
  }

  @override
  String get stsReset => 'Reset: ';

  @override
  String stsResetToValue(Object name, Object value) {
    return 'Reset $name to $value';
  }

  @override
  String get stsResetAll => 'Reset all style settings?';

  @override
  String get csPageTitle => 'Color settings';

  @override
  String csEditingTheme(Object themeType) {
    return 'Editing: $themeType theme\nLong press buttons to reset individually';
  }

  @override
  String get csPickerTitle => 'Pick a color!';

  @override
  String csPickerSemantics(Object name) {
    return 'Activate to open a color picker for $name. Long press to reset $name.';
  }

  @override
  String get csResetTo => 'Reset to...';

  @override
  String get csTheme => 'Theme';

  @override
  String get csThemeText => 'Theme text';

  @override
  String get csRecommended => 'Use recommended?';

  @override
  String get csUseCustom => 'Use custom';

  @override
  String get csPageText => 'Page text';

  @override
  String get csButtons => 'Buttons';

  @override
  String get csButtonText => 'Buttons text';

  @override
  String get csAccent => 'Accent';

  @override
  String get csAccentText => 'Accent text';

  @override
  String csResetAll(Object themeType) {
    return 'Reset all $themeType theme colors?';
  }

  @override
  String get isPageTitle => 'Image settings';

  @override
  String get isImage => 'image';

  @override
  String isButtonHint(Object title) {
    return 'Update the $title image';
  }

  @override
  String isDialogTitle(Object title) {
    return 'How should the $title image be updated?';
  }

  @override
  String get isFromFile => 'From file';

  @override
  String get isFromCamera => 'From camera';

  @override
  String get isGetFailed => 'Failed to retrieve image';

  @override
  String isSetFailed(Object error) {
    return 'Failed to update image:\n$error';
  }

  @override
  String get isResetIt => 'Reset it';

  @override
  String get isClearIt => 'Clear it';

  @override
  String get isCreditTo => 'Credit to:';

  @override
  String get isSource => 'Wherever you got it!';

  @override
  String isResetAll(Object themeType) {
    return 'Reset all $themeType theme images?';
  }
}
