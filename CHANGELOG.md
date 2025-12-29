# Changelog

All notable changes to this project will be documented in this file.

## [11.0.0] - 2025-12-31
### Added
- appName and androidPackage parameters to all sample settings screen constructions
  - For EzUpdater and/or config saving/loading
- Undo passthrough to ezSnackBar
- Save config link to randomize and reset buttons
  - Toggle-able in Widget, included in sample settings screens

### Removed
- ezL10n function, now use EzConfig.l10n

### Updated
- !! EzConfig/settings updates are fully live now !!
  - EzConfig.set can optionally redraw the UI immediately
    - Default false for performance
      - All sample settings screens have appropriate instances set true (ImageSettings, for example)
      - Sample settings screens also have a new EzApplyFAB that appears when changes are made
  - EzConfig.init has breaking changes (see docs, minor break)
  - EzConfig.getLocale -> getStoredLocale
  - Privatized EzConfig fields, added lots of getters/setters
  - Common spacers should now be access via EzConfig.layout.[spacer,separator,margin,...] (previously ezSpacer, ezSeparator, ezMargin...)
- Flutter 3.38.X
- Simplified/shortened the human translations pending message to "Machine translated"

## [10.2.0] - 2025-10-20
### Added
- Shared consts for default spacers (eSpacer, ezMargin, ezSeparator...)
  - ez[Start|Center|End]Line too
- ezUpdater to code gen
- ezModal
  - Custom defaults and auto-consumes ezAnimDuration

### Updated
- Comment style (fewer '')
- ezAnimDuration half param to mod(ifier)
- ezDivider default from 4x spacing to 3x
- EzLink padding; no longer adheres to kMinInteractiveDimension
- EzAdaptiveScaffold -> EzAdaptiveParent
- Modal styling
- Design settings
  - Put all the previews inside a modal, similar to layout settings
- More EzBackFAB options
- Material alert dialog padding
  - && EzTutorial to match

### Fixed
- i(Pad)OS share plus bug
- Option order for "on" EzColorSetting Widgets

## [10.1.0] - 2025-09-26
### Added
- Supplemental onHover passthrough for EzLink
- EzMenuLink
- EzFABLink
- showScrollHint option to EzScrollView
- (Restored) EzNewLine
- More comments
- EzUpdaterFAB
- Platform aware && web safe ezFullscreenToggle helper function

## Removed
- Redundant menuButtonStyle overrides
- (More) Redundant ?? fallbacks for EzConfig.get calls

## Updated
- EzBackAction and EzBackFAB to use maybePop
- Material alert dialog title padding
- EzVideoPlayer
  - Better state management, subtitles, scroll hints, and more!
- Router config to use ezGoTransition/animationDurationKey
- EzSettingsHome build
  - The settings paths can now be URLs, wrapping the EzElevatedButtons in a Link Widget
- animationDurationKey to int (from double)

## Fixed
- Bug when updating text background opacity via a new background image
- Design settings live theme updates
- Advanced text settings live theme updates
- Advanced color settings bug
  - Auto-closing the "Add a color" modal on theme update; a live redraw is not feasible/worth the effort

## [10.0.0] - 2025-09-07
### Updated
- Flutter 3.35.0 (breaking changes(s))
  - Example inherited breaking changes: new EzRadio
- Explicit ndkVersion in build.gradle
- Image settings -> design settings (breaking change)
  - Has previous background image setting(s) and new animation duration and button transparency settings
  - Reminder that "isX" l10n entries are now "dsX"
  - Re-ordered the default settings: Color, Design, Layout, Text
- Theme data calls; split into `fixed` (outside build) and `dynamic` (inside build) chunks
  - TextTheme and ColorScheme are now dynamic, so background ThemeMode changes will automatically redraw the UI
- GoRouter setup to consume the new animation duration setting
- ezImagePicker prefsPath is now optional
  - Previously returned the image and auto-set the config key, config is now optional
