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
  String get gApplyChanges => 'Apply changes';

  @override
  String get gContinue => 'Continue';

  @override
  String get gSkip => 'Skip';

  @override
  String get gOpen => 'Open';

  @override
  String get gOpenLink => 'Open link';

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
  String get gUndo => 'Undo';

  @override
  String get gRedo => 'Redo';

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
  String get gDarkTheme => 'Dark theme';

  @override
  String get gLightTheme => 'Light theme';

  @override
  String get gBothThemes => 'Both themes';

  @override
  String get gEditing => 'Editing: ';

  @override
  String get gEditingThemeHint => 'Open the system theme settings';

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
  String get gCenterReset => 'Hold center to reset';

  @override
  String get gLoadingAnim =>
      'Loading. The Empathetic logo animated as a spinning hourglass.';

  @override
  String get gPlay => 'Play';

  @override
  String get gPause => 'Pause';

  @override
  String get gReplay => 'Replay';

  @override
  String get gMute => 'Mute';

  @override
  String get gUnMute => 'Un-mute';

  @override
  String get gPlaybackSpeed => 'Playback speed';

  @override
  String get gCaptions => 'Subtitles/captions';

  @override
  String get gCaptionsHint => 'Hold for fonts';

  @override
  String get gFullScreen => 'Fullscreen';

  @override
  String get gHowThisWorks => 'How this works';

  @override
  String get gHowThisWorksHint => 'Open helpful documentation';

  @override
  String get gMachineTranslated => 'Machine translated';

  @override
  String get gUpdates => 'Updates available';

  @override
  String get gHardRefresh =>
      'Please hard refresh the page...\nCtrl + Shift + R';

  @override
  String get gHardRefreshMac =>
      'Please hard refresh the page...\nCommand + Shift + R';

  @override
  String get gHardRefreshMobile =>
      'Please refresh the page in the browser menu.';

  @override
  String get gEnterURL => 'Enter URL';

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
  String get gUndoWarn1 => 'Cannot be undone automatically.\n';

  @override
  String get gSave => 'Save';

  @override
  String get gSaveHint => 'Activate to save a JSON config file.';

  @override
  String get gUndoWarn2 => ' your current config to restore it manually.';

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
  String get ssRestartReminder =>
      'Close and reopen the app to apply your changes.';

  @override
  String get ssRestartReminderWeb =>
      'Reload/refresh the page to apply your changes.';

  @override
  String get ssHaveFun => 'Have fun!';

  @override
  String get ssDominantHand => 'Dominant hand';

  @override
  String get ssThemeMode => 'Theme mode';

  @override
  String get ssLanguage => 'Language';

  @override
  String get ssLangHint => 'Activate to change the app language';

  @override
  String get ssUpdateDark => 'Update dark theme';

  @override
  String get ssUpdateLight => 'Update light theme';

  @override
  String get ssUpdateBoth => 'Update both theme modes';

  @override
  String get ssLoadPreset => 'Load preset';

  @override
  String get ssLoadPresetHint => 'Activate to show presets';

  @override
  String get ssBigButtons => 'Big buttons';

  @override
  String get ssHighVisibility => 'High visibility';

  @override
  String get ssChalkboard => 'Chalkboard';

  @override
  String get ssNebula => 'Nebula';

  @override
  String get ssDarkOnly =>
      'This is a dark theme preset. It will set the theme mode to dark, and update that theme.\nContinue?';

  @override
  String get ssLightOnly =>
      'This is a light theme preset. It will set the theme mode to light, and update that theme.\nContinue?';

  @override
  String ssApplied(Object config) {
    return '$config applied.';
  }

  @override
  String get ssTryMe => 'Try me';

  @override
  String get ssRandom => 'Randomize';

  @override
  String ssRandomize(Object themeType) {
    return 'Randomize $themeType theme?';
  }

  @override
  String get ssConfigTip => 'Save/load config';

  @override
  String get ssSaveConfig => 'Save config';

  @override
  String ssConfigSaved(Object path) {
    return 'Your configuration has been saved to $path';
  }

  @override
  String get ssWrongConfigExt => 'The file was not saved as ';

  @override
  String get ssLoadConfig => 'Load config';

  @override
  String get ssResetAll => 'Reset all settings?';

  @override
  String get ssResetBoth => 'Reset both theme modes';

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
  String csReset(Object themeType) {
    return 'Reset $themeType colors?';
  }

  @override
  String get dsPageTitle => 'Design settings';

  @override
  String get dsAnimDuration => 'Animation duration';

  @override
  String get dsMilliseconds => 'Milliseconds';

  @override
  String get dsPreview => 'Preview';

  @override
  String get dsButtonOpacity => 'Button opacity';

  @override
  String get dsBackground => 'Background opacity';

  @override
  String get dsOutline => 'Outline opacity';

  @override
  String get dsBackgroundImg => 'Background image';

  @override
  String dsImgSettingHint(Object title) {
    return 'Update the $title image';
  }

  @override
  String get dsFromFile => 'From file';

  @override
  String get dsFromCamera => 'From camera';

  @override
  String get dsFromNetwork => 'From URL';

  @override
  String get dsSolidColor => 'Solid color';

  @override
  String get dsResetIt => 'Reset it';

  @override
  String get dsClearIt => 'Clear it';

  @override
  String get dsUseForColors => 'Update the app colors using this image';

  @override
  String get dsImgGetFailed => 'Failed to retrieve image';

  @override
  String get dsImgSetFailed => 'Failed to update image';

  @override
  String get dsImgPermission =>
      'Some sites don\'t allow their images to be accessed by others.\nTry an image from another host.';

  @override
  String get dsUseFull => 'Use full image?';

  @override
  String get dsFit => 'How should it fit?';

  @override
  String get dsCrop => 'Crop';

  @override
  String get dsNoWeb => 'Image editing is not supported on web';

  @override
  String get dsDrag => 'Drag';

  @override
  String get dsDragHint => 'Drag to reposition the image';

  @override
  String get dsSwipe => 'Swipe';

  @override
  String get dsSwipeHint => 'Swipe to reposition the image';

  @override
  String get dsPinch => 'Pinch';

  @override
  String get dsPinchHint => 'Pinch to zoom in/out';

  @override
  String get dsScroll => 'Scroll';

  @override
  String get dsScrollHint => 'Scroll to zoom in/out';

  @override
  String get dsRotateLeft => 'Rotate left';

  @override
  String get dsRotateRight => 'Rotate right';

  @override
  String dsReset(Object themeType) {
    return 'Reset $themeType design?';
  }

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
  String lsReset(Object themeType) {
    return 'Reset $themeType layout?';
  }

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
  String tsReset(Object themeType) {
    return 'Reset $themeType text styles?';
  }
}

