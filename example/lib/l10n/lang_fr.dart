// ignore: unused_import
import 'package:intl/intl.dart' as intl;
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
  String get csNameTip => 'La meilleure application de toutes';

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
  String get csPubTip => 'Ou, Personne Exemple';

  @override
  String get csDescription => 'Description';

  @override
  String get csDescPreview => 'Une ou deux phrases sur votre application.';

  @override
  String get csDomainName => 'Nom de domaine';

  @override
  String get csDomainTip => 'À l\'envers, c\'est';

  @override
  String get csInvalidDomain =>
      '\'domain.name\' seulement; RegExp(r\'^[a-z0-9_]+\\.[a-z]+\$\')';

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
      'Ouvrir un générateur de palette de couleurs en ligne';

  @override
  String get csFileBrowser => 'Ouvrir l\'explorateur de fichiers';

  @override
  String get csFlutterPath => 'Flutter chemin';

  @override
  String get csNoSpaces => 'Le chemin ne peut pas contenir d\'espaces';

  @override
  String get csNotInstalled => 'N\'est pas installé?';

  @override
  String get csPathRequired =>
      'Chemin requis. Impossible d\'utiliser le dossier racine.';

  @override
  String get csBadPath => 'Chemin invalide';

  @override
  String get csAdvanced => 'Paramètres avancés';

  @override
  String csRestore(Object setting) {
    return 'Restaurer $setting';
  }

  @override
  String get csOutputPath => 'Chemin de sortie';

  @override
  String get csCopyright => 'Avis de droits d\'auteur';

  @override
  String get csCopyrightTip => 'Sera inclus en haut de chaque fichier Dart';

  @override
  String get csLicenseDocs =>
      'Ouvrir la documentation sur les licences open source';

  @override
  String get csL10nTip =>
      'Configuration de localisation (également connue sous le nom de traductions)';

  @override
  String get csLintTip => 'Règles de lint';

  @override
  String get csLaunchTip =>
      'Ajoute des options de lancement au menu de débogage de VS Code';

  @override
  String get csGenerate => 'Générer l\'application';

  @override
  String get csInvalidFields => 'Certains champs sont invalides';

  @override
  String get csRequired => 'Tous les champs sont obligatoires';

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
  String get asPageTitle => 'Archiviste';

  @override
  String get asUseIt => '\n\nUtilisez-le sur ';

  @override
  String asToGen(Object app_name) {
    return ' pour le bureau pour générer le code pour $app_name';
  }

  @override
  String get gsPageTitle => 'Générateur';

  @override
  String get gsConsole => 'Sortie de la console';

  @override
  String get gsIsReadyIn => 'est prêt dans';

  @override
  String get gsFirstRun =>
      'La première exécution prend généralement un certain temps';

  @override
  String get gsNeedPermission =>
      'Open UI nécessite un accès complet au disque. S\'il vous plaît, allez à...\nParamètres système > Confidentialité et sécurité > Accès complet au disque > Open UI activé, puis réessayez.';

  @override
  String get gsSeeNBelieve =>
      'Si vous souhaitez vérifier ce que fait Open UI, allez ';

  @override
  String get gsSeeNBelieveHint =>
      'Ouvrir le code de génération de code d\'Open UI.';

  @override
  String get gsNotInstalled => 'Flutter n\'est pas installé';

  @override
  String get gsPartialSuccess =>
      'Le code a été généré avec succès, mais une partie de la configuration du projet a échoué.';

  @override
  String get rsWouldYou => 'Souhaitez-vous...';

  @override
  String get rsInstall => 'L\'installer';

  @override
  String get rsInstallHint => 'Ouvrir le guide d\'installation de Flutter';

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
