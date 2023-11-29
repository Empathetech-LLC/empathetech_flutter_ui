import 'efui_lang.dart';

/// The translations for English (`en`).
class EFUILangEn extends EFUILang {
  EFUILangEn([String locale = 'en']) : super(locale);

  @override
  String get gYes => 'Yes';

  @override
  String get gNo => 'No';

  @override
  String get gLeft => 'Left';

  @override
  String get gRight => 'Right';

  @override
  String get gApply => 'Apply';

  @override
  String get gContinue => 'Continue';

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
  String get gPlay => 'Play';

  @override
  String get gPause => 'Pause';

  @override
  String get gReplay => 'Replay';

  @override
  String get gAutoPlayDisabled => 'Auto-play videos are disabled.';

  @override
  String get gMute => 'Mute';

  @override
  String get gPage => 'Page';

  @override
  String get gHomeHint => 'Return to the home screen';

  @override
  String get gAttention => 'Attention';

  @override
  String get gResetAll => 'Reset all';

  @override
  String get gResetDialogTitle => 'Reset all settings?';

  @override
  String get gResetDialogContent => 'Cannot be undone';

  @override
  String get gResetAllWarn =>
      'Cannot be undone\nChanges take effect on app restart';

  @override
  String get gResetAllWarnWeb =>
      'Cannot be undone\nChanges take effect on page reload';

  @override
  String gEditingTheme(Object themeType) {
    return 'Editing: $themeType theme';
  }

  @override
  String get ssPageTitle => 'Settings';

  @override
  String get ssSettingsGuide =>
      'Each button will preview it\'s changes.\nReload the page for your changes to take full effect!\nHave fun!';

  @override
  String get ssSettingsGuideWeb =>
      'Each button will preview it\'s changes.\nRestart the app for your changes to take full effect!\nHave fun!';

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
  String get isFromNetwork => 'From URL';

  @override
  String get isEnterURL => 'Enter URL';

  @override
  String get isNetworkPreview => 'Preview of your chosen image';

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

  @override
  String get csThemeMode => 'Theme mode';

  @override
  String get csThemeSemantics =>
      'Open to select a theme mode. Currently set to:';

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
  String csResetAll(Object themeType) {
    return 'Reset all $themeType theme colors?';
  }

  @override
  String get csBackground => 'Background';

  @override
  String get csOnBackground => 'Background text';

  @override
  String get csSurface => 'Surface';

  @override
  String get csOnSurface => 'Surface text';

  @override
  String get csPrimary => 'Primary';

  @override
  String get csOnPrimary => 'Primary text';

  @override
  String get csSecondary => 'Secondary';

  @override
  String get csOnSecondary => 'Secondary text';

  @override
  String get csTertiary => 'Tertiary';

  @override
  String get csOnTertiary => 'Tertiary text';

  @override
  String get csError => 'Error';

  @override
  String get csOnError => 'Error text';

  @override
  String get csOutline => 'Outline';

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
  String get lsDominantHand => 'Dominant hand';

  @override
  String get lsHandSemantics =>
      'Open to choose left or right. Currently set to:';

  @override
  String get stsPageTitle => 'Style settings';

  @override
  String get stsTextFont => 'Text font';

  @override
  String get stsChooseFont => 'Choose a font';

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
}
