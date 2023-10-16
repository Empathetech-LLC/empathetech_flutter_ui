import 'efui_phrases.dart';

/// The translations for English (`en`).
class EFUIPhrasesEn extends EFUIPhrases {
  EFUIPhrasesEn([String locale = 'en']) : super(locale);

  @override
  String get close => 'Close';

  @override
  String get apply => 'Apply';

  @override
  String get cancel => 'Cancel';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get warning => 'WARNING';

  @override
  String get useCustom => 'Use custom';

  @override
  String get useRecommended => 'Use recommended?';

  @override
  String get resetTo => 'Reset to...';

  @override
  String colorSettingSemantics(Object name) {
    return 'Activate to open a color picker for $name. Long press to reset $name.';
  }

  @override
  String get right => 'Right';

  @override
  String get left => 'Left';

  @override
  String get dominantHand => 'Dominant hand';

  @override
  String get handSettingSemantics =>
      'Open to choose left or right. Currently set to:';

  @override
  String defaultTag(Object font) {
    return '$font* (default)';
  }

  @override
  String get chooseFont => 'Choose a font';

  @override
  String get fontSettingLabel => 'Text font';

  @override
  String get fromFile => 'From file';

  @override
  String get fromCamera => 'From camera';

  @override
  String get resetIt => 'Reset it';

  @override
  String get clearIt => 'Clear it';

  @override
  String imageSettingDialogTitle(Object title) {
    return 'How should the $title image be updated?';
  }

  @override
  String imageSettingHint(Object title) {
    return 'Update the $title image';
  }

  @override
  String get creditTo => 'Credit to:';

  @override
  String get image => 'image';

  @override
  String get resetAll => 'Reset all';

  @override
  String get resetButtonHint => 'Reset all custom settings';

  @override
  String get resetButtonDialogTitle => 'Reset all settings?';

  @override
  String get resetButtonDialogContents => 'Cannot be undone';

  @override
  String get currently => 'Currently: ';

  @override
  String nameSetToValue(Object name, Object value) {
    return '$name is currently set to $value';
  }

  @override
  String get reset => 'Reset: ';

  @override
  String resetNameToValue(Object name, Object value) {
    return 'Reset $name to $value';
  }

  @override
  String get system => 'System';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get themeMode => 'Theme mode';

  @override
  String get themeSwitchSemantics =>
      'Open to select a theme mode. Currently set to:';

  @override
  String get margin => 'Margin';

  @override
  String get padding => 'Padding';

  @override
  String get circleSize => 'Circle button size';

  @override
  String get buttonSpacing => 'Button spacing';

  @override
  String get textSpacing => 'Text spacing';

  @override
  String get attention => 'Attention';

  @override
  String get pickAColor => 'Pick a color!';

  @override
  String get clipCopy => 'Copied to clipboard';

  @override
  String get failedImageGet => 'Failed to retrieve image';

  @override
  String failedImageSet(Object error) {
    return 'Failed to update image:\n$error';
  }

  @override
  String get autoPlayDisabled => 'Auto-play videos are disabled.';
}
