// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'efui_lang.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class EFUILangEn extends EFUILang {
  EFUILangEn([String locale = 'en']) : super(locale);

  @override
  String get gApply => 'Apply';

  @override
  String get gContinue => 'Continue';

  @override
  String get gOpen => 'Open';

  @override
  String get gSuccess => 'Success';

  @override
  String get gSuccessExl => 'Success!';

  @override
  String get gYes => 'Yes';

  @override
  String get gAnd => 'and';

  @override
  String get gHelp => 'Help';

  @override
  String get gNA => 'N/A';

  @override
  String get gNAHint => 'Not applicable';

  @override
  String get gOptional => 'optional';

  @override
  String get gOptions => 'Options';

  @override
  String get gRequired => 'Required';

  @override
  String get gBack => 'Back';

  @override
  String get gCancel => 'Cancel';

  @override
  String get gClose => 'Close';

  @override
  String get gDisabled => 'Disabled';

  @override
  String get gError => 'Error';

  @override
  String get gFailure => 'Failure';

  @override
  String get gNo => 'No';

  @override
  String get gDark => 'Dark';

  @override
  String get gLight => 'Light';

  @override
  String get gSystem => 'System';

  @override
  String get gEditing => 'Editing: ';

  @override
  String gEditingTheme(Object themeType) {
    return 'Editing: $themeType theme';
  }

  @override
  String get gLeft => 'Left';

  @override
  String get gRight => 'Right';

  @override
  String get gAdvanced => 'Advanced';

  @override
  String get gQuick => 'Quick';

  @override
  String get gDecrease => 'Decrease';

  @override
  String get gIncrease => 'Increase';

  @override
  String get gMaximum => 'Maximum';

  @override
  String get gMinimum => 'Minimum';

  @override
  String get gLoadingAnim =>
      'Loading. The Empathetic logo animated as a spinning hourglass.';

  @override
  String get gPlay => 'Play';

  @override
  String get gPause => 'Pause';

  @override
  String get gMute => 'Mute';

  @override
  String get gUnMute => 'Un-mute';

  @override
  String get gPlaybackSpeed => 'Playback speed';

  @override
  String get gReplay => 'Replay';

  @override
  String get gFullScreen => 'Full screen';

  @override
  String get gHowThisWorks => 'How this works';

  @override
  String get gHowThisWorksHint => 'Open helpful documentation';

  @override
  String get gTranslationsPending => 'Translations pending human review';

  @override
  String get gUpdates => 'Updates available';

  @override
  String get gValidURL => 'Please enter a valid URL';

  @override
  String get g404Wonder => 'Not all who wander are lost.';

  @override
  String get g404 => 'But, in this case: 404 page not found.';

  @override
  String get g404Note =>
      'Note: Flutter web uses hash routing, like...\nhttps://www.example.com/#/destination';

  @override
  String get gOpenSource => 'Open source';

  @override
  String get gOpenEmpathetech => 'Open a link to Empathetic LLC';

  @override
  String get gEFUISourceHint => 'Open the GitHub page for EFUI';

  @override
  String get gOpenUIReleases => 'Open the releases page for Open UI';

  @override
  String get gGiveFeedback => 'Give feedback';

  @override
  String get gOpeningFeedback => 'Opening the feedback tool.';

  @override
  String get gAttachScreenshot =>
      'Please attach your screenshot (in Downloads folder)';

  @override
  String get gSupportEmail => 'Our support Email';

  @override
  String gClipboard(Object thing) {
    return '$thing has been copied to the clipboard.';
  }

  @override
  String get gAttention => 'Attention';

  @override
  String get gCurrently => 'Currently:';

  @override
  String gSetToValue(Object name, Object value) {
    return '$name is set to $value';
  }

  @override
  String get gRemove => 'Remove';

  @override
  String get gReset => 'Reset';

  @override
  String get gResetTo => 'Reset:';

  @override
  String gResetValue(Object name) {
    return 'Reset $name?';
  }

  @override
  String gResetValueTo(Object name, Object value) {
    return 'Reset $name to $value';
  }

  @override
  String get gResetAll => 'Reset all';

  @override
  String get gUndoWarn => 'Cannot be undone';

  @override
  String get gCreditTo => 'Credit to:';

  @override
  String get gCreator => 'Creator of';

  @override
  String get gMadeBy => 'Made by';

  @override
  String get gYou => 'Set by you';

  @override
  String get ssPageTitle => 'Settings';

  @override
  String get ssNavHint => 'Open the settings page';

  @override
  String get ssSettingsGuide =>
      'Close and reopen the app to apply your changes.\n\nHave fun!';

  @override
  String get ssSettingsGuideWeb =>
      'Reload/refresh the page to apply your changes.\n\nHave fun!';

  @override
  String get ssThemeMode => 'Theme mode';

  @override
  String get ssDominantHand => 'Dominant hand';

  @override
  String get ssLanguage => 'Language';

  @override
  String get ssLangHint => 'Activate to change the app language';

  @override
  String get ssLoadConfig => 'Load config';

  @override
  String get ssLoadConfigHint => 'Activate to show presets';

  @override
  String get ssTryMe => 'Try me';

  @override
  String get ssRandom => 'Randomize';

  @override
  String ssRandomize(Object themeType) {
    return 'Randomize $themeType theme?';
  }

  @override
  String get ssAccessible => 'Accessible controls';

  @override
  String get ssZeroStrain => 'Zero eye strain';

  @override
  String get ssVideoGame => 'Video game';

  @override
  String get ssChalkboard => 'Chalkboard';

  @override
  String get ssFancyPants => 'Fancy pants';

  @override
  String get ssResetAll => 'Reset all settings?';

  @override
  String get tsPageTitle => 'Text settings';

  @override
  String tsBatchOverride(Object setting) {
    return 'You have already made granular \"$setting\" changes in advanced settings.\n\nAre you sure you want to override those changes with a batch update?';
  }

  @override
  String get tsTextBackground => 'Text background opacity';

  @override
  String get tsIconSize => 'Icon size';

  @override
  String tsLinkHint(Object style) {
    return 'Activate to edit $style';
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
  String get lsScroll => 'Hide scrollbars';

  @override
  String get lsResetAll => 'Reset all layout settings?';

  @override
  String get csPageTitle => 'Color settings';

  @override
  String get csPickerHint =>
      'Open a color picker. Long press for more options.';

  @override
  String get csMonoChrome => 'Use monochrome scheme';

  @override
  String get csHighContrast => 'Use high contrast scheme';

  @override
  String get csPickerTitle => 'Pick a color';

  @override
  String get csRecommended => 'Use contrast recommendation?';

  @override
  String get csUseCustom => 'Use custom';

  @override
  String get csAddColor => 'Add a color';

  @override
  String get csCurrVal => 'Current color value:';

  @override
  String get csSchemeBase => 'Build scheme\nfrom image';

  @override
  String get csFromImage => 'A color scheme will be generated from the image.';

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
  String get isFit => 'How should it fit?';

  @override
  String isResetAll(Object themeType) {
    return 'Reset all $themeType theme images?';
  }

  @override
  String isAndColors(Object themeType) {
    return 'And the $themeType color scheme?';
  }
}

