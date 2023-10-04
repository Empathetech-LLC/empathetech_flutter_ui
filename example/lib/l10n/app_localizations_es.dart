import 'app_localizations.dart';

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Empático Flutter UI';

  @override
  String get homeLinkHint => 'Regresar a la pantalla principal';

  @override
  String get light => 'claro';

  @override
  String get dark => 'oscuro';

  @override
  String editingTheme(Object themeType) {
    return 'Editando: tema $themeType';
  }

  @override
  String get resetAllWarning =>
      'No se puede deshacer\nLos cambios tendrán efecto al reiniciar la aplicación';

  @override
  String get resetAllWarningWeb =>
      'No se puede deshacer\nLos cambios tendrán efecto al recargar la página';

  @override
  String get imageSettings => 'Configuraciones de imagen';

  @override
  String resetAllImages(Object themeType) {
    return '¿Restablecer todas las imágenes del tema $themeType?';
  }

  @override
  String get page => 'Página';

  @override
  String get yourSourceCredit => '¡De donde lo obtuviste!';

  @override
  String get colorSettings => 'Configuraciones de color';

  @override
  String resetAllColors(Object themeType) {
    return '¿Restablecer todos los colores del tema $themeType?';
  }

  @override
  String editingThemeColors(Object themeType) {
    return 'Editando: colores del tema $themeType\nMantén presionados los botones para restablecer individualmente';
  }

  @override
  String get theme => 'Tema';

  @override
  String get themeText => 'Texto del tema';

  @override
  String get pageText => 'Texto de la página';

  @override
  String get buttons => 'Botones';

  @override
  String get buttonText => 'Texto de los botones';

  @override
  String get accent => 'Acento';

  @override
  String get accentText => 'Texto de acento';

  @override
  String get styleSettings => 'Configuraciones de estilo';

  @override
  String get resetAllStyle =>
      '¿Restablecer todas las configuraciones de estilo?';

  @override
  String get margin => 'margen';

  @override
  String get padding => 'relleno';

  @override
  String get circleSize => 'tamaño del botón circular';

  @override
  String get buttonSpacing => 'espaciado de botones';

  @override
  String get textSpacing => 'espaciado de texto';

  @override
  String get settings => 'Configuraciones';

  @override
  String get attention => 'ATENCIÓN';

  @override
  String get resetWarning =>
      'Cada botón mostrará una vista previa de sus cambios\n¡Recarga la página para que tus cambios surtan efecto por completo!\n¡Diviértete!';

  @override
  String get resetWarningWeb =>
      'Cada botón mostrará una vista previa de sus cambios\n¡Reinicia la aplicación para que tus cambios surtan efecto por completo!\n¡Diviértete!';

  @override
  String get styling => 'Estilización';

  @override
  String get colors => 'Colores';

  @override
  String get images => 'Imágenes';
}
