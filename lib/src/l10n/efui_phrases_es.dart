import 'efui_phrases.dart';

/// The translations for Spanish Castilian (`es`).
class EFUIPhrasesEs extends EFUIPhrases {
  EFUIPhrasesEs([String locale = 'es']) : super(locale);

  @override
  String get close => 'Cerrar';

  @override
  String get apply => 'Aplicar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get warning => 'ADVERTENCIA';

  @override
  String get useCustom => 'Usar personalizado';

  @override
  String get useRecommended => '¿Usar recomendado?';

  @override
  String get resetTo => 'Restablecer a...';

  @override
  String colorSettingSemantics(Object name) {
    return 'Activar para abrir el selector de color para $name. Mantenga presionado para restablecer $name.';
  }

  @override
  String get right => 'Derecha';

  @override
  String get left => 'Izquierda';

  @override
  String get dominantHand => 'Mano dominante';

  @override
  String get handSettingSemantics =>
      'Abrir para elegir izquierda o derecha. Actualmente configurado en:';

  @override
  String defaultTag(Object font) {
    return '$font* (por defecto)';
  }

  @override
  String get chooseFont => 'Selecciona una fuente';

  @override
  String get fontSettingLabel => 'Fuente de texto';

  @override
  String get fromFile => 'Desde archivo';

  @override
  String get fromCamera => 'Desde cámara';

  @override
  String get resetIt => 'Restablécelo';

  @override
  String get clearIt => 'Borrarlo';

  @override
  String imageSettingDialogTitle(Object title) {
    return '¿Cómo se debe actualizar la imagen de $title?';
  }

  @override
  String imageSettingHint(Object title) {
    return 'Actualizar la imagen de $title';
  }

  @override
  String get creditTo => 'Crédito a:';

  @override
  String get image => 'imagen';

  @override
  String get resetAll => 'Restablecer todo';

  @override
  String get resetButtonHint =>
      'Restablecer todas las configuraciones personalizadas';

  @override
  String get resetButtonDialogTitle =>
      '¿Restablecer todas las configuraciones?';

  @override
  String get resetButtonDialogContents => 'No se puede deshacer';

  @override
  String get currently => 'Actualmente: ';

  @override
  String nameSetToValue(Object name, Object value) {
    return '$name está configurado actualmente en $value';
  }

  @override
  String get reset => 'Restablecer: ';

  @override
  String resetNameToValue(Object name, Object value) {
    return 'Restablecer $name a $value';
  }

  @override
  String get system => 'Sistema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Oscuro';

  @override
  String get themeMode => 'Modo de tema';

  @override
  String get themeSwitchSemantics =>
      'Abrir para seleccionar un modo de tema. Actualmente configurado en:';

  @override
  String get margin => 'Margen';

  @override
  String get padding => 'Relleno';

  @override
  String get circleSize => 'Tamaño del botón circular';

  @override
  String get buttonSpacing => 'Espaciado de botones';

  @override
  String get textSpacing => 'Espaciado de texto';

  @override
  String get attention => 'Atención';

  @override
  String get pickAColor => '¡Selecciona un color!';

  @override
  String get clipCopy => 'Copiado al portapapeles';

  @override
  String get failedImageGet => 'No se pudo recuperar la imagen';

  @override
  String failedImageSet(Object error) {
    return 'No se pudo actualizar la imagen:\n$error';
  }

  @override
  String get autoPlayDisabled =>
      'Los videos con reproducción automática están desactivados.';
}
