// ignore_for_file: non_constant_identifier_names
/* We use the following convention: scope_CamelName
 * g == global
 * d == default
 * hs == home screen
 * ss == settings screen
 * sss == style settings screen
 * cs == color settings screen
 * is == image settings screen
 */

import 'efui_lang.dart';

/// The translations for Spanish Castilian (`es`).
class EFUILangEs extends EFUILang {
  EFUILangEs([String locale = 'es']) : super(locale);

  @override
  String get g_Yes => 'Sí';

  @override
  String get g_No => 'No';

  @override
  String get g_Right => 'Derecha';

  @override
  String get g_Left => 'Izquierda';

  @override
  String get g_Apply => 'Aplicar';

  @override
  String get g_Cancel => 'Cancelar';

  @override
  String get g_Close => 'Cerrar';

  @override
  String get g_System => 'Sistema';

  @override
  String get g_Light => 'Claro';

  @override
  String get g_Dark => 'Oscuro';

  @override
  String get g_Page => 'Página';

  @override
  String get g_autoPlayDisabled =>
      'Los videos con reproducción automática están desactivados.';

  @override
  String get d_HomeHint => 'Regresar a la pantalla principal';

  @override
  String get d_ResetAll => 'Restablecer todo';

  @override
  String get d_ResetDialogTitle => '¿Restablecer todas las configuraciones?';

  @override
  String get d_ResetDialogContent => 'No se puede deshacer';

  @override
  String get d_Attention => 'Atención';

  @override
  String get d_ResetAllWarn =>
      'No se puede deshacer\nLos cambios tendrán efecto al recargar la página';

  @override
  String get d_ResetAllWarnWeb =>
      'No se puede deshacer\nLos cambios tendrán efecto al reiniciar la aplicación';

  @override
  String d_EditingTheme(Object themeType) {
    return 'Editando: tema $themeType';
  }

  @override
  String get hs_ThemeMode => 'Modo de tema';

  @override
  String get hs_ThemeSemantics =>
      'Abrir para seleccionar un modo de tema. Actualmente configurado en:';

  @override
  String get hs_DominantHand => 'Mano dominante';

  @override
  String get hs_HandSemantics =>
      'Abrir para elegir izquierda o derecha. Actualmente configurado en:';

  @override
  String get hs_Style => 'Estilo';

  @override
  String get hs_Colors => 'Colores';

  @override
  String get hs_Images => 'Imágenes';

  @override
  String get ss_PageTitle => 'Configuraciones';

  @override
  String get ss_SettingsGuide =>
      'Cada botón mostrará una vista previa de sus cambios.\n¡Recarga la página para que tus cambios surtan efecto por completo!\n¡Diviértete!';

  @override
  String get ss_SettingsGuideWeb =>
      'Cada botón mostrará una vista previa de sus cambios.\n¡Reinicia la aplicación para que tus cambios surtan efecto por completo!\n¡Diviértete!';

  @override
  String get sts_PageTitle => 'Configuraciones de estilo';

  @override
  String get sts_TextFont => 'Fuente de texto';

  @override
  String get sts_chooseFont => 'Selecciona una fuente';

  @override
  String sts_DefaultFont(Object font) {
    return '$font* (por defecto)';
  }

  @override
  String get sts_Margin => 'Margen';

  @override
  String get sts_Padding => 'Relleno';

  @override
  String get sts_CircleSize => 'Tamaño del botón circular';

  @override
  String get sts_ButtonSpacing => 'Espaciado de botones';

  @override
  String get sts_TextSpacing => 'Espaciado de texto';

  @override
  String get sts_Currently => 'Actualmente: ';

  @override
  String sts_SetToValue(Object name, Object value) {
    return '$name está configurado actualmente en $value';
  }

  @override
  String get sts_Reset => 'Restablecer: ';

  @override
  String sts_ResetToValue(Object name, Object value) {
    return 'Restablecer $name a $value';
  }

  @override
  String get sts_ResetAll =>
      '¿Restablecer todas las configuraciones de estilo?';

  @override
  String get cs_PageTitle => 'Configuraciones de color';

  @override
  String cs_EditingTheme(Object themeType) {
    return 'Editando: colores del tema $themeType\nMantén presionados los botones para restablecer individualmente';
  }

  @override
  String get cs_PickerTitle => '¡Selecciona un color!';

  @override
  String cs_PickerSemantics(Object name) {
    return 'Activar para abrir el selector de color para $name. Mantenga presionado para restablecer $name.';
  }

  @override
  String get cs_ResetTo => 'Restablecer a...';

  @override
  String get cs_Theme => 'Tema';

  @override
  String get cs_ThemeText => 'Texto del tema';

  @override
  String get cs_Recommended => '¿Usar recomendado?';

  @override
  String get cs_UseCustom => 'Usar personalizado';

  @override
  String get cs_PageText => 'Texto de la página';

  @override
  String get cs_Buttons => 'Botones';

  @override
  String get cs_ButtonText => 'Texto de los botones';

  @override
  String get cs_Accent => 'Acento';

  @override
  String get cs_AccentText => 'Texto de acento';

  @override
  String cs_ResetAll(Object themeType) {
    return '¿Restablecer todos los colores del tema $themeType?';
  }

  @override
  String get is_PageTitle => 'Configuraciones de imagen';

  @override
  String get is_Image => 'imagen';

  @override
  String is_ButtonHint(Object title) {
    return 'Actualizar la imagen de $title';
  }

  @override
  String is_DialogTitle(Object title) {
    return '¿Cómo se debe actualizar la imagen de $title?';
  }

  @override
  String get is_FromFile => 'Desde archivo';

  @override
  String get is_FromCamera => 'Desde cámara';

  @override
  String get is_GetFailed => 'No se pudo recuperar la imagen';

  @override
  String is_SetFailed(Object error) {
    return 'No se pudo actualizar la imagen:\n$error';
  }

  @override
  String get is_ResetIt => 'Restablécelo';

  @override
  String get is_ClearIt => 'Borrarlo';

  @override
  String get is_CreditTo => 'Crédito a:';

  @override
  String get is_Source => '¡De donde lo obtuviste!';

  @override
  String is_ResetAll(Object themeType) {
    return '¿Restablecer todas las imágenes del tema $themeType?';
  }
}
