// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'lang.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class LangEn extends Lang {
  LangEn([String locale = 'en']) : super(locale);

  @override
  String get csPageTitle => 'Builder';

  @override
  String get csAppName => 'App name';

  @override
  String get csNamePreview => 'example_app';

  @override
  String get csNameTip => 'Best App Ever';

  @override
  String get csBecomes => 'becomes';

  @override
  String get csInvalidName =>
      'Lowercase letters, numbers, and underscores are allowed.';

  @override
  String get csYourApp => 'your app';

  @override
  String get csPubName => 'Publisher name';

  @override
  String get csPubPreview => 'Example Organization';

  @override
  String get csPubTip => 'Or, Example Person';

  @override
  String get csDescription => 'Description';

  @override
  String get csDescPreview => 'One or two sentences about your app.';

  @override
  String get csDomainName => 'Domain name';

  @override
  String get csDomainTip => 'Backwards, it is';

  @override
  String get csInvalidDomain =>
      '\'domain.name\' only; RegExp(r\'^[a-z0-9_]+\\.[a-z]+\$\')';

  @override
  String get csInclude => 'Include';

  @override
  String get csEasy => 'Easy to change later';

  @override
  String csGenApp(Object app_name) {
    return 'When you generate $app_name, the current ';
  }

  @override
  String get csTheApp => 'the app';

  @override
  String get csTheConfig => 'the config';

  @override
  String csSetColors(Object app_name) {
    return ' (except images) will become the default config for $app_name.\n\nIt is recommended to set a custom color scheme. If you need help building one, try starting ';
  }

  @override
  String get csHere => 'here.';

  @override
  String get csHereHint => 'Open an online color scheme builder';

  @override
  String get csFileBrowser => 'Open file browser';

  @override
  String get csFlutterPath => 'Flutter path';

  @override
  String get csNoSpaces => 'Path cannot have spaces';

  @override
  String get csNotInstalled => 'Not installed?';

  @override
  String get csPathRequired => 'Path required. Cannot use root folder.';

  @override
  String get csBadPath => 'Invalid path';

  @override
  String get csAdvanced => 'Advanced settings';

  @override
  String csRestore(Object setting) {
    return 'Restore $setting';
  }

  @override
  String get csOutputPath => 'Output path';

  @override
  String get csCopyright => 'Copyright notice';

  @override
  String get csCopyrightTip => 'Will be included at the top of every Dart file';

  @override
  String get csLicenseDocs => 'Open documentation on open source licenses';

  @override
  String get csL10nTip => 'Localization (aka translations) config';

  @override
  String get csLintTip => 'Lint rules';

  @override
  String get csLaunchTip => 'Adds launch options to VS Code\'s debug menu';

  @override
  String get csGenerate => 'Generate app';

  @override
  String get csInvalidFields => 'Some fields are invalid';

  @override
  String get csRequired => 'All fields are required';

  @override
  String get csResetHint => 'Activate and confirm what should be reset.';

  @override
  String get csResetBuilder => 'Builder values';

  @override
  String get csResetApp => 'App settings';

  @override
  String get csResetBoth => 'Both';

  @override
  String get csResetNothing => 'Nothing';

  @override
  String get asPageTitle => 'Archiver';

  @override
  String get asUseIt => '\n\nUse it on ';

  @override
  String asToGen(Object app_name) {
    return ' for desktop to generate the code for $app_name';
  }

  @override
  String get gsPageTitle => 'Generator';

  @override
  String get gsConsole => 'Console output';

  @override
  String get gsIsReadyIn => 'is ready in';

  @override
  String get gsFirstRun => 'First run usually takes awhile';

  @override
  String get gsNeedPermission =>
      'Open UI needs Full Disk Access.\n\nPlease go to...\nSystem Settings > Privacy & Security > Full Disk Access > Enable Open UI; then try again.';

  @override
  String get gsSeeNBelieve => 'If you want to verify what Open UI does, go ';

  @override
  String get gsSeeNBelieveHint => 'Open Open UI\'s code generation code.';

  @override
  String get gsNotInstalled => 'Flutter is not installed';

  @override
  String get gsPartialSuccess =>
      'The code was successfully generated, but some of the project setup failed.';

  @override
  String get rsWouldYou => 'would you like to...';

  @override
  String get rsInstall => 'Install it';

  @override
  String get rsInstallHint => 'Open Flutter\'s installation guide';

  @override
  String get rsRun => 'Run it';

  @override
  String get rsWipe => 'Wipe it';

  @override
  String get rsNextTime => 'Success, fingers crossed for next time!';

  @override
  String get rsAnotherOne =>
      'Another failure; you should probably take over...';

  @override
  String get rsLeave => 'Leave it';
}

