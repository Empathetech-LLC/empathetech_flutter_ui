// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'efui_lang.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class EFUILangEs extends EFUILang {
  EFUILangEs([String locale = 'es']) : super(locale);

  @override
  String get gApply => 'Aplicar';

  @override
  String get gContinue => 'Continuar';

  @override
  String get gOpen => 'Abrir';

  @override
  String get gSuccess => 'Éxito';

  @override
  String get gSuccessExl => '¡Éxito!';

  @override
  String get gYes => 'Sí';

  @override
  String get gAnd => 'y';

  @override
  String get gHelp => 'Ayuda';

  @override
  String get gNA => 'N/D';

  @override
  String get gNAHint => 'No disponible';

  @override
  String get gOptional => 'opcional';

  @override
  String get gOptions => 'Opciones';

  @override
  String get gRequired => 'Requerido';

  @override
  String get gBack => 'Atrás';

  @override
  String get gCancel => 'Cancelar';

  @override
  String get gClose => 'Cerrar';

  @override
  String get gDisabled => 'Deshabilitado';

  @override
  String get gError => 'Error';

  @override
  String get gFailure => 'Fracaso';

  @override
  String get gNo => 'No';

  @override
  String get gDark => 'Oscuro';

  @override
  String get gLight => 'Claro';

  @override
  String get gSystem => 'Sistema';

  @override
  String get gEditing => 'Editando: ';

  @override
  String gEditingTheme(Object themeType) {
    return 'Editando: tema $themeType';
  }

  @override
  String get gLeft => 'Izquierda';

  @override
  String get gRight => 'Derecha';

  @override
  String get gAdvanced => 'Avanzado';

  @override
  String get gQuick => 'Rápido';

  @override
  String get gDecrease => 'Disminuir';

  @override
  String get gIncrease => 'Aumentar';

  @override
  String get gMaximum => 'Máximo';

  @override
  String get gMinimum => 'Mínimo';

  @override
  String get gLoadingAnim =>
      'Cargando. El logotipo empático animado como un reloj de arena giratorio.';

  @override
  String get gPlay => 'Reproducir';

  @override
  String get gPause => 'Pausa';

  @override
  String get gMute => 'Silenciar';

  @override
  String get gUnMute => 'Desactivar silencio';

  @override
  String get gPlaybackSpeed => 'Velocidad de reproducción';

  @override
  String get gReplay => 'Repetir';

  @override
  String get gFullScreen => 'Pantalla completa';

  @override
  String get gHowThisWorks => 'Cómo funciona';

  @override
  String get gHowThisWorksHint => 'Abrir documentación útil';

  @override
  String get gTranslationsPending =>
      'Traducciones pendientes de revisión humana';

  @override
  String get gUpdates => 'Actualizaciones disponibles';

  @override
  String get gValidURL => 'Por favor, introduzca una URL válida';

  @override
  String get g404Wonder => 'No todos los que deambulan están perdidos.';

  @override
  String get g404 => 'Pero, en este caso: 404 página no encontrada.';

  @override
  String get g404Note =>
      'Nota: Flutter web utiliza enrutamiento hash, como...\nhttps://www.example.com/#/settings';

  @override
  String get gOpenSource => 'Código abierto';

  @override
  String get gOpenEmpathetech => 'Abrir un enlace a Empathetic LLC';

  @override
  String get gEFUISourceHint => 'Abrir la página de GitHub de EFUI';

  @override
  String get gOpenUIReleases => 'Abrir la página de lanzamientos de Open UI';

  @override
  String get gGiveFeedback => 'Dar feedback';

  @override
  String get gOpeningFeedback => 'Apertura de la herramienta de feedback.';

  @override
  String get gAttachScreenshot =>
      'Adjunte su captura de pantalla (en la carpeta de Descargas)';

  @override
  String get gSupportEmail => 'Nuestro Email de soporte';

  @override
  String gClipboard(Object thing) {
    return '$thing ha sido copiado al portapapeles.';
  }

  @override
  String get gAttention => 'Atención';

  @override
  String get gCurrently => 'Actualmente:';

  @override
  String gSetToValue(Object name, Object value) {
    return '$name está configurado a $value';
  }

  @override
  String get gRemove => 'Quitar';

  @override
  String get gReset => 'Restablecer';

  @override
  String get gResetTo => 'Restablecer:';

  @override
  String gResetValue(Object name) {
    return '¿Restablecer $name?';
  }

  @override
  String gResetValueTo(Object name, Object value) {
    return 'Restablecer $name a $value';
  }

  @override
  String get gResetAll => 'Restablecer todo';

  @override
  String get gUndoWarn => 'No se puede deshacer';

  @override
  String get gCreditTo => 'Acreditando a:';

  @override
  String get gCreator => 'Creador de';

  @override
  String get gMadeBy => 'Hecho por';

  @override
  String get gYou => 'Configurado por ti';

  @override
  String get ssPageTitle => 'Configuración';

  @override
  String get ssNavHint => 'Abrir la página de configuración';

  @override
  String get ssSettingsGuide =>
      'Cierre y vuelva a abrir la app para aplicar los cambios.\n\n¡Diviértete!';

  @override
  String get ssSettingsGuideWeb =>
      'Recarga o actualice la página para aplicar tus cambios.\n\n¡Diviértete!';

  @override
  String get ssThemeMode => 'Modo del tema';

  @override
  String get ssDominantHand => 'Mano preferente';

  @override
  String get ssLanguage => 'Idioma';

  @override
  String get ssLangHint => 'Activar para cambiar el idioma de la aplicación';

  @override
  String get ssRandom => 'Aleatorizar';

  @override
  String ssRandomize(Object themeType) {
    return '¿Aleatorizar el tema $themeType?';
  }

  @override
  String get ssResetAll => '¿Restablecer todas las configuraciones?';

  @override
  String get tsPageTitle => 'Configuración del texto';

  @override
  String tsBatchOverride(Object setting) {
    return 'Ya has realizado cambios de \"$setting\" granulares en la configuración avanzada.\n\n¿Seguro que quieres anular esos cambios con una actualización por lotes?';
  }

  @override
  String get tsTextBackground => 'Opacidad del fondo del texto';

  @override
  String get tsIconSize => 'Tamaño del icono';

  @override
  String tsLinkHint(Object style) {
    return 'Activar para editar $style';
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
  String get csPickerHint =>
      'Abre un selector de color. Mantén pulsado para ver más opciones.';

  @override
  String get csMonoChrome => 'Usar esquema monocromático';

  @override
  String get csHighContrast => 'Usar esquema de alto contraste';

  @override
  String get csPickerTitle => 'Selecciona un color';

  @override
  String get csRecommended => '¿Usar contraste recomendado?';

  @override
  String get csUseCustom => 'Usar personalizado';

  @override
  String get csAddColor => 'Añadir un color';

  @override
  String get csCurrVal => 'Valor de color actual:';

  @override
  String get csSchemeBase => 'Crear tema\nusando imagen';

  @override
  String get csFromImage =>
      'Se generará un esquema de color a partir de la imagen.';

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
  String get isFit => '¿Cómo debe quedar?';

  @override
  String isResetAll(Object themeType) {
    return '¿Restablecer todas las imágenes del tema $themeType?';
  }
}
