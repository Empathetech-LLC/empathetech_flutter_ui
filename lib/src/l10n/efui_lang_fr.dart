import 'efui_lang.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class EFUILangFr extends EFUILang {
  EFUILangFr([String locale = 'fr']) : super(locale);

  @override
  String get gYes => 'Oui';

  @override
  String get gNo => 'Non';

  @override
  String get gOptions => 'Paramètres';

  @override
  String get gApply => 'Appliquer';

  @override
  String get gContinue => 'Continuer';

  @override
  String get gCancel => 'Annuler';

  @override
  String get gClose => 'Fermer';

  @override
  String get gBYO => 'Construisez la vôtre';

  @override
  String get gEFUISourceHint => 'Ouvre la page GitHub d\'EFUI';

  @override
  String get gGiveFeedback => 'Partager des commentaires';

  @override
  String gClipboard(Object thing) {
    return '$thing copié dans le presse-papiers';
  }

  @override
  String get gSupportEmail => 'E-mail de support';

  @override
  String get gLeft => 'Gauche';

  @override
  String get gRight => 'Droite';

  @override
  String get gBack => 'Retour';

  @override
  String get gSystem => 'Système';

  @override
  String get gLight => 'Clair';

  @override
  String get gDark => 'Sombre';

  @override
  String get gEditing => 'Modification : ';

  @override
  String gEditingTheme(Object themeType) {
    return 'Modification : Thème $themeType';
  }

  @override
  String get gQuick => 'Rapide';

  @override
  String get gAdvanced => 'Avancé';

  @override
  String get gHowThisWorks => 'Comment ça marche';

  @override
  String get gHowThisWorksHint => 'Ouvre la documentation utile';

  @override
  String get gAttention => 'Attention';

  @override
  String get gCurrently => 'Actuellement :';

  @override
  String gSetToValue(Object name, Object value) {
    return '$name est défini sur $value';
  }

  @override
  String get gReset => 'Réinitialiser :';

  @override
  String gResetToValue(Object name, Object value) {
    return 'Réinitialiser $name à $value';
  }

  @override
  String get gResetAll => 'Tout réinitialiser';

  @override
  String get gResetWarn => 'Ne peut pas être annulé';

  @override
  String get gCreditTo => 'Crédits à :';

  @override
  String get gYou => 'Défini par vous';

  @override
  String get ssPageTitle => 'Paramètres';

  @override
  String get ssSettingsGuide =>
      'Redémarrez l\'application pour appliquer vos modifications.\n\nAmusez-vous bien !';

  @override
  String get ssSettingsGuideWeb =>
      'Rechargez la page pour appliquer vos modifications.\n\nAmusez-vous bien !';

  @override
  String get ssThemeMode => 'Mode de thème';

  @override
  String get ssDominantHand => 'Main dominante';

  @override
  String get ssLanguage => 'Langue';

  @override
  String get ssLanguages => 'Langues';

  @override
  String get ssLangHint => 'Langue de l\'appli';

  @override
  String get ssResetAll => 'Réinitialiser tous les paramètres ?';

  @override
  String get tsPageTitle => 'Paramètres de texte';

  @override
  String tsBatchOverride(Object setting) {
    return 'Vous avez déjà apporté des modifications à \"$setting\" dans les paramètres avancés.\n\nÊtes-vous sûr de vouloir remplacer ces modifications par une mise à jour de masse ?';
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
  String tsLinkHint(Object style) {
    return 'Activer pour modifier $style';
  }

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
  String get tsDecrease => 'Réduire';

  @override
  String get tsIncrease => 'Augmenter';

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
  String get lsResetAll =>
      'Réinitialiser tous les paramètres de mise en page ?';

  @override
  String get csPageTitle => 'Paramètres de couleur';

  @override
  String csPickerHint(Object name) {
    return 'Ouvre un sélecteur de couleurs pour $name. Appuyer longuement pour plus d\'options.';
  }

  @override
  String get csMonoChrome => 'Utiliser un schéma monochrome';

  @override
  String get csHighContrast => 'Utiliser un schéma à contraste élevé';

  @override
  String get csPrimary => 'Primary';

  @override
  String get csOnPrimary => 'On primary';

  @override
  String get csPrimaryContainer => 'Primary container';

  @override
  String get csOnPrimaryContainer => 'On primary container';

  @override
  String get csPrimaryFixed => 'Primary fixed';

  @override
  String get csPrimaryFixedDim => 'Primary fixed dim';

  @override
  String get csOnPrimaryFixed => 'On primary fixed';

  @override
  String get csOnPrimaryFixedVariant => 'On primary fixed variant';

  @override
  String get csSecondary => 'Secondary';

  @override
  String get csOnSecondary => 'On secondary';

  @override
  String get csSecondaryContainer => 'Secondary container';

  @override
  String get csOnSecondaryContainer => 'On secondary container';

  @override
  String get csSecondaryFixed => 'Secondary fixed';

  @override
  String get csSecondaryFixedDim => 'Secondary fixed dim';

  @override
  String get csOnSecondaryFixed => 'On secondary fixed';

  @override
  String get csOnSecondaryFixedVariant => 'On secondary fixed variant';

  @override
  String get csTertiary => 'Tertiary';

  @override
  String get csOnTertiary => 'On tertiary';

  @override
  String get csTertiaryContainer => 'Tertiary container';

  @override
  String get csOnTertiaryContainer => 'On tertiary container';

  @override
  String get csTertiaryFixed => 'Tertiary fixed';

  @override
  String get csTertiaryFixedDim => 'Tertiary fixed dim';

  @override
  String get csOnTertiaryFixed => 'On tertiary fixed';

  @override
  String get csOnTertiaryFixedVariant => 'On tertiary fixed variant';

  @override
  String get csError => 'Error';

  @override
  String get csOnError => 'On error';

  @override
  String get csErrorContainer => 'Error container';

  @override
  String get csOnErrorContainer => 'On error container';

  @override
  String get csOutline => 'Outline';

  @override
  String get csOutlineVariant => 'Outline variant';

  @override
  String get csSurface => 'Surface';

  @override
  String get csOnSurface => 'On surface';

  @override
  String get csSurfaceDim => 'Surface dim';

  @override
  String get csSurfaceBright => 'Surface bright';

  @override
  String get csSurfaceContainerLowest => 'Surface container lowest';

  @override
  String get csSurfaceContainerLow => 'Surface container low';

  @override
  String get csSurfaceContainer => 'Surface container';

  @override
  String get csSurfaceContainerHigh => 'Surface container high';

  @override
  String get csSurfaceContainerHighest => 'Surface container highest';

  @override
  String get csOnSurfaceVariant => 'On surface variant';

  @override
  String get csInverseSurface => 'Inverse surface';

  @override
  String get csOnInverseSurface => 'On inverse surface';

  @override
  String get csInversePrimary => 'Inverse primary';

  @override
  String get csScrim => 'Scrim';

  @override
  String get csShadow => 'Shadow';

  @override
  String get csSurfaceTint => 'Surface tint';

  @override
  String get csPickerTitle => 'Choisissez une couleur';

  @override
  String get csRecommended => 'Utiliser la recommandation de contraste ?';

  @override
  String get csUseCustom => 'Utiliser personnalisé';

  @override
  String get csAddColor => 'Ajouter une couleur';

  @override
  String get csRemove => 'Retirer';

  @override
  String get csReset => 'Réinitialiser';

  @override
  String get csResetTo => 'Réinitialiser à...';

  @override
  String get csSchemeBase => 'Construire le schéma\nà partir de l\'image';

  @override
  String get csOptional => 'optionnel';

  @override
  String get csFromImage =>
      'Construire le schéma de couleurs à partir d\'une image';

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
  String isDialogTitle(Object title) {
    return 'Comment l\'image $title doit-elle être mise à jour ?';
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
  String isResetAll(Object themeType) {
    return 'Réinitialiser toutes les images du thème $themeType ?';
  }
}
