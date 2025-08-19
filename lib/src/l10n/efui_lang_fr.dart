// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'efui_lang.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class EFUILangFr extends EFUILang {
  EFUILangFr([String locale = 'fr']) : super(locale);

  @override
  String get gApply => 'Appliquer';

  @override
  String get gContinue => 'Continuer';

  @override
  String get gOpen => 'Ouvrir';

  @override
  String get gSuccess => 'Succès';

  @override
  String get gSuccessExl => 'Succès !';

  @override
  String get gYes => 'Oui';

  @override
  String get gAnd => 'et';

  @override
  String get gHelp => 'Aide';

  @override
  String get gNA => 'N/D';

  @override
  String get gNAHint => 'Non disponible';

  @override
  String get gOptional => 'optionnel';

  @override
  String get gOptions => 'Paramètres';

  @override
  String get gRequired => 'Requis';

  @override
  String get gBack => 'Retour';

  @override
  String get gCancel => 'Annuler';

  @override
  String get gClose => 'Fermer';

  @override
  String get gDisabled => 'Désactivé';

  @override
  String get gError => 'Erreur';

  @override
  String get gFailure => 'Échec';

  @override
  String get gNo => 'Non';

  @override
  String get gDark => 'Sombre';

  @override
  String get gLight => 'Clair';

  @override
  String get gSystem => 'Système';

  @override
  String get gEditing => 'Modification : ';

  @override
  String gEditingTheme(Object themeType) {
    return 'Modification : Thème $themeType';
  }

  @override
  String get gLeft => 'Gauche';

  @override
  String get gRight => 'Droite';

  @override
  String get gAdvanced => 'Avancé';

  @override
  String get gQuick => 'Rapide';

  @override
  String get gDecrease => 'Réduire';

  @override
  String get gIncrease => 'Augmenter';

  @override
  String get gMaximum => 'Maximum';

  @override
  String get gMinimum => 'Minimum';

  @override
  String get gLoadingAnim =>
      'Chargement. Le logo empathique animé comme un sablier tournant.';

  @override
  String get gPlay => 'Lecture';

  @override
  String get gPause => 'Pause';

  @override
  String get gMute => 'Muet';

  @override
  String get gUnMute => 'Désactiver le son';

  @override
  String get gPlaybackSpeed => 'Vitesse de lecture';

  @override
  String get gReplay => 'Rejouer';

  @override
  String get gFullScreen => 'Plein écran';

  @override
  String get gHowThisWorks => 'Comment ça marche';

  @override
  String get gHowThisWorksHint => 'Ouvre la documentation utile';

  @override
  String get gTranslationsPending =>
      'Traductions en attente de révision humaine';

  @override
  String get gUpdates => 'Mises à jour disponibles';

  @override
  String get gValidURL => 'Veuillez saisir une URL valide';

  @override
  String get g404Wonder => 'Tous ceux qui errent ne sont pas perdus.';

  @override
  String get g404 => 'Mais, dans ce cas : page 404 non trouvée.';

  @override
  String get g404Note =>
      'Remarque : Flutter Web utilise le routage par hachage, comme...\nhttps://www.example.com/#/settings';

  @override
  String get gOpenSource => 'Open source';

  @override
  String get gOpenEmpathetech => 'Ouvre un lien vers Empathetic LLC';

  @override
  String get gEFUISourceHint => 'Ouvre la page GitHub d\'EFUI';

  @override
  String get gOpenUIReleases => 'Ouvre la page des versions d\'Open UI';

  @override
  String get gGiveFeedback => 'Partager des commentaires';

  @override
  String get gOpeningFeedback => 'Ouverture de l\'outil de feedback.';

  @override
  String get gAttachScreenshot =>
      'Veuillez joindre votre capture d\'écran (dans le dossier de Téléchargements)';

  @override
  String get gSupportEmail => 'Notre Email de support';

  @override
  String gClipboard(Object thing) {
    return '$thing a été copié dans le presse-papiers.';
  }

  @override
  String get gAttention => 'Attention';

  @override
  String get gCurrently => 'Actuellement :';

  @override
  String gSetToValue(Object name, Object value) {
    return '$name est défini sur $value';
  }

  @override
  String get gRemove => 'Retirer';

  @override
  String get gReset => 'Réinitialiser';

  @override
  String get gResetTo => 'Réinitialiser :';

  @override
  String gResetValue(Object name) {
    return 'Réinitialiser $name ?';
  }

  @override
  String gResetValueTo(Object name, Object value) {
    return 'Réinitialiser $name à $value';
  }

  @override
  String get gResetAll => 'Tout réinitialiser';

  @override
  String get gUndoWarn => 'Ne peut pas être annulé';

  @override
  String get gCreditTo => 'Crédits à :';

  @override
  String get gCreator => 'Créateur de';

  @override
  String get gMadeBy => 'Fait par';

  @override
  String get gYou => 'Défini par vous';

  @override
  String get ssPageTitle => 'Paramètres';

  @override
  String get ssNavHint => 'Ouvrir la page des paramètres';

  @override
  String get ssSettingsGuide =>
      'Fermez et rouvrez l\'application pour appliquer vos modifications.\n\nAmusez-vous bien !';

  @override
  String get ssSettingsGuideWeb =>
      'Rechargez/actualisez la page pour appliquer vos modifications.\n\nAmusez-vous bien !';

  @override
  String get ssThemeMode => 'Mode de thème';

  @override
  String get ssDominantHand => 'Main dominante';

  @override
  String get ssLanguage => 'Langue';

  @override
  String get ssLangHint => 'Activer pour changer la langue de l\'application';

  @override
  String get ssLoadPreset => 'Charger un préréglage';

  @override
  String get ssLoadPresetHint => 'Activer pour afficher les préréglages';

  @override
  String get ssSaveConfig => 'Enregistrer la configuration';

  @override
  String get ssLoadConfig => 'Charger la configuration';

  @override
  String get ssTryMe => 'Essayez-moi';

  @override
  String get ssRandom => 'Randomiser';

  @override
  String ssRandomize(Object themeType) {
    return 'Thème $themeType aléatoire ?';
  }

  @override
  String get ssBigButtons => 'Gros boutons';

  @override
  String get ssHighVisibility => 'Haute visibilité';

  @override
  String get ssVideoGame => 'Mode jeu';

  @override
  String get ssChalkboard => 'Tableau noir';

  @override
  String get ssFancyPants => 'Pantalons élégants';

  @override
  String get ssResetAll => 'Réinitialiser tous les paramètres ?';

  @override
  String get tsPageTitle => 'Paramètres de texte';

  @override
  String tsBatchOverride(Object setting) {
    return 'Vous avez déjà apporté des modifications à \"$setting\" dans les paramètres avancés.\n\nÊtes-vous sûr de vouloir remplacer ces modifications par une mise à jour de masse ?';
  }

  @override
  String get tsTextBackground => 'Opacité de l\'arrière-plan du texte';

  @override
  String get tsIconSize => 'Taille de l\'icône';

  @override
  String tsLinkHint(Object style) {
    return 'Activer pour modifier $style';
  }

  @override
  String get tsDisplay => 'Affichage';

  @override
  String get tsHeadline => 'Gros titre';

  @override
  String get tsTitle => 'Titre';

  @override
  String get tsBody => 'Corps';

  @override
  String get tsLabel => 'Label';

  @override
  String get tsFontFamily => 'Police de caractères';

  @override
  String get tsFontSize => 'Taille de police';

  @override
  String get tsBold => 'Gras';

  @override
  String get tsItalic => 'Italique';

  @override
  String get tsUnderline => 'Souligné';

  @override
  String get tsLetterSpacing => 'Espacement des lettres';

  @override
  String get tsWordSpacing => 'Espacement des mots';

  @override
  String get tsLineHeight => 'Hauteur de ligne';

  @override
  String get tsDisplayP1 => 'Est-ce que ça ';

  @override
  String get tsDisplayLink => 's\'affiche';

  @override
  String get tsDisplayP2 => ' bien ?';

  @override
  String get tsHeadlineP1 => 'Est-ce que ';

  @override
  String get tsHeadlineLink => 'les gros titres';

  @override
  String get tsHeadlineP2 => ' se différencient...';

  @override
  String get tsTitleP1 => 'des ';

  @override
  String get tsTitleLink => 'titres ?';

  @override
  String get tsBodyP1 => 'Qu\'en est-il ';

  @override
  String get tsBodyLink => 'du corps ?';

  @override
  String get tsBodyP2 => ' Est-ce facile à lire ?';

  @override
  String get tsLabelP1 => 'Et ';

  @override
  String get tsLabelLink => 'les labels ?';

  @override
  String get tsLabelP2 => ' Ni trop gros, ni trop petits ?';

  @override
  String get tsResetAll => 'Réinitialiser tous les paramètres de texte ?';

  @override
  String get lsPageTitle => 'Paramètres de mise en page';

  @override
  String get lsMargin => 'Marge extérieure';

  @override
  String get lsPadding => 'Marge intérieure';

  @override
  String get lsSpacing => 'Espacement';

  @override
  String get lsScroll => 'Masquer les barres de défilement';

  @override
  String get lsResetAll =>
      'Réinitialiser tous les paramètres de mise en page ?';

  @override
  String get csPageTitle => 'Paramètres de couleur';

  @override
  String get csPickerHint =>
      'Ouvre un sélecteur de couleurs. Appuyer longuement pour plus d\'options.';

  @override
  String get csMonoChrome => 'Utiliser un schéma monochrome';

  @override
  String get csHighContrast => 'Utiliser un schéma à contraste élevé';

  @override
  String get csPickerTitle => 'Choisissez une couleur';

  @override
  String get csRecommended => 'Utiliser la recommandation de contraste ?';

  @override
  String get csUseCustom => 'Utiliser personnalisé';

  @override
  String get csAddColor => 'Ajouter une couleur';

  @override
  String get csCurrVal => 'Valeur de couleur actuelle :';

  @override
  String get csSchemeBase => 'Construire le schéma\nà partir de l\'image';

  @override
  String get csFromImage =>
      'Un schéma de couleurs sera généré à partir de l\'image.';

  @override
  String get csColorScheme => 'schéma de couleurs';

  @override
  String csResetAll(Object themeType) {
    return 'Réinitialiser toutes les couleurs du thème $themeType ?';
  }

  @override
  String get isPageTitle => 'Paramètres d\'image';

  @override
  String get isBackground => 'Arrière-plan';

  @override
  String get isImage => 'image';

  @override
  String isButtonHint(Object title) {
    return 'Mettre à jour l\'image $title';
  }

  @override
  String get isFromFile => 'Depuis un fichier';

  @override
  String get isFromCamera => 'Depuis la caméra';

  @override
  String get isFromNetwork => 'Depuis une URL';

  @override
  String get isResetIt => 'Réinitialiser';

  @override
  String get isClearIt => 'Effacer';

  @override
  String get isEnterURL => 'Entrer l\'URL';

  @override
  String get isGetFailed => 'Impossible de récupérer l\'image';

  @override
  String isSetFailed(Object error) {
    return 'Échec de la mise à jour de l\'image :\n$error';
  }

  @override
  String get isPermission =>
      'Certains sites ne permettent pas à d\'autres d\'accéder à leurs images.\nEssayez une image provenant d\'un autre hébergeur.';

  @override
  String get isUseForColors =>
      'Mettre à jour les couleurs de l\'application à l\'aide de cette image';

  @override
  String get isFit => 'Comment devrait-il s\'adapter ?';

  @override
  String isResetAll(Object themeType) {
    return 'Réinitialiser toutes les images du thème $themeType ?';
  }

  @override
  String isAndColors(Object themeType) {
    return 'Et le schéma de couleurs $themeType ?';
  }
}
