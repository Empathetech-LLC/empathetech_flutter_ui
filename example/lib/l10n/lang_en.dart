import 'lang.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class LangEn extends Lang {
  LangEn([String locale = 'en']) : super(locale);

  @override
  String get gRequired => 'Required';

  @override
  String get gSuccess => 'Success!';

  @override
  String get gFailure => 'Failure';

  @override
  String get csInvalidName =>
      'Lowercase letters, numbers, and underscores are allowed.';

  @override
  String get csInvalidDomain =>
      '\'dom.name\' only; r\'^[a-z0-9_]+\\.[a-z]+\$\'';

  @override
  String get csLoad => 'Load config';

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
  String get rsWouldYou => 'would you like to...';

  @override
  String get rsInstall => 'Install it';

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