- Extra parameters on sample setting screens (minor breaking change(s))
  - Condensed, BYO spacing widgets
- Properly consuming iconSize in EzImageSettings and EzLocaleSettings
- Cleanup spacing for EzAlertDialogs when entries are null
  - And alignment when there are more than 2 actions
- Text color for the text style providers
  - Removed constructor param, added redraw method
-  Text style settings widgets now require the providers as params, rather than checking the context (breaking change)
   -  Required for seamless theme mode changes

### Added
- Simple UX for saving and loading configs
- Sample configs
  - Previously defined accessible configs (large touch points and high vis) and new sillier configs
- typeMap tracker to EzConfig
  - Load config will check the typeMap for allowed entries
- Sample image editor screen; crop, rotate, zoom, oh my!
  - EzImageSetting has a new showEditor param, default true

### Removed
- Unused local fonts
- Redundant ?? fallbacks for EzConfig.get calls

## [9.2.0] - 2025-06-27
### Updated
- sample_screen (all 5) customization
  - Defaults constructors are unchanged, default behavior 90+% unchanged
- EzSwapScaffold -> EzAdaptiveScaffold
  - No longer requires a threshold, they are included (and can be modified)
  - Now only requires a `small` screen Widget
  - Supports `small`, `medium`, and `large` breakpoints
- Default surface colors
- Open UI code gen to match changes
- Fixed getTextColor; calculations hadn't been updated for Flutter's new double .rgb values
- Default EzDivider size (and added more passthrough parameters)

### Added
- surfaceDim to default config and ThemeData
- EzLocaleSetting customization
- EzAdaptiveWidget
  - Existing EzSwapX widgets now have a breakpoint parameter, default to `small` (same value as before)
- Set<String>? skip param to EzConfig.reset
- EzCheckboxPair
- SwitchThemeData to ezThemeData
- EzSwitchPair

## [9.1.0] - 2025-06-11
### Updated
- Web links have proper context menus
  - Minimal developer changes required
    - EzLinkImageProvider is now EzImageLink
    - Some EzXLink parameters have been updated
- Config randomizer is a little more random
- Code comments

### Added
- EzElevated(Icon)Link
- More feedback localizations
- SemanticsRole to EzToolTipper

## [9.0.1] - 2025-05-24
### Updated
- Flutter 3.32.0
- ezCMD
- EzLocaleSetting

## [9.0.0] - 2025-05-12
### Updated
- Localization strategy
  - EzConfig now requires a fallback
    - Example: `l10nFallback: await EFUILang.delegate.load(americanEnglish),`
    - Enables all things EFUI to continue working in apps that have unsupported Locales
      - If calling EFUILang in your code, here is the updated recommendation:
        - ``
  - Updated EzLocaleSetting for the new strategy
  - Added skip parameter to EzLocaleSetting
- Improved EzConfig.init() efficiency

## [8.1.1] - 2025-04-27
### Added
- Split between default mobile and desktop configs
  - Technically a breaking change, just need to update the parameter name
    - Implementing the split is optional; the old default is now mobileEmpathConfig
- isMobile and isDesktop PlatformTarget helpers

### Updated
- Version tracking checks in CI/CD
- SharePlus package

## [8.1.0] - 2025-04-20
### Added
- customActions param to ezLog
- Testing configs
- ezToolbarHeight
- Consideration for kMinInteractiveDimension in adaptive layout(s)

### Changed
- Code cleanup
- EzSettingType enum
  - Breaking change; split into separate enums

### Removed
- Config bloat
- ezIconSize
  - Added iconSizeKey to EzConfig

## [8.0.2] - 2025-02-27
### Updated
- Copyright year from range to current year
- More 3.29 dependencies

## [8.0.1] - 2025-02-13
### Updated
- Flutter 3.29
- ezWindowNamer
- urlValidator -> validateUrl

## [8.0.0] - 2025-02-04
### Updated
- Oops, I did it again...
  - "Honestly, pretty much everything" (Empathetech, v7: Sep 2024)
