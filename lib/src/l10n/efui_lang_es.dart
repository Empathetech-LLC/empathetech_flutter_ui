import 'efui_lang.dart';

/// The translations for Spanish Castilian (`es`).
class EFUILangEs extends EFUILang {
  EFUILangEs([String locale = 'es']) : super(locale);

  @override
  String get gYes => 'Sí';

  @override
  String get gNo => 'No';

  @override
  String get gLeft => 'Izquierda';

  @override
  String get gRight => 'Derecha';

  @override
  String get gHomeHint => 'Regresar a la pantalla principal';

  @override
  String get gAttention => 'Atención';

  @override
  String get gApply => 'Aplicar';

  @override
  String get gContinue => 'Continuar';

  @override
  String get gCancel => 'Cancelar';

  @override
  String get gClose => 'Cerrar';

  @override
  String gDefaultEntry(Object entry) {
    return '$entry* (por defecto)';
  }

  @override
  String get gCurrently => 'Actualmente: ';

  @override
  String gSetToValue(Object name, Object value) {
    return '$name está configurado actualmente en $value';
  }

  @override
  String get gReset => 'Restablecer: ';

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
  String gEditingTheme(Object themeType) {
    return 'Editando: tema $themeType';
  }

  @override
  String get gSystem => 'Sistema';

  @override
  String get gLight => 'Ligero';

  @override
  String get gDark => 'Oscuro';

  @override
  String get gPlay => 'Reproducir';

  @override
  String get gPause => 'Pausar';

  @override
  String get gReplay => 'Repetir';

  @override
  String get gMute => 'Silenciar';

  @override
  String get gAutoPlayDisabled =>
      'La reproducción automática de videos está desactivada.';

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
  String get ssLangSemantics =>
      'Activa para actualizar el idioma de la aplicación';

  @override
  String get ssLanguages => 'Idiomas';

  @override
  String get ssResetAll => '¿Restablecer todas las configuraciones?';

  @override
  String get isPageTitle => 'Configuraciones de imagen';

  @override
  String get isPage => 'Página';

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
  String get isEnterURL => 'Desde URL';

  @override
  String get isNetworkPreview => 'Vista previa de tu imagen seleccionada';

  @override
  String get isGetFailed => 'Error al recuperar la imagen';

  @override
  String isSetFailed(Object error) {
    return 'Error al actualizar la imagen:\n$error';
  }

  @override
  String get isResetIt => 'Restablécelo';

  @override
  String get isClearIt => 'Borrarlo';

  @override
  String get isUseForColors =>
      '¿Actualizar los colores de la aplicación usando esta imagen?';

  @override
  String get isCreditTo => 'Crédito a:';

  @override
  String get isSource => '¡De donde lo obtuviste!';

  @override
  String isResetAll(Object themeType) {
    return '¿Restablecer todas las imágenes del tema $themeType?';
  }

  @override
  String get csPageTitle => 'Configuraciones de color';

  @override
  String get csThemeMode => 'Modo de tema';

  @override
  String get csThemeSemantics =>
      'Abrir para seleccionar un modo de tema. Actualmente configurado en:';

  @override
  String csEditingTheme(Object themeType) {
    return 'Editando: colores del tema $themeType\nMantén presionados los botones para restablecer individualmente';
  }

  @override
  String get csPickerTitle => '¡Selecciona un color!';

  @override
  String csPickerSemantics(Object name) {
    return 'Activar para abrir el selector de color para $name. Mantenga presionado para restablecer $name.';
  }

  @override
  String get csResetTo => 'Restablecer a...';

  @override
  String csResetAll(Object themeType) {
    return '¿Restablecer todos los colores del tema $themeType?';
  }

  @override
  String get csBackground => 'Fondo';

  @override
  String get csOnBackground => 'Texto del fondo';

  @override
  String get csSurface => 'Superficie';

  @override
  String get csOnSurface => 'Texto de la superficie';

  @override
  String get csSurfaceTint => 'Tinte de la superficie';

  @override
  String get csSurfaceVariant => 'Variante de la superficie';

  @override
  String get csOnSurfaceVariant => 'Texto de la variante de la superficie';

  @override
  String get csInverseSurface => 'Superficie inversa';

  @override
  String get csOnInverseSurface => 'Texto en superficie inversa';

  @override
  String get csPrimary => 'Primario';

  @override
  String get csOnPrimary => 'Texto primario';

  @override
  String get csInversePrimary => 'Primario inverso';

  @override
  String get csSecondary => 'Secundario';

  @override
  String get csOnSecondary => 'Texto secundario';

  @override
  String get csTertiary => 'Terciario';

  @override
  String get csOnTertiary => 'Texto terciario';

  @override
  String get csError => 'Error';

  @override
  String get csOnError => 'Texto de error';

  @override
  String get csOutline => 'Contorno';

  @override
  String get csOutlineVariant => 'Variante del contorno';

  @override
  String get csScrim => 'Cortinilla';

  @override
  String get csShadow => 'Sombra';

  @override
  String get csRecommended => '¿Usar recomendado?';

  @override
  String get csUseCustom => 'Usar personalizado';

  @override
  String get csOptional => 'Opcional';

  @override
  String get csSchemeBase => 'Base del esquema de colores';

  @override
  String get lsPageTitle => 'Configuraciones de diseño';

  @override
  String get lsDominantHand => 'Mano dominante';

  @override
  String get lsHandSemantics =>
      'Abrir para elegir izquierda o derecha. Actualmente configurado en:';

  @override
  String get lsMargin => 'Margen';

  @override
  String get lsTextSpacing => 'Espaciado de texto';

  @override
  String get lsButtonSpacing => 'Espaciado de botones';

  @override
  String get lsResetAll => '¿Restablecer todas las configuraciones de diseño?';

  @override
  String get stsPageTitle => 'Configuraciones de estilo';

  @override
  String get stsTextFont => 'Fuente de texto';

  @override
  String get stsFonts => 'Fuentes';

  @override
  String get stsPadding => 'Relleno';

  @override
  String get stsResetAll => '¿Restablecer todas las configuraciones de estilo?';
}
