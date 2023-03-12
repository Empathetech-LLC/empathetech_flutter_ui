library ez_ui;

const String backImageKey = 'backImage';
const String backColorKey = 'appBackgroundColor';
const String themeColorKey = 'themeColor';
const String themeTextColorKey = 'themeTextColor';
const String buttonColorKey = 'buttonColor';
const String buttonTextColorKey = 'buttonTextColor';
const String buttonSpacingKey = 'buttonSpacing';
const String dialogSpacingKey = 'dialogSpacing';
const String marginKey = 'margin';
const String paddingKey = 'padding';
const String fontFamilyKey = 'fontFamily';
const String fontSizeKey = 'fontSize';

final Map<String, dynamic> defaultConfig = {
  backImageKey: null,
  backColorKey: 0xE6A520DA, // Empathetech purple
  themeColorKey: 0xFF141414, // Almost black
  themeTextColorKey: 0xFFFFFFFF, // White
  buttonColorKey: 0xE6DAA520, // Empathetech gold
  buttonTextColorKey: 0xFF000000, // Black
  buttonSpacingKey: 35.0,
  dialogSpacingKey: 20.0,
  marginKey: 15.0,
  paddingKey: 12.5,
  fontFamilyKey: 'Roboto',
  fontSizeKey: 24.0,
};
