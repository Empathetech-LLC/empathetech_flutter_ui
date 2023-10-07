import 'phrases.dart';

/// The translations for English (`en`).
class PhrasesEn extends Phrases {
  PhrasesEn([String locale = 'en']) : super(locale);

  @override
  String get homeLinkHint => 'Return to the home screen';

  @override
  String editingTheme(Object themeType) {
    return 'Editing: $themeType theme';
  }

  @override
  String get resetAllWarning =>
      'Cannot be undone\nChanges take effect on app restart';

  @override
  String get resetAllWarningWeb =>
      'Cannot be undone\nChanges take effect on page reload';

  @override
  String get imageSettings => 'Image settings';

  @override
  String resetAllImages(Object themeType) {
    return 'Reset all $themeType theme images?';
  }

  @override
  String get page => 'Page';

  @override
  String get yourSourceCredit => 'Wherever you got it!';

  @override
  String get colorSettings => 'Color settings';

  @override
  String resetAllColors(Object themeType) {
    return 'Reset all $themeType theme colors?';
  }

  @override
  String editingThemeColors(Object themeType) {
    return 'Editing: $themeType theme\nLong press buttons to reset individually';
  }

  @override
  String get theme => 'Theme';

  @override
  String get themeText => 'Theme text';

  @override
  String get pageText => 'Page text';

  @override
  String get buttons => 'Buttons';

  @override
  String get buttonText => 'Buttons text';

  @override
  String get accent => 'Accent';

  @override
  String get accentText => 'Accent text';

  @override
  String get styleSettings => 'Style settings';

  @override
  String get resetAllStyle => 'Reset all style settings?';

  @override
  String get settings => 'Settings';

  @override
  String get attention => 'ATTENTION';

  @override
  String get resetWarning =>
      'Each button will preview it\'s changes.\nReload the page for your changes to take full effect!\nHave fun!';

  @override
  String get resetWarningWeb =>
      'Each button will preview it\'s changes.\nRestart the app for your changes to take full effect!\nHave fun!';

  @override
  String get styling => 'Styling';

  @override
  String get colors => 'Colors';

  @override
  String get images => 'Images';
}
