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
  String get gLeft => 'Izquierda';

  @override
  String get gRight => 'Derecha';

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
  String get gHowThisWorksHint =>
      'Cómo funciona esto; activar para abrir documentación útil';

  @override
  String get gAttention => 'Atención';

  @override
  String get gCurrently => 'Actualmente:';

  @override
  String gSetToValue(Object name, Object value) {
    return '$name está configurado actualmente en $value';
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
  String get gResetTip =>
      'No se puede deshacer\nLos cambios tendrán efecto al reiniciar la aplicación';

  @override
  String get gResetTipWeb =>
      'No se puede deshacer\nLos cambios tendrán efecto al recargar la página';

  @override
  String get gHomeHint => 'Regresar a la pantalla principal';

  @override
  String get gCreditTo => 'Crédito a:';

  @override
  String get ssPageTitle => 'Configuraciones';

  @override
  String get ssSettingsGuide =>
      'Cada configuración mostrará una vista previa de sus cambios.\n¡Recarga la página para que tus cambios surtan efecto por completo!\n¡Diviértete!';

  @override
  String get ssSettingsGuideWeb =>
      'Cada configuración mostrará una vista previa de sus cambios.\n¡Reinicia la aplicación para que tus cambios surtan efecto por completo!\n¡Diviértete!';

  @override
  String get ssLanguage => 'Idioma';

  @override
  String get ssLanguages => 'Idiomas';

  @override
  String get ssLangSemantics =>
      'Activa para actualizar el idioma de la aplicación';

  @override
  String get ssThemeMode => 'Modo de tema';

  @override
  String get ssThemeSemantics =>
      'Abrir para seleccionar un modo de tema. Actualmente configurado en:';

  @override
  String get ssDominantHand => 'Mano dominante';

  @override
  String get ssHandSemantics =>
      'Abrir para elegir izquierda o derecha. Actualmente configurado en:';

  @override
  String get ssResetAll => '¿Restablecer todas las configuraciones?';

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
  String get isFromNetwork => 'Ingrese URL';

  @override
  String get isResetIt => 'Restablécelo';

  @override
  String get isClearIt => 'Borrarlo';

  @override
  String get isEnterURL => 'Desde URL';

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

  @override
  String get csPageTitle => 'Configuraciones de color';

  @override
  String csPickerSemantics(Object name) {
    return 'Activar para abrir el selector de color para $name. Mantenga presionado para restablecer $name.';
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
  String get csInversePrimary => 'Primario Inverso';

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
  String get csSchemeBase => 'Construir a partir\nde la imagen';

  @override
  String get csOptional => 'opcional';

  @override
  String get csFromImage =>
      'Construye la paleta de colores a partir de una imagen';

  @override
  String get csColorScheme => 'esquema de colores';

  @override
  String csResetAll(Object themeType) {
    return '¿Restablecer todos los colores del tema $themeType?';
  }

  @override
  String get stsPageTitle => 'Configuraciones de estilo';

  @override
  String get stsTextFont => 'Fuente de texto';

  @override
  String get stsFonts => 'Fuentes';

  @override
  String get stsMargin => 'Margen';

  @override
  String get stsPadding => 'Relleno';

  @override
  String get stsButtonSpacing => 'Espaciado de botones';

  @override
  String get stsTextSpacing => 'Espaciado de texto';

  @override
  String get stsResetAll => '¿Restablecer todas las configuraciones de estilo?';
}