/// The translations for English, as used in the United States (`en_US`).
class EFUILangEnUs extends EFUILangEn {
  EFUILangEnUs() : super('en_US');

  @override
  String get gApply => 'Apply';

  @override
  String get gApplyChanges => 'Apply changes';

  @override
  String get gContinue => 'Continue';

  @override
  String get gSkip => 'Skip';

  @override
  String get gOpen => 'Open';

  @override
  String get gOpenLink => 'Open link';

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
  String get gUndo => 'Undo';

  @override
  String get gRedo => 'Redo';

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
  String get gDarkTheme => 'Dark theme';

  @override
  String get gLightTheme => 'Light theme';

  @override
  String get gBothThemes => 'Both themes';

  @override
  String get gEditing => 'Editing: ';

  @override
  String get gEditingThemeHint => 'Open the system theme settings';

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
  String get gCenterReset => 'Hold center to reset';

  @override
  String get gLoadingAnim =>
      'Loading. The Empathetic logo animated as a spinning hourglass.';

  @override
  String get gPlay => 'Play';

  @override
  String get gPause => 'Pause';

  @override
  String get gReplay => 'Replay';

  @override
  String get gMute => 'Mute';

  @override
  String get gUnMute => 'Un-mute';

  @override
  String get gPlaybackSpeed => 'Playback speed';

  @override
  String get gCaptions => 'Subtitles/captions';

  @override
  String get gCaptionsHint => 'Hold for fonts';

  @override
  String get gFullScreen => 'Fullscreen';

  @override
  String get gHowThisWorks => 'How this works';

  @override
  String get gHowThisWorksHint => 'Open helpful documentation';

  @override
  String get gMachineTranslated => 'Machine translated';

  @override
  String get gUpdates => 'Updates available';

  @override
  String get gHardRefresh =>
      'Please hard refresh the page...\nCtrl + Shift + R';

  @override
  String get gHardRefreshMac =>
      'Please hard refresh the page...\nCommand + Shift + R';

  @override
  String get gHardRefreshMobile =>
      'Please refresh the page in the browser menu.';

  @override
  String get gEnterURL => 'Enter URL';

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
  String get gUndoWarn1 => 'Cannot be undone automatically.\n';

  @override
  String get gSave => 'Save';

  @override
  String get gSaveHint => 'Activate to save a JSON config file.';