/// The translations for English, as used in the United States (`en_US`).
class LangEnUs extends LangEn {
  LangEnUs() : super('en_US');

  @override
  String get csPageTitle => 'Builder';

  @override
  String get csAppName => 'App name';

  @override
  String get csNamePreview => 'example_app';

  @override
  String get csNameTip => 'Best App Ever';

  @override
  String get csBecomes => 'becomes';

  @override
  String get csInvalidName =>
      'Lowercase letters, numbers, and underscores are allowed.';

  @override
  String get csYourApp => 'your app';

  @override
  String get csPubName => 'Publisher name';

  @override
  String get csPubPreview => 'Example Organization';

  @override
  String get csPubTip => 'Or, Example Person';

  @override
  String get csDescription => 'Description';

  @override
  String get csDescPreview => 'One or two sentences about your app.';

  @override
  String get csDomainName => 'Domain name';

  @override
  String get csDomainTip => 'Backwards, it is';

  @override
  String get csInvalidDomain =>
      '\'domain.name\' only; RegExp(r\'^[a-z0-9_]+\\.[a-z]+\$\')';

  @override
  String get csInclude => 'Include';

  @override
  String get csEasy => 'Easy to change later';

  @override
  String csGenApp(Object app_name) {
    return 'When you generate $app_name, the current ';
  }

  @override
  String get csTheApp => 'the app';

  @override
  String get csTheConfig => 'the config';

  @override
  String csSetColors(Object app_name) {
    return ' (except images) will become the default config for $app_name.\n\nIt is recommended to set a custom color scheme. If you need help building one, try starting ';
  }

  @override
  String get csHere => 'here.';

  @override
  String get csHereHint => 'Open an online color scheme builder';

  @override
  String get csFileBrowser => 'Open file browser';

  @override
  String get csFlutterPath => 'Flutter path';

  @override
  String get csNoSpaces => 'Path cannot have spaces';

  @override
  String get csNotInstalled => 'Not installed?';

  @override
  String get csPathRequired => 'Path required. Cannot use root folder.';

  @override
  String get csBadPath => 'Invalid path';

  @override
  String get csAdvanced => 'Advanced settings';

  @override
  String csRestore(Object setting) {
    return 'Restore $setting';
  }

  @override
  String get csOutputPath => 'Output path';

  @override
  String get csCopyright => 'Copyright notice';

  @override
  String get csCopyrightTip => 'Will be included at the top of every Dart file';

  @override
  String get csLicenseDocs => 'Open documentation on open source licenses';

  @override
  String get csL10nTip => 'Localization (aka translations) config';

  @override
  String get csLintTip => 'Lint rules';

  @override
  String get csLaunchTip => 'Adds launch options to VS Code\'s debug menu';

  @override
  String get csGenerate => 'Generate app';

  @override
  String get csInvalidFields => 'Some fields are invalid';

  @override
  String get csRequired => 'All fields are required';

  @override
  String get csResetHint => 'Activate and confirm what should be reset.';

  @override
  String get csResetBuilder => 'Builder values';

  @override
  String get csResetApp => 'App settings';

  @override
  String get csResetBoth => 'Both';

  @override
  String get csResetNothing => 'Nothing';

  @override
  String get asPageTitle => 'Archiver';

  @override
  String get asUseIt => '\n\nUse it on ';

  @override
  String asToGen(Object app_name) {
    return ' for desktop to generate the code for $app_name';
  }

  @override
  String get gsPageTitle => 'Generator';

  @override
  String get gsConsole => 'Console output';

  @override
  String get gsIsReadyIn => 'is ready in';

  @override
  String get gsFirstRun => 'First run usually takes awhile';

  @override
  String get gsNeedPermission =>
      'Open UI needs Full Disk Access.\n\nPlease go to...\nSystem Settings > Privacy & Security > Full Disk Access > Enable Open UI; then try again.';

  @override
  String get gsSeeNBelieve => 'If you want to verify what Open UI does, go ';

  @override
  String get gsSeeNBelieveHint => 'Open Open UI\'s code generation code.';

  @override
  String get gsNotInstalled => 'Flutter is not installed';

  @override
  String get gsPartialSuccess =>
      'The code was successfully generated, but some of the project setup failed.';

  @override
  String get rsWouldYou => 'would you like to...';

  @override
  String get rsInstall => 'Install it';

  @override
  String get rsInstallHint => 'Open Flutter\'s installation guide';

  @override
  String get rsRun => 'Run it';

  @override
  String get rsWipe => 'Wipe it';

  @override
  String get rsNextTime => 'Success, fingers crossed for next time!';

  @override
  String get rsAnotherOne =>
      'Another failure; you should probably take over...';

  @override
  String get rsLeave => 'Leave it';
}