/// The translations for English, as used in the United States (`en_US`).
class EFUILangEnUs extends EFUILangEn {
  EFUILangEnUs() : super('en_US');

  @override
  String get gApply => 'Apply';

  @override
  String get gContinue => 'Continue';

  @override
  String get gOpen => 'Open';

  @override
  String get gSuccess => 'Success';

  @override
  String get gSuccessExl => 'Success!';

  @override
  String get gYes => 'Yes';

  @override
  String get gAnd => 'and';

  @override
  String get gHelp => 'Help';

  @override
  String get gNA => 'N/A';

  @override
  String get gNAHint => 'Not applicable';

  @override
  String get gOptional => 'optional';

  @override
  String get gOptions => 'Options';

  @override
  String get gRequired => 'Required';

  @override
  String get gBack => 'Back';

  @override
  String get gCancel => 'Cancel';

  @override
  String get gClose => 'Close';

  @override
  String get gDisabled => 'Disabled';

  @override
  String get gError => 'Error';

  @override
  String get gFailure => 'Failure';

  @override
  String get gNo => 'No';

  @override
  String get gDark => 'Dark';

  @override
  String get gLight => 'Light';

  @override
  String get gSystem => 'System';

  @override
  String get gEditing => 'Editing: ';

  @override
  String gEditingTheme(Object themeType) {
    return 'Editing: $themeType theme';
  }

  @override
  String get gLeft => 'Left';

  @override
  String get gRight => 'Right';

  @override
  String get gAdvanced => 'Advanced';

  @override
  String get gQuick => 'Quick';

  @override
  String get gDecrease => 'Decrease';

  @override
  String get gIncrease => 'Increase';

  @override
  String get gMaximum => 'Maximum';

  @override
  String get gMinimum => 'Minimum';

  @override
  String get gLoadingAnim =>
      'Loading. The Empathetic logo animated as a spinning hourglass.';

  @override
  String get gPlay => 'Play';

  @override
  String get gPause => 'Pause';

  @override
  String get gMute => 'Mute';

  @override
  String get gUnMute => 'Un-mute';

  @override
  String get gPlaybackSpeed => 'Playback speed';

  @override
  String get gReplay => 'Replay';

  @override
  String get gFullScreen => 'Full screen';

  @override
  String get gHowThisWorks => 'How this works';

  @override
  String get gHowThisWorksHint => 'Open helpful documentation';

  @override
  String get gTranslationsPending => 'Translations pending human review';

