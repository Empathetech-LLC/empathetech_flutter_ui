import 'lang.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class LangEs extends Lang {
  LangEs([String locale = 'es']) : super(locale);

  @override
  String get csPageTitle => 'Constructor';

  @override
  String get csAppName => 'Nombre de la aplicación';

  @override
  String get csNamePreview => 'ejemplo_app';

  @override
  String get csNameHint => 'La mejor aplicación de todas';

  @override
  String get csBecomes => 'se convierte en';

  @override
  String get csInvalidName =>
      'Se permiten letras minúsculas, números y guiones bajos.';

  @override
  String get csYourApp => 'tu aplicación';

  @override
  String get csPubName => 'Nombre del editor';

  @override
  String get csPubPreview => 'Organización Ejemplo';

  @override
  String get csPubHint => 'O Persona Ejemplo';

  @override
  String get csDescription => 'Descripción';

  @override
  String get csDescPreview => 'Una o dos frases sobre tu aplicación.';

  @override
  String get csDomainName => 'Nombre de dominio';

  @override
  String get csDomainHint => 'Revés, esta al';

  @override
  String get csInvalidDomain =>
      '\'domain.name\' solamente; RegExp(r\'^[a-z0-9_]+\\.[a-z]+\$\')';

  @override
  String get csSupportEmail => 'Correo de soporte';

  @override
  String get csSupportHint =>
      'Si se proporciona, se incluirá el sistema de comentarios que utilizamos.';

  @override
  String get csInvalidEmail => 'Correo no válido';

  @override
  String get csInclude => 'Incluir';

  @override
  String get csEasy => 'Fácil de cambiar más tarde';

  @override
  String csGenApp(Object app_name) {
    return 'Cuando generas $app_name el actual ';
  }

  @override
  String get csTheApp => 'la aplicación';

  @override
  String get csTheConfig => 'la configuración';

  @override
  String csSetColors(Object app_name) {
    return ' (excepto imágenes) se convertirá en la configuración predeterminada para $app_name.\n\nSe recomienda establecer un esquema de colores personalizado. Si necesitas ayuda para construir uno, intenta comenzar ';
  }

  @override
  String get csHere => 'aquí.';

  @override
  String get csHereHint =>
      'Abre un enlace a un constructor de esquemas de colores en línea';

  @override
  String get csAdvanced => 'Configuraciones avanzadas';

  @override
  String csRestore(Object setting) {
    return 'Restaurar $setting';
  }

  @override
  String get csPathRequired =>
      'Se requiere ruta. No se puede usar la carpeta raíz.';

  @override
  String get csBadPath => 'Ruta no válida';

  @override
  String get csCopyright => 'Aviso de derechos de autor';

  @override
  String get csCopyrightHint =>
      'Se incluirá en la parte superior de cada archivo Dart';

  @override
  String get csLicenseDocs =>
      'Abrir documentación sobre licencias de código abierto';

  @override
  String get csL10nHint =>
      'Configuración de localización (también conocida como traducciones)';

  @override
  String get csLintHint => 'Reglas de lint';

  @override
  String get csLaunchHint =>
      'Agrega opciones de lanzamiento al menú de depuración de VS Code';

  @override
  String get csSave => 'Guardar configuración';

  @override
  String get csLoad => 'Cargar configuración';

  @override
  String get csGenerate => 'Generar aplicación';

  @override
  String get csInvalidFields => 'Algunos campos son inválidos';

  @override
  String get csResetHint => 'Activa y confirma lo que se debe reiniciar.';

  @override
  String get csResetBuilder => 'Valores del constructor';

  @override
  String get csResetApp => 'Configuración de la aplicación';

  @override
  String get csResetBoth => 'Ambos';

  @override
  String get csResetNothing => 'Nada';

  @override
  String get rsWouldYou => 'Te gustaría...';

  @override
  String get rsInstall => 'Instalarlo';

  @override
  String get rsRun => 'Ejecutarlo';

  @override
  String get rsWipe => 'Borrarlo';

  @override
  String get rsNextTime => '¡Éxito, crucemos los dedos para la próxima!';

  @override
  String get rsAnotherOne =>
      'Otro fracaso; probablemente deberías tomar el control...';

  @override
  String get rsLeave => 'Dejarlo';
}
