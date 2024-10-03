import 'efui_lang.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class EFUILangEn extends EFUILang {
  EFUILangEn([String locale = 'en']) : super(locale);

  @override
  String get gYes => 'Yes';

  @override
  String get gNo => 'No';

  @override
  String get gOptions => 'Options';

  @override
  String get gApply => 'Apply';

  @override
  String get gContinue => 'Continue';

  @override
  String get gCancel => 'Cancel';

  @override
  String get gClose => 'Close';

  @override
  String get gBYO => 'Build your own';

  @override
  String get gEFUISourceHint => 'Open the GitHub page for EFUI';

  @override
  String get gGiveFeedback => 'Give feedback';

  @override
  String gClipboard(Object thing) {
    return '$thing copied to clipboard';
  }

  @override
  String get gSupportEmail => 'Support Email';

  @override
  String get gLeft => 'Left';

  @override
  String get gRight => 'Right';

  @override
  String get gBack => 'Back';

  @override
  String get gSystem => 'System';

  @override
  String get gLight => 'Light';

  @override
  String get gDark => 'Dark';

  @override
  String get gEditing => 'Editing: ';

  @override
  String gEditingTheme(Object themeType) {
    return 'Editing: $themeType theme';
  }

  @override
  String get gQuick => 'Quick';

  @override
  String get gAdvanced => 'Advanced';

  @override
  String get gHowThisWorks => 'How this works';

  @override
  String get gHowThisWorksHint => 'Open helpful documentation';

  @override
  String get gAttention => 'Attention';

  @override
  String get gCurrently => 'Currently:';

  @override
  String gSetToValue(Object name, Object value) {
    return '$name is set to $value';
  }

  @override
  String get gReset => 'Reset:';

  @override
  String gResetToValue(Object name, Object value) {
    return 'Reset $name to $value';
  }

  @override
  String get gResetAll => 'Reset all';

  @override
  String get gResetWarn => 'Cannot be undone';

  @override
  String get gCreditTo => 'Credit to:';

  @override
  String get gYou => 'Set by you';

  @override
  String get ssPageTitle => 'Settings';

  @override
  String get ssSettingsGuide =>
      'Restart the app to apply your changes.\n\nHave fun!';

  @override
  String get ssSettingsGuideWeb =>
      'Reload the page to apply your changes.\n\nHave fun!';

  @override
  String get ssThemeMode => 'Theme mode';

  @override
  String get ssDominantHand => 'Dominant hand';

  @override
  String get ssLanguage => 'Language';

  @override
  String get ssLanguages => 'Languages';

  @override
  String get ssLangHint => 'App language';

  @override
  String get ssResetAll => 'Reset all settings?';

  @override
  String get tsPageTitle => 'Text settings';

  @override
  String tsBatchOverride(Object setting) {
    return 'You have already made granular \"$setting\" changes in advanced settings.\n\nAre you sure you want to override those changes with a batch update?';
  }

  @override
  String get tsDisplay => 'Display';

  @override
  String get tsHeadline => 'Headline';

  @override
  String get tsTitle => 'Title';

  @override
  String get tsBody => 'Body';

  @override
  String get tsLabel => 'Label';

  @override
  String tsLinkHint(Object style) {
    return 'Activate to edit $style';
  }

  @override
  String get tsFontFamily => 'Font family';

  @override
  String get tsFontSize => 'Font size';

  @override
  String get tsBold => 'Bold';

  @override
  String get tsItalic => 'Italic';

  @override
  String get tsUnderline => 'Underline';

  @override
  String get tsLetterSpacing => 'Letter spacing';

  @override
  String get tsWordSpacing => 'Word spacing';

  @override
  String get tsLineHeight => 'Line height';

  @override
  String get tsDecrease => 'Decrease';

  @override
  String get tsIncrease => 'Increase';

  @override
  String get tsDisplayP1 => 'Does this ';

  @override
  String get tsDisplayLink => 'display';

  @override
  String get tsDisplayP2 => ' well?';

  @override
  String get tsHeadlineP1 => 'Are ';

  @override
  String get tsHeadlineLink => 'headlines';

  @override
  String get tsHeadlineP2 => ' distinct...';

  @override
  String get tsTitleP1 => 'from ';

  @override
  String get tsTitleLink => 'titles?';

  @override
  String get tsBodyP1 => 'How about ';

  @override
  String get tsBodyLink => 'the body?';

  @override
  String get tsBodyP2 => ' Is it easy to read?';

  @override
  String get tsLabelP1 => 'And ';

  @override
  String get tsLabelLink => 'the labels?';

  @override
  String get tsLabelP2 => ' Not too big, not too small?';

  @override
  String get tsResetAll => 'Reset all text settings?';

  @override
  String get lsPageTitle => 'Layout settings';

  @override
  String get lsMargin => 'Margin';

  @override
  String get lsPadding => 'Padding';

  @override
  String get lsSpacing => 'Spacing';

  @override
  String get lsScroll => 'Hide scrollbars?';

  @override
  String get lsResetAll => 'Reset all layout settings?';

  @override
  String get csPageTitle => 'Color settings';

  @override
  String csPickerHint(Object name) {
    return 'Open a color picker for $name. Long press for more options.';
  }

  @override
  String get csMonoChrome => 'Use monochrome scheme';

  @override
  String get csHighContrast => 'Use high contrast scheme';

  @override
  String get csPrimary => 'Primary';

  @override
  String get csOnPrimary => 'On primary';

  @override
  String get csPrimaryContainer => 'Primary container';

  @override
  String get csOnPrimaryContainer => 'On primary container';

  @override
  String get csPrimaryFixed => 'Primary fixed';

  @override
  String get csPrimaryFixedDim => 'Primary fixed dim';

  @override
  String get csOnPrimaryFixed => 'On primary fixed';

  @override
  String get csOnPrimaryFixedVariant => 'On primary fixed variant';

  @override
  String get csSecondary => 'Secondary';

  @override
  String get csOnSecondary => 'On secondary';

  @override
  String get csSecondaryContainer => 'Secondary container';

  @override
  String get csOnSecondaryContainer => 'On secondary container';

  @override
  String get csSecondaryFixed => 'Secondary fixed';

  @override
  String get csSecondaryFixedDim => 'Secondary fixed dim';

  @override
  String get csOnSecondaryFixed => 'On secondary fixed';

  @override
  String get csOnSecondaryFixedVariant => 'On secondary fixed variant';

  @override
  String get csTertiary => 'Tertiary';

  @override
  String get csOnTertiary => 'On tertiary';

  @override
  String get csTertiaryContainer => 'Tertiary container';

  @override
  String get csOnTertiaryContainer => 'On tertiary container';

  @override
  String get csTertiaryFixed => 'Tertiary fixed';

  @override
  String get csTertiaryFixedDim => 'Tertiary fixed dim';

  @override
  String get csOnTertiaryFixed => 'On tertiary fixed';

  @override
  String get csOnTertiaryFixedVariant => 'On tertiary fixed variant';

  @override
  String get csError => 'Error';

  @override
  String get csOnError => 'On error';

  @override
  String get csErrorContainer => 'Error container';

  @override
  String get csOnErrorContainer => 'On error container';

  @override
  String get csOutline => 'Outline';

  @override
  String get csOutlineVariant => 'Outline variant';

  @override
  String get csSurface => 'Surface';

  @override
  String get csOnSurface => 'On surface';

  @override
  String get csSurfaceDim => 'Surface dim';

  @override
  String get csSurfaceBright => 'Surface bright';

  @override
  String get csSurfaceContainerLowest => 'Surface container lowest';

  @override
  String get csSurfaceContainerLow => 'Surface container low';

  @override
  String get csSurfaceContainer => 'Surface container';

  @override
  String get csSurfaceContainerHigh => 'Surface container high';

  @override
  String get csSurfaceContainerHighest => 'Surface container highest';

  @override
  String get csOnSurfaceVariant => 'On surface variant';

  @override
  String get csInverseSurface => 'Inverse surface';

  @override
  String get csOnInverseSurface => 'On inverse surface';

  @override
  String get csInversePrimary => 'Inverse primary';

  @override
  String get csScrim => 'Scrim';

  @override
  String get csShadow => 'Shadow';

  @override
  String get csSurfaceTint => 'Surface tint';

  @override
  String get csPickerTitle => 'Pick a color';

  @override
  String get csRecommended => 'Use contrast recommendation?';

  @override
  String get csUseCustom => 'Use custom';

  @override
  String get csAddColor => 'Add a color';

  @override
  String get csRemove => 'Remove';

  @override
  String get csReset => 'Reset';

  @override
  String get csSchemeBase => 'Build scheme\nfrom image';

  @override
  String get csOptional => 'optional';

  @override
  String get csFromImage => 'Build the color scheme from an image';

  @override
  String get csColorScheme => 'color scheme';

  @override
  String csResetAll(Object themeType) {
    return 'Reset all $themeType theme colors?';
  }

  @override
  String get isPageTitle => 'Image settings';

  @override
  String get isBackground => 'Background';

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
  String get isResetIt => 'Reset it';

  @override
  String get isClearIt => 'Clear it';

  @override
  String get isEnterURL => 'Enter URL';

  @override
  String get isGetFailed => 'Failed to retrieve image';

  @override
  String isSetFailed(Object error) {
    return 'Failed to update image:\n$error';
  }

  @override
  String get isPermission =>
      'Some sites don\'t allow their images to be accessed by others.\nTry an image from another host.';

  @override
  String get isUseForColors => 'Update the app colors using this image';

  @override
  String isResetAll(Object themeType) {
    return 'Reset all $themeType theme images?';
  }
}
