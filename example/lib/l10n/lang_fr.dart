import 'lang.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class LangFr extends Lang {
  LangFr([String locale = 'fr']) : super(locale);

  @override
  String get csPageTitle => 'Constructeur';

  @override
  String get csAppName => 'Nom de l\'application';

  @override
  String get csNamePreview => 'exemple_app';

  @override
  String get csNameHint => 'La meilleure application de toutes';

  @override
  String get csBecomes => 'devient';

  @override
  String get csInvalidName =>
      'Les lettres minuscules, les chiffres et les traits de soulignement sont autorisés.';

  @override
  String get csYourApp => 'votre application';

  @override
  String get csPubName => 'Nom de l\'éditeur';

  @override
  String get csPubPreview => 'Organisation Exemple';

  @override
  String get csPubHint => 'Ou Personne Exemple';

  @override
  String get csDescription => 'Description';

  @override
  String get csDescPreview => 'Une ou deux phrases sur votre application.';

  @override
  String get csDomainName => 'Nom de domaine';

  @override
  String get csDomainHint => 'À l\'envers, c\'est';

  @override
  String get csInvalidDomain =>
      '\'domain.name\' seulement; RegExp(r\'^[a-z0-9_]+\\.[a-z]+\$\')';

  @override
  String get csSupportEmail => 'Courriel de soutien';

  @override
  String get csSupportHint =>
      'Si fourni, le système de commentaires que nous utilisons sera inclus.';

  @override
  String get csInvalidEmail => 'Courriel invalide';

  @override
  String get csInclude => 'Inclure';

  @override
  String get csEasy => 'Facile à changer plus tard';

  @override
  String csGenApp(Object app_name) {
    return 'Lorsque vous générez $app_name l\'actuel ';
  }

  @override
  String get csTheApp => 'l\'application';

  @override
  String get csTheConfig => 'la configuration';

  @override
  String csSetColors(Object app_name) {
    return ' (sauf les images) deviendra la configuration par défaut pour $app_name.\n\nIl est recommandé de définir un schéma de couleurs personnalisé. Si vous avez besoin d\'aide pour en construire un, essayez de commencer ';
  }

  @override
  String get csHere => 'ici.';

  @override
  String get csHereHint =>
      'Ouvrez un lien vers un constructeur de schémas de couleurs en ligne';

  @override
  String get csAdvanced => 'Paramètres avancés';

  @override
  String get csPathRequired =>
      'Chemin requis. Impossible d\'utiliser le dossier racine.';

  @override
  String get csBadPath => 'Chemin invalide';

  @override
  String get csCopyright => 'Avis de droits d\'auteur';

  @override
  String get csCopyrightHint => 'Sera inclus en haut de chaque fichier Dart';

  @override
  String get csL10nHint =>
      'Configuration de localisation (également connue sous le nom de traductions)';

  @override
  String get csLintHint => 'Règles de lint';

  @override
  String get csLaunchHint =>
      'Ajoute des options de lancement au menu de débogage de VS Code';

  @override
  String get csSave => 'Enregistrer la configuration';

  @override
  String get csLoad => 'Charger la configuration';

  @override
  String get csGenerate => 'Générer l\'application';

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
