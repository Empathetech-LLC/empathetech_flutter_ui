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
  String get gSkip => 'Saltar';

  @override
  String get gOpen => 'Abrir';

  @override
  String get gOpenLink => 'Abrir enlace';

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
  String get gUndo => 'Deshacer';

  @override
  String get gRedo => 'Rehacer';

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
  String get gEditingThemeHint => 'Abrir la configuración del tema del sistema';

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
  String get gCenterReset => 'Mantén el centro para restablecer';

  @override
  String get gLoadingAnim =>
      'Cargando. El logotipo empático animado como un reloj de arena giratorio.';

  @override
  String get gPlay => 'Reproducir';

  @override
  String get gPause => 'Pausa';

  @override
  String get gReplay => 'Repetir';

  @override
  String get gMute => 'Silenciar';

  @override
  String get gUnMute => 'Desactivar silencio';

  @override
  String get gPlaybackSpeed => 'Velocidad de reproducción';

  @override
  String get gCaptions => 'Subtítulos/captions';

  @override
  String get gCaptionsHint => 'Mantén pulsado para fuentes';

  @override
  String get gFullScreen => 'Pantalla completa';

  @override
  String get gHowThisWorks => 'Cómo funciona';

  @override
  String get gHowThisWorksHint => 'Abrir documentación útil';

  @override
  String get gMachineTranslated => 'Traducción automática';

  @override
  String get gUpdates => 'Actualizaciones disponibles';

  @override
  String get gHardRefresh =>
      'Por favor, actualice la página...\nCtrl + Shift + R';

  @override
  String get gHardRefreshMac =>
      'Por favor, actualice la página...\nCommand + Shift + R';

  @override
  String get gHardRefreshMobile =>
      'Actualice la página en el menú del navegador.';

  @override
  String get gEnterURL => 'Inserta el link';

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
  String get gUndoWarn1 => 'No se puede deshacer automáticamente.\n';

  @override
  String get gSave => 'Guarde';

  @override
  String get gUndoWarn2 =>
      ' su configuración actual para restaurarla manualmente.';

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
  String get ssRestartReminder =>
      'Cierre y vuelva a abrir la app para aplicar los cambios.';

  @override
  String get ssRestartReminderWeb =>
      'Recarga o actualice la página para aplicar tus cambios.';

  @override
  String get ssHaveFun => '¡Diviértete!';

  @override
  String get ssDominantHand => 'Mano preferente';

  @override
  String get ssThemeMode => 'Modo del tema';

  @override
  String get ssLanguage => 'Idioma';

  @override
  String get ssLangHint => 'Activar para cambiar el idioma de la aplicación';

  @override
  String get ssLoadPreset => 'Cargar preajuste';

  @override
  String get ssLoadPresetHint => 'Activar para mostrar ajustes preestablecidos';

  @override
  String get ssBigButtons => 'Botones grandes';

  @override
  String get ssHighVisibility => 'Alta visibilidad';

  @override
  String get ssVideoGame => 'Videojuego';

  @override
  String get ssChalkboard => 'Pizarra';

  @override
  String get ssFancyPants => 'Pantalones elegantes';

  @override
  String get ssDarkOnly =>
      'Este es un preajuste de tema oscuro. Cambiará el modo del tema a oscuro y actualizará ese tema.\n¿Continuar?';

  @override
  String get ssLightOnly =>
      'Este es un preajuste de tema claro. Cambiará el modo del tema a claro y actualizará ese tema.\n¿Continuar?';

  @override
  String ssApplied(Object config) {
    return '$config aplicado.';
  }

  @override
  String get ssTryMe => 'Pruébame';

  @override
  String get ssRandom => 'Randomiser';

  @override
  String ssRandomize(Object themeType) {
    return 'Thème $themeType aléatoire ?';
  }

  @override
  String get ssConfigTip => 'Guardar/cargar configuración';

  @override
  String get ssSaveConfig => 'Guardar configuración';

  @override
  String ssConfigSaved(Object path) {
    return 'Su configuración se ha guardado en $path';
  }

  @override
  String get ssWrongConfigExt => 'El archivo no se guardó como ';

  @override
  String get ssLoadConfig => 'Cargar configuración';

  @override
  String get ssResetAll => '¿Restablecer todas las configuraciones?';

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
  String get dsPageTitle => 'Configuración de diseño';

  @override
  String get dsAnimDuration => 'Duración de la animación';

  @override
  String get dsMilliseconds => 'Milisegundos';

  @override
  String get dsPreview => 'Avance';

  @override
  String get dsButtonOpacity => 'Opacidad del botón';

  @override
  String get dsBackground => 'Fondo del botón';

  @override
  String get dsOutline => 'Contorno del botón';

  @override
  String get dsBackgroundImg => 'Imagen de fondo';

  @override
  String dsImgSettingHint(Object title) {
    return 'Actualizar la imagen $title';
  }

  @override
  String get dsFromFile => 'Usando un archivo';

  @override
  String get dsFromCamera => 'Usando la cámara';

  @override
  String get dsFromNetwork => 'Usando un link';

  @override
  String get dsResetIt => 'Restablecer';

  @override
  String get dsClearIt => 'Borrar';

  @override
  String get dsUseForColors =>
      'Actualiza los colores de la app usando esta imagen';

  @override
  String get dsImgGetFailed => 'Error al intentar obtener la imagen';

  @override
  String get dsImgSetFailed => 'Error al intentar actualizar la imagen';

  @override
  String get dsImgPermission =>
      'Algunas webs restringen el acceso a sus imágenes.\nIntenta usar una imagen de otra página.';

  @override
  String get dsUseFull => '¿Usar la imagen completa?';

  @override
  String get dsFit => '¿Cómo debe quedar?';

  @override
  String get dsCrop => 'Recortar';

  @override
  String get dsNoWeb => 'La edición de imágenes no es compatible en la web';

  @override
  String get dsDrag => 'Arrastrar';

  @override
  String get dsDragHint => 'Arrastra para mover la imagen';

  @override
  String get dsSwipe => 'Deslizar';

  @override
  String get dsSwipeHint => 'Desliza para mover la imagen';

  @override
  String get dsPinch => 'Pellizcar';

  @override
  String get dsPinchHint => 'Pellizca para acercar/alejar la imagen';

  @override
  String get dsScroll => 'Desplazar';

  @override
  String get dsScrollHint => 'Desplaza para acercar/alejar la imagen';

  @override
  String get dsRotateLeft => 'Girar a la izquierda';

  @override
  String get dsRotateRight => 'Girar a la derecha';

  @override
  String dsResetAll(Object themeType) {
    return '¿Restablecer todas las configuraciones de diseño globales y de $themeType?';
  }

  @override
  String get lsPageTitle => 'Configuración del esquema';

  @override
  String get lsMargin => 'Margen';

  @override
  String get lsPadding => 'Acolchado';

  @override
  String get lsSpacing => 'Espaciado';

  @override
  String get lsScroll => 'Ocultar las barras de desplazamiento';

  @override
  String get lsResetAll => '¿Restablecer todos los configuración del esquema?';

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
}