  @override
  String get gUpdates => 'Updates available';

  @override
  String get gValidURL => 'Please enter a valid URL';

  @override
  String get g404Wonder => 'Not all who wander are lost.';

  @override
  String get g404 => 'But, in this case: 404 page not found.';

  @override
  String get g404Note =>
      'Note: Flutter web uses hash routing, like...\nhttps://www.example.com/#/destination';

  @override
  String get gOpenSource => 'Open source';

  @override
  String get gOpenEmpathetech => 'Open a link to Empathetic LLC';

  @override
  String get gEFUISourceHint => 'Open the GitHub page for EFUI';

  @override
  String get gOpenUIReleases => 'Open the releases page for Open UI';

  @override
  String get gGiveFeedback => 'Give feedback';

  @override
  String get gOpeningFeedback => 'Opening the feedback tool.';

  @override
  String get gAttachScreenshot =>
      'Please attach your screenshot (in Downloads folder)';

  @override
  String get gSupportEmail => 'Our support Email';

  @override
  String gClipboard(Object thing) {
    return '$thing has been copied to the clipboard.';
  }

  @override
  String get gAttention => 'Attention';

  @override
  String get gCurrently => 'Currently:';

  @override
  String gSetToValue(Object name, Object value) {
    return '$name is set to $value';
  }

  @override
  String get gRemove => 'Remove';

  @override
  String get gReset => 'Reset';

  @override
  String get gResetTo => 'Reset:';

  @override
  String gResetValue(Object name) {
    return 'Reset $name?';
  }

  @override
  String gResetValueTo(Object name, Object value) {
    return 'Reset $name to $value';
  }

  @override
  String get gResetAll => 'Reset all';

  @override
  String get gUndoWarn => 'Cannot be undone';

  @override
  String get gCreditTo => 'Credit to:';

  @override
  String get gCreator => 'Creator of';

  @override
  String get gMadeBy => 'Made by';

  @override
  String get gYou => 'Set by you';

  @override
  String get ssPageTitle => 'Settings';

  @override
  String get ssNavHint => 'Open the settings page';

  @override
  String get ssSettingsGuide =>
      'Close and reopen the app to apply your changes.\n\nHave fun!';

  @override
  String get ssSettingsGuideWeb =>
      'Reload/refresh the page to apply your changes.\n\nHave fun!';

  @override
  String get ssThemeMode => 'Theme mode';

  @override
  String get ssDominantHand => 'Dominant hand';

  @override
  String get ssLanguage => 'Language';

  @override
  String get ssLangHint => 'Activate to change the app language';

  @override
  String get ssLoadConfig => 'Load config';

  @override
  String get ssLoadConfigHint => 'Activate to show presets';

  @override
  String get ssTryMe => 'Try me';

  @override
  String get ssRandom => 'Randomize';

  @override
  String ssRandomize(Object themeType) {
    return 'Randomize $themeType theme?';
  }

  @override
  String get ssAccessible => 'Accessible controls';

  @override
  String get ssZeroStrain => 'Zero eye strain';

  @override
  String get ssVideoGame => 'Video game';

  @override
  String get ssChalkboard => 'Chalkboard';

  @override
  String get ssFancyPants => 'Fancy pants';

  @override
  String get ssResetAll => 'Reset all settings?';

  @override
  String get tsPageTitle => 'Text settings';

  @override
  String tsBatchOverride(Object setting) {
    return 'You have already made granular \"$setting\" changes in advanced settings.\n\nAre you sure you want to override those changes with a batch update?';
  }

  @override
  String get tsTextBackground => 'Text background opacity';

  @override
  String get tsIconSize => 'Icon size';

  @override
  String tsLinkHint(Object style) {
    return 'Activate to edit $style';
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
  String get lsScroll => 'Hide scrollbars';

  @override
  String get lsResetAll => 'Reset all layout settings?';

  @override
  String get csPageTitle => 'Color settings';

  @override
  String get csPickerHint =>
      'Open a color picker. Long press for more options.';

  @override
  String get csMonoChrome => 'Use monochrome scheme';

  @override
  String get csHighContrast => 'Use high contrast scheme';

  @override
  String get csPickerTitle => 'Pick a color';

  @override
  String get csRecommended => 'Use contrast recommendation?';

  @override
  String get csUseCustom => 'Use custom';

  @override
  String get csAddColor => 'Add a color';

  @override
  String get csCurrVal => 'Current color value:';

  @override
  String get csSchemeBase => 'Build scheme\nfrom image';

  @override
  String get csFromImage => 'A color scheme will be generated from the image.';

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
  String get isFit => 'How should it fit?';

  @override
  String isResetAll(Object themeType) {
    return 'Reset all $themeType theme images?';
  }

  @override
  String isAndColors(Object themeType) {
    return 'And the $themeType color scheme?';
  }
}
