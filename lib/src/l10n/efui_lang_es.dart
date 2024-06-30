import 'efui_lang.dart';

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
  String get gGiveFeedback => 'Dar comentarios';

  @override
  String gClipboard(Object thing) {
    return '$thing copiado al portapapeles';
  }

  @override
  String get gSupportEmail => 'Correo electrónico de soporte';

  @override
  String get gLeft => 'Izquierda';

  @override
  String get gRight => 'Derecha';

  @override
  String get gBack => 'Atrás';

  @override
  String get gSystem => 'Sistema';

  @override
  String get gLight => 'Ligero';

  @override
  String get gDark => 'Oscuro';

  @override
  String get gEditing => 'Editando: ';

  @override
  String gEditingTheme(Object themeType) {
    return 'Editando: tema $themeType';
  }

  @override
  String get gHowThisWorks => 'Cómo funciona esto';

  @override
  String get gHowThisWorksHint => 'Activar para abrir documentación útil';

  @override
  String get gAttention => 'Atención';

  @override
  String get gCurrently => 'Actualmente:';

  @override
  String gSetToValue(Object name, Object value) {
    return '$name está establecido en $value';
  }

  @override
  String gDefaultEntry(Object entry) {
    return '$entry* (por defecto)';
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
  String get gCreditTo => 'Crédito a:';

  @override
  String get ssPageTitle => 'Configuraciones';

  @override
  String get ssSettingsGuide =>
      'Reinicia la aplicación para guardar tus cambios.\n\n¡Diviértete!';

  @override
  String get ssSettingsGuideWeb =>
      'Recarga la página para guardar tus cambios.\n\n¡Diviértete!';

  @override
  String get ssThemeMode => 'Modo de tema';

  @override
  String get ssDominantHand => 'Mano dominante';

  @override
  String get ssLanguage => 'Idioma';

  @override
  String get ssLanguages => 'Idiomas';

  @override
  String get ssLangSemantics => 'Idioma de la aplicación';

  @override
  String get ssResetAll => '¿Restablecer todas las configuraciones?';

  @override
  String get tsPageTitle => 'Configuraciones de texto';

  @override
  String get tsDisplay => 'Presentar';

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
  String get tsFontFamily => 'Familia de fuentes';

  @override
  String get tsFontSize => 'Tamaño de fuente';

  @override
  String get tsBold => 'Negrita';

  @override
  String get tsItalic => 'Itálica';

  @override
  String get tsUnderline => 'Subrayar';

  @override
  String get tsLetterSpacing => 'Espaciado de letras';

  @override
  String get tsWordSpacing => 'Espaciado de palabras';

  @override
  String get tsLineHeight => 'Altura de línea';

  @override
  String get tsDecrease => 'Disminuir';

  @override
  String get tsIncrease => 'Aumentar';

  @override
  String get tsDisplayP1 => '¿Esto se ';

  @override
  String get tsDisplayLink => 'presenta';

  @override
  String get tsDisplayP2 => ' bien?';

  @override
  String get tsHeadlineP1 => 'Son los ';

  @override
  String get tsHeadlineLink => 'encabezados';

  @override
  String get tsHeadlineP2 => ' distintos...';

  @override
  String get tsTitleP1 => 'de los ';

  @override
  String get tsTitleLink => 'títulos?';

  @override
  String get tsBodyP1 => '¿Qué tal ';

  @override
  String get tsBodyLink => 'el cuerpo?';

  @override
  String get tsBodyP2 => ' ¿Es fácil de leer?';

  @override
  String get tsLabelP1 => '¿Y ';

  @override
  String get tsLabelLink => 'las etiquetas?';

  @override
  String get tsLabelP2 => ' ¿No demasiado grande ni demasiado pequeño?';

  @override
  String get tsResetAll => '¿Restablecer todas las configuraciones de texto?';

  @override
  String get lsPageTitle => 'Configuraciones de diseño';

  @override
  String get lsMargin => 'Margen';

  @override
  String get lsPadding => 'Relleno';

  @override
  String get lsSpacing => 'Espaciado';

  @override
  String get lsResetAll => '¿Restablecer todas las configuraciones de diseño?';

  @override
  String get csPageTitle => 'Configuraciones de color';

  @override
  String csPickerSemantics(Object name) {
    return 'Activar para abrir un selector de color para $name. Mantenga presionado para más opciones.';
  }

  @override
  String get csBasic => 'Básica';

  @override
  String get csAdvanced => 'Avanzada';

  @override
  String get csHighContrast => 'Utilice colores de alto contraste';

  @override
  String get csMonoChrome => 'Usar esquema monocromático';

  @override
  String get csPrimary => 'Primario';

  @override
  String get csOnPrimary => 'En primario';

  @override
  String get csPrimaryContainer => 'Contenedor primario';

  @override
  String get csOnPrimaryContainer => 'En contenedor primario';

  @override
  String get csPrimaryFixed => 'Primario fijo';

  @override
  String get csPrimaryFixedDim => 'Oscuro primario fijo';

  @override
  String get csOnPrimaryFixed => 'En primario fijo';

  @override
  String get csOnPrimaryFixedVariant => 'En variante de primario fijo';

  @override
  String get csSecondary => 'Secundario';

  @override
  String get csOnSecondary => 'En secundario';

  @override
  String get csSecondaryContainer => 'Contenedor secundario';

  @override
  String get csOnSecondaryContainer => 'En contenedor secundario';

  @override
  String get csSecondaryFixed => 'Secundario fijo';

  @override
  String get csSecondaryFixedDim => 'Oscuro secundario fijo';

  @override
  String get csOnSecondaryFixed => 'En secundario fijo';

  @override
  String get csOnSecondaryFixedVariant => 'En variante de secundario fijo';

  @override
  String get csTertiary => 'Terciario';

  @override
  String get csOnTertiary => 'En terciario';

  @override
  String get csTertiaryContainer => 'Contenedor terciario';

  @override
  String get csOnTertiaryContainer => 'En contenedor terciario';

  @override
  String get csTertiaryFixed => 'Terciario fijo';

  @override
  String get csTertiaryFixedDim => 'Oscuro terciario fijo';

  @override
  String get csOnTertiaryFixed => 'En terciario fijo';

  @override
  String get csOnTertiaryFixedVariant => 'En variante de terciario fijo';

  @override
  String get csError => 'Error';

  @override
  String get csOnError => 'En error';

  @override
  String get csErrorContainer => 'Contenedor de error';

  @override
  String get csOnErrorContainer => 'En contenedor de error';

  @override
  String get csOutline => 'Contorno';

  @override
  String get csOutlineVariant => 'Variante de contorno';

  @override
  String get csSurface => 'Superficie';

  @override
  String get csOnSurface => 'En superficie';

  @override
  String get csSurfaceDim => 'Superficie oscuro';

  @override
  String get csSurfaceBright => 'Superficie brillante';

  @override
  String get csSurfaceContainerLowest => 'Contenedor de superficie más bajo';

  @override
  String get csSurfaceContainerLow => 'Contenedor de superficie bajo';

  @override
  String get csSurfaceContainer => 'Contenedor de superficie';

  @override
  String get csSurfaceContainerHigh => 'Contenedor de superficie alto';

  @override
  String get csSurfaceContainerHighest => 'Contenedor de superficie más alto';

  @override
  String get csOnSurfaceVariant => 'En variante de superficie';

  @override
  String get csInverseSurface => 'Superficie inversa';

  @override
  String get csOnInverseSurface => 'En superficie inversa';

  @override
  String get csInversePrimary => 'Primario inversa';

  @override
  String get csScrim => 'Telón';

  @override
  String get csShadow => 'Sombra';

  @override
  String get csSurfaceTint => 'Tinte de superficie';

  @override
  String get csPickerTitle => '¡Selecciona un color!';

  @override
  String get csRecommended => '¿Usar recomendación de contraste?';

  @override
  String get csUseCustom => 'Usar personalizado';

  @override
  String get csAddColor => 'Añadir un color';

  @override
  String get csRemove => 'Eliminar';

  @override
  String get csReset => 'Restablecer';

  @override
  String get csResetTo => 'Restablecer a...';

  @override
  String get csSchemeBase => 'Construir esquema a partir\nde la imagen';

  @override
  String get csOptional => 'opcional';

  @override
  String get csFromImage =>
      'Construye la esquema de colores a partir de una imagen';

  @override
  String get csColorScheme => 'esquema de colores';

  @override
  String csResetAll(Object themeType) {
    return '¿Restablecer todos los colores del tema $themeType?';
  }

  @override
  String get isPageTitle => 'Configuraciones de imagen';

  @override
  String get isBackground => 'Fondo';

  @override
  String get isImage => 'imagen';

  @override
  String isButtonHint(Object title) {
    return 'Actualizar la imagen de $title';
  }

  @override
  String isDialogTitle(Object title) {
    return '¿Cómo se debe actualizar la imagen de $title?';
  }

  @override
  String get isFromFile => 'Desde archivo';

  @override
  String get isFromCamera => 'Desde cámara';

  @override
  String get isFromNetwork => 'Desde URL';

  @override
  String get isResetIt => 'Restablecerlo';

  @override
  String get isClearIt => 'Limpiarlo';

  @override
  String get isEnterURL => 'Ingrese URL';

  @override
  String get isGetFailed => 'Error al recuperar la imagen';

  @override
  String isSetFailed(Object error) {
    return 'Error al actualizar la imagen:\n$error';
  }

  @override
  String get isPermission =>
      'Algunos sitios no permiten que otros accedan a sus imágenes.\nPruebe con una imagen de otro host.';

  @override
  String get isUseForColors =>
      'Actualizar los colores de la aplicación usando esta imagen';

  @override
  String isResetAll(Object themeType) {
    return '¿Restablecer todas las imágenes del tema $themeType?';
  }
}
