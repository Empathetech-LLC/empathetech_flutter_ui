# Changelog

All notable changes to this project will be documented in this file.

## [3.1.2] - 2023-08-25
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
- Image wrappers to require semantics for enforcing accessibility
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
