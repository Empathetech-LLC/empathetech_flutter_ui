import 'efui_lang.dart';

/// The translations for Spanish Castilian (`es`).
class EFUILangEs extends EFUILang {
  EFUILangEs([String locale = 'es']) : super(locale);

  @override
  String get gYes => 'Sí';

  @override
  String get gNo => 'No';

  @override
  String get gRight => 'Derecha';

  @override
  String get gLeft => 'Izquierda';

  @override
  String get gApply => 'Aplicar';

  @override
  String get gCancel => 'Cancelar';

  @override
  String get gClose => 'Cerrar';

  @override
  String get gContinue => 'Continuar';

  @override
  String get gSystem => 'Sistema';

  @override
  String get gLight => 'Ligero';

  @override
  String get gDark => 'Oscuro';

  @override
  String get gPage => 'Página';

  @override
  String get gPlay => 'Reproducir';

  @override
  String get gPause => 'Pausar';

  @override
  String get gMute => 'Silenciar';

  @override
  String get gReplay => 'Repetir';

  @override
  String get gAutoPlayDisabled =>
      'La reproducción automática de videos está desactivada.';

  @override
  String get dHomeHint => 'Regresar a la pantalla principal';

  @override
  String get dResetAll => 'Restablecer todo';

  @override
  String get dResetDialogTitle => '¿Restablecer todas las configuraciones?';

  @override
  String get dResetDialogContent => 'No se puede deshacer';

  @override
  String get dAttention => 'Atención';

  @override
  String get dResetAllWarn =>
      'No se puede deshacer\nLos cambios tendrán efecto al reiniciar la aplicación';

  @override
  String get dResetAllWarnWeb =>
      'No se puede deshacer\nLos cambios tendrán efecto al recargar la página';

  @override
  String dEditingTheme(Object themeType) {
    return 'Editando: tema $themeType';
  }

  @override
  String get hsThemeMode => 'Modo de tema';

  @override
  String get hsThemeSemantics =>
      'Abrir para seleccionar un modo de tema. Actualmente configurado en:';

  @override
  String get hsDominantHand => 'Mano dominante';

  @override
  String get hsHandSemantics =>
      'Abrir para elegir izquierda o derecha. Actualmente configurado en:';

  @override
  String get ssPageTitle => 'Configuraciones';

  @override
  String get ssSettingsGuide =>
      'Cada botón mostrará una vista previa de sus cambios.\n¡Recarga la página para que tus cambios surtan efecto por completo!\n¡Diviértete!';

  @override
  String get ssSettingsGuideWeb =>
      'Cada botón mostrará una vista previa de sus cambios.\n¡Reinicia la aplicación para que tus cambios surtan efecto por completo!\n¡Diviértete!';

  @override
  String get stsPageTitle => 'Configuraciones de estilo';

  @override
  String get stsTextFont => 'Fuente de texto';

  @override
  String get stsChooseFont => 'Selecciona una fuente';

  @override
  String stsDefaultFont(Object font) {
    return '$font* (por defecto)';
  }

  @override
  String get stsMargin => 'Margen';

  @override
  String get stsPadding => 'Relleno';

  @override
  String get stsCircleSize => 'Tamaño del botón circular';

  @override
  String get stsButtonSpacing => 'Espaciado de botones';

  @override
  String get stsTextSpacing => 'Espaciado de texto';

  @override
  String get stsCurrently => 'Actualmente: ';

  @override
  String stsSetToValue(Object name, Object value) {
    return '$name está configurado actualmente en $value';
  }

  @override
  String get stsReset => 'Restablecer: ';

  @override
  String stsResetToValue(Object name, Object value) {
    return 'Restablecer $name a $value';
  }

  @override
  String get stsResetAll => '¿Restablecer todas las configuraciones de estilo?';

  @override
  String get csPageTitle => 'Configuraciones de color';

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
  String get csPrimary => 'Primario';

  @override
  String get csOnPrimary => 'Texto primario';

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
  String get csTheme => 'Tema';

  @override
  String get csThemeText => 'Texto del tema';

  @override
  String get csRecommended => '¿Usar recomendado?';

  @override
  String get csUseCustom => 'Usar personalizado';

  @override
  String get csPageText => 'Texto de la página';

  @override
  String get csButtons => 'Botones';

  @override
  String get csButtonText => 'Texto de los botones';

  @override
  String get csAccent => 'Acento';

  @override
  String get csAccentText => 'Texto de acento';

  @override
  String get isPageTitle => 'Configuraciones de imagen';

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
  String get isCreditTo => 'Crédito a:';

  @override
  String get isSource => '¡De donde lo obtuviste!';

  @override
  String isResetAll(Object themeType) {
    return '¿Restablecer todas las imágenes del tema $themeType?';
  }
}
