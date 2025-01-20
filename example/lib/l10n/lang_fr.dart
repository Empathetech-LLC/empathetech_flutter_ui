import 'lang.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class LangFr extends Lang {
  LangFr([String locale = 'fr']) : super(locale);

  @override
  String get gRequired => 'Requis';

  @override
  String get gSuccess => 'Succès !';

  @override
  String get gFailure => 'Échec';

  @override
  String get csInvalidName =>
      'Les lettres minuscules, les chiffres et les traits de soulignement sont autorisés.';

  @override
  String get csInvalidDomain =>
      '\'dom.name\' seulement; r\'^[a-z0-9_]+\\.[a-z]+\$\'';

  @override
  String get csLoad => 'Charger la configuration';

  @override
  String get csResetHint =>
      'Activez et confirmez ce qui doit être réinitialisé.';

  @override
  String get csResetBuilder => 'Valeurs du constructeur';

  @override
  String get csResetApp => 'Paramètres de l\'application';

  @override
  String get csResetBoth => 'Les deux';

  @override
  String get csResetNothing => 'Rien';

  @override
  String get rsWouldYou => 'Souhaitez-vous...';

  @override
  String get rsInstall => 'L\'installer';

  @override
  String get rsRun => 'L\'exécuter';

  @override
  String get rsWipe => 'L\'effacer';

  @override
  String get rsNextTime =>
      'Succès, croisons les doigts pour la prochaine fois !';

  @override
  String get rsAnotherOne =>
      'Un autre échec ; vous devriez probablement prendre le relais...';

  @override
  String get rsLeave => 'Le laisser';
}
