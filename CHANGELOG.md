# Changelog

All notable changes to this project will be documented in this file.

## [5.1.0] - 2024-02-XX
### Updated
- Jenkins pipeline to use external libraries
- File organization
- EzAppProvider parameters (non-breaking)
- Lint rules
  - Audited code according to new rules
- EzConfig.init(customDefaults -> defaults) && no longer using empathetechConfig as a base
  - Potential (somewhat likely) breaking change
- Updated isLightThemeKey -> isDarkThemeKey to match PlatformWidgets convention
  - Minor breaking change

### Removed
- TextSpacingKey && associated Widgets
  - EzNewLine is a better strategy
- navigators.dart

### Added
- Full text theme controls

## [5.0.1] - 2024-01-06
### Updated
- Licensing to 2024
- Set an EzColorSetting bug free
  - Was preventing the color picker from starting
- Empathetech links

## [5.0.0] - 2024-01-02
### Updated
- To Material 3
  - Big updates to...
    - Localizations, configKeys, empathetechConfig, EzConfig, ezThemeData, Color functions, all custom buttons and links
    - The Example app and README to showcase everything
  - Restored iOS web icons and video
  - Updated textScaleFactor to textScaler
  - Using SelectionArea rather than SelectableText
    - Updated EzRichText and EzPlainText
- Made EzLink a TextButton
  - Made EzInlineLink a WidgetSpan wrapper around EzLink
- Expanded EzRowCol
- Updated file organization

### Removed
- EzText

### Added
- EzLocaleSetting
- ColorScheme generation functions
- Tooltips
- EzNewLine

## [4.3.3] - 2023-11-16
### Updated
- EzImageSetting options
  - Updated usability on Web
- EzAlertDialog parameters
  - Minor breaking change
  - Fixed visual bug with ColorPicker

## [4.3.2] - 2023-11-12
### Updated
- EzPlainText

## [4.3.1] - 2023-11-12
### Updated
- Jenkins checks
- Platform widgets

### Added
- EzLinkImage

## [4.3.0] - 2023-10-31
### Removed
- EzVideoPlayer
  - Moved to `efui_video_player` package

### Updated
- Funding config

## [4.2.1] - 2023-10-25
### Updated
- Jenkinsfile checks
- Icon buttons
  - There is an issue with icon buttons on iOS browsers, so icons have been removed when (kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) for now

## [4.2.0] - 2023-10-22
### Updated
- File organization for navigability
- README asset organization
- Comments
- Moved consts/credits to consts/empathetechConfig
- Updated all text Widgets
  - Minor breaking changes
- EzColors from classes to functions
  - Minor breaking change
- Responsive widgets make limited space checks themselves
  - Minor breaking upgrade
- Renamed Phrases && EFUIPhrases to Lang && EFUILang
  - Minor breaking change

### Removed
- Copy to clipboard function && flutter toast package
  - Minor breaking change

### Added
- EzSwapScaffold

## [4.1.1] - 2023-10-08
### Updated
- Asset file extensions
  - [It worked on my machine](https://discussions.apple.com/thread/251191099)
- l10n file names for consistency
  - NOT a breaking change

## [4.1.0] - 2023-10-07
### Updated
- `Create git release` section of Jenkinsfile
- Reverted the line length to 80
- Fixed http links in README
- Renamed EFUILocalizations to EFUIPhrases and AppLocalizations to Phrases
  - Minor breaking changes

## [4.0.0] - 2023-10-07
### Updated
- File structure
- Removed EzApp and made EzAppProvider
- Split enums into their own folder
- Pre-existing release check in the Jenkinsfile
- README
  - A ot
- Renamed EzDialog to EzAlertDialog
  - Removed EzYesNo and created ezAlertActions
- Project line length to 99
- Semantics
  - A lot
- Many references to "default" were updated to "empathetech"
- Parameters (minor breaks)
  - Renamed EzColorSetting.message to EzColorSetting.name
  - Renamed BackgroundColor -> PageColor
  - Renamed ParagraphSpacing to TextSpacing

### Added
- Example app
- Español (and localizations infrastructure)
- More comments
- EzBackAction
- EzLayoutSwitch
- EzResetButton

### Removed
- Unused and/or unverified classes
  - EzNotifications (will return)
  - Eb2Casa

## [3.1.2] - 2023-08-26
### Updated
- Documentation
- Package description
- README

### Added
- Dart docs dev dependency and checks in Jenkinsfile

## [3.1.1] - 2023-08-15
### Updated
- Jenkinsfile checks

### Fixed
- Pan update listener on EzScreen caused bugs. Gone for now.

## [3.1.0] - 2023-08-11
### Updated
- Spacer settings previews
- EzLink && EzWebLink
  - Simplified creation and requiring semantics
- Image wrappers to require semantics for screen readers
- Semantics updates create minor breaks, hence the middle integer update

### Added
- Button alignment options to the video player
- Click and drag to EzScreen
- Router options for EzApp

## [3.0.3] - 2023-08-08
### Updated
- Jenkins pipeline

## [3.0.2] - 2023-08-08
### Added
- Jenkins automation

### Removed
- GitHub Actions

### Updated
- Exports file (fixed name typo)

## [3.0.1] - 2023-05-16
### Updated
- EzSpacer, added a .swap constructor for space constrained screens
- Default styling: paragraph spacing, card accent color

## [3.0.0] - 2023-05-16
### Updated
- Everything

## [2.0.0] - 2023-04-16
### Added
- Flutter analyze GitHub Action
- Donations section to README
- Web UI
  - Special shout out to EzWebPlayer.dart

### Updated
- Most of everything, lots of breaking changes
  - Hence 2.0.0
  - Most wrappers are now a classes, extending the top level Widget

## [1.1.4] - 2023-03-31
### Fixed
- File name bugs... turns out OSX is case-aware, but not case-sensitive

## [1.1.3] - 2023-03-31
### Updated
- Alerts to Future
- Context to non-named param

## [1.1.2] - 2023-03-31
### Updated
- ez scaffold, fixed warning
- imports

## [1.1.1] - 2023-03-31
### Updated
- ez scaffold to a class
- variable names for readability
- ez button to a class
- all setting.dart files
- text forms

### Added
- ez text
- automatic end drawer conversion
- Navigator helper functions

## [1.1.0] - 2023-03-15
### Updated
- Base dart file to be an exporter
- Custom widgets to use required parameters
  - For better readability on import/usage, without the overhead of making custom classes
- Streamlined theme/styling for a "code it once" build style
  - Material first, Cupertino is built from what is found
  - Also streamlined some of the custom widgets via new enum parameters
- Commenting and documentation
  - Shout out to ChatGPT for making this a lot faster than solo-developing (at time of writing)

## [1.0.4] - 2023-03-14
### Updated
- Release strategy; good ol' fashioned shell scripts >> GitHub Actions (in this use case)

## [1.0.3] - 2023-03-13
### Added
- Github action environment

## [1.0.2] - 2023-03-13
### Added
- Publishing github action

## [1.0.1] - 2023-03-13
### Added
- Path version to 1.8.2 for compatibility

## [1.0.0] - 2023-03-11
### Added
- Functional code
- Minimal documentation

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