  @override
  String get gUndoWarn2 => ' your current config to restore it manually.';

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
  String get ssRestartReminder =>
      'Close and reopen the app to apply your changes.';

  @override
  String get ssRestartReminderWeb =>
      'Reload/refresh the page to apply your changes.';

  @override
  String get ssHaveFun => 'Have fun!';

  @override
  String get ssDominantHand => 'Dominant hand';

  @override
  String get ssThemeMode => 'Theme mode';

  @override
  String get ssLanguage => 'Language';

  @override
  String get ssLangHint => 'Activate to change the app language';

  @override
  String get ssUpdateDark => 'Update dark theme';

  @override
  String get ssUpdateLight => 'Update light theme';

  @override
  String get ssUpdateBoth => 'Update both theme modes';

  @override
  String get ssLoadPreset => 'Load preset';

  @override
  String get ssLoadPresetHint => 'Activate to show presets';

  @override
  String get ssBigButtons => 'Big buttons';

  @override
  String get ssHighVisibility => 'High visibility';

  @override
  String get ssChalkboard => 'Chalkboard';

  @override
  String get ssNebula => 'Nebula';

  @override
  String get ssDarkOnly =>
      'This is a dark theme preset. It will set the theme mode to dark, and update that theme.\nContinue?';

  @override
  String get ssLightOnly =>
      'This is a light theme preset. It will set the theme mode to light, and update that theme.\nContinue?';

  @override
  String ssApplied(Object config) {
    return '$config applied.';
  }

  @override
  String get ssTryMe => 'Try me';

  @override
  String get ssRandom => 'Randomize';

  @override
  String ssRandomize(Object themeType) {
    return 'Randomize $themeType theme?';
  }

  @override
  String get ssConfigTip => 'Save/load config';

  @override
  String get ssSaveConfig => 'Save config';

  @override
  String ssConfigSaved(Object path) {
    return 'Your configuration has been saved to $path';
  }

  @override
  String get ssWrongConfigExt => 'The file was not saved as ';

  @override
  String get ssLoadConfig => 'Load config';

  @override
  String get ssResetAll => 'Reset all settings?';

  @override
  String get ssResetBoth => 'Reset both theme modes';

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
  String csReset(Object themeType) {
    return 'Reset $themeType colors?';
  }

  @override
  String get dsPageTitle => 'Design settings';

  @override
  String get dsAnimDuration => 'Animation duration';

  @override
  String get dsMilliseconds => 'Milliseconds';

  @override
  String get dsPreview => 'Preview';

  @override
  String get dsButtonOpacity => 'Button opacity';

  @override
  String get dsBackground => 'Background opacity';

  @override
  String get dsOutline => 'Outline opacity';

  @override
  String get dsBackgroundImg => 'Background image';

  @override
  String dsImgSettingHint(Object title) {
    return 'Update the $title image';
  }

  @override
  String get dsFromFile => 'From file';

  @override
  String get dsFromCamera => 'From camera';

  @override
  String get dsFromNetwork => 'From URL';

  @override
  String get dsSolidColor => 'Solid color';

  @override
  String get dsResetIt => 'Reset it';

  @override
  String get dsClearIt => 'Clear it';

  @override
  String get dsUseForColors => 'Update the app colors using this image';

  @override
  String get dsImgGetFailed => 'Failed to retrieve image';

  @override
  String get dsImgSetFailed => 'Failed to update image';

  @override
  String get dsImgPermission =>
      'Some sites don\'t allow their images to be accessed by others.\nTry an image from another host.';

  @override
  String get dsUseFull => 'Use full image?';

  @override
  String get dsFit => 'How should it fit?';

  @override
  String get dsCrop => 'Crop';

  @override
  String get dsNoWeb => 'Image editing is not supported on web';

  @override
  String get dsDrag => 'Drag';

  @override
  String get dsDragHint => 'Drag to reposition the image';

  @override
  String get dsSwipe => 'Swipe';

  @override
  String get dsSwipeHint => 'Swipe to reposition the image';

  @override
  String get dsPinch => 'Pinch';

  @override
  String get dsPinchHint => 'Pinch to zoom in/out';

  @override
  String get dsScroll => 'Scroll';

  @override
  String get dsScrollHint => 'Scroll to zoom in/out';

  @override
  String get dsRotateLeft => 'Rotate left';

  @override
  String get dsRotateRight => 'Rotate right';

  @override
  String dsReset(Object themeType) {
    return 'Reset $themeType design?';
  }

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
  String lsReset(Object themeType) {
    return 'Reset $themeType layout?';
  }

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
  String tsReset(Object themeType) {
    return 'Reset $themeType text styles?';
  }
}
