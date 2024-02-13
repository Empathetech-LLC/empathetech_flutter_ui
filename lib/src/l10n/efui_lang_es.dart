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
  String gSettingX(Object setting) {
    return 'Configuración de $setting';
  }

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
  String get tsFontFamily => 'Familia de fuentes';

  @override
  String get tsFontSize => 'Tamaño';

  @override
  String get tsFontWeight => 'Peso';

  @override
  String get tsFontStyle => 'Estilo';

  @override
  String get tsLetterSpacing => 'Espaciado de letras';

  @override
  String get tsWordSpacing => 'Espaciado de palabras';

  @override
  String get tsFontHeight => 'Altura';

  @override
  String get tsFontDecoration => 'Decoración';

  @override
  String get tsFonts => 'Fuentes';

  @override
  String get tsDisplayPreview => '¿Se muestra bien esto?';

  @override
  String get tsHeadlinePreview => 'Los titulares son distintos...';

  @override
  String get tsTitlePreview => '¿de los títulos?';

  @override
  String get tsBodyPreview => '¿Y el cuerpo? ¿Es fácil de leer?';

  @override
  String get tsLabelPreview =>
      '¿Y las etiquetas? ¿No son demasiado grandes ni demasiado pequeñas?';

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
  String get csPrimary => 'Primario';

  @override
  String get csOnPrimary => 'En Primario';

  @override
  String get csPrimaryContainer => 'Contenedor Primario';

  @override
  String get csOnPrimaryContainer => 'En Contenedor Primario';

  @override
  String get csSecondary => 'Secundario';

  @override
  String get csOnSecondary => 'En Secundario';

  @override
  String get csSecondaryContainer => 'Contenedor Secundario';

  @override
  String get csOnSecondaryContainer => 'En Contenedor Secundario';

  @override
  String get csTertiary => 'Terciario';

  @override
  String get csOnTertiary => 'En Terciario';

  @override
  String get csTertiaryContainer => 'Contenedor Terciario';

  @override
  String get csOnTertiaryContainer => 'En Contenedor Terciario';

  @override
  String get csError => 'Error';

  @override
  String get csOnError => 'En Error';

  @override
  String get csErrorContainer => 'Contenedor de Error';

  @override
  String get csOnErrorContainer => 'En Contenedor de Error';

  @override
  String get csOutline => 'Contorno';

  @override
  String get csOutlineVariant => 'Variante de Contorno';

  @override
  String get csBackground => 'Fondo';

  @override
  String get csOnBackground => 'En Fondo';

  @override
  String get csSurface => 'Superficie';

  @override
  String get csOnSurface => 'En Superficie';

  @override
  String get csSurfaceVariant => 'Variante de Superficie';

  @override
  String get csOnSurfaceVariant => 'En Variante de Superficie';

  @override
  String get csInverseSurface => 'Superficie Inversa';

  @override
  String get csOnInverseSurface => 'En Superficie Inversa';

  @override
  String get csInversePrimary => 'Primario Inversa';

  @override
  String get csScrim => 'Telón';

  @override
  String get csShadow => 'Sombra';

  @override
  String get csSurfaceTint => 'Tinte de Superficie';

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
  String get csSchemeBase => 'Construir a partir\nde imagen';

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
  String get isUseForColors =>
      '¿Actualizar los colores de la aplicación usando esta imagen?';

  @override
  String isResetAll(Object themeType) {
    return '¿Restablecer todas las imágenes del tema $themeType?';
  }
}