- Summary
  - Standardized naming
    - Every method and class that isn't a direct alias has been labeled ez/Ez
  - Even more comments
    - Just about every method, class, and parameter has a doc comment
  - Lots of helper Widgets to streamline creating EzConfig responsive layouts
  - While making EAG (below) and comment auditing, gave some old code some TLC. Things with known breaking changes...
    - EzAlertDialog
    - Some EzConfig keys (names)
      - bold and italics across the board
      - google font keys
      - iconSize is new and required
  - Bug fixes

### Added
- Empathetech App Generator!
  - Open UI is no longer a demo app, and can now be used to generate new empathetic apps
    - Open UI now has it's own l10n library as well
- Open UI version tracking
  - And a FABulous Widget to go with it
- ezCmd
- Lots of text helper functions

### Revived
- EFUI video player
  - Now just a class in EFUI

## [7.3.1] - 2024-10-19
### Updated
- Feedback button
  - Better communication and works on web!
- Feedback related localizations
- Moved color key names to consts

### Added
- ezLog function to differentiate permanent and temporary logs
- getBasePlatform and screenshotHint (functions/helpers.dart)
- ezSnackBar and snackWidth (functions/snack_bars.dart)
- EzCountdownTimer (widgets/helpers/countdown_timer.dart)

## [7.3.0] - 2024-10-16
### Added
- Randomize button
  - Added more defaults to const file

### Updated
- Spacer -> Separator at bottom of sample screens
- Reading time
  - Now estimates 100 words/min reading rate and has a 2 second minimum
- FAB theme
- SnackBar theme
- Line icons got promoted for the randomize button's D6 icon

### Removed
- logSnack dialog
- Scaffold messenger key from Open UI
  - Updated to context call

## [7.2.1] - 2024-10-08
### Added
- EzConfig.reset
  - Updated EzResetButton default to be EzConfig.reset
- Image setting defaults
- BoxFit consts
- Bug fixes

### Updated
- Image fit preview

## [7.2.0] - 2024-10-06
### Updated
- Integrated testing
- Analysis options
- Code comments
- Using named routes (go router)
- Page image key -> background image key
- Dialog function parameters
- Empathetech theme data
- Localizations
- EzScreen decorations
- Highlight opacity 0.1 -> 0.25
- Alert dialogs
- Color pickers

### Added
- Text backgrounds
  - Background opacity slider in sample text settings
- Mounted context checks
- Additional settings passthrough for sample screens
- Sizing widgets
- Icon option to EzLink && EzInlineLink
- PlatformTheme check backups
  - Makes it easier to use EFUI w/out having to use Flutter Platform Widgets
    - FPW is still recommended (and unaffiliated)
- isLefty responsive Elevated, Text, and MenuItem buttons
- Hide scrollbars setting
- Fit options for image settings
- More text underlining and more options for it

### Removed
- EzLinkImage
  - EzLinkImageProvider is better

## [7.1.0] - 2024-09-08
### Added
- Integration testing utils
- Lefty test

### Updated
- Tightened dependencies
- Layout settings mins, maxes, and defaults
- RowCol bug fix
- EzRichText semantics
  - EzInlineLink params and documentation
  - EzPlainText placeholder

## [7.0.0] - 2024-09-06
### Updated
- Honestly, pretty much everything
  - Will get back to good CHANGELOG-ing next release
    - And smaller releases
  - Code comments are aplenty, any breaking changes should be easy to track down

## [6.0.0] - 2024-03-23
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
  - Similarly, isRightHandKey -> isLefty
- EzSliderSetting -> EzLayoutSetting
- TextStyleType -> TextSettingType
- All EzSettings now use `configKey` as the main param
  - Minor breaking change
- The README to match changes
  - Removed images, live exists 
    - And will grow soon!

### Removed
- TextSpacingKey && associated Widgets
  - EzNewLine is a better strategy
- EzTextStyle
- enums dir
  - Moved code to new homes (Hand -> dominant_hand_switch and such)

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
