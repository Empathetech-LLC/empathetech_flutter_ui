import 'efui_lang.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class EFUILangEs extends EFUILang {
  EFUILangEs([String locale = 'es']) : super(locale);

  @override
  String get gYes => 'Sí';

  @override
  String get gNo => 'No';

  @override
  String get gOptions => 'Opciones';

  @override
  String get gApply => 'Aplicar';

  @override
  String get gContinue => 'Continuar';

  @override
  String get gCancel => 'Cancelar';

  @override
  String get gClose => 'Cerrar';

  @override
  String get gBYO => 'Construye uno';

  @override
  String get gEFUISourceHint => 'Abrir la página de GitHub de EFUI';

  @override
  String get gGiveFeedback => 'Dar feedback';

  @override
  String gClipboard(Object thing) {
    return '$thing copiado al portapapeles';
  }

  @override
  String get gSupportEmail => 'Email de soporte';

  @override
  String get gLeft => 'Izquierda';

  @override
  String get gRight => 'Derecha';

  @override
  String get gBack => 'Atrás';

  @override
  String get gSystem => 'Sistema';

  @override
  String get gLight => 'Claro';

  @override
  String get gDark => 'Oscuro';

  @override
  String get gEditing => 'Editando: ';

  @override
  String gEditingTheme(Object themeType) {
    return 'Editando: tema $themeType';
  }

  @override
  String get gQuick => 'Rápido';

  @override
  String get gAdvanced => 'Avanzado';

  @override
  String get gHowThisWorks => 'Cómo funciona';

  @override
  String get gHowThisWorksHint => 'Abrir documentación útil';

  @override
  String get gAttention => 'Atención';

  @override
  String get gCurrently => 'Actualmente:';

  @override
  String gSetToValue(Object name, Object value) {
    return '$name está configurado a $value';
  }

  @override
  String get gReset => 'Restablecer:';

  @override
  String gResetToValue(Object name, Object value) {
    return 'Restablecer $name a $value';
  }

  @override
  String get gResetAll => 'Restablecer todo';

  @override
  String get gResetWarn => 'No se puede deshacer';

  @override
  String get gCreditTo => 'Acreditando a:';

  @override
  String get gYou => 'Configurado por ti';

  @override
  String get ssPageTitle => 'Configuración';

  @override
  String get ssSettingsGuide =>
      'Reinicia la app para aplicar los cambios.\n\n¡Diviértete!';

  @override
  String get ssSettingsGuideWeb =>
      'Recarga la página para aplicar tus cambios.\n\n¡Diviértete!';

  @override
  String get ssThemeMode => 'Modo del tema';

  @override
  String get ssDominantHand => 'Mano preferente';

  @override
  String get ssLanguage => 'Idioma';

  @override
  String get ssLanguages => 'Idiomas';

  @override
  String get ssLangHint => 'Idioma de la aplicación';

  @override
  String get ssResetAll => '¿Restablecer todas las configuraciones?';

  @override
  String get tsPageTitle => 'Configuración del texto';

  @override
  String tsBatchOverride(Object setting) {
    return 'Ya has realizado cambios de \"$setting\" granulares en la configuración avanzada.\n\n¿Seguro que quieres anular esos cambios con una actualización por lotes?';
  }

  @override
  String get tsDisplay => 'Despliegue';

  @override
  String get tsHeadline => 'Encabezado';

  @override
  String get tsTitle => 'Título';

  @override
  String get tsBody => 'Cuerpo';

  @override
  String get tsLabel => 'Etiqueta';

  @override
  String tsLinkHint(Object style) {
    return 'Activar para editar $style';
  }

  @override
  String get tsFontFamily => 'Familia de fuente';

  @override
  String get tsFontSize => 'Tamaño de fuente';

  @override
  String get tsBold => 'Negrita';

  @override
  String get tsItalic => 'Cursiva';

  @override
  String get tsUnderline => 'Subrayado';

  @override
  String get tsLetterSpacing => 'Espaciado entre letras';

  @override
  String get tsWordSpacing => 'Espaciado entre palabras';

  @override
  String get tsLineHeight => 'Altura de línea';

  @override
  String get tsDecrease => 'Disminuir';

  @override
  String get tsIncrease => 'Aumentar';

  @override
  String get tsDisplayP1 => '¿Se ';

  @override
  String get tsDisplayLink => 'despliegue';

  @override
  String get tsDisplayP2 => ' bien esto?';

  @override
  String get tsHeadlineP1 => '¿Se diferencian los ';

  @override
  String get tsHeadlineLink => 'encabezados';

  @override
  String get tsHeadlineP2 => '...';

  @override
  String get tsTitleP1 => 'de los ';

  @override
  String get tsTitleLink => 'títulos?';

  @override
  String get tsBodyP1 => '¿Y ';

  @override
  String get tsBodyLink => 'el cuerpo?';

  @override
  String get tsBodyP2 => ' ¿Se puede leer bien?';

  @override
  String get tsLabelP1 => '¿Y ';

  @override
  String get tsLabelLink => 'las etiquetas?';

  @override
  String get tsLabelP2 => ' ¿No muy grandes, no muy pequeñas?';

  @override
  String get tsResetAll => '¿Restablecer la configuración del texto?';

  @override
  String get lsPageTitle => 'Configuración del esquema';

  @override
  String get lsMargin => 'Margen';

  @override
  String get lsPadding => 'Acolchado';

  @override
  String get lsSpacing => 'Espaciado';

  @override
  String get lsScroll => '¿Ocultar las barras de desplazamiento?';

  @override
  String get lsResetAll => '¿Restablecer todos los configuración del esquema?';

  @override
  String get csPageTitle => 'Configuración de color';

  @override
  String csPickerHint(Object name) {
    return 'Abre un selector de color para $name. Mantén pulsado para ver más opciones.';
  }

  @override
  String get csMonoChrome => 'Usar esquema monocromático';

  @override
  String get csHighContrast => 'Usar esquema de alto contraste';

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
  String get csPickerTitle => 'Selecciona un color';

  @override
  String get csRecommended => '¿Usar contraste recomendado?';

  @override
  String get csUseCustom => 'Usar personalizado';

  @override
  String get csAddColor => 'Añadir un color';

  @override
  String get csRemove => 'Quitar';

  @override
  String get csReset => 'Restablecer';

  @override
  String get csResetTo => 'Restablecer a...';

  @override
  String get csSchemeBase => 'Crear tema\nusando imagen';

  @override
  String get csOptional => 'opcional';

  @override
  String get csFromImage => 'Diseña un esquema de color a partir de una imagen';

  @override
  String get csColorScheme => 'esquema de color';

  @override
  String csResetAll(Object themeType) {
    return 'Restablecer todos los esquemas de colores de $themeType?';
  }

  @override
  String get isPageTitle => 'Configuración de imagen';

  @override
  String get isBackground => 'Fondo';

  @override
  String get isImage => 'imagen';

  @override
  String isButtonHint(Object title) {
    return 'Actualizar la imagen $title';
  }

  @override
  String isDialogTitle(Object title) {
    return '¿Cómo quieres actualizar la imagen $title?';
  }

  @override
  String get isFromFile => 'Usando un archivo';

  @override
  String get isFromCamera => 'Usando la cámara';

  @override
  String get isFromNetwork => 'Usando un link';

  @override
  String get isResetIt => 'Restablecer';

  @override
  String get isClearIt => 'Borrar';

  @override
  String get isEnterURL => 'Inserta el link';

  @override
  String get isGetFailed => 'Error al intentar obtener la imagen';

  @override
  String isSetFailed(Object error) {
    return 'Error al intentar actualizar la imagen:\n$error';
  }

  @override
  String get isPermission =>
      'Algunas webs restringen el acceso a sus imágenes.\nIntenta usar una imagen de otra página.';

  @override
  String get isUseForColors =>
      'Actualiza los colores de la app usando esta imagen';

  @override
  String isResetAll(Object themeType) {
    return '¿Restablecer todas las imágenes del tema $themeType?';
  }
}
